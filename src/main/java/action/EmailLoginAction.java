package action;

import mybatis.dao.UserDAO;
import mybatis.vo.UserVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EmailLoginAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    // 사용자가 입력한 이메일과 비밀번호 읽기
    String email = request.getParameter("email");
    String password = request.getParameter("pw");


    if (email == null || password == null) {
      // 이메일과 비밀번호가 없는 초기 상태에서는 error 설정하지 않음
      return "jsp/emailLogin.jsp";
    }

    UserVO user = UserDAO.login_check(email, password);

    if (user != null) {
      // 로그인 성공 - 세션에 사용자 정보 저장
      String emailLoginProfileImg = "https://cdn-icons-png.flaticon.com/512/847/847969.png";

      HttpSession session = request.getSession();
      session.setAttribute("profileImg", emailLoginProfileImg);
      session.setAttribute("email", email);
      session.setAttribute("user", user);
      return "jsp/index.jsp"; // 성공 시 메인 화면으로 이동
    } else {
      // 로그인 실패 - 오류 메시지 설정
      request.setAttribute("error", "이메일 또는 비밀번호를 확인해주세요.");
      return "jsp/emailLogin.jsp"; // 로그인 화면으로 이동
    }
  }
}
