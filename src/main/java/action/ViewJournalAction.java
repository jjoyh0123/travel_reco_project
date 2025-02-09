package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ViewJournalAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {


    return "/jsp/view_journal.jsp";
  }
}
