package action;

import mybatis.dao.CustomerServiceDAO;
import mybatis.vo.FAQVO;
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

    FAQVO[] FAQVO = CustomerServiceDAO.getFaq();
    request.setAttribute("FAQVO", FAQVO);

     // System.out.println(FAQVO);

    return "/jsp/customer_service.jsp";
  }
}
// customer_service.jsp
// customer_service.xml
// CustomerServiceDAO
// CustomerServiceAction