<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="com.trajectory.utils.StaticClass" %>
<%
	String openId = request.getParameter("openId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>easyui/icon.css">
<style type="text/css">
	body{
		background: white;
	}
	img{
		width: 35px; height: 35px;
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
		background:url('<%=path%>/page/manage/images/back.png');
		background-size: 100% 100%;
		width: 25px; height: 25px;
		cursor: pointer;
	}
</style>
</head>
<body>
<div class="top-bar">
	<span id="backBtn"></span>
	<div class="title">用户订单</div>
</div>
<div>
	<table id="table" class="easyui-datagrid" title="用户：<%=openId%> 的订单" style="width:100%;height:500px"
			data-options="rownumbers:true,pagination:true,singleSelect:true,collapsible:true">
		<thead>
			<tr>
				<th data-options="field:'id',width:50">ID</th>
				<th data-options="field:'paintings',width:80">画作</th>
				<th data-options="field:'totalPrice',width:60">总价</th>
				<th data-options="field:'distributionMode',width:60">配送方式</th>
				<th data-options="field:'paymentMode',width:80">支付方式</th>
				<th data-options="field:'payState',width:80">支付状态</th>
				<th data-options="field:'user',width:80">用户账号</th>
				<th data-options="field:'address',width:80">收货地址</th>
				<th data-options="field:'phone',width:80">联系方式</th>
				<th data-options="field:'remarks',width:50">备注</th>
				<th data-options="field:'createTime',width:100">创建时间</th>
				<th data-options="field:'state',width:60">状态</th>
				<th data-options="field:'operation',width:90">操作</th>
			</tr>
		</thead>
	</table>
</div>
<script type="text/javascript" src="<%=basePath%>easyui/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">
$(function(){
	//alert("jquery");
	
	$("#backBtn").on("click", function(){
		window.history.go(-1);
	});
	
	$("#table").datagrid({"url":"<%=path%>/manage/getUserOrders?user=<%=openId%>"});
	$("#table").datagrid({"loadFilter":pagerFilter});
	$("#table").datagrid({
		onDblClickRow: function(rowIndex, rowData){
			//alert(rowIndex+" "+JSON.stringify(rowData));
			window.location.href = "<%=path%>/manage/toOrderDetail?id="+rowData.id;
		}
	});
});
function pagerFilter(data){
	for(var i=0;i<data.length;i++){
		var item = data[i];
		var html = "";
		for(var j=0;j<item.paintings.length;j++){
			var paintingTemp = item.paintings[j];
			html += "<img src='<%=StaticClass.IMAGE_BASE_URL%>"+paintingTemp.imageUrl+"'/>";
		}
		item.paintings = html;
	}
	return data;
}
</script>
</body>
</html>