package action;

import org.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;

public class TestAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    try {
      BufferedReader reader = request.getReader();
      String line = reader.readLine();
      if(line != null) { // null 값인 경우에 대한 예외처리
        JSONObject data = new JSONObject(line);
        String type = data.getString("type");
        String user_idx = data.getString("user_idx");

        if ("leave".equals(type)) {
          System.out.printf("type: %s, user_idx: %s\n", type, user_idx);
          // 브라우저 종료 또는 페이지 이탈 처리
          // String userId = getUserId(request); // 사용자 ID 가져오기
          // String tempDir = getTempDirectory(userId); // 임시 이미지 저장 경로 가져오기
          // cleanDirectory(tempDir); // 임시 이미지 삭제
          // ... (추가 작업: DB 업데이트, 로그 기록 등)
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }
}