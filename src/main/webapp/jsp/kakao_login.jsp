<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  // 카카오 로그인 프로필 이미지 URL
  String kakaoProfileImg = "https://w7.pngwing.com/pngs/247/997/png-transparent-kakaotalk-hd-logo.png";

  // 세션에 프로필 이미지 저장
  session.setAttribute("profileImg", kakaoProfileImg);
  // session.setAttribute("user", "");
  session.setAttribute("idx", "104");
  session.setAttribute("email", "zenzen@kakao.com");
  session.setAttribute("nick", "젠젠카카오");

  // 메인 페이지로 이동
  response.sendRedirect("Controller");
%>