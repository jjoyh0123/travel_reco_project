package action.planning;

import action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PlanningAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String action = request.getParameter("action");

    if(!action.equals("date_select") && !action.equals("destination_select") && !action.equals("confirm") && !action.equals("planning")) {
      return "/error.jsp";
    }
    else {
      switch (action) {
        case "date_select":
          return "jsp/planning/date_select.jsp";
        case "destination_select":
          return "jsp/planning/destination_select.jsp";
        case "confirm":
          return "jsp/planning/confirm.jsp";
        case "planning":
          return "jsp/planning/planning.jsp";
        default:
          return "error.jsp";
      }
    }
  }
}
