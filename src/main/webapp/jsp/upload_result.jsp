<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>

<%
  // 쿼리 파라미터에서 결과 메시지 가져오기
  String status = request.getParameter("status");
  String message = request.getParameter("message");
  String fileNames = request.getParameter("fileNames");

  // fileNames를 JSONArray로 변환 (null 처리 및 최적화)
  JSONArray jsonArray = fileNames != null && fileNames.trim().startsWith("[") ? new JSONArray(fileNames) : new JSONArray();

  // org.json 라이브러리를 사용하여 JSON 객체 생성
  JSONObject jsonObject = new JSONObject();
  jsonObject.put("status", status);
  jsonObject.put("message", message);
  jsonObject.put("fileNames", jsonArray);

  // JSON 데이터를 응답으로 전송
  response.setContentType("application/json");
  response.setCharacterEncoding("UTF-8");
  response.getWriter().write(jsonObject.toString());
%>