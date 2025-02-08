package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class KakaoLoginAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    System.out.println("KakaoLoginAction");
    return "jsp/kakao_login.jsp";
  }
}
