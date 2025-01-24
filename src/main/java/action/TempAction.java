package action;

import mybatis.vo.TempVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class TempAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    List<TempVO> tempList = new ArrayList<>();
    Random random = new Random();

    for (int i = 1; i <= 10; i++) {
      TempVO tempVO = new TempVO();
      tempVO.setTitle("temp" + i);
      tempVO.setMap_x(String.valueOf(37.5 + (random.nextDouble() * 0.1)));
      tempVO.setMap_y(String.valueOf(126.9 + (random.nextDouble() * 0.1)));
      tempList.add(tempVO);
    }

    request.setAttribute("tempList", tempList);
    return "temp.jsp";
  }
}
