<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

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
<style type="text/css">
	body{
		background: #47B0F0;
		vertical-align: middle;
	}
	.bg{
		background: white;
		margin:100px auto;
		width: 450px; height: 335px;
		-moz-border-radius:15px;     /*仅firefox支持，实现圆角效果*/
		-webkit-border-radius:15px;    /*仅safari，chrome支持，实现圆角效果*/
		-khtml-border-radius:15px;    /*仅safari，chrome支持，实现圆角效果*/
		border-radius:15px;    /*仅firefox，opera，safari，chrome支持，实现圆角效果*/
	}
	.title{
		padding: 15px 0px;
		margin-left: 35px;
		color: #47B0F0;
		font-weight: 600;
		font-size: 20px;
	}
	.line{
		background: #47B0F0;
		width: 100%; height: 2px;
	}
	.content{
		text-align: center;
		margin-top: 15px;
	}
	input {
		width: 270px;
		height: 42px;
		margin-top: 25px;
		padding: 0 15px;
		-moz-border-radius: 6px;
		-webkit-border-radius: 6px;
		border-radius: 6px;
		border: 1px solid #ccc; /* browsers that don't support rgba */
		font-family: 'PT Sans', Helvetica, Arial, sans-serif;
		font-size: 14px;
	}
	button {
		cursor: pointer;
		width: 260px;
		height: 40px;
		margin-top: 45px;
		padding: 0;
		background: #205AA4;
		-moz-border-radius: 3px;
		-webkit-border-radius: 3px;
		border-radius: 3px;
		border: 1px solid #205AA4;
		font-family: 'PT Sans', Helvetica, Arial, sans-serif;
		font-size: 18px;
		font-weight: 600;
		color: #fff;
	}

	button:hover {
		background: #2C79DE;
		border: 1px solid #2C79DE;
	}

	button:active {
		background: #205AA4;
		border: 1px solid #205AA4;
	}
</style>
</head>
<body>
<div class="bg">
	<div class="title">
		用户登录
	</div>
	<div class="line"></div>
	<div class="content">
		<div>
			<input id="username" type="text" name="" placeholder="用户名">
		</div>
		<div>
			<input id="password" type="password" name="" placeholder="密码">
		</div>
		<div>
			<button id="login">登录</button>
		</div>
	</div>
</div>
<script type="text/javascript" src="<%=basePath%>script/jquery-1.11.2.js"></script>
<script type="text/javascript">
$(function(){
	//alert("jquery");
	
	$("#login").on("click", function(){
		var username = $("#username").val();
		var password = $("#password").val();
		if(username==""){
			alert("请输入用户名");
			return;
		}else if(password==""){
			alert("请输入密码");
			return;
		}
		var param = {
			username: username,
			password: password
		};
		$.ajax({
			url: "<%=path%>/manage/login",
			type: "POST",
			data: param,
			success: function(data){
				if(data=="true"){
					//window.location.href = "/SellPaintings/manage/toMain";
					window.location.href = "<%=path%>/page/manage/main.jsp";
				}else{
					alert(data);
				}
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				alert("请求失败："+textStatus);
				alert(errorThrown+" "+XMLHttpRequest.status);
			}
		});
	});
});
</script>
</body>
</html>
