package action;

import mybatis.dao.ViewJournalDAO;
import mybatis.vo.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class ViewJournalAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String plan_idx = request.getParameter("plan_idx");
    JournalVO journalVO = ViewJournalDAO.getJournal(plan_idx);
    List<ImageVO> imageList = ViewJournalDAO.get_Images(plan_idx);
    DateVO[] dateVO = ViewJournalDAO.getDate(plan_idx);
    List<ViewJournalDTO> list = ViewJournalDAO.getPlace(plan_idx);
    PlanVO planVO = ViewJournalDAO.getPlan(plan_idx);
    ReviewVO[] reviewVO = ViewJournalDAO.getReview();

    request.setAttribute("journalVO", journalVO);
    request.setAttribute("imageList", imageList);
    request.setAttribute("dateVO", dateVO);
    request.setAttribute("list", list);
    request.setAttribute("planVO", planVO);
    request.setAttribute("reviewVO", reviewVO);
    request.setAttribute("plan_idx", plan_idx);

    return "/jsp/view_journal.jsp";
  }
}
