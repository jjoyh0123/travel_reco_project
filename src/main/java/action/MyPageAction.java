package action;

import mybatis.dao.MyPageDAO;
import mybatis.vo.PlanVO;
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
    int userId = user.getIdx();

    // 데이터 생성 (예시 데이터)
    if ("my_trip_plan".equals(type)) {
      List<PlanVO> myTrips = MyPageDAO.getPlanByUser(userId);
      request.setAttribute("myTrips", myTrips);
    } else if ("my_trip_review".equals(type)) {
      List<UserVO> myReviews = new ArrayList<>();
      UserVO review1 = new UserVO();
      review1.setNick("후기1");
      review1.setEmail("review1@example.com");
      myReviews.add(review1);
      request.setAttribute("myReviews", myReviews);

    } else if ("my_review_history".equals(type)) {
      List<UserVO> myReviewHistory = new ArrayList<>();
      UserVO reviewHistory1 = new UserVO();
      reviewHistory1.setNick("리뷰 기록1");
      reviewHistory1.setEmail("history1@example.com");
      myReviewHistory.add(reviewHistory1);
      request.setAttribute("myReviewHistory", myReviewHistory);
    }

    return "jsp/my_page.jsp";
  }
}
