package action;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import net.coobird.thumbnailator.Thumbnails;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class UploadImageAction implements Action {
  private static final String UPLOAD_DIR = "/var/www/html/upload_tmp/";
  private static final long MAX_FILE_SIZE = 2 * 1024 * 1024; // 2MB

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    // 필수 파라미터 설정
    List<String> uploaded_image_paths = new ArrayList<>();
    String type = null;
    String user_idx = null;
    String plan_idx = null;
    String place_idx = null;
    String dynamic_idx;
    String init_path;
    String upload_image_path;
    String resized_image_path = null;

    try {
      DiskFileItemFactory factory = new DiskFileItemFactory();
      ServletFileUpload upload = new ServletFileUpload(factory);
      upload.setHeaderEncoding("UTF-8");
      upload.setSizeMax(MAX_FILE_SIZE);
      List<FileItem> items = upload.parseRequest(request);

      for (FileItem item : items) {
        if (item.isFormField()) {
          String field_name = item.getFieldName();
          String field_value = item.getString("UTF-8");

          if ("type".equals(field_name)) {
            type = field_value;
          } else if ("user_idx".equals(field_name)) {
            user_idx = field_value;
          } else if ("plan_idx".equals(field_name)) {
            plan_idx = field_value;
          } else if ("place_idx".equals(field_name)) {
            place_idx = field_value;
          }
        }
      }

      // 파라미터 검증
      if (type == null || type.isEmpty() || user_idx == null || user_idx.isEmpty()) {
        set_request_attribute(request, "error", "type 혹은 user_idx 값은 필수임.", null);
        return "jsp/upload_image_result.jsp";
      }

      if ("journal".equals(type)) {
        if (plan_idx == null || plan_idx.isEmpty()) {
          set_request_attribute(request, "error", "journal 이미지 업로드시 plan_idx 파라미터는 필수임.", null);
          return "jsp/upload_image_result.jsp";
        }
      } else if ("review".equals(type)) {
        if (place_idx == null || place_idx.isEmpty()) {
          set_request_attribute(request, "error", "review 이미지 업로드시 place_idx 파라미터는 필수임.", null);
          return "jsp/upload_image_result.jsp";
        }
      } else {
        set_request_attribute(request, "error", "type 비유효.", null);
        return "jsp/upload_image_result.jsp";
      }

      dynamic_idx = type.equals("journal") ? plan_idx : place_idx;
      init_path = UPLOAD_DIR + user_idx + "/" + type + "/" + dynamic_idx;

      for (FileItem item : items) {
        if (!item.isFormField()) { // !isFormField(폼필드가 아니면 무조건 multipart 객체(이미지 등)임)
          String upload_file_name = item.getName();
          if (upload_file_name != null && !upload_file_name.isEmpty()) {
            upload_image_path = init_path;
            String new_file_name = UUID.randomUUID() + "." + FilenameUtils.getExtension(upload_file_name);

            // 이미지가 없는 경우도 있을 것 같아서 mkdirs은 이미지가 있는게 확인 되는 경우에만 실행
            File target_dir = new File(upload_image_path);
            if (!target_dir.exists()) {
              if (!target_dir.mkdirs()) {
                set_request_attribute(request, "error", "업로드 디렉토리 생성 실패:\n" + target_dir.getPath(), null);
                return "jsp/upload_image_result.jsp";
              }
            }

            try (InputStream is = item.getInputStream()) {
              long file_size = is.available();
              if (file_size > 100 * 1024) { // 파일 사이즈가 100kb 보다 크면 리사이징
                resized_image_path = upload_image_path + "/resized_" + new_file_name;
                Thumbnails.of(is)
                    .scale(calculate_scale_factor(file_size))
                    .toFile(new File(resized_image_path));
              } else {
                upload_image_path += "/" + new_file_name;
                Files.copy(is, new File(upload_image_path).toPath());
              }
            } catch (IOException inner_IO_exception) {
              inner_IO_exception.printStackTrace();
              set_request_attribute(request, "error", "이미지 업로드 중 오류:\n" + inner_IO_exception.getMessage(), null);
              if (new File(upload_image_path).exists()) {
                new File(upload_image_path).delete();
              } else if (resized_image_path != null && new File(resized_image_path).exists()) {
                new File(resized_image_path).delete();
              }
              return "jsp/upload_image_result.jsp";
            }
          }
        }
      }

      // 이미지 전부 업로드 후 디렉토리 권한 변경해서 nginx 에서 접근 가능하게
      try {
        Runtime.getRuntime().exec("chown -R www-data:www-data " + UPLOAD_DIR);
      } catch (IOException outer_IO_exception) {
        outer_IO_exception.printStackTrace();
        set_request_attribute(request, "error", "파일 소유자 변경 중 오류 발생:\n" + outer_IO_exception.getMessage(), null);
        return "jsp/upload_image_result.jsp";
      }

      // 해당 경로의 모든 이미지 파일들 불러오기
      String uploaded_image_path = UPLOAD_DIR + user_idx + "/" + type + "/" + dynamic_idx;
      String url_path = ":4000/upload_tmp/" + user_idx + "/" + type + "/" + dynamic_idx + "/";
      if(new File(uploaded_image_path).exists()) {
        File[] files = new File(uploaded_image_path).listFiles();
        if(files != null) {
          for (File file : files) {
            uploaded_image_paths.add(url_path + file.getName());
          }
        }
      }

      set_request_attribute(request, "success", "파일 업로드 완료!", uploaded_image_paths);
      return "jsp/upload_image_result.jsp";
    } catch (Exception multipart_exception) {
      multipart_exception.printStackTrace();
      set_request_attribute(request, "error", "MultipartRequest 생성 중 오류:\n" + multipart_exception.getMessage(), null);
      return "jsp/upload_image_result.jsp";
    }
  }

  public double calculate_scale_factor(long file_size) {
    return Math.sqrt((double) 100 * 1024 / file_size);
  }

  public void set_request_attribute(HttpServletRequest request, String status, String message, List<String> image_names) {
    request.setAttribute("status", status);
    request.setAttribute("message", message);
    if(image_names != null && !image_names.isEmpty()) {
      request.setAttribute("image_names", image_names);
    }
  }
}