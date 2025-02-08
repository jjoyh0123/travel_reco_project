package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IndexAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    if(request.getAttribute("action") == null) return "jsp/index.jsp";
    else return "jsp/error.jsp";
  }
}
