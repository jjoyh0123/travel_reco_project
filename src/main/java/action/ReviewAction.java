package action;

import mybatis.dao.ReviewDAO;
import mybatis.vo.ReviewVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ReviewAction implements Action{
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String reviewText = request.getParameter("review");
    String rateParam = request.getParameter("rate");

    // 별점이 선택되지 않았다면 응답을 반환
    if (rateParam == null || rateParam.isEmpty() || reviewText == null || reviewText.isEmpty()) {
      return "별점을 선택하세요!";
    }

    // double rate = Double.parseDouble(rateParam);
    String rate = rateParam;

    // ReviewVO 객체 생성 및 데이터 저장
    ReviewVO reviewVO = new ReviewVO();
    reviewVO.setReview(reviewText);
    reviewVO.setRate(rate);

    // DAO를 통해 데이터 저장
    ReviewDAO.insertReview(reviewVO);

    // AJAX 요청이므로 응답을 직접 반환
    try {
      response.setContentType("text/plain; charset=UTF-8");
      response.getWriter().write("저장 완료");
    } catch (IOException e) {
      e.printStackTrace();
    }

    return null; // AJAX이므로 viewPath 필요 없음
  }
}
