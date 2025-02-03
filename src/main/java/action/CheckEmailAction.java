package action;

import mybatis.dao.SignupDAO;
import org.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class CheckEmailAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String email = request.getParameter("email");
    JSONObject jsonResponse = new JSONObject();

    if (email == null || email.trim().isEmpty()) {
      jsonResponse.put("status", "error");
      jsonResponse.put("message", "이메일을 입력해주세요.");
    } else {
      boolean isDuplicate = SignupDAO.emailCheck(email);
      if (isDuplicate) {
        jsonResponse.put("status", "error");
        jsonResponse.put("message", "이미 사용 중인 이메일입니다.");
      } else {
        jsonResponse.put("status", "success");
        jsonResponse.put("message", "사용 가능한 이메일입니다.");
      }
    }

    // JSON 응답 설정
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    try (PrintWriter out = response.getWriter()) {
      out.print(jsonResponse.toString());
      out.flush();
    } catch (IOException e) {
      throw new RuntimeException(e);
    }

    return null;  // 직접적인 페이지 이동 없이 JSON 응답을 반환
  }
}
