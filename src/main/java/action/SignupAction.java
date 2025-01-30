package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybatis.dao.SignupDAO;

public class SignupAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String email = request.getParameter("email");
    String pw = request.getParameter("password");
    String nick = request.getParameter("nickname");

    boolean isDuplicateEmail = SignupDAO.emailCheck(email);
    boolean isDuplicateNick = SignupDAO.nickCheck(nick);

    if (isDuplicateEmail || isDuplicateNick) {
      request.setAttribute("errorMessage", "이메일 또는 닉네임이 이미 사용 중입니다.");
      return "jsp/signup.jsp";
    }

    // 회원 정보 저장
    SignupDAO.signup(email, pw, nick);

    // 회원가입 성공 플래그 설정
    request.setAttribute("signupSuccess", "true");

    return "jsp/signup.jsp";  // 팝업을 띄우고 index.jsp로 이동
  }
}
