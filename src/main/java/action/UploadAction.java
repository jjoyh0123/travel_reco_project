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

public class UploadAction implements Action {
  private static final String UPLOAD_DIR = "/var/www/html/upload_img";
  private static final long MAX_FILE_SIZE = 2 * 1024 * 1024; // 2MB

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    List<String> uploadedFileNames = new ArrayList<>();

    try {
      DiskFileItemFactory factory = new DiskFileItemFactory();
      ServletFileUpload upload = new ServletFileUpload(factory);
      upload.setHeaderEncoding("UTF-8");
      upload.setSizeMax(MAX_FILE_SIZE);

      List<FileItem> items = upload.parseRequest(request);

      // 폼 필드에서 파라미터 값 가져오기
      String contentType = null;
      String user_idx = null;
      String journal_idx = null;
      String review_idx = null;

      for (FileItem item : items) {
        if (item.isFormField()) {
          String fieldName = item.getFieldName();
          String fieldValue = item.getString("UTF-8");

          if ("content_type".equals(fieldName)) {
            contentType = fieldValue;
          } else if ("user_idx".equals(fieldName)) {
            user_idx = fieldValue;
          } else if ("journal_idx".equals(fieldName)) {
            journal_idx = fieldValue;
          } else if ("review_idx".equals(fieldName)) {
            review_idx = fieldValue;
          }
        }
      }

      // 파라미터 값 확인
      if (contentType == null || contentType.isEmpty() || user_idx == null || user_idx.isEmpty()) {
        request.setAttribute("status", "error");
        request.setAttribute("message", "content_type 및 user_idx 파라미터는 필수입니다.");
        return "jsp/upload_result.jsp";
      }

      for (FileItem item : items) {
        if (!item.isFormField()) {
          String originalFileName = item.getName();
          if (originalFileName != null && !originalFileName.isEmpty()) {
            String extension = FilenameUtils.getExtension(originalFileName);
            String uuid = UUID.randomUUID().toString();
            String fileName = uuid + "." + extension;

            String originalFilePath = null;

            if ("journal".equals(contentType)) {
              if (journal_idx == null || journal_idx.isEmpty()) {
                request.setAttribute("status", "error");
                request.setAttribute("message", "journal_idx 파라미터는 필수입니다.");
                return "jsp/upload_result.jsp";
              }
              originalFilePath = UPLOAD_DIR + File.separator + user_idx + File.separator + "journal" + File.separator + journal_idx + File.separator + fileName;
            } else if ("review".equals(contentType)) {
              if (review_idx == null || review_idx.isEmpty()) {
                request.setAttribute("status", "error");
                request.setAttribute("message", "review_idx 파라미터는 필수입니다.");
                return "jsp/upload_result.jsp";
              }
              originalFilePath = UPLOAD_DIR + File.separator + user_idx + File.separator + "review" + File.separator + review_idx + File.separator + fileName;
            } else {
              request.setAttribute("status", "error");
              request.setAttribute("message", "잘못된 content_type 값입니다.");
              return "jsp/upload_result.jsp";
            }

            File uploadDir = new File(originalFilePath.substring(0, originalFilePath.lastIndexOf(File.separator)));
            if (!uploadDir.exists()) {
              if (!uploadDir.mkdirs()) {
                request.setAttribute("status", "error");
                request.setAttribute("message", "업로드 디렉토리를 생성하지 못했습니다: " + uploadDir.getPath());
                return "jsp/upload_result.jsp";
              }
            }

            String resizedFilePath = originalFilePath.substring(0, originalFilePath.lastIndexOf(File.separator)) + File.separator + "resized_" + fileName;

            File uploadedFile = new File(originalFilePath);
            item.write(uploadedFile);

            try (InputStream is = Files.newInputStream(uploadedFile.toPath())) {
              long fileSize = Files.size(uploadedFile.toPath());
              if (fileSize > 100 * 1024) {
                Thumbnails.of(uploadedFile)
                    .scale(0.5)
                    .toFile(new File(resizedFilePath));
              } else {
                Files.copy(uploadedFile.toPath(), new File(resizedFilePath).toPath());
              }

              uploadedFileNames.add(fileName);

            } catch (IOException innerException) {
              innerException.printStackTrace();
              request.setAttribute("status", "error");
              request.setAttribute("message", "리사이징 중 오류: " + innerException.getMessage());
              new File(originalFilePath).delete();
              return "jsp/upload_result.jsp";
            }
          }
        }
      }

      request.setAttribute("status", "success");
      request.setAttribute("message", "파일들이 업로드되고 크기가 조정되었습니다!");
      request.setAttribute("fileNames", uploadedFileNames);
      return "jsp/upload_result.jsp";

    } catch (Exception multipartException) {
      multipartException.printStackTrace();
      request.setAttribute("status", "error");
      request.setAttribute("message", "MultipartRequest 생성 중 오류: " + multipartException.getMessage());
      return "jsp/upload_result.jsp";
    }
  }
}