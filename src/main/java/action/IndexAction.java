package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IndexAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {


    /*DAO에서는 매퍼에서 셀렉문을 호출해서 vo를 List로 받아서 배열로 변환해서 반환하는 함술를 만들자/
    /*DAO 호출해서 VO 배열을 받자*/
    /*받은 VO를 request에 저장해서 jsp에서 빼서 쓰자*/


    return "index.jsp";
  }
}
