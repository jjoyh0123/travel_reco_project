package action;

import mybatis.dao.MyPageDAO;
import mybatis.vo.PlanVO;
import mybatis.vo.ReviewVO;
import mybatis.vo.UserVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

public class MyPageAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {

    // type 값 가져오기
    String type = request.getParameter("type");

    UserVO user = (UserVO) request.getSession().getAttribute("user");
    try {
      int userId = user.getIdx();

      // 데이터 생성 (예시 데이터)
      if ("my_trip_plan".equals(type)) {
        List<PlanVO> myTrips = MyPageDAO.getPlanByUser(userId);
        request.setAttribute("myTrips", myTrips);
      } else if ("my_trip_review".equals(type)) {
        List<ReviewVO> myReviews = MyPageDAO.getJournalByUser(userId);
        request.setAttribute("myReviews", myReviews);
      } else if ("my_review_history".equals(type)) {
        List<ReviewVO> myReviewHistory = MyPageDAO.getReviewHistoryByUser(userId);
        request.setAttribute("myReviewHistory", myReviewHistory);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    return "jsp/my_page.jsp";
  }
}
