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
      return "jsp/login.jsp";  // 로그인 상태가 아닐 경우 로그인 페이지로 이동
    }

    // 입력된 비밀번호 가져오기
    String inputPassword = request.getParameter("password");

    // DB에서 비밀번호 조회
    String storedPassword = UserDAO.getPassword(currentUser.getIdx());

    // 비밀번호 검증
    if (storedPassword == null || !storedPassword.equals(inputPassword)) {
      request.setAttribute("msg", "비밀번호가 일치하지 않습니다.");
      return "jsp/profile_update.jsp";  // JSP로 메시지를 전달하며 포워딩
    }

    // 회원탈퇴 처리
    if (UserDAO.deactivateUser(currentUser.getIdx())) {
      session.invalidate();  // 세션 무효화
      return "jsp/delete_account_page.jsp";  // 탈퇴 성공 시 완료 페이지로 이동
    } else {
      request.setAttribute("msg", "회원탈퇴에 실패했습니다.");
      return "jsp/profile_update.jsp";  // 탈퇴 실패 시 메시지 출력
    }
  }

}