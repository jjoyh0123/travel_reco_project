package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DestinationPickerAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    return "/destination_picker.jsp";
  }
}
