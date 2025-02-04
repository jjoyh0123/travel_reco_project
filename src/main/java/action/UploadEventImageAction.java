package action;

import mybatis.dao.ImageDAO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.List;

public class UploadEventImageAction implements Action {
  private static final String UPLOAD_DIR = "/var/www/html/upload_img/event/";
  private static final long MAX_FILE_SIZE = 2 * 1024 * 1024; // 2MB

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    try {
      DiskFileItemFactory factory = new DiskFileItemFactory();
      ServletFileUpload upload = new ServletFileUpload(factory);
      upload.setHeaderEncoding("UTF-8");
      upload.setSizeMax(MAX_FILE_SIZE);
      List<FileItem> items = upload.parseRequest(request);

      // 필수 파라미터 설정
      String type = null;
      String idx = null;

      for (FileItem item : items) {
        /*
        * item 1 (name="type")
        * name=null, StoreLocation=null, size=3 bytes, isFormField=true, FieldName=type
        * item 2 (name="idx")
        * name=null, StoreLocation=null, size=1 bytes, isFormField=true, FieldName=idx
        * item 3 (이미지파일)
        * name=crossburnpurp.gif,
        * StoreLocation=D:\Code\SIST_JSP\Util\apache-tomcat-9.0.98-windows-x64\apache-tomcat-9.0.98\temp\\upload_329481e1_e4e4_40c2_9173_e2ec12480cc2_00000002.tmp,
        * (unicode escape로 인해 \\임의 변경)
        * size=18034 bytes, isFormField=false, FieldName=file
        */
        if (item.isFormField()) {
          String fieldName = item.getFieldName();
          String fieldValue = item.getString("UTF-8");

          if ("type".equals(fieldName)) {
            type = fieldValue;
          } else if ("idx".equals(fieldName)) {
            idx = fieldValue;
          }
        }
      }

      // 파라미터 검증
      if (type == null || type.isEmpty() || idx == null || idx.isEmpty()) {
        set_request_attribute(request, "error", "type 및 idx 파라미터는 필수입니다.", null);
        return "jsp/upload_event_image_result.jsp";
      }

      String upload_image_path = null;
      StringBuilder upload_image_path_builder = new StringBuilder("upload_img/event/");

      // 이미지 경로 내부에 idx로 시작하는 파일 삭제
      File directory = new File(UPLOAD_DIR);
      String final_idx = idx;
      File[] files = directory.listFiles((dir, name) -> name.startsWith(final_idx));
      if(files != null) {
        for(File file : files) {
          if(file.isFile() && !file.delete()) {
            set_request_attribute(request, "error", "기존 파일 삭제 실패", null);
            return "jsp/upload_event_image_result.jsp";
          }
        }
      }

      if (type.equals("modify")) {
        for (FileItem item : items) {
          if (!item.isFormField()) {
            String upload_file_name = item.getName(); // item.getName() == [image_name.extension]
            if (upload_file_name != null && !upload_file_name.isEmpty()) {
              String extension = FilenameUtils.getExtension(upload_file_name);
              String new_file_name = idx + "." + extension;

              // 신규 이미지 업로드
              if (type.equals("modify")) {
                try (InputStream is = item.getInputStream()) {
                  Files.copy(is, new File(UPLOAD_DIR + new_file_name).toPath());
                  upload_image_path_builder.append(new_file_name);
                  upload_image_path = upload_image_path_builder.toString();
                } catch (IOException innerException) {
                  innerException.printStackTrace();
                  set_request_attribute(request, "error", "이미지 업로드 중 오류: " + innerException.getMessage(), null);
                  new File(UPLOAD_DIR + new_file_name).delete();
                  return "jsp/upload_event_image_result.jsp";
                }
              }
            }
          }
        }

        // 이미지 파일 권한 변경
        try {
          Runtime.getRuntime().exec("chown -R www-data:www-data " + UPLOAD_DIR);
        } catch (IOException e) {
          e.printStackTrace();
          set_request_attribute(request, "error", "파일 소유자 변경 중 오류 발생: " + e.getMessage(), null);
          return "jsp/upload_event_image_result.jsp";
        }

        set_request_attribute(request, "success", "파일 업로드 완료!", upload_image_path);
      } else if(type.equals("delete")) {
        set_request_attribute(request, "success", "파일 삭제 완료!", upload_image_path);
      }

      // DB file_path UPDATE
      int cnt = ImageDAO.update_event_image_path(idx, upload_image_path);
      if(cnt == 0) {
        set_request_attribute(request, "error", "파일이 업로드 되었으나 DB에서 업데이트 되지 않음.", null);
      }

      return "jsp/upload_event_image_result.jsp";
    } catch (Exception multipartException) {
      multipartException.printStackTrace();
      set_request_attribute(request, "error", "MultipartRequest 생성 중 오류: " + multipartException.getMessage(), null);
      return "jsp/upload_event_image_result.jsp";
    }
  }

  public void set_request_attribute(HttpServletRequest request, String status, String message, String upload_image_path) {
    request.setAttribute("status", status);
    request.setAttribute("message", message);
    if(upload_image_path != null && !upload_image_path.isEmpty()) {
      request.setAttribute("upload_image_path", upload_image_path);
    }
  }
}