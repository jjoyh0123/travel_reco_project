package action;

import mybatis.dao.FAQDAO;
import mybatis.dao.NoticeDAO;
import mybatis.vo.NoticeVO;
import mybatis.vo.TempVO;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminViewAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    try {
      request.setCharacterEncoding("UTF-8");
      response.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");
    } catch (Exception e) {
      e.printStackTrace();
    }

    String tab = request.getParameter("tab");
    String idx = request.getParameter("idx");
    String enc_type = request.getContentType();
    String viewpath = null;

    if (enc_type == null) {
      TempVO vo = null;
      switch (tab) {
        case "post":

          break;
        case "notice":
          vo = NoticeDAO.getOne(idx);
          break;
        case "support":
          break;
        case "faq":
          vo = FAQDAO.getOne(idx);
          break;
      }

      request.setAttribute("vo", vo);
      viewpath = "jsp/admin_view.jsp";
    } else if (enc_type.startsWith("application")) {
      try {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String reg_date = request.getParameter("reg_date");
        String update_date = request.getParameter("update_date");
        String hit = request.getParameter("hit");
        String status = request.getParameter("status");

        content = content.replaceAll("<[^>]*>", "");

        NoticeVO vo = new NoticeVO();
        vo.setIdx(idx);
        vo.setTitle(title);
        vo.setContent(content);
        vo.setReg_date(reg_date);
        vo.setUpdate_date(update_date);
        vo.setHit(hit);
        vo.setStatus(status);


        if (idx == null || idx.isEmpty()) {
          NoticeDAO.insertNotice(vo);
        } else {
          NoticeDAO.updateNotice(vo);
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("Controller?type=admin&tab=notice");
        dispatcher.forward(request, response);
        return null;
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
    return viewpath;
  }
}
