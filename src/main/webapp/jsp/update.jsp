<%@ page contentType="application/json;charset=UTF-8" %>
<%
  Boolean success = (Boolean) request.getAttribute("success");
%>
{
  "success":
  <%= success %>
}

