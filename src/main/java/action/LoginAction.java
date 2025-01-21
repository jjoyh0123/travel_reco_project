package action;

import org.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

public class LoginAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    try {
      // 1. 카카오 인증 코드 가져오기
      String code = request.getParameter("code");
      if (code == null || code.isEmpty()) {
        // 인증 코드가 없으면 로그인 페이지로 이동
        return "login.jsp";
      }

      // 2. 카카오 서버에서 액세스 토큰 요청
      String apiUrl = "https://kauth.kakao.com/oauth/token";
      HttpURLConnection connection = (HttpURLConnection) new URL(apiUrl).openConnection();
      connection.setRequestMethod("POST");
      connection.setDoOutput(true);

      String params = "grant_type=authorization_code"
          + "&client_id=YOUR_KAKAO_API_KEY" // REST API 키를 입력하세요
          + "&redirect_uri=http://localhost:8080/controller?action=LoginAction" // 리디렉션 URL
          + "&code=" + code;

      try (OutputStream os = connection.getOutputStream()) {
        os.write(params.getBytes());
      }

      // 3. 액세스 토큰 응답 처리
      InputStream responseStream = connection.getInputStream();
      String responseBody = new BufferedReader(new InputStreamReader(responseStream))
          .lines().collect(java.util.stream.Collectors.joining());

      JSONObject tokenResponse = new JSONObject(responseBody);
      String accessToken = tokenResponse.getString("access_token");

      // 4. 액세스 토큰으로 사용자 정보 요청
      URL userInfoUrl = new URL("https://kapi.kakao.com/v2/user/me");
      HttpURLConnection userInfoConnection = (HttpURLConnection) userInfoUrl.openConnection();
      userInfoConnection.setRequestMethod("GET");
      userInfoConnection.setRequestProperty("Authorization", "Bearer " + accessToken);

      InputStream userInfoStream = userInfoConnection.getInputStream();
      String userInfoResponse = new BufferedReader(new InputStreamReader(userInfoStream))
          .lines().collect(java.util.stream.Collectors.joining());

      JSONObject userInfo = new JSONObject(userInfoResponse);
      String email = userInfo.getJSONObject("kakao_account").getString("email");

      // 5. 사용자 정보를 세션에 저장
      request.getSession().setAttribute("userId", email);

      // 6. 메인 페이지로 리다이렉트
      return "index.jsp";

    } catch (Exception e) {
      e.printStackTrace();
      // 오류 발생 시 로그인 페이지로 이동
      return "login.jsp";
    }
  }
}
