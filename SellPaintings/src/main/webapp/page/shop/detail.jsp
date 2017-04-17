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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<!-- 适应手机屏幕的meta -->
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/aui.2.0.css">
<style type="text/css">
	.title{
		margin: 5px 15px;
		font-size: 20px;
		font-weight: 600;
	}
	.price{
		margin-top: 5px;
		font-size: 18px;
		color: #FF6F0F;
		padding: 10px;
	}
	.btn_order{
		float: right;
		font-size: 15px;
		background-color: #FFAB73;
		color: white;
		padding: 3px 10px;
		margin-right: 15px;
		margin-top: -5px;
		-moz-border-radius:5px;     /*仅firefox支持，实现圆角效果*/
		-webkit-border-radius:5px;    /*仅safari，chrome支持，实现圆角效果*/
		-khtml-border-radius:5px;    /*仅safari，chrome支持，实现圆角效果*/
		border-radius:5px;    /*仅firefox，opera，safari，chrome支持，实现圆角效果*/
	}
	.descript{
		margin: 15px;
	}
	.author{
		margin-left: 15px;
	}
	/* 横线穿过字体 */
	.line{
		text-decoration: line-through;
	}
</style>
</head>
<body>
<header class="aui-bar aui-bar-nav">
	<a class="aui-pull-left aui-btn" id="btnBack">
		<span class="aui-iconfont aui-icon-left"></span>
	</a>
	<div class="aui-title">画作详情</div>
</header>
<div>
	<img src="<%=StaticClass.IMAGE_BASE_URL%>${painting.imageUrl}" style="width: 100%;">
	<div class="title">
		${painting.title}
	</div>
	<div>
		<span class="price line">￥${painting.originalPrice}</span>
		<span class="price">￥${painting.discountPrice}</span>
		<span class="btn_order">
			订购
		</span>
	</div>
	<div class="descript">
		${painting.descript}
	</div>
	<div class="author">
		作者：${painting.author}
	</div>
</div>
<script type="text/javascript" src="<%=path%>/script/jquery-1.11.2.js"></script>
<script type="text/javascript">
	$(function(){
		// alert("jquery");
		
		$("#btnBack").on("click", function(){
			window.history.go(-1);
			window.location.reload();
		});
		
		$(".btn_order").on("click", function(){
			var id = ${painting.id};
			window.location.href = "toShoppingCart?type=add&id="+id;
		});
	});
</script>
</body>
</html>