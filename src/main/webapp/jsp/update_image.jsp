<%@ page contentType="application/json;charset=UTF-8" %>
<%
  Boolean success = (Boolean) request.getAttribute("success");
  String imageUrl = (String) request.getAttribute("imageUrl");
%>
{
  "success": <%= success %>,
  "imageUrl": "<%= imageUrl != null ? imageUrl : "" %>"
}
