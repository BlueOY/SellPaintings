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
	<!-- 适应手机屏幕的meta -->
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
	<!-- 其它的meta -->
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
			max-width: 1024px;
		}
		/* 横线穿过字体 */
		.line{
			text-decoration: line-through;
		}
		/* 商品列表的样式 */
		.showlist{
			margin: 3px;
		}
		.showlist ul{
			list-style:none;
			padding: 0px;
		}
		.showlist li{
			float: left; width: 50%;
		}
		.showlist .item{
			padding: 6px;
		}
		.showlist img{
			width: 100%;
		}
		.showlist .title{
			text-align: left;
			font-size: 13px;
			padding: 3px;
		}
		.showlist .price{
			font-size: 10px;
			color: #FF6F0F;
			padding: 3px;
		}
		.showlist .btn_order{
			float: right;
			font-size: 10px;
			background-color: #FFAB73;
			color: white;
			padding: 3px 5px;
			margin: -3px;
			-moz-border-radius:3px;     /*仅firefox支持，实现圆角效果*/
			-webkit-border-radius:3px;    /*仅safari，chrome支持，实现圆角效果*/
			-khtml-border-radius:3px;    /*仅safari，chrome支持，实现圆角效果*/
			border-radius:3px;    /*仅firefox，opera，safari，chrome支持，实现圆角效果*/
		}
	</style>
  </head>
  
  <body>
  <div style="position: fixed; right: 0; background: url(images/guapai.png); background-size: 100% 100%; width: 135px; height: 70px; text-align: center;">
	<div style="margin-top: 40px; font-size: 12px; font-weight: 600;" id="toOrderList">查看我的订单</div>
  </div>
  <div>
	<img src="images/index_picture.jpg" style="width: 100%;">
	<div style="text-align: center; font-size: 12px; font-weight: 600; margin: 25px;">
		<p>名师画作，在线预订</p>
		<p>配送范围：长沙市</p>
		<p>配送时间：周一至周五：18:00-22:00</p>
		<p>周六周日：9:00-18:00</p>
	</div>
	<div class="showlist">
		<ul id="ulList">
			<!-- <li>
				<div class="item">
					<img src="images/index_p1.png">
					<div class="title">
						图文列表
					</div>
					<div>
						<span class="price">
							￥158.00
						</span>
						<span class="btn_order">
							订购
						</span>
					</div>
				</div>
			</li>
			<li>
				<div class="item">
					<img src="images/index_p1.png">
					<div class="title">
						图文列表
					</div>
					<div>
						<span class="price">
							￥158.00
						</span>
						<span class="btn_order">
							订购
						</span>
					</div>
				</div>
			</li> -->
		</ul>
	</div>
  </div>
	<script type="text/javascript" src="<%=basePath%>script/jquery-1.11.2.js"></script>
	<script type="text/javascript">
		$(function(){
			$.ajax({
				url: "shop/getPaintingsList",
				type: "POST",
				success: function(data){
					//alert(data);
					createHtmlList(JSON.parse(data));
				}
			});
			$("#ulList").on("click", ".item img", function(){
				var id = $(this).parent().data("id");
				window.location.href = "shop/toPaintingDetail?id="+id;
			});
			$("#ulList").on("click", ".btn_order", function(){
				var id = $(this).parents(".item").data("id");
				window.location.href = "shop/toShoppingCart?type=add&id="+id;
			});
			$("#toOrderList").on("click", function(){
				window.location.href = "shop/toOrderList";
			});
		});
		function createHtmlList(dataList){
			var innerHtml = "";
			for(var i=0;i<dataList.length;i++){
				var item = dataList[i];
				innerHtml+=
				"<li>"+
					"<div class='item' data-id='"+item.id+"'>"+
						"<img src='<%=StaticClass.IMAGE_BASE_URL%>"+item.imageUrl+"'>"+
						"<div class='title'>"+
							item.title+
						"</div>"+
						"<div>";
				if(item.discountPrice==0){
					innerHtml+=
							"<span class='price'>"+
								"￥"+item.originalPrice+
							"</span>";
				}else{
					innerHtml+=
							"<span class='price line'>"+
								"￥"+item.originalPrice+
							"</span>"+
							"<span class='price'>"+
								"￥"+item.discountPrice+
							"</span>";
				}
				innerHtml+=
							"<span class='btn_order'>"+
								"订购"+
							"</span>"+
						"</div>"+
					"</div>"+
				"</li>";
			}
			$("#ulList").html(innerHtml);
		}
	</script>
  </body>
</html>
