package action;

import mybatis.dao.UserDAO;
import mybatis.vo.UserVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserDeleteAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    HttpSession session = request.getSession();
    UserVO currentUser = (UserVO) session.getAttribute("user");

    if (currentUser == null) {
      return "jsp/login.jsp";  // 로그인 정보가 없을 경우 로그인 페이지로 이동
    }

    int userId = currentUser.getIdx();

    // 회원탈퇴 처리
    if (UserDAO.deactivateUser(userId)) {
      session.invalidate();  // 세션 무효화
      return "jsp/deleted.jsp";  // 탈퇴 완료 페이지로 이동
    } else {
      request.setAttribute("msg", "회원탈퇴에 실패했습니다.");
      return "jsp/updateProfile.jsp";
    }
  }
}