package action;

import mybatis.dao.SignupDAO;
import mybatis.dao.UserDAO;
import mybatis.vo.UserVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SignupAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String email = request.getParameter("email");
    String pw = request.getParameter("password");
    String nick = request.getParameter("nickname");

    // 중복 체크
    boolean isDuplicateEmail = SignupDAO.emailCheck(email);
    boolean isDuplicateNick = SignupDAO.nickCheck(nick);

    if (isDuplicateEmail || isDuplicateNick) {
      request.setAttribute("errorMessage", "이메일 또는 닉네임이 이미 사용 중입니다.");
      return "jsp/signup.jsp";
    }

    // 회원 정보 저장
    SignupDAO.signup(email, pw, nick);

    // 회원가입 성공 후 자동 로그인 처리
    UserVO user = UserDAO.login_check(email, pw);

    if (user != null) {
      // 세션에 사용자 정보와 프로필 사진 저장
      String emailLoginProfileImg = "https://cdn-icons-png.flaticon.com/512/847/847969.png";

      HttpSession session = request.getSession();
      session.setAttribute("profileImg", emailLoginProfileImg);
      session.setAttribute("email", email);
      session.setAttribute("user", user);
      session.setAttribute("signupSuccess", true);

      // 메인 페이지로 리다이렉트
      return "jsp/index.jsp";

    } else {
      // 로그인 실패 시 (정상적이라면 발생하지 않음)
      request.setAttribute("errorMessage", "자동 로그인에 실패했습니다.");
      return "jsp/emailLogin.jsp";
    }
  }
}
