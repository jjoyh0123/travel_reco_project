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
  public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
    BufferedReader reader = request.getReader();
    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = reader.readLine()) != null) {
      sb.append(line);
    }

    JSONObject requestData = new JSONObject(sb.toString());

    // System.out.printf("sb: %s\n", sb.toString());

    // System.out.printf("user_idx: %s\n", requestData.getString("user_idx"));
    // System.out.printf("area_code: %s\n", requestData.getString("area_code"));
    // System.out.printf("title: %s\n", requestData.getString("title"));
    // System.out.printf("start_date: %s\n", requestData.getString("start_date"));
    // System.out.printf("end_date: %s\n", requestData.getString("end_date"));
    // System.out.printf("status: %s\n", requestData.getString("status"));
    // System.out.printf("dates: %s\n", requestData.getJSONObject("dates"));
    /*
    * dates: {
    *   "2025-02-08":[
    *     {
    *       "thumbnail":"http://tong.visitkorea.or.kr/cms/resource/11/2889211_image3_1.jpg",
    *       "content_id":"2928947",
    *       "content_type_id":1,
    *       "map_x":126.9817485525,
    *       "map_y":37.5647822864,
    *       "time":"00:00",
    *       "title":"가네시 롯데본점"
    *     }
    *   ],
    *   "2025-02-07":[
    *     {
    *       "thumbnail":"http://tong.visitkorea.or.kr/cms/resource/08/2871008_image3_1.JPG",
    *       "content_id":"2871024",
    *       "content_type_id":1,
    *       "map_x":127.0377755568,
    *       "map_y":37.5099674377,
    *       "time":"00:00",
    *       "title":"가나돈까스의집"
    *     }
    *   ]
    * }
    * */

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
      // for (int i = 0; i < places.length(); i++) {
        // JSONObject place = places.getJSONObject(i);
        // boolean success = PlanDAO.insertPlace(planIdx, dateIdx, i + 1, place);
        // if (!success) {
        //   return jsonResponse(response, false, "Failed to save place: " + place.getString("title"));
        // }
      // }
    }

    request.setAttribute("jsonResponseText", new Gson().toJson("{\"success\":\"true\"}"));
    return "/planning2.jsp";
  }

  // private String jsonResponse(HttpServletResponse response, boolean success, String error) throws IOException {
  //   response.setContentType("application/json");
  //   Map<String, Object> resMap = new HashMap<>();
  //   resMap.put("success", success);
  //   if (error != null) resMap.put("error", error);
  //   response.getWriter().write(new JSONObject(resMap).toString());
  //   return null;
  // }
}
