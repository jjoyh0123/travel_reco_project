package action;

import mybatis.dao.CustomerServiceDAO;
import mybatis.vo.FaqVO;
import mybatis.vo.NoticeVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CustomerServiceAction implements Action{
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String viewPath = null;
    // System.out.println("notice");
    NoticeVO[] noticeVO = CustomerServiceDAO.getNotice();
    request.setAttribute("noticeVO", noticeVO);

    FaqVO[] faqVO = CustomerServiceDAO.getFaq();
    request.setAttribute("faqVO", faqVO);

     // System.out.println(faqVO);

    return "/jsp/customer_service.jsp";
  }
}
// customer_service.jsp
// customer_service.xml
// CustomerServiceDAO
// CustomerServiceAction