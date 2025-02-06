package action;

import mybatis.vo.ApidataVO;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

public class Temp4Action implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    Paging page = new Paging();
    HttpSession session = request.getSession();

    String areaCode = request.getParameter("areaCode");
    String keyword = request.getParameter("keyword");

    // 1. totalCount 계산 -------------------------------------------------
    Integer totalRecord = (Integer) session.getAttribute("totalRecord");
    boolean isSearch = keyword != null && !keyword.trim().isEmpty();

    try {
      if (totalRecord == null || isSearch) {
        String totalUrl;
        if (isSearch) {
          totalUrl = "http://apis.data.go.kr/B551011/KorService1/searchKeyword1?" +
              "serviceKey=7O%2BS3FUEPYFub2Ap2u9bYHh%2BsjDTjijIZZEm8c08xQTLQQgv7IehSi5I%2FG1hMPE6x6%2B3A3IzhIztXbdrLMc90A%3D%3D" +
              "&numOfRows=1&pageNo=1" +
              "&MobileOS=ETC&MobileApp=AppTest" +
              "&listYN=N&arrange=A" +
              "&keyword=" + URLEncoder.encode(keyword, "UTF-8") +
              (areaCode != null ? "&areaCode=" + areaCode : "");
        } else {
          totalUrl = "http://apis.data.go.kr/B551011/KorService1/areaBasedList1?" +
              "serviceKey=7O%2BS3FUEPYFub2Ap2u9bYHh%2BsjDTjijIZZEm8c08xQTLQQgv7IehSi5I%2FG1hMPE6x6%2B3A3IzhIztXbdrLMc90A%3D%3D" +
              "&numOfRows=1&pageNo=1" +
              "&MobileOS=ETC&MobileApp=AppTest" +
              "&listYN=N&arrange=A" +
              (areaCode != null ? "&areaCode=" + areaCode : "");
        }
        System.out.println(totalUrl);

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
        System.out.println(totalCnt);
        totalRecord = Integer.parseInt(totalCnt);
        session.setAttribute("totalRecord", totalRecord);
      }
    } catch (Exception e) {
      throw new RuntimeException("TotalCount 조회 실패", e);
    }


    // 페이징 설정
    page.setTotalRecord(totalRecord);
    String cPage = request.getParameter("cPage");
    page.setNowPage(cPage == null || cPage.isEmpty() ? 1 : Integer.parseInt(cPage));

    // 데이터 조회
    try {
      String apiUrl;
      if (isSearch) {
        apiUrl = "http://apis.data.go.kr/B551011/KorService1/searchKeyword1?" +
            "serviceKey=7O%2BS3FUEPYFub2Ap2u9bYHh%2BsjDTjijIZZEm8c08xQTLQQgv7IehSi5I%2FG1hMPE6x6%2B3A3IzhIztXbdrLMc90A%3D%3D" +
            "&numOfRows=10&pageNo=" + cPage +
            "&MobileOS=ETC&MobileApp=AppTest" +
            "&listYN=Y&arrange=A" +
            "&keyword=" + URLEncoder.encode(keyword, "UTF-8") +
            (areaCode != null ? "&areaCode=" + areaCode : "");
      } else {
        apiUrl = "http://apis.data.go.kr/B551011/KorService1/areaBasedList1?" +
            "serviceKey=7O%2BS3FUEPYFub2Ap2u9bYHh%2BsjDTjijIZZEm8c08xQTLQQgv7IehSi5I%2FG1hMPE6x6%2B3A3IzhIztXbdrLMc90A%3D%3D" +
            "&numOfRows=10&pageNo=" + cPage +
            "&MobileOS=ETC&MobileApp=AppTest" +
            "&listYN=Y&arrange=A" +
            (areaCode != null ? "&areaCode=" + areaCode : "");
      }
      URL url = new URL(apiUrl);
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestProperty("Content-Type", "application/xml");
      conn.connect();

      SAXBuilder builder = new SAXBuilder();
      Document doc = builder.build(conn.getInputStream());
      Element root = doc.getRootElement();
      Element body = root.getChild("body");
      Element items = body.getChild("items");

      List<Element> item_list = items.getChildren("item");
      ApidataVO[] ar = new ApidataVO[item_list.size()];
      int i = 0;
      for (Element item : item_list) {
        String content_id = item.getChildText("contentid");
        String content_type_id = item.getChildText("contenttypeid");
        String title = item.getChildText("title");
        String thumbnail = item.getChildText("firstimage2");
        String map_x = item.getChildText("mapx");
        String map_y = item.getChildText("mapy");
        String addr1 = item.getChildText("addr1");
        String tel = item.getChildText("tel");

        ar[i++] = new ApidataVO(content_id, content_type_id, title, thumbnail, map_x, map_y, addr1, tel);
      }

      request.setAttribute("ar", ar);
      request.setAttribute("page", page);
      request.setAttribute("areaCode", areaCode);
      request.setAttribute("keyword", keyword);

    } catch (Exception e) {
      throw new RuntimeException("데이터 조회 실패", e);
    }

    return "/temp4.jsp";
  }
}