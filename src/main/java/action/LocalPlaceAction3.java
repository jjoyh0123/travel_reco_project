package action;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

public class LocalPlaceAction3 implements Action{
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    StringBuffer sb = new StringBuffer(
        "http://apis.data.go.kr/B551011/KorService1/detailInfo1?");
    sb.append("serviceKey=FDp2a3vCnN%2BVvgfwp%2BneIQPvN3zTM7aLpEznSGbkyDN47qXAmtPene0L3A8mgUsbO%2F7pzLR3EX7rdD0%2B6wZe3Q%3D%3D");
    sb.append("&numOfRows=1000");
    sb.append("&pageNo=1");
    sb.append("&MobileOS=ETC");
    sb.append("&MobileApp=AppTest");
    sb.append("&arrange=A");
    sb.append("&listYN=Y");

    try {
      String contentId = request.getParameter("contentId");

      // 'areacode' 값이 존재하면 URL에 추가
      if (contentId != null && !contentId.isEmpty()) {
        sb.append("&areaCode=" + contentId); // 예: &areaCode=1
      }

      String contentTypeId = request.getParameter("contentTypeId");

      if (contentTypeId != null && !contentTypeId.isEmpty()) {
        sb.append("&contentTypeId=" + contentTypeId);
      }else{
        sb.append("");
      }

      //브라우저 창에서 경로(URL)를 입력하고 요청하듯이 프로그램 상에서는 요청할 때는
      // URL객체를 만들어야 한다.
      URL url = new URL(sb.toString());

      //경로를 연결하는 객체 openconnection은 httpulrconnection의 부모 따라서 캐스팅해서 사용해도 된다
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();

      //응답 받을 데이터의 형식을 지정
      conn.setRequestProperty("Content-Type", "application/xml");

      //연결 - 요청! connect = 연결 즉, 요청이 되면 api와 연결된 상태가 된다. 하지만 필요한 xml을 직접 받아야한다,
      conn.connect();

      // JDOM라이브러리에 있는 SAXBuilder를 통해 응답메세지를 XML문서화 시키기 위해
      // 필요로 하는 객체다.
      SAXBuilder builder = new SAXBuilder();

      //응답되는 내용을 하나의 XML의 문서(Document)로 인식해야 한다. 주의해야할 점: jdom에 있는 document 가져오기
      Document doc = builder.build(conn.getInputStream());

      //루트엘리먼트를 얻어낸다.
      Element root = doc.getRootElement(); // 주의해야할 점: jdom에 있는 element를 가져오기

      //System.out.println(root.getName()); // response

      Element body = root.getChild("body"); //element는 태그를 의미

      //body 안에 있는 items를 얻는다.
      Element items = body.getChild("items");

      //items안에 있는 item 요소들을 얻자

      List<Element> item_list = items.getChildren("item");

      //System.out.println(item_list.size());
      //xml을 잡아서 두긴 했지만 jsp에 쓰지 못한다
      //item들은 요소(element)다 이것을 JSP에서 표현할 수 있는 의미가 부여된 vo로 변환하자
      //배열을 만들자(list의 크기와 같아야 한다.)
      mybatis.vo.DataVO[] ar = new mybatis.vo.DataVO[item_list.size()];

      int i= 0;
      for(Element item : item_list) {
        //하나의 item요소에서 원하는 값들을 얻어낸다.(title,add1.....) 태그들 빼고 태그 안에 있는 것들
        String title = item.getChildText("title");
        String eventstartdate = item.getChildText("eventstartdate");
        String eventenddate = item.getChildText("eventenddate");
        String firstimage = item.getChildText("firstimage");
        String firstimage2 = item.getChildText("firstimage2");
        String mapx = item.getChildText("mapx");
        String mapy = item.getChildText("mapy");
        String addr1 = item.getChildText("addr1");
        String tel = item.getChildText("tel");
        String roomintro = item.getChildText("roomintro");
        //vo객체로 생성하자
        mybatis.vo.DataVO vo = new mybatis.vo.DataVO(title, mapx, mapy,
            addr1, firstimage, firstimage2, tel, eventstartdate, eventenddate, roomintro);

        //생성된 vo객체를 배열에 추가
        ar[i] = vo;
        ++i;
      }
      //배열에 모든 item들이 vo객체로 생성되어 저장된 상태다. 배열을
      //jsp에서 표현할 수 있도록 request에 저장하자
      request.setAttribute("ar", ar);
    } catch (Exception e) {
      e.printStackTrace();
    }


    return "jsp/localPlace.jsp";
  }
}
