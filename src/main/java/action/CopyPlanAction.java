package action;

import mybatis.dao.PlanDAO;
import mybatis.vo.PlanVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

import static mybatis.dao.PlanDAO.*;

public class CopyPlanAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
    // Check that the user is logged in.
    request.getSession().setAttribute("user_idx", "58");
    String sessionUserIdx = (String) request.getSession().getAttribute("user_idx");
    System.out.println(sessionUserIdx);
    if (sessionUserIdx == null) {
      // Redirect to login page if not logged in.
      return "/jsp/login.jsp";
    }

    String planId = request.getParameter("planId");
    PlanVO origPlan = getPlanById(planId);
    if (origPlan == null) {
      request.setAttribute("error", "Plan not found.");
      return "/jsp/error.jsp";
    }

    // If the logged-in user is the owner, do not allow copying.
    if (sessionUserIdx.equals(origPlan.getUser_idx())) {
      return "Controller?type=viewPlan&planId=" + planId;
    }

    // Check if the new start/end dates are provided.
    String newStartDate = request.getParameter("newStartDate");
    String newEndDate = request.getParameter("newEndDate");
    if (newStartDate == null || newEndDate == null) {
      // Forward to date picker if dates are not yet provided.
      request.setAttribute("plan", origPlan);
      return "date_picker2.jsp";
    }

    // Copy the plan with the new date range.
    int newPlanId = PlanDAO.copyPlan(planId, sessionUserIdx, newStartDate, newEndDate);

    return "Controller?type=my_trip_plan";
  }

}