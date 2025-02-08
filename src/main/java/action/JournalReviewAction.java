package action;

import mybatis.dao.JournalDAO;
import mybatis.dao.JournalReviewDAO;
import mybatis.vo.JournalVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class JournalReviewAction implements Action {


  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {

    JournalVO[] journal = JournalReviewDAO.getReview();
    request.setAttribute("journal", journal);

    return "jsp/journal_review.jsp";
  }
}
