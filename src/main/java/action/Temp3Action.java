package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Temp3Action implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    return "temp3.jsp";
  }
}
