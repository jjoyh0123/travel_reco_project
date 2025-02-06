package action;

import mybatis.vo.PlaceVO;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

public class Temp4Action implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    Paging page = new Paging();
    HttpSession session = request.getSession();

    // TotalCount 가져오기 (세션에 없을 경우 API 호출)
    Integer totalRecord = (Integer) session.getAttribute("totalRecord");
    if (totalRecord == null) {
      try {
        String totalUrl = "http://apis.data.go.kr/B551011/KorService1/areaBasedList1?" +
            "serviceKey=7O%2BS3FUEPYFub2Ap2u9bYHh%2BsjDTjijIZZEm8c08xQTLQQgv7IehSi5I%2FG1hMPE6x6%2B3A3IzhIztXbdrLMc90A%3D%3D" +
            "&numOfRows=1" +
            "&pageNo=1" +
            "&MobileOS=ETC" +
            "&MobileApp=AppTest" +
            "&arrange=A" +
            "&listYN=N";

        if (request.getParameter("areaCode") != null) {
          totalUrl += "&areacode=" + request.getParameter("areaCode");
        }

        URL url = new URL(totalUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestProperty("Content-Type", "application/xml");
        conn.connect();

        SAXBuilder builder = new SAXBuilder();
        Document doc = builder.build(conn.getInputStream());
        Element root = doc.getRootElement();
        Element body = root.getChild("body");
        Element items = body.getChild("items");
        Element item = items.getChild("item");
        String totalCnt = item.getChildText("totalCnt");

        totalRecord = Integer.parseInt(totalCnt);
        System.out.println(totalRecord);
        session.setAttribute("totalRecord", totalRecord);
      } catch (Exception e) {
        throw new RuntimeException("TotalCount 조회 실패", e);
      }
    }

    // 페이징 설정
    page.setTotalRecord(totalRecord);
    String cPage = request.getParameter("cPage");
    page.setNowPage(cPage == null || cPage.isEmpty() ? 1 : Integer.parseInt(cPage));

    // 데이터 조회
    try {
      StringBuffer sb = new StringBuffer();
      sb.append("http://apis.data.go.kr/B551011/KorService1/areaBasedList1?");
      sb.append("serviceKey=7O%2BS3FUEPYFub2Ap2u9bYHh%2BsjDTjijIZZEm8c08xQTLQQgv7IehSi5I%2FG1hMPE6x6%2B3A3IzhIztXbdrLMc90A%3D%3D");
      sb.append("&numOfRows=").append(page.getNumPerPage());
      sb.append("&pageNo=").append(page.getNowPage());
      sb.append("&MobileOS=ETC");
      sb.append("&MobileApp=AppTest");
      sb.append("&arrange=A");
      sb.append("&listYN=Y");

      String areaCode = request.getParameter("areaCode");
      if (areaCode != null && !areaCode.isEmpty()) {
        sb.append("&areacode=").append(areaCode);
      }

      URL url = new URL(sb.toString());
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestProperty("Content-Type", "application/xml");
      conn.connect();

      SAXBuilder builder = new SAXBuilder();
      Document doc = builder.build(conn.getInputStream());
      Element root = doc.getRootElement();
      Element body = root.getChild("body");
      Element items = body.getChild("items");

      List<Element> item_list = items.getChildren("item");
      PlaceVO[] ar = new PlaceVO[item_list.size()];
      int i = 0;
      for (Element item : item_list) {
        String title = item.getChildText("title");
        String map_x = item.getChildText("mapx");
        String map_y = item.getChildText("mapy");
        String thumbnail = item.getChildText("firstimage2");
        String content_id = item.getChildText("contentid");
        String content_type_id = item.getChildText("contenttypeid");

        ar[i++] = new PlaceVO("", "", content_id, content_type_id, title, thumbnail, map_x, map_y, "");
      }

      request.setAttribute("ar", ar);
      request.setAttribute("page", page);
      request.setAttribute("areaCode", areaCode);

    } catch (Exception e) {
      throw new RuntimeException("데이터 조회 실패", e);
    }

    return "/temp4.jsp";
  }
}