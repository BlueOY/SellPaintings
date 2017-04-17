<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="java.util.*" %>
<%@ page import="com.trajectory.pojo.Painting" %>
<%@ page import="com.trajectory.utils.StaticClass" %>
<%
	List<Painting> paintingsList = (List<Painting>)request.getSession().getAttribute("paintingsList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<!-- 适应手机屏幕的meta -->
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/aui.2.0.css">
	<style type="text/css">
		.title{
			font-size: 18px !important;
			font-weight: 600;
			margin-left: 5px;
		}
		.content{
			font-size: 15px !important;
			margin-left: 5px;
			
			display: -webkit-box;
			-webkit-box-orient: vertical;
			-webkit-line-clamp: 3;
			overflow: hidden;
		}
		.price{
			font-size: 16px;
			float: right;
			margin-right: 5px;
			color: #FF6F0F;
		}
		.btnDelete{
			float: right;
			background: #aaa;
			color: white;
			padding: 3px 18px;
			font-size: 13px;
			bottom: 0px;

			position: absolute;
			bottom: 5px;
			right: 0px;
		}
		.btnDeleteAll{
			float: right;
			background: #aaa;
			color: white;
			padding: 3px 18px;
			font-size: 15px;
			bottom: 0px;
		}
		.label{
			font-size: 16px !important;
			font-weight: 600;
			margin-left: 5px;
		}
		/* 横线穿过字体 */
		.line{
			text-decoration: line-through;
		}
		/* 弹出框的样式 */
		.dialog{
			position: fixed; width: 100%; height: 100%; top: 0px; text-align:center; display:table;
		}
		.dialog .bg{
			background-color: #000; position: absolute; width: 100%; height: 100%; opacity: 0.3; z-index:-1;
		}
		.dialog .content{
			display:table-cell; vertical-align:middle; padding: 20%;
		}
		.dialog .item{
			background: white; padding: 8px;
		}
		.dialog input[type="radio"]{
			width: 10px; height: 10px;
		}
		.horizontal_line{
			width: 100%; height: 0.5px;
			background: #ccc;
		}
	</style>
</head>
<body style="background: #EFEFEF">
<header class="aui-bar aui-bar-nav">
	<a class="aui-pull-left aui-btn" id="btnBack">
		<span class="aui-iconfont aui-icon-left"></span>
	</a>
	<div class="aui-title">提交订单</div>
</header>
<div class="aui-content aui-margin-b-15" id="list">
	<ul class="aui-list aui-list-in">
		<li class="aui-list-item">
			<div class="aui-list-item-inner">
				<div class="aui-list-item-title title">店铺</div>
				<div class="aui-list-item-right">
					<span class="btnDeleteAll">清空</span>
				</div>
			</div>
		</li>
		<%
			int totalPrice=0;
			String paintings="";
			int i=0;
			for(Painting painting : paintingsList){
				i++;
				if(painting.getDiscountPrice()>0){
					totalPrice += painting.getDiscountPrice();
				}else{
					totalPrice += painting.getOriginalPrice();
				}
				
				paintings += painting.getId();
				if(i<paintingsList.size()){
					paintings += ",";
				}
		%>
		<li class="aui-list-item commodity" data-id="<%=painting.getId()%>">
			<div style="width: 100%; margin:5px;">
				<div style="float: left; background: url(<%=StaticClass.IMAGE_BASE_URL+painting.getImageUrl()%>); width: 130px; height: 130px; background-size: 100% 100%;">
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
					<div>
						<span class="btnDelete">删除</span>
					</div>
				</div>
			</div>
		</li>
		<%
			}
		%>
		<li class="aui-list-item mode_of_distribution">
			<div class="aui-list-item-inner aui-list-item-arrow">
				<div class="aui-list-item-title label">配送方式</div>
				<div class="aui-list-item-right content" id="distributionMode">快递</div>
			</div>
		</li>
		<li class="aui-list-item mode_of_payment">
			<div class="aui-list-item-inner aui-list-item-arrow">
				<div class="aui-list-item-title label">付款方式</div>
				<div class="aui-list-item-right content" id="paymentMode">货到付款</div>
			</div>
		</li>
		<li class="aui-list-item address_item">
			<div class="aui-list-item-inner">
				<div class="aui-list-item-title label">
					收货地址：
				</div>
				<div class="aui-list-item-input" style="width: 65%;">
					<input class="content" id="address" type="text" placeholder="请输入收货地址">
				</div>
			</div>
		</li>
		<li class="aui-list-item">
			<div class="aui-list-item-inner">
				<div class="aui-list-item-title label">
					联系方式：
				</div>
				<div class="aui-list-item-input" style="width: 65%;">
					<input class="content" id="phone" type="text" placeholder="请输入联系方式">
				</div>
			</div>
		</li>
		<li class="aui-list-item">
			<div class="aui-list-item-inner">
				<div class="aui-list-item-title label">
					买家留言：
				</div>
				<div class="aui-list-item-input" style="width: 65%;">
					<input class="content" id="remarks" type="text" placeholder="请输入给商家的留言">
				</div>
			</div>
		</li>
	</ul>
	<div style="height:80px;"></div>
	<div style="position: fixed; bottom: 0px; border-top: 1px solid #ccc; width: 100%; background: white;">
		<div style="padding: 10px 35px; background: #CC7000; color: white; float: right; font-size: 18px;" id="submit">提交订单</div>
		<div style="padding: 10px 35px; float: right; font-size: 18px;">合计：￥<%=StaticClass.totalPriceFormat(totalPrice)%></div>
	</div>
	
	<div class="dialog" id="distribution">
		<div class="bg"></div>
		<div class="content">
			<div class="item">
				<label><input name="distribution" type="radio" data-id="0" checked="true"/> 快递</label>
			</div>
			<div class="horizontal_line"></div>
			<div class="item">
				<label><input name="distribution" type="radio" data-id="1"/> 自取</label>
			</div>
		</div>
	</div>

	<div class="dialog" id="payment">
		<div class="bg"></div>
		<div class="content">
			<div class="item">
				<label><input name="payment" type="radio" data-id="0" checked="true"/> 货到付款</label>
			</div>
			<div class="horizontal_line"></div>
			<div class="item">
				<label><input name="payment" type="radio" data-id="1"/> 微信支付</label>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="<%=path%>/script/jquery-1.11.2.js"></script>
<script type="text/javascript">
	$(function(){
		initView();
		initDialog();
	});
	
	function initView(){
		if(<%=paintingsList.size()%>==0){
			alert("购物车为空");
			window.location.href = "<%=basePath%>page/shop/index.jsp";
		}
		
		$("#btnBack").on("click", function(){
			window.history.go(-1);
			window.location.reload();
		});
		
		$("#list").on("click", ".btnDelete", function(){
			var id = $(this).parents("li").data("id");
			window.location.href = "<%=path%>/shop/toShoppingCart?type=delete&id="+id;
			return false;
		});
		$("#list").on("click", ".btnDeleteAll", function(){
			window.location.href = "<%=path%>/shop/toShoppingCart?type=deleteAll";
			return false;
		});
		
		$("#list").on("click", ".commodity", function(){
			var id = $(this).data("id");
			window.location.href = "<%=path%>/shop/toPaintingDetail?id="+id;
		});
		
		$("#submit").on("click", function(){
			var paintings = "<%=paintings%>";
			var distributionMode = $("#distributionMode").text();
			var paymentMode = $("#paymentMode").text();
			var address = $("#address").val();
			var phone = $("#phone").val();
			var remarks = $("#remarks").val();
			var totalPrice = <%=totalPrice%>;
			if(distributionMode=="快递"){
				if(address==""){
					alert("请填写收货地址");
					return;
				}
			}
			var param = {
				paintingIds: paintings,
				distributionMode: distributionMode,
				paymentMode: paymentMode,
				payState: "未付款",
				address: address,
				phone: phone,
				remarks: remarks,
				totalPrice: totalPrice
			};
			$.ajax({
				url: "<%=path%>/shop/submitOrder",
				type: "POST",
				data: param,
				success: function(data){
					if(data=="true"){
						window.location.href = "<%=path%>/shop/toOrderList";
					}else{
						alert(data);
					}
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					alert("请求失败："+textStatus);
					alert(errorThrown);
					alert(XMLHttpRequest.status);
				}
			});
		});
	}
	
	function initDialog(){
		$(".bg").on("click", function(){
			$(".dialog").hide();
		});
		$("#list").on("click", ".mode_of_payment", function(){
			$("#payment").show();
		});
		$("#list").on("click", "input[name='payment']", function(){
			$(".dialog").hide();
			var id = $(this).data("id");
			if(id==0){
				$(".mode_of_payment .content").text("货到付款");
			}else if(id==1){
				$(".mode_of_payment .content").text("微信支付");
			}
		});
		$("#list").on("click", ".mode_of_distribution", function(){
			$("#distribution").show();
		});
		$("#list").on("click", "input[name='distribution']", function(){
			$(".dialog").hide();
			var id = $(this).data("id");
			if(id==0){
				$(".mode_of_distribution .content").text("快递");
				$(".address_item").show();
			}else if(id==1){
				$(".mode_of_distribution .content").text("自取");
				$(".address_item").hide();
			}
		});

		$(".dialog").hide();
	}
</script>
</body>
</html>