package action;

import mybatis.vo.TempVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

public class Temp2Action implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    // 좌표 배열 받기
    String[] route1Titles = request.getParameterValues("route1Titles");
    String[] route1Lats = request.getParameterValues("route1Lats");
    String[] route1Lngs = request.getParameterValues("route1Lngs");
    String[] route2Titles = request.getParameterValues("route2Titles");
    String[] route2Lats = request.getParameterValues("route2Lats");
    String[] route2Lngs = request.getParameterValues("route2Lngs");

    List<TempVO> route1 = new ArrayList<>();
    List<TempVO> route2 = new ArrayList<>();

    if (route1Titles != null && route1Lats != null && route1Lngs != null) {
      for (int i = 0; i < route1Titles.length; i++) {
        TempVO tempVO = new TempVO();
        tempVO.setTitle(route1Titles[i]);
        tempVO.setMap_x(route1Lats[i]);
        tempVO.setMap_y(route1Lngs[i]);
        route1.add(tempVO);
      }
    }

    if (route2Titles != null && route2Lats != null && route2Lngs != null) {
      for (int i = 0; i < route2Titles.length; i++) {
        TempVO tempVO = new TempVO();
        tempVO.setTitle(route2Titles[i]);
        tempVO.setMap_x(route2Lats[i]);
        tempVO.setMap_y(route2Lngs[i]);
        route2.add(tempVO);
      }
    }

    // request 에 경로 저장
    request.setAttribute("route1", route1);
    request.setAttribute("route2", route2);

    return "temp2.jsp";
  }
}
