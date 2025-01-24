// package action;
//
// import javax.servlet.http.HttpServletRequest;
// import javax.servlet.http.HttpServletResponse;
//
// public class DestinationPickerAction implements Action {
//   @Override
//   public String execute(HttpServletRequest request, HttpServletResponse response) {
//     // Retrieve selected area_code
//     String areaCode = request.getParameter("area_code");
//
//     // Save into session
//     if (areaCode != null) {
//       request.getSession().setAttribute("areaCode", areaCode);
//     }
//
//     // Redirect to the next step or a confirmation page
//     return "/confirmation.jsp";
//   }
// }

package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DestinationPickerAction implements Action {
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

    // This action now directly redirects to destination_picker.jsp
    return "/destination_picker.jsp";
  }
}
