package action;

import mybatis.vo.UserVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateUserAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String idx = request.getParameter("idx");
    String email = request.getParameter("email");
    String nick = request.getParameter("nick");
    String pw = request.getParameter("pw");
    String status = request.getParameter("status");

    UserVO vo = new UserVO();
    vo.setIdx(idx);
    vo.setEmail(email);
    vo.setNick(nick);
    vo.setPw(pw);
    vo.setStatus(status);

    boolean success = false;
    request.setAttribute("success", success);
    return "update.jsp";
  }
}
