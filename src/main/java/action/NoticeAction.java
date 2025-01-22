package action;

import mybatis.dao.NoticeDAO;
import mybatis.vo.FaqVO;
import mybatis.vo.NoticeVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NoticeAction implements Action{
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String viewPath = null;
    System.out.println("notice");
    NoticeVO[] nvo = NoticeDAO.getNotice();
    request.setAttribute("nvo", nvo);

    FaqVO[] fvo = NoticeDAO.getFaq();
    request.setAttribute("fvo", fvo);

     System.out.println(fvo);

    return "notice.jsp";
  }
}
