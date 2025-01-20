package action;

import mybatis.dao.NoticeDAO;
import mybatis.vo.NoticeVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NoticeAction implements Action{
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String viewPath = null;

    NoticeVO[] ar = NoticeDAO.getNotice();
    request.setAttribute("ar", ar);

    System.out.println(ar[0]);

    return "main2.jsp";
  }
}
