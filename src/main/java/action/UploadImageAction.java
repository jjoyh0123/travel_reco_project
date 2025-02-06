package action;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import net.coobird.thumbnailator.Thumbnails;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

public class UploadImageAction implements Action {
  private static final String UPLOAD_DIR = "/var/www/html/upload_tmp/";
  private static final long MAX_FILE_SIZE = 2 * 1024 * 1024; // 2MB

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    DiskFileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
    upload.setHeaderEncoding("UTF-8");
    upload.setSizeMax(MAX_FILE_SIZE);
    List<FileItem> items;

    // 필수 파라미터 초기화
    String action = null;
    String type = null;
    String user_idx = null;
    String plan_idx = null;
    String place_idx = null;
    String file_path = null;

    // 파라미터 세팅
    try {
      items = upload.parseRequest(request);

      for (FileItem item : items) {
        if (item.isFormField()) {
          String field_name = item.getFieldName();
          String field_value = item.getString("UTF-8");

          if ("action".equals(field_name)) {
            action = field_value;
          } else if ("type".equals(field_name)) {
            type = field_value;
          } else if ("user_idx".equals(field_name)) {
            user_idx = field_value;
          } else if ("plan_idx".equals(field_name)) {
            plan_idx = field_value;
          } else if ("place_idx".equals(field_name)) {
            place_idx = field_value;
          } else if ("file_path".equals(field_name)) {
            file_path = field_value;
          }
        }
      }
    } catch (FileUploadException fileUploadException) {
      set_request_attribute(request, "error", "파일 업로드 문제 발생:\n" + fileUploadException.getMessage(), null);
      return "jsp/upload_image_result.jsp";
    } catch (UnsupportedEncodingException unsupportedEncodingException) {
      set_request_attribute(request, "error", "인코딩 문제 발생:\n" + unsupportedEncodingException.getMessage(), null);
      return "jsp/upload_image_result.jsp";
    }

    if (action == null || action.isEmpty()) {
      set_request_attribute(request, "error", "action 값은 필수임.", null);
      return "jsp/upload_image_result.jsp";
    }

    switch (action) {
      case "upload": {
        upload_image_files_and_return_list(request, items, type, user_idx, plan_idx, place_idx);
        break;
      } case "delete_one": {
        delete_one_image_file(request, file_path);
        break;
      } case "delete_all": {
        delete_all_image_files(request, user_idx);
        break;
      } default: {
        set_request_attribute(request, "error", "유효하지 않은 action.", null);
      }
    }

    return "jsp/upload_image_result.jsp";
  }

  private void upload_image_files_and_return_list(HttpServletRequest request, List<FileItem> items, String type, String user_idx, String plan_idx, String place_idx) {
    String dynamic_idx;
    String init_path;
    String upload_image_path;
    String resized_image_path = null;
    List<String> uploaded_image_paths = new ArrayList<>();

    try {
      if (type == null || type.isEmpty() || user_idx == null || user_idx.isEmpty()) {
        set_request_attribute(request, "error", "type 혹은 user_idx 값은 필수임.", null);
        return;
      }

      if ("journal".equals(type)) {
        if (plan_idx == null || plan_idx.isEmpty()) {
          set_request_attribute(request, "error", "journal 이미지 업로드시 plan_idx 파라미터는 필수임.", null);
          return;
        }
      } else if ("review".equals(type)) {
        if (place_idx == null || place_idx.isEmpty()) {
          set_request_attribute(request, "error", "review 이미지 업로드시 place_idx 파라미터는 필수임.", null);
          return;
        }
      } else {
        set_request_attribute(request, "error", "유효하지 않은 type.", null);
        return;
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
                return;
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
            } catch (IOException input_stream_IO_exception) {
              input_stream_IO_exception.printStackTrace();
              set_request_attribute(request, "error", "이미지 업로드 중 오류:\n" + input_stream_IO_exception.getMessage(), null);
              if (new File(upload_image_path).exists()) {
                new File(upload_image_path).delete();
              } else if (resized_image_path != null && new File(resized_image_path).exists()) {
                new File(resized_image_path).delete();
              }
              return;
            }
          }
        }
      }

      // 이미지 전부 업로드 되면 디렉토리 권한 변경해서 nginx 에서 접근 가능하게
      try {
        Runtime.getRuntime().exec("chown -R www-data:www-data " + UPLOAD_DIR);
      } catch (IOException runtime_IO_exception) {
        runtime_IO_exception.printStackTrace();
        set_request_attribute(request, "error", "파일 소유자 변경 중 오류 발생:\n" + runtime_IO_exception.getMessage(), null);
        return;
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
    } catch (Exception multipart_exception) {
      multipart_exception.printStackTrace();
      set_request_attribute(request, "error", "MultipartRequest 생성 중 오류:\n" + multipart_exception.getMessage(), null);
    }
  }

  private void delete_one_image_file(HttpServletRequest request, String file_path) {
    if(file_path == null || file_path.isEmpty()) {
      set_request_attribute(request, "error", "file_path 는 필수.", null);
      return;
    }

    List<String> uploaded_image_paths = new ArrayList<>();
    String target_located_url_path = file_path.substring(file_path.lastIndexOf("upload_tmp"), file_path.lastIndexOf("/"));
    String target_file_path = "/var/www/html/" + file_path.substring(file_path.lastIndexOf("upload_tmp"));
    String target_located_path = "/var/www/html/" + target_located_url_path;

    int exit_code = 0;
    if(new File(target_file_path).exists()) {
      try {
        Process process = Runtime.getRuntime().exec("rm -f " + target_file_path);
        exit_code = process.waitFor();
      } catch (IOException delete_image_IO_exception) {
        set_request_attribute(request, "error", "이미지 삭제 중 오류:\n" + delete_image_IO_exception.getMessage(), null);
      } catch (InterruptedException interruptedException) {
        set_request_attribute(request, "error", "이미지 삭제 중 exit_code " + exit_code + ":\n" + interruptedException.getMessage(), null);
      }
    } else {
      set_request_attribute(request, "error", "이미지 삭제 중 오류, 해당 파일이 존재하지 않음.", null);
    }

    if(new File(target_located_path).exists()) {
      File[] files = new File(target_located_path).listFiles();
      if(files != null) {
        for (File file : files) {
          uploaded_image_paths.add(":4000/" + target_located_url_path + "/" + file.getName());
        }
      }
    }
    set_request_attribute(request, "success", "이미지 삭제 완료", uploaded_image_paths);
  }

  private void delete_all_image_files(HttpServletRequest request, String user_idx) {
    if (user_idx == null || user_idx.isEmpty()) {
      set_request_attribute(request, "error", "user_idx 값은 필수임.", null);
      System.out.println("error: user_idx required");
      return;
    }

    String target_path = "/var/www/html/upload_tmp/" + user_idx;
    if(new File(target_path).exists()) {
      try {
        Runtime.getRuntime().exec("rm -rf " + target_path);
        set_request_attribute(request, "success", "이미지 전체 삭제 완료", null);
      } catch (IOException delete_all_IO_exception) {
        set_request_attribute(request, "error", "이미지 삭제 중 오류:\n" + delete_all_IO_exception.getMessage(), null);
        System.out.println("error: delete IO exception");
        delete_all_IO_exception.printStackTrace();
      }
    } else {
      set_request_attribute(request, "error", "삭제 대상이 없습니다.", null);
      System.out.println("error: target path not exist");
    }
  }

  private double calculate_scale_factor(long file_size) {
    return Math.sqrt((double) 100 * 1024 / file_size);
  }

  private void set_request_attribute(HttpServletRequest request, String status, String message, List<String> image_names) {
    request.setAttribute("status", status);
    request.setAttribute("message", message);
    if(image_names != null && !image_names.isEmpty()) {
      request.setAttribute("image_names", image_names);
    }
  }
}