<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="com.trajectory.utils.StaticClass" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
    This is my JSP page. <br>
    <a href="<%=path%>/page/shop/index.jsp">shop</a>
    <a href="<%=path%>/page/manage/main.jsp">manage</a>
    <br/>
    <br/>
    <a href="<%=path%>/testUploadImg.jsp">testUploadImg</a>
    <br/>
    <a href="<%=path%>/testEL.jsp">testEL</a>
	
    <script type="text/javascript" src="<%=basePath%>script/jquery-1.11.2.js"></script>
	<script type="text/javascript">
		$(function(){
			//alert("jquery");
			
		});
	</script>
  </body>
</html>
