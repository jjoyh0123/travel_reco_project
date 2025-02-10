package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DirectionsAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String title = request.getParameter("title");
    String mapx = request.getParameter("mapx");
    String mapy = request.getParameter("mapy");


    request.setAttribute("title", title);
    request.setAttribute("mapx", mapx);
    request.setAttribute("mapy", mapy);

    return "jsp/directions.jsp";
  }
}
