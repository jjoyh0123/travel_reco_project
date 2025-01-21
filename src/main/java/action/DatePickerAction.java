package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DatePickerAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    return "/date_picker.jsp";
  }
}
