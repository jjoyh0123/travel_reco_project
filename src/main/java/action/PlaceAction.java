package action;

import mybatis.dao.PlaceDAO;
import mybatis.vo.DateVO;
import mybatis.vo.PlaceVO;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import sun.net.www.protocol.http.HttpURLConnection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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

    // 공공데이터를 호출하는 경로 준비
    // http://apis.data.go.kr/B551011/KorService1/areaBasedList1
    // ?
    // serviceKey=agF1uM5XXABo8OyPGCCRmbBlgrJE68lod7AvGl4Sz%2FjdH6T7b7X6B%2BHkco7utd1LNHCrLWfLbjpXteXOpgcYkA%3D%3D
    // &pageNo=1
    // &numOfRows=10
    // &MobileApp=AppTest
    // &MobileOS=ETC
    // &arrange=A
    // &contentTypeId=32
    // &areaCode=31

    StringBuffer sb = new StringBuffer("http://apis.data.go.kr/B551011/KorService1/areaBasedList1?");
    sb.append("serviceKey=agF1uM5XXABo8OyPGCCRmbBlgrJE68lod7AvGl4Sz%2FjdH6T7b7X6B%2BHkco7utd1LNHCrLWfLbjpXteXOpgcYkA%3D%3D");
    sb.append("&pageNo=1");
    sb.append("&numOfRows=10");
    sb.append("&MobileApp=AppTest");
    sb.append("&MobileOS=ETC");
    sb.append("&arrange=A");
    sb.append("&contentTypeId=32");
    sb.append("&areaCode=31");

    try {
      URL url = new URL(sb.toString());

      HttpURLConnection conn = (HttpURLConnection) url.openConnection();

      conn.setRequestProperty("Content-Type", "application/xml");

      conn.connect();

      SAXBuilder builder = new SAXBuilder();

      Document doc = builder.build(conn.getInputStream());

      Element root = doc.getRootElement();

      Element body = root.getChild("Body");

      Element items = body.getChild("items");

      List<Element> item_list = items.getChildren("item");

      PlaceVO[] ar = new PlaceVO[item_list.size()];
      int i = 0;
      for (Element item : item_list) {
        //   private String date_idx, visit_order, content_id, content_type_id, title, thumnail, map_x, map_y, time;
        String date_idx =  item.getChildText("dateIdx");
        String visit_order =  item.getChildText("visit_order");
        String content_id = item.getChildText("content_id");
        String content_type_id = item.getChildText("content_type");
        String title = item.getChildText("title");
        String thumnail = item.getChildText("thumbnail");
        String map_x = item.getChildText("map_x");
        String map_y = item.getChildText("map_y");
        String time = item.getChildText("time");

        PlaceVO vo = new PlaceVO(date_idx, visit_order, content_id, content_type_id, title, thumnail, map_x, map_y, time);

        ar[i++] = vo;
      }


    } catch (IOException | JDOMException e) {
      e.printStackTrace();
    }

    return "/jsp/journal.jsp";
  }
}
