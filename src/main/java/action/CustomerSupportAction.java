package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CustomerSupportAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    return "jsp/customer_support.jsp";
  }
}
