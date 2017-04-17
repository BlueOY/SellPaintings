<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<link rel="stylesheet" type="text/css" href="<%=path%>/lib/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/lib/easyui/icon.css">
<script type="text/javascript" src="<%=path%>/lib/easyui/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/lib/easyui/jquery.easyui.min.js"></script>