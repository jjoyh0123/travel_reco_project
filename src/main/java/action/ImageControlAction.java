package action;

import mybatis.dao.ImageControlDAO;
import mybatis.vo.ImageVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ImageControlAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String planIdx = request.getParameter("planIdx"); // planIdx 받아오기
    int imageIndex = Integer.parseInt(request.getParameter("imageIndex")); // imageIndex 받아오기

    // ImageDAO를 사용해 DB에서 이미지 정보 가져오기
    ImageControlDAO imageDAO = new ImageControlDAO();
    ImageVO imageVO = imageDAO.getImage(Integer.parseInt(planIdx), imageIndex);

    boolean success = false;
    String imageUrl = null;

    if (imageVO != null) {
      success = true;
      imageUrl = imageVO.getFile_path(); // 이미지 URL 가져오기
    }

    // 성공 여부와 이미지 URL을 요청에 담기
    request.setAttribute("success", success);
    request.setAttribute("imageUrl", imageUrl);

    // JSON 응답을 위한 JSP 페이지로 포워딩
    return "jsp/update_image.jsp";  // 응답을 처리할 JSP 파일 경로
  }
}
