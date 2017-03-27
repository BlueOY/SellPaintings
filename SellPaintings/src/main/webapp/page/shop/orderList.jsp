<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="java.util.*" %>
<%@ page import="com.trajectory.pojo.Order" %>
<%@ page import="com.trajectory.pojo.Painting" %>
<%
	List<Order> list = (List<Order>)request.getAttribute("orderList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
	<!-- 适应手机屏幕的meta -->
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/aui.2.0.css">
	<style type="text/css">
		.orderState{
			color: #F36D0A;
			font-size: 18px;
		}
		.order_id{
			font-size: 18px !important;
			corlor: #efefef;
		}
		.title{
			font-size: 18px !important;
			font-weight: 600;
			margin: 15px;
		}
		.content{
			font-size: 16px !important;
			margin-left: 15px;

			display: -webkit-box;
			-webkit-box-orient: vertical;
			-webkit-line-clamp: 4;
			overflow: hidden;
		}
		.price{
			font-size: 16px;
			float: right;
			margin-right: 5px;
			color: #FF6F0F;
		}

		#list ul{
			margin-top: 10px;
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
	<div class="aui-title">我的订单</div>
</header>
<div class="aui-content aui-margin-b-15" id="list">
	<ul class="aui-list aui-list-in">
		<li class="aui-list-item">
			<div class="aui-list-item-inner">
				<div class="aui-list-item-title order_id">订单编号：123</div>
				<div class="aui-list-item-right">
					<span class="orderState">交易完成</span>
				</div>
			</div>
		</li>
		<li class="aui-list-item commodity" data-id="1">
			<div style="width: 100%;">
				<div style="float: left; background: url(<%=basePath%>images/index_p1.png); width: 130px; height: 130px; background-size: 100% 100%;">
				</div>
				<div style="float: left; width: calc(100% - 130px); height: 130px; position: relative;">
					<div>
						<span class="title">title</span>
						<span class="price">￥100</span>
						<span class="price line">￥123</span>
					</div>
					<div class="content">描述描述描述描述描述描述描述描述描述描描述描述描述描述描描述描述描述描述描描述描述描述描述描描述描述描述描述描描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述</div>
				</div>
			</div>
		</li>
		<li class="aui-list-item mode_of_distribution">
			<div class="aui-list-item-inner">
				<div class="aui-list-item-title"></div>
				<div class="aui-list-item-right content">合计：<span class="price">￥123</span></div>
			</div>
		</li>
	</ul>
	<%
		for(Order order : list){
			List<Painting> paintings = order.getPaintings();
	%>
	<ul class="aui-list aui-list-in">
		<li class="aui-list-item">
			<div class="aui-list-item-inner">
				<div class="aui-list-item-title order_id">订单编号：<%=order.getId()%></div>
				<div class="aui-list-item-right">
					<span class="orderState"><%=order.getState()%></span>
				</div>
			</div>
		</li>
		<%
			int totalPrice=0;
			for(Painting painting : paintings){
				if(painting.getDiscountPrice()>0){
					totalPrice += painting.getDiscountPrice();
				}else{
					totalPrice += painting.getOriginalPrice();
				}
		%>
		<li class="aui-list-item commodity" data-id="2">
			<div style="width: 100%;">
				<div style="float: left; background: url(<%=basePath%>images/index_p1.png); width: 130px; height: 130px; background-size: 100% 100%;">
				</div>
				<div style="float: left; width: calc(100% - 130px); height: 130px; position: relative;">
					<div>
						<span class="title"><%=painting.getTitle()%></span>
						<%
							if(painting.getDiscountPrice()>0){
						%>
						<span class="price">￥<%=painting.getDiscountPrice()%></span>
						<span class="price line">￥<%=painting.getOriginalPrice()%></span>
						<%
							}else{
						%>
						<span class="price">￥<%=painting.getOriginalPrice()%></span>
						<%
							}
						%>
					</div>
					<div class="content"><%=painting.getDescript()%></div>
				</div>
			</div>
		</li>
		<%
			}
		%>
		<li class="aui-list-item mode_of_distribution">
			<div class="aui-list-item-inner">
				<div class="aui-list-item-title"></div>
				<div class="aui-list-item-right content">合计：<span class="price">￥<%=totalPrice%></span></div>
			</div>
		</li>
	</ul>
	<%
		}
	%>
</div>
<script type="text/javascript" src="<%=basePath%>script/jquery-1.11.2.js"></script>
<script type="text/javascript">
	$(function(){
		$("#btnBack").on("click", function(){
			window.history.go(-1);
			window.location.reload();
		});
		
		$("#list").on("click", ".commodity", function(){
			var id = $(this).data("id");
			window.location.href = "toPaintingDetail?id="+id;
		});
	});
</script>
</body>
</html>