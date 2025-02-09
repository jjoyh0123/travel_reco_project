package action.planning;

import action.Action;
import com.google.gson.Gson;
import mybatis.dao.PlanDAO;
import mybatis.vo.PlanVO;
import mybatis.vo.planning.TouristSpotVO;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class PlanningAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String action = request.getParameter("action");

    if (!action.equals("date_select") && !action.equals("destination_select") && !action.equals("confirm") && !action.equals("planning") && !action.equals("get_tour_spot") && !action.equals("save_plan")) {
      return "/error.jsp";
    } else {
      switch (action) {
        case "date_select":
          return "jsp/planning/date_select.jsp";
        case "destination_select":
          return "jsp/planning/destination_select.jsp";
        case "confirm":
          return "jsp/planning/confirm.jsp";
        case "planning":
          return "jsp/planning/planning.jsp";
        case "get_tour_spot":
          return get_tour_spot(request);
        case "save_plan":
          return save_plan(request);
        default:
          return "/jsp/error.jsp";
      }
    }
  }

  private String get_tour_spot(HttpServletRequest request) {
    String json_response;
    JSONObject json_object = new JSONObject();

    String area_code = request.getParameter("area_code") != null ? request.getParameter("area_code") : "1";
    String page = request.getParameter("page") != null ? request.getParameter("page") : "1";
    String content_type_id = request.getParameter("content_type_id");

    if(content_type_id != null && content_type_id.equals("fav") && request.getSession().getAttribute("user_idx") != null) {
      String user_idx = request.getSession().getAttribute("user_idx").toString();
      List<TouristSpotVO> list = PlanDAO.get_favorite_place(user_idx);

      json_object.put("status", "success");
      json_object.put("data", list);
    }

    StringBuilder api_URL = new StringBuilder("http://apis.data.go.kr/B551011/KorService1/areaBasedList1?");
    api_URL.append("serviceKey=v%2BHAli1W1AWCpXPRa5gf1hhL1rbEK%2BRGlCdQXZ4ShmnPl2YYNj0%2F7eTcZy9pAQzxFifJ647n5MXrQ%2Bf2ygvNmA%3D%3D");
    api_URL.append("&MobileOS=ETC");
    api_URL.append("&MobileApp=MyApp");
    api_URL.append("&_type=json");
    api_URL.append("&numOfRows=10");
    api_URL.append("&pageNo=").append(page);
    api_URL.append("&areaCode=").append(area_code);
    api_URL.append("&arrange=O"); // A:제목순 C:수정일순 D:생성일순 + 대표이미지있는 정렬 O:제목순 Q:수정일순 R: 생성일순
    if (content_type_id != null && !content_type_id.equals("all")) api_URL.append("&contentTypeId=").append(content_type_id);
    // http://apis.data.go.kr/B551011/KorService1/areaBasedList1?serviceKey=v%2BHAli1W1AWCpXPRa5gf1hhL1rbEK%2BRGlCdQXZ4ShmnPl2YYNj0%2F7eTcZy9pAQzxFifJ647n5MXrQ%2Bf2ygvNmA%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=MyApp&_type=json&areaCode=1&arrange=O
    /*
    {
      "response": {
        "header": {
          "resultCode": "0000",
          "resultMsg": "OK"
        },
        "body": {
          "items": {
            "item": [
              {
                "addr1": "서울특별시 강남구 테헤란로13길 65",
    */

    try {
      URL url = new URL(api_URL.toString());
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("GET");

      StringBuilder api_res_text = new StringBuilder();
      BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
      String line;
      while ((line = br.readLine()) != null) {
        api_res_text.append(line);
      }
      br.close();

      JSONObject api_res_json = new JSONObject(api_res_text.toString());

      if (api_res_json.has("response") && api_res_json.getJSONObject("response").has("header")) {
        JSONObject header = api_res_json.getJSONObject("response").getJSONObject("header");
        String result_code = header.getString("resultCode");
        ArrayList<TouristSpotVO> spots = new ArrayList<>();

        if (result_code.equals("0000") && api_res_json.has("response") && api_res_json.getJSONObject("response").getJSONObject("body").getJSONObject("items").has("item")) {
          JSONArray items = api_res_json.getJSONObject("response").getJSONObject("body").getJSONObject("items").getJSONArray("item");

          for (int i = 0; i < items.length(); i++) {
            JSONObject item = items.getJSONObject(i);
            TouristSpotVO spot = new TouristSpotVO();
            spot.setArea_code(area_code);
            spot.setContent_id(item.optString("contentid", ""));
            spot.setContent_type_id(item.getString("contenttypeid"));
            spot.setTitle(item.getString("title"));
            spot.setAddress(item.optString("addr1", "주소 없음"));
            spot.setThumbnail(item.optString("firstimage2", "https://dummyimage.com/50"));
            spot.setMap_x(item.optDouble("mapx", 0.0));
            spot.setMap_y(item.optDouble("mapy", 0.0));
            spots.add(spot);
          }

          json_object.put("status", "success");
          json_object.put("data", spots);
        } else {
          json_object.put("status", "success");
          json_object.put("data", spots);
        }
      } else {
        json_object.put("status", "error");
      }
    } catch (IOException e) {
      json_object.put("status", "error");
      e.printStackTrace();
    }

    request.setAttribute("json_response", json_object);
    return "jsp/planning/res_json.jsp";
  }

  private String save_plan(HttpServletRequest request) {
    JSONObject json_object = new JSONObject();
    StringBuilder sb = new StringBuilder();
    String line;

    try {
      BufferedReader reader = request.getReader();
      while ((line = reader.readLine()) != null) {
        sb.append(line);
      }

    } catch (IOException e) {
      e.printStackTrace();
      json_object.put("status", false);
      request.setAttribute("json_response", json_object);
      return "jsp/planning/res_json.jsp";
    }

    JSONObject requestData = new JSONObject(sb.toString());
    System.out.printf("Full requestData: %s\n", requestData);

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
      json_object.put("status", false);
      request.setAttribute("json_response", json_object);
      return "jsp/planning/res_json.jsp";
    }
    System.out.printf("Insert plan successfully, planIdx = %d\n", planIdx);

    JSONObject dates = requestData.getJSONObject("dates");
    System.out.printf("Full dates: %s\n", dates);
    for (String dateKey : dates.keySet()) {
      System.out.printf("in dates for, dateKey: %s\n", dateKey);
      int dateIdx = PlanDAO.insertDate(planIdx, dateKey);
      System.out.println("Inserting date, plan_idx: " + planIdx + " at " + dateKey + " with dateIdx: " + dateIdx);
      if (dateIdx == -1) {
        System.out.printf("Failed to save date, at %s.\n", dateKey);
        json_object.put("status", false);
        request.setAttribute("json_response", json_object);
        return "jsp/planning/res_json.jsp";
      }

      JSONArray places = dates.getJSONArray(dateKey);
      System.out.printf("places length: %d, places: %s\n", places.length(), places);
      for(int i = 0; i < places.length(); i++) {
        JSONObject place = places.getJSONObject(i);
        System.out.printf("in places for, plan_id: %s, dateIdx: %s\n Full place: %s\n", planIdx, dateIdx, place);
        int success_insert_place = PlanDAO.insertPlace(planIdx, dateIdx, i + 1, place);
        if(success_insert_place == 0) {
          System.out.printf("Failed to insert place, plan_idx: %s, dateKey: %s, date_idx: %s, place title: %s\n", planIdx, dateKey, dateIdx, place.getString("title"));
          json_object.put("status", false);
          request.setAttribute("json_response", json_object);
          return "jsp/planning/res_json.jsp";
        }
      }
    }

    json_object.put("status", true);
    request.setAttribute("json_response", json_object);
    return "jsp/planning/res_json.jsp";
  }
}
