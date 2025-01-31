package action;

import mybatis.dao.PlanDAO;
import mybatis.vo.PlanVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PlanConfirmAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    // Retrieve session attributes
    String startDate = (String) request.getSession().getAttribute("startDate");
    String endDate = (String) request.getSession().getAttribute("endDate");
    String areaCode = request.getParameter("area_code");
    // String startDate = request.getParameter("start_date");
    // String endDate = request.getParameter("end_date");

    System.out.println("confirm.areaCode : " + areaCode);
    System.out.println("confirm.startDate : " + startDate);
    System.out.println("confirm.endDate : " + endDate);

    if (startDate == null || endDate == null || areaCode == null) {
      // Redirect to error page if any data is missing
      return "/error.jsp";
    }

    // ✅ Store areaCode in session
    request.getSession().setAttribute("areaCode", areaCode);

    // Create a new PlanVO object
    PlanVO plan = new PlanVO();
    plan.setUser_idx("1"); // Temporary user_idx, replace with actual user_idx
    plan.setArea_code(areaCode);
    plan.setTitle("Default Title"); // Replace with dynamic title if needed
    plan.setStart_date(startDate);
    plan.setEnd_date(endDate);
    plan.setStatus("0"); // Default status: 0 (active)

    // Save to the database
    // try (SqlSession ss = FactoryService.getFactory().openSession()) {
    //   PlanDAO dao = new PlanDAO(ss);
    //   int cnt = dao.insertPlan(plan); // Insert plan into the database
    //   if (cnt > 0) {
    //     ss.commit();  // Commit the transaction
    //   } else {
    //     ss.rollback();
    //   }
    //   System.out.println(cnt);
    // } catch (Exception e) {
    //   e.printStackTrace();
    //   return "/error.jsp"; // Redirect to error page if saving fails
    // }

    PlanDAO.insertPlan(plan);

    // // Clear session data
    // request.getSession().removeAttribute("startDate");
    // request.getSession().removeAttribute("endDate");

    // ✅ Keep session attributes (startDate, endDate, areaCode)

    // Redirect to planning page
    return "/planning.jsp";
  }
}
