<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  // 고정된 카카오 프로필 이미지 URL
  String naverProfileImg = "https://play-lh.googleusercontent.com/jYtnK__ibJh9emODIgTyjZdbKym1iAj4RfoVhQZcfbG-DuTSHR5moHVx9CQnqg1yoco9";

  // 세션에 프로필 이미지 저장
  session.setAttribute("profileImg", naverProfileImg);

  // 메인 페이지로 이동
  response.sendRedirect("Controller");
%>
