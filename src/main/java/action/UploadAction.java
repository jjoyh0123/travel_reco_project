package action;

import mybatis.dao.ImageDAO;
import mybatis.vo.ImageVO;
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

      // Set & get required parameter
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

      // Parameter validation
      if (contentType == null || contentType.isEmpty() || user_idx == null || user_idx.isEmpty()) {
        setRequestAttributes(request, "error", "content_type 및 user_idx 파라미터는 필수입니다.", null);
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
            StringBuilder uploaded_img_path = new StringBuilder("upload_img/");
            uploaded_img_path.append(user_idx).append("/").append(contentType).append("/");
            ImageVO imageVO = new ImageVO();

            // Check parameter & set VO
            if ("journal".equals(contentType)) {
              if (journal_idx == null || journal_idx.isEmpty()) {
                setRequestAttributes(request, "error", "journal_idx 파라미터는 필수입니다.", null);
                return "jsp/upload_result.jsp";
              }
              originalFilePath = UPLOAD_DIR + File.separator + user_idx + File.separator + contentType + File.separator + journal_idx + File.separator + fileName;
              uploaded_img_path.append(journal_idx).append("/");
              imageVO.setJournal_idx(journal_idx);
            } else if ("review".equals(contentType)) {
              if (review_idx == null || review_idx.isEmpty()) {
                setRequestAttributes(request, "error", "review_idx 파라미터는 필수입니다.", null);
                return "jsp/upload_result.jsp";
              }
              originalFilePath = UPLOAD_DIR + File.separator + user_idx + File.separator + contentType + File.separator + review_idx + File.separator + fileName;
              uploaded_img_path.append(review_idx).append("/");
              imageVO.setReview_idx(review_idx);
            } else {
              setRequestAttributes(request, "error", "잘못된 content_type 값입니다.", null);
              return "jsp/upload_result.jsp";
            }
            imageVO.setType(contentType);

            // mkdirs
            File uploadDir = new File(originalFilePath.substring(0, originalFilePath.lastIndexOf(File.separator)));
            if (!uploadDir.exists()) {
              if (!uploadDir.mkdirs()) {
                setRequestAttributes(request, "error", "업로드 디렉토리를 생성하지 못했습니다: " + uploadDir.getPath(), null);
                return "jsp/upload_result.jsp";
              }
            }

            try (InputStream is = item.getInputStream()) {
              long fileSize = is.available();
              if (fileSize > 100 * 1024) {
                // save resized image
                String resizedFilePath = originalFilePath.substring(0, originalFilePath.lastIndexOf(File.separator)) + File.separator + "resized_" + fileName;
                double scaleFactor = calculateScaleFactor(fileSize);
                Thumbnails.of(is)
                    .scale(scaleFactor)
                    .toFile(new File(resizedFilePath));
                uploaded_img_path.append("resized_").append(fileName);
                uploadedFileNames.add(uploaded_img_path.toString());
              } else {
                // save original image
                Files.copy(is, new File(originalFilePath).toPath());
                uploaded_img_path.append(fileName);
                uploadedFileNames.add(uploaded_img_path.toString());
              }
            } catch (IOException innerException) {
              innerException.printStackTrace();
              setRequestAttributes(request, "error", "리사이징 중 오류: " + innerException.getMessage(), null);
              new File(originalFilePath).delete();
              return "jsp/upload_result.jsp";
            }

            imageVO.setFile_path(uploaded_img_path.toString());
            ImageDAO.insert_image_path(imageVO);
          }
        }
      }

      // chown
      try {
        Runtime.getRuntime().exec("chown -R www-data:www-data " + UPLOAD_DIR + File.separator + user_idx);
      } catch (IOException e) {
        e.printStackTrace();
        setRequestAttributes(request, "error", "파일 소유자 변경 중 오류 발생: " + e.getMessage(), null);
        return "jsp/upload_result.jsp";
      }

      setRequestAttributes(request, "success", "파일들이 업로드되고 크기가 조정되었습니다!", uploadedFileNames);
      return "jsp/upload_result.jsp";

    } catch (Exception multipartException) {
      multipartException.printStackTrace();
      setRequestAttributes(request, "error", "MultipartRequest 생성 중 오류: " + multipartException.getMessage(), null);
      return "jsp/upload_result.jsp";
    }
  }

  public double calculateScaleFactor(long fileSize) {
    return Math.sqrt((double) 100 * 1024 / fileSize);
  }

  public void setRequestAttributes(HttpServletRequest request, String status, String message, List<String> fileNames) {
    request.setAttribute("status", status);
    request.setAttribute("message", message);
    if(fileNames != null && !fileNames.isEmpty()) {
      request.setAttribute("fileNames", fileNames);
    }
  }
}