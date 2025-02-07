package action;

import mybatis.dao.JournalBestDAO;
import mybatis.vo.JournalBestVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateBestAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String idx = request.getParameter("idx");
    String tier = request.getParameter("tier");

    boolean success;

    // 해당 tier 의 데이터가 있는지 확인
    boolean exists = JournalBestDAO.exists_journal_best(tier);
    if (exists) {
      boolean flag = JournalBestDAO.deact_journal_best(tier);

      if (!flag) {
        request.setAttribute("success", false);
        return "jsp/update.jsp";
      }
    }

    // 새로운 레코드 추가
    JournalBestVO vo = new JournalBestVO();
    vo.setJournal_idx(idx);
    vo.setTier(tier);
    vo.setStatus("0");

    success = JournalBestDAO.new_journal_best(vo);

    request.setAttribute("success", success);
    return "jsp/update.jsp";
  }
}
