package action;

import mybatis.dao.PlaceDAO;
import mybatis.vo.DateVO;
import mybatis.vo.JournalDTO;
import mybatis.vo.PlaceVO;
import mybatis.vo.PlanVO;
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
    //
    DateVO[] dateVO = PlaceDAO.getDate();
    request.setAttribute("dateVO", dateVO);
    //
    PlanVO[] planVO = PlaceDAO.getPlan();
    request.setAttribute("planVO", planVO);

    List<JournalDTO> list = PlaceDAO.getoneIdx(1);
    request.setAttribute("list", list);


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

    // StringBuffer sb = new StringBuffer("http://apis.data.go.kr/B551011/KorService1/areaBasedList1?");
    // sb.append("serviceKey=agF1uM5XXABo8OyPGCCRmbBlgrJE68lod7AvGl4Sz%2FjdH6T7b7X6B%2BHkco7utd1LNHCrLWfLbjpXteXOpgcYkA%3D%3D");
    // sb.append("&pageNo=1");
    // sb.append("&numOfRows=10");
    // sb.append("&MobileApp=AppTest");
    // sb.append("&MobileOS=ETC");
    // sb.append("&arrange=A");


    // try {
    //     URL url = new URL(sb.toString());
    //     HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    //     conn.setRequestProperty("Content-Type", "application/xml");
    //     conn.connect();
    //     SAXBuilder builder = new SAXBuilder();
    //     Document doc = builder.build(conn.getInputStream());
    //     Element root = doc.getRootElement();
    //     Element body = root.getChild("body");
    //     Element items = body.getChild("items");
    //     List<Element> item_list = items.getChildren("item");
    //
    //     PlaceVO[] ar = new PlaceVO[item_list.size()];
    //     int i = 0;
    //     for (Element item : item_list) {
    //       //   private String date_idx, visit_order, content_id, content_type_id, title, thumnail, map_x, map_y, time, date;
    //       String date_idx =  item.getChildText("date_idx");
    //       String visit_order =  item.getChildText("visit_order");
    //       String content_id = item.getChildText("contentid");
    //       String content_type_id = item.getChildText("contenttypeid");
    //       String title = item.getChildText("title");
    //       String thumnail = item.getChildText("firstimage2");
    //       String map_x = item.getChildText("map_x");
    //       String map_y = item.getChildText("map_y");
    //       String time = item.getChildText("time");
    //
    //
    //
    //       PlaceVO vo = new PlaceVO(date_idx, visit_order, content_id, content_type_id, title, thumnail, map_x, map_y, time);
    //       System.out.println(content_id+"/"+vo.getContent_id());
    //       System.out.println(thumnail);
    //       ar[i++] = vo;
    //     }
    //     request.setAttribute("ar", ar);
    // } catch (IOException | JDOMException e) {
    //   e.printStackTrace();
    // }

    return "/jsp/journal.jsp";
  }
}
