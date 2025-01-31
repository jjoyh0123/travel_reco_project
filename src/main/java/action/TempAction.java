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
    Random random = new Random();

    // 리스트 개수를 2~10개 랜덤으로 설정
    int listCount = 2 + random.nextInt(9); // 2부터 10까지

    List<List<TempVO>> tempLists = new ArrayList<>();

    for (int i = 1; i <= listCount; i++) {
      List<TempVO> tempList = new ArrayList<>();

      // 각 리스트의 TempVO 개수를 2~20개 랜덤으로 설정
      int tempCount = 2 + random.nextInt(19); // 2부터 20까지

      for (int j = 1; j <= tempCount; j++) {
        TempVO tempVO = new TempVO();
        tempVO.setTitle("temp" + j);
        tempVO.setMap_x(String.valueOf(37.5 + (random.nextDouble() * 0.1)));
        tempVO.setMap_y(String.valueOf(126.9 + (random.nextDouble() * 0.1)));
        tempList.add(tempVO);
      }

      // 리스트를 tempLists 에 추가
      tempLists.add(tempList);
    }

    request.setAttribute("tempLists", tempLists); // 모든 리스트를 설정
    request.setAttribute("tempListCount", listCount); // 리스트 개수를 설정
    return "temp.jsp";
  }
}
