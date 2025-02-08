package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LogoutAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    // 세션 무효화
    request.getSession().invalidate();

    // 로그인 페이지로 포워딩 (dispatch 방식)
    return "jsp/login.jsp";
  }
}
