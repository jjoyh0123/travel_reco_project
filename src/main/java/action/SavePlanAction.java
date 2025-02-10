package action;

import com.google.gson.Gson;
import mybatis.dao.PlanDAO;
import mybatis.vo.PlanVO;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class SavePlanAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    StringBuilder sb = new StringBuilder();
    String line;
    try {
      BufferedReader reader = request.getReader();
      while ((line = reader.readLine()) != null) {
        sb.append(line);
      }
    } catch (IOException e) {
      e.printStackTrace();
    }

    JSONObject requestData = new JSONObject(sb.toString());


    PlanVO plan = new PlanVO();
    plan.setUser_idx(requestData.getString("user_idx"));
    plan.setArea_code(requestData.getString("area_code"));
    plan.setTitle(requestData.getString("title"));
    plan.setStart_date(requestData.getString("start_date"));
    plan.setEnd_date(requestData.getString("end_date"));
    plan.setStatus("0"); // Default active

    int planIdx = PlanDAO.insertPlan(plan);
    if (planIdx == -1) {
      System.out.println("Failed to save plan.");
      request.setAttribute("jsonResponseText", new Gson().toJson("{\"success\":\"false\"}"));
      return "/planning2.jsp";
    }
    System.out.printf("Insert plan successfully, planIdx = %d\n", planIdx);

    JSONObject dates = requestData.getJSONObject("dates");
    // System.out.println(dates.toString());
    // int dateIdx = 1;
    for (String dateKey : dates.keySet()) {
      System.out.printf("in dates for, dateKey: %s\n", dateKey);
      int dateIdx = PlanDAO.insertDate(planIdx, dateKey);
      System.out.println("Plan idx: " + planIdx);
      System.out.println("Inserting date at " + dateKey + " with dateIdx: " + dateIdx);
      if (dateIdx == -1) {
        System.out.println("Failed to save date.");
        System.out.printf("Failed to save date, at %s.\n", dateKey);
        request.setAttribute("jsonResponseText", new Gson().toJson("{\"success\":\"false\"}"));
        return "/planning2.jsp";
      }

      JSONArray places = dates.getJSONArray(dateKey);
      System.out.printf("places length: %d, places: %s\n", places.length(), places);
      for(int i = 0; i < places.length(); i++) {
        JSONObject place = places.getJSONObject(i);
        System.out.printf("in places for, dateIdx: %s, place: %s\n", dateIdx, place);
        int success_insert_place = PlanDAO.insertPlace(planIdx, dateIdx, i + 1, place);
        if(success_insert_place == 0) {
          System.out.println("Failed to save place: " + place.getString("title"));
          request.setAttribute("jsonResponseText", new Gson().toJson("{\"success\":\"false\"}"));
          return "/planning2.jsp";
        }
      }

    }

    request.setAttribute("jsonResponseText", new Gson().toJson("{\"success\":\"true\"}"));
    return "/planning2.jsp";
  }


}
