package action;

import com.google.gson.Gson;
import mybatis.vo.TouristSpotVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

public class AddPlaceToPlanAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    response.setCharacterEncoding("UTF-8");
    response.setContentType("application/json");  // Ensure it's JSON

    // Get the session and retrieve the plan list
    HttpSession session = request.getSession();
    ArrayList<TouristSpotVO> plan = (ArrayList<TouristSpotVO>) session.getAttribute("plan");
    if (plan == null) {
      plan = new ArrayList<>();
    }

    // Get parameters from request
    String contentid = request.getParameter("contentid");
    String title = request.getParameter("title");
    String address = request.getParameter("address");
    String image = request.getParameter("image");
    String category = request.getParameter("category");

    double mapx = 0.0;
    double mapy = 0.0;
    try {
      mapx = Double.parseDouble(request.getParameter("mapx"));
      mapy = Double.parseDouble(request.getParameter("mapy"));
    } catch (Exception e) {
      // Handle exception gracefully
    }

    // Add new place to the plan list
    TouristSpotVO spot = new TouristSpotVO();
    spot.setContentid(contentid);
    spot.setTitle(title);
    spot.setAddress(address);
    spot.setImage(image);
    spot.setCategory(category);
    spot.setMapx(mapx);
    spot.setMapy(mapy);

    plan.add(spot);
    session.setAttribute("plan", plan);

    // Convert updated plan to JSON and send response
    String json = new Gson().toJson(plan);

    System.out.println("Sending JSON response: " + json); // Debugging log
    response.getWriter().write(json);
    response.getWriter().flush();  // Ensure response is sent immediately
    response.getWriter().close();  // Close stream to prevent further processing
    return null;  // Ensure no JSP forwarding
  }
}
