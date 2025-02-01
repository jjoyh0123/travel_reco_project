package action;

import mybatis.dao.PlaceDAO;
import mybatis.vo.DateVO;
import mybatis.vo.PlaceVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PlaceAction implements Action{
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String viewPath = null;

    PlaceVO[] placeVO = PlaceDAO.getPlace();
    request.setAttribute("placeVO", placeVO);

    DateVO[] dateVO = PlaceDAO.getDate();
    request.setAttribute("dateVO", dateVO);

    // 공공데이터를 호출하는 경로 준비
    //

    return "/jsp/journal.jsp";
  }
}
