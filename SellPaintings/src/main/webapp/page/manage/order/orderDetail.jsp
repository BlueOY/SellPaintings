<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="com.trajectory.utils.StaticClass" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
	body{
		background: white;
	}
	/* 标题栏的样式 */
	.top-bar{
		position: relative;
		top: 0;
		right: 0;
		left: 0;
		z-index: 10;
		width: 100%;
		text-align: center;
		display: table;
		background: #2A76DB;
		color: white;
		padding: 10px 0px;
		font-size: 20px;
	}
	.title{
		position: absolute;
		text-align: center;
		width: auto;
		right: 5rem;
		left: 5rem;
	}
	#backBtn{
		float:left; margin-left: 15px;
		background:url('../images/back.png');
		background-size: 100% 100%;
		width: 25px; height: 25px;
		cursor: pointer;
	}
</style>
</head>
<body>
<div class="top-bar">
	<span id="backBtn"></span>
	<div class="title">订单详情</div>
</div>
<div style="overflow-y: auto; height:550px;">
	<div style="width:30px; height:1300px; background: red;"></div>
</div>
<%-- <script type="text/javascript" src="<%=basePath%>script/jquery-1.11.2.js"></script> --%>
<script type="text/javascript" src="<%=basePath%>easyui/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">
$(function(){
	//alert("jquery");
	
	$("#backBtn").on("click", function(){
		window.history.go(-1);
	});
});
</script>
</body>
</html>