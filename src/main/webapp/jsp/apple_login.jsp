<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  // 구글 프로필 이미지 URL
  String googleProfileImg = "https://wikyung.com/upload/dc261b764a5849b08845fe47e003a3aa.png";

  // 세션에 프로필 이미지 저장
  session.setAttribute("profileImg", googleProfileImg);

  // 메인 페이지로 이동
  response.sendRedirect("Controller");
%>

