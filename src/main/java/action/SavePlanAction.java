package action;

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
  public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
    BufferedReader reader = request.getReader();
    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = reader.readLine()) != null) {
      sb.append(line);
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
      return jsonResponse(response, false, "Failed to save plan.");
    }

    JSONObject dates = requestData.getJSONObject("dates");
    System.out.println(dates.toString());
    for (String dateKey : dates.keySet()) {
      int dateIdx = PlanDAO.insertDate(planIdx, dateKey);
      System.out.println("Plan idx: " + planIdx);
      System.out.println("Inserting date for: " + dateKey + " with dateIdx: " + dateIdx);
      if (dateIdx == -1) {
        return jsonResponse(response, false, "Failed to save date: " + dateKey);
      }

      JSONArray places = dates.getJSONArray(dateKey);
      for (int i = 0; i < places.length(); i++) {
        JSONObject place = places.getJSONObject(i);
        boolean success = PlanDAO.insertPlace(planIdx, dateIdx, i + 1, place);
        if (!success) {
          return jsonResponse(response, false, "Failed to save place: " + place.getString("title"));
        }
      }
    }

    return jsonResponse(response, true, null);
  }

  private String jsonResponse(HttpServletResponse response, boolean success, String error) throws IOException {
    response.setContentType("application/json");
    Map<String, Object> resMap = new HashMap<>();
    resMap.put("success", success);
    if (error != null) resMap.put("error", error);
    response.getWriter().write(new JSONObject(resMap).toString());
    return null;
  }
}
