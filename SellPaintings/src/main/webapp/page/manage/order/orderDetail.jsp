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
<link rel="stylesheet" type="text/css" href="<%=path%>/bootstrap/bootstrap_diy.css">
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
	.top-bar .title{
		position: absolute;
		text-align: center;
		width: auto;
		right: 5rem;
		left: 5rem;
	}
	.top-bar #backBtn{
		float:left; margin-left: 15px;
		background:url('../images/back.png');
		background-size: 100% 100%;
		width: 25px; height: 25px;
		cursor: pointer;
	}
	/* 画作的样式 */
	.painting_heading{
		border: 1px solid #ccc;
		padding: 5px; margin-top: 15px;
	}
	.painting{
		border: 1px solid #ccc;
		height: 147px;
	}
	.painting .img{
		width: 145px; height: 145px;
		background: url('../images/index_p1.png');
		background-size: 100% 100%;
		float: left;
	}
	.painting .content{
		float: left;
		width: calc(60% - 145px); height: 145px; position: relative;
	}
	.painting .title{
		font-size: 25px !important;
		font-weight: 600;
		padding-top: 15px;
		padding-left: 25px;
	}
	.painting .price{
		font-size: 25px;
		float: right;
		margin-right: 30px;
		color: #FF6F0F;
	}
	.painting .descript{
		font-size: 20px !important;
		margin: 10px 25px;

		display: -webkit-box;
		-webkit-box-orient: vertical;
		-webkit-line-clamp: 3;
		overflow: hidden;
	}
	.painting .author{
		float: left;
		margin: 65px 35px;
	}
	.painting .time{
		float: left;
		padding: 65px 35px;
	}
	/* 横线穿过字体 */
	.line{
		text-decoration: line-through;
	}
	/* 初始化隐藏 */
	.init-hide{
		display: none;
	}
</style>
</head>
<body>
<div class="top-bar">
	<span id="backBtn"></span>
	<div class="title">订单详情</div>
</div>
<div class="container-fluid" style="overflow-y: scroll;">
	<div class="row">
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputPassword1">订单号</label>
			<input type="text" class="form-control field" readOnly="true" id="id" value="${order.id}" placeholder="订单号">
		</div>
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputEmail1">用户</label>
			<input type="text" class="form-control field" readOnly="true" id="user" value="${order.user}" placeholder="用户">
		</div>
	</div>
	<div class="row">
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputEmail1">配送方式</label>
			<input type="text" class="form-control field" readOnly="true" id="distributionMode" value="${order.distributionMode}" placeholder="配送方式">
		</div>
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputPassword1">支付方式</label>
			<input type="text" class="form-control field" readOnly="true" id="paymentMode" value="${order.paymentMode}" placeholder="支付方式">
		</div>
	</div>
	<div class="row">
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputPassword1">总金额</label>
			<input type="text" class="form-control field" readOnly="true" id="totalPrice" value="${order.totalPrice}" placeholder="总金额">
		</div>
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputPassword1">支付状态</label>
			<input type="text" class="form-control field" readOnly="true" id="payState" value="${order.payState}" placeholder="支付状态">
		</div>
	</div>
	<div class="row">
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputEmail1">收货地址</label>
			<input type="text" class="form-control field" readOnly="true" id="address" value="${order.address}" placeholder="收货地址">
		</div>
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputPassword1">联系方式</label>
			<input type="text" class="form-control field" readOnly="true" id="phone" value="${order.phone}" placeholder="联系方式">
		</div>
	</div>
	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12">
			<label for="exampleInputEmail1">备注</label>
			<input type="text" class="form-control field" readOnly="true" id="remarks" value="${order.remarks}" placeholder="备注">
		</div>
		
	</div>
	<div class="row">
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputEmail1">创建时间</label>
			<input type="text" class="form-control field" readOnly="true" id="createTime" value="${order.createTime}" placeholder="创建时间">
		</div>
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputPassword1">订单状态</label>
			<input type="text" class="form-control field" readOnly="true" id="state" value="${order.state}" placeholder="订单状态">
		</div>
	</div>
	<div class="painting_heading">画作</div>
	<div class="painting">
		<div class="img"></div>
		<div class="content">
			<div>
				<span class="title">title</span>
				<span class="price">
					<span class="line">￥123</span>
					￥100
				</span>
			</div>
			<div class="descript">描述描述描述描述描述描述描述描述描述描描述描述描述描述描描述描述描述描述描描述描述描述描述描描述描述描述描述描描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述</div>
		</div>
		<div style="width: 1px; height: 100%; background: #ccc; float: left;"></div>
		<div class="author">
			作者
		</div>
		<div style="width: 1px; height: 100%; background: #ccc; float: left;"></div>
		<div class="time">
			2016-01-01
		</div>
		<div style="width: 1px; height: 100%; background: #ccc; float: left;"></div>
		<div style="margin: 65px auto; text-align: center;">
			<button>删除</button>
		</div>
	</div>
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