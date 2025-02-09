<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  // 구글로그인 프로필 이미지 URL
  String googleProfileImg = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png";

  // 세션에 프로필 이미지 저장
  session.setAttribute("profileImg", googleProfileImg);

  // 메인 페이지로 이동
  response.sendRedirect("Controller");
%>
