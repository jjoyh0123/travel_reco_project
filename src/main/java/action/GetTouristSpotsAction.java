package action;

import mybatis.vo.TouristSpotVO;
import org.json.JSONArray;
import org.json.JSONObject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

public class GetTouristSpotsAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    // ✅ Retrieve areaCode from session
    String areaCode = (String) request.getSession().getAttribute("areaCode");
    if (areaCode == null) {
      response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing areaCode in session");
      return null;
    }
    System.out.println(areaCode);
    String apiUrl = "http://apis.data.go.kr/B551011/KorService1/areaBasedList1?"
        + "serviceKey=v%2BHAli1W1AWCpXPRa5gf1hhL1rbEK%2BRGlCdQXZ4ShmnPl2YYNj0%2F7eTcZy9pAQzxFifJ647n5MXrQ%2Bf2ygvNmA%3D%3D"
        + "&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=MyApp&_type=json&"
        + "areaCode=1&arrange=A&listYN=Y";

    URL url = new URL(apiUrl);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");

    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
    StringBuilder responseText = new StringBuilder();
    String line;
    while ((line = br.readLine()) != null) {
      responseText.append(line);
    }
    br.close();

    // ✅ Print API response for debugging
    System.out.println("API Response: " + responseText.toString());

    // ✅ Convert response to JSON
    JSONObject jsonResponse = new JSONObject(responseText.toString());

    // ✅ Validate the JSON structure
    if (!jsonResponse.has("response") ||
        !jsonResponse.getJSONObject("response").has("body") ||
        !jsonResponse.getJSONObject("response").getJSONObject("body").has("items")) {
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Invalid API response structure");
      return null;
    }


    // JSONObject jsonResponse = new JSONObject(responseText.toString());

    JSONObject bodyObj = jsonResponse.getJSONObject("response").getJSONObject("body");
    JSONObject itemsObj = bodyObj.getJSONObject("items"); // ✅ Get the "items" object


    // ✅ Check if "items" contains "item" and extract the array
    JSONArray items;
    if (itemsObj.has("item")) {
      items = itemsObj.getJSONArray("item");
      System.out.println(items.toString());
    } else {
      items = new JSONArray();  // ✅ Return empty array if no data
      System.out.println(itemsObj.toString());
    }

    ArrayList<TouristSpotVO> spots = new ArrayList<>();
    for (int i = 0; i < items.length(); i++) {
      JSONObject item = items.getJSONObject(i);
      TouristSpotVO spot = new TouristSpotVO();
      spot.setTitle(item.getString("title"));
      spot.setAddress(item.optString("addr1", "주소 없음"));
      spot.setImage(item.optString("firstimage2", "https://via.placeholder.com/50"));
      spot.setMapx(item.optDouble("mapx", 0.0));
      spot.setMapy(item.optDouble("mapy", 0.0));
      spots.add(spot);
    }

    // // Manually create JSON response string
    // StringBuilder jsonOutput = new StringBuilder();
    // jsonOutput.append("[");
    // for (int i = 0; i < spots.size(); i++) {
    //   TouristSpotVO spot = spots.get(i);
    //   jsonOutput.append("{")
    //       .append("\"title\":\"").append(spot.getTitle()).append("\",")
    //       .append("\"address\":\"").append(spot.getAddress()).append("\",")
    //       .append("\"image\":\"").append(spot.getImage()).append("\",")
    //       .append("\"mapx\":").append(spot.getMapx()).append(",")
    //       .append("\"mapy\":").append(spot.getMapy())
    //       .append("}");
    //   if (i < spots.size() - 1) {
    //     jsonOutput.append(",");
    //   }
    // }
    // jsonOutput.append("]");
    //
    // response.setContentType("application/json");
    // response.setCharacterEncoding("UTF-8");
    // response.getWriter().write(jsonOutput.toString());

    // ✅ Manually build JSON response
    JSONObject result = new JSONObject();
    result.put("status", "success");
    result.put("places", spots);

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(result.toString());

    return "/planning.jsp";
  }
}
