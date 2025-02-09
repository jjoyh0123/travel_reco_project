package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DatePickerAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    // Retrieve start_date and end_date from the request parameters
    String startDate = request.getParameter("start_date");
    String endDate = request.getParameter("end_date");

    // Save into session if the dates are present
    if (startDate != null && endDate != null) {
      request.getSession().setAttribute("startDate", startDate);
      request.getSession().setAttribute("endDate", endDate);
    }

    System.out.println("Start Date: " + startDate);
    System.out.println("End Date: " + endDate);

    // Redirect to destination picker page (or any other page)
    return "/date_picker.jsp";
  }
}
