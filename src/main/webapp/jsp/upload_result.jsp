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

  // request 속성에서 fileNames 가져오기 (Optional 적용)
  List<String> fileNames = Optional.ofNullable((List<String>) request.getAttribute("fileNames")).orElse(new ArrayList<>());

  // fileNames를 JSONArray로 변환 (빈 리스트 처리 및 유효성 검사)
  JSONArray jsonArray;
  if (fileNames != null) {
    try {
      jsonArray = new JSONArray(fileNames);
    } catch (JSONException e) {
      jsonArray = new JSONArray(); // 유효하지 않은 경우 빈 JSONArray 생성
    }
  } else {
    jsonArray = new JSONArray();
  }

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