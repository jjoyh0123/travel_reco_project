package action;

import mybatis.vo.UserVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.List;

public class MyPageAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {

    // session에서 'type' 파라미터를 가져옵니다.
    String type = request.getParameter("type");

    // 각 'type'에 따라 다르게 처리
    if ("my_trip_plan".equals(type)) {
      // DB에서 나의 여행 데이터를 가져오는 로직
      List<UserVO> myTrips = new ArrayList<>();
      UserVO userVO = new UserVO();
      userVO.setNick("nick");
      userVO.setEmail("email");
      myTrips.add(userVO);
      myTrips.add(userVO);
      request.setAttribute("myTrips", myTrips);

    } else if ("my_trip_review".equals(type)) {
      // DB에서 나의 여행 후기 데이터를 가져오는 로직
      // 예시: List<ReviewDTO> myReviews = TripDAO.getMyReviews();
      // request.setAttribute("myReviews", myReviews);
      List<UserVO> myReviews = new ArrayList<>();
      UserVO userVO = new UserVO();
      userVO.setNick("nick");
      userVO.setEmail("email");
      myReviews.add(userVO);
      request.setAttribute("myReviews", myReviews);

    } else if ("my_review_history".equals(type)) {
      // DB에서 나의 리뷰 이력 데이터를 가져오는 로직
      // 예시: List<ReviewHistoryDTO> myReviewHistory = TripDAO.getMyReviewHistory();
      // request.setAttribute("myReviewHistory", myReviewHistory);

    }

    // 요청에 해당하는 데이터를 전달하고 my_page.jsp로 이동
    return "jsp/my_page.jsp";
  }
}
