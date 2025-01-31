package action;

import com.google.gson.Gson;
import org.json.JSONArray;
import org.json.JSONObject;

import mybatis.vo.TouristSpotVO;
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
    String apiUrl = "http://apis.data.go.kr/B551011/KorService1/areaBasedList1?"
        + "serviceKey=v%2BHAli1W1AWCpXPRa5gf1hhL1rbEK%2BRGlCdQXZ4ShmnPl2YYNj0%2F7eTcZy9pAQzxFifJ647n5MXrQ%2Bf2ygvNmA%3D%3D"
        + "&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=MyApp&_type=json&areaCode=1&arrange=A&listYN=Y";

    URL url = new URL(apiUrl);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");

    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
    StringBuffer responseText = new StringBuffer();
    String line="";
    while ((line = br.readLine()) != null) {
      responseText.append(line);
    }
    br.close();

    JSONObject jsonResponse = new JSONObject(responseText.toString());
    JSONArray items = jsonResponse.getJSONObject("response").getJSONObject("body").getJSONObject("items").getJSONArray("item");

    ArrayList<TouristSpotVO> spots = new ArrayList<>();

    for (int i = 0; i < items.length(); i++) {
      JSONObject item = items.getJSONObject(i);
      TouristSpotVO spot = new TouristSpotVO();
      spot.setTitle(item.getString("title"));
      spot.setAddress(item.optString("addr1", "주소 없음"));
      spot.setImage(item.optString("firstimage2", "https://via.placeholder.com/50"));
      spot.setMapx(item.optDouble("mapx", 0.0));
      spot.setMapy(item.optDouble("mapy", 0.0));
      spot.setCategory(item.getString("contenttypeid"));

      spots.add(spot);
    }

    String jsonResponseText = new Gson().toJson(spots);

    System.out.println("Raw JSON Response: " + jsonResponseText); // Debugging log

    request.setAttribute("jsonResponseText", jsonResponseText);
    //response.setContentType("application/json");
    //response.setCharacterEncoding("UTF-8");
    //response.getWriter().write(new Gson().toJson(spots));
    //response.getWriter().write(jsonResponseText);

    return "/planning2.jsp";
  }
}
