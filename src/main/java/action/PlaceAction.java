package action;

import mybatis.dao.PlaceDAO;
import mybatis.vo.*;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

public class PlaceAction implements Action{
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String viewPath = null;

    PlaceVO[] placeVO = PlaceDAO.getPlace();
    request.setAttribute("placeVO", placeVO);

    DateVO[] dateVO = PlaceDAO.getDate();
    request.setAttribute("dateVO", dateVO);

    PlanVO[] planVO = PlaceDAO.getPlan();
    request.setAttribute("planVO", planVO);

    List<JournalDTO> list = PlaceDAO.getoneIdx(1);
    request.setAttribute("list", list);

    ReviewVO[] reviewVO = PlaceDAO.getReview();
    request.setAttribute("reviewVO", reviewVO);

    return "/jsp/journal.jsp";


  }
}
