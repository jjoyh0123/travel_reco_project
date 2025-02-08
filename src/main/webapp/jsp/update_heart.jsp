<%@ page contentType="application/json;charset=UTF-8" %>
<%
  Boolean success = (Boolean) request.getAttribute("success");
  Integer newStatus = (Integer) request.getAttribute("newStatus");
%>
{
  "success": <%= success %>,
  "newStatus": <%= newStatus %>
}
