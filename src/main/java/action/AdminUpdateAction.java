package action;

import mybatis.dao.NoticeDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AdminUpdateAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String idx = request.getParameter("idx");
    String status = request.getParameter("status");
    if (idx != null && !idx.isEmpty()) {
      if (status.equals("1")) {
        NoticeDAO.restoreNotice(idx);
      } else {
        NoticeDAO.deleteNotice(idx);
      }
      RequestDispatcher dispatcher = request.getRequestDispatcher("Controller?type=admin&tab=notice");
      try {
        dispatcher.forward(request, response);
      } catch (ServletException | IOException e) {
        throw new RuntimeException(e);
      }
    }
    return "admin_main.jsp";
  }
}
