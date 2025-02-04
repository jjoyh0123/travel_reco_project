<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Optional" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="java.util.ArrayList" %>
<%
  // request 속성에서 결과 메시지 가져오기 (Optional 적용)
  String status = Optional.ofNullable((String) request.getAttribute("status")).orElse("error");
  String message = Optional.ofNullable((String) request.getAttribute("message")).orElse("알 수 없는 오류가 발생했습니다.");
  String upload_image_path = Optional.ofNullable((String) request.getAttribute("upload_image_path")).orElse("이미지 경로가 없습니다.");

  // org.json 라이브러리를 사용하여 JSON 객체 생성
  JSONObject jsonObject = new JSONObject();
  jsonObject.put("status", status);
  jsonObject.put("message", message);
  jsonObject.put("upload_image_path", upload_image_path);

  // JSON 데이터를 응답으로 전송
  response.setContentType("application/json");
  response.setCharacterEncoding("UTF-8");
  response.getWriter().write(jsonObject.toString());
%>