package action;

import mybatis.dao.*;
import mybatis.vo.JournalBestVO;
import mybatis.vo.TempVO;
import util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    response.setContentType("text/html;charset=utf-8");
    String tab = request.getParameter("tab");
    if (tab == null) {
      tab = "user";
    }
    String tab2 = request.getParameter("tab2");
    String tab3 = request.getParameter("tab3");
    String search = request.getParameter("search");
    // 페이징 처리를 위한 객체 생성
    Paging page = new Paging();

    /*
    tab 변수를 통해 게시물이 어떤 게시판의 게시물인지 확인 필요
    user = user_table / badge_table (tab2 = user / badge)
    post = 게시판 별 게시글 목록 (tab2 로 지역 구분)
    notice = 공지사항 목록
    support = 1:1 문의 목록
    --아래는 게시글 없이 기능만 존재--
    event = 이미지 등록 기능만
    best_plan = 베스트 선정
    */
    // 총 게시물 수 구하기
    int totalCount = 0;

    switch (tab) {
      case "user":
        if (search == null || search.isEmpty()) {
          if (tab2 == null || tab2.equals("user"))
            totalCount = UserDAO.getTotalCount();
          else if (tab2.equals("badge"))
            totalCount = BadgeDAO.getTotalCount();
        } else {
          if (tab2 == null || tab2.equals("user"))
            totalCount = UserDAO.getSearchCount(search);
          else if (tab2.equals("badge"))
            totalCount = BadgeDAO.getSearchCount(search);
        }
        break;
      case "post":
        if (search == null || search.isEmpty()) {
          String area_code = "";
          if (tab2 != null) {
            area_code = tab2.replaceAll("\\D", "");
          }
          if (area_code.isEmpty()) {
            totalCount = JournalDAO.getTotalCount();
          } else {
            totalCount = JournalDAO.getAreaCount(area_code);
          }
        } else {
          String area_code = "";
          if (tab2 != null) {
            area_code = tab2.replaceAll("\\D", "");
          }
          if (area_code.isEmpty()) {
            totalCount = JournalDAO.getTotalCount(search);
          } else {
            totalCount = JournalDAO.getSearchCount(area_code, search);
          }
        }
        break;
      case "notice":
        totalCount = NoticeDAO.getTotalCount();
        break;
      case "support":
        totalCount = SupportDAO.getTotalCount();
        break;
      case "best_plan":
        if (tab3 == null)
          tab3 = "3";
        totalCount = JournalDAO.getRangeCount(tab3);
        break;
    }

    // 페이징 객체 안에 총 게시물의 수를 저장하며 전체 페이지 수를 구함
    page.setTotalRecord(totalCount);

    // 현재 페이지 값을 파라미터로 받아옴
    String cPage = request.getParameter("cPage");
    if (cPage == null) {
      page.setNowPage(1);
    } else {
      int nowPage = Integer.parseInt(cPage);
      page.setNowPage(nowPage);
      // 게시물을 추출할 때 사용되는 begin 과 end, 시작 페이지와 끝 페이지 값이 구해짐
    }

    TempVO[] ar = null;
    JournalBestVO[] best = null;
    switch (tab) {
      case "user":
        if (search == null || search.isEmpty()) {
          if (tab2 == null || tab2.equals("user"))
            ar = UserDAO.getList(page.getBegin(), page.getEnd());
          else if (tab2.equals("badge"))
            ar = BadgeDAO.getList(page.getBegin(), page.getEnd());
        } else {
          if (tab2 == null || tab2.equals("user"))
            ar = UserDAO.getSearchList(page.getBegin(), page.getEnd(), search);
          else if (tab2.equals("badge"))
            ar = BadgeDAO.getSearchList(page.getBegin(), page.getEnd(), search);
        }
        break;
      case "post":
        if (search == null || search.isEmpty()) {
          String area_code = "";
          if (tab2 != null) {
            area_code = tab2.replaceAll("\\D", "");
          }
          if (area_code.isEmpty()) {
            ar = JournalDAO.getList(page.getBegin(), page.getEnd());
          } else {
            ar = JournalDAO.getList(page.getBegin(), page.getEnd(), area_code);
          }
        } else {
          String area_code = "";
          if (tab2 != null) {
            area_code = tab2.replaceAll("\\D", "");
          }
          if (area_code.isEmpty()) {
            ar = JournalDAO.getSearchList(page.getBegin(), page.getEnd(), search);
          } else {
            ar = JournalDAO.getSearchList(page.getBegin(), page.getEnd(), area_code, search);
          }
        }
        break;
      case "notice":
        ar = NoticeDAO.getList(page.getBegin(), page.getEnd());
        break;
      case "support":
        ar = SupportDAO.getList(page.getBegin(), page.getEnd());
        break;
      case "best_plan":
        best = JournalBestDAO.getList();
        ar = JournalDAO.getRangeList(page.getBegin(), page.getEnd(), tab3, tab2);
        break;
      default:
        ar = TempDAO.getList();
        break;
    }

    request.setAttribute("ar", ar);
    request.setAttribute("page", page);
    request.setAttribute("cPage", cPage);
    request.setAttribute("tab", tab);
    request.setAttribute("best", best);

    return "admin_main.jsp";
  }
}
