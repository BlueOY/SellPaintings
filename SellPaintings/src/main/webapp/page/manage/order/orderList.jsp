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
<jsp:include page='../../../lib/easyui.jsp'></jsp:include>
<style type="text/css">
	body{
		background: white;
	}
	.title{
		background: #2A76DB;
		color: white;
		text-align:center;
		padding: 10px 0px;
		font-size: 20px;
	}
	
	img{
		width: 35px; height: 35px;
	}
</style>
</head>
<body>
<div class="title">
	订单管理
</div>
<div>
	<table id="table" class="easyui-datagrid" title="Basic DataGrid" style="width:100%;height:500px"
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
<script type="text/javascript">
$(function(){
	//alert("jquery");
	
	$("#table").datagrid({"url":"<%=basePath%>manage/getOrders"});
	$("#table").datagrid({"loadFilter":pagerFilter});
	//$("#table").datagrid("loadData", getData());
	$("#table").datagrid({
		onDblClickRow: function(rowIndex, rowData){
			//alert(rowIndex+" "+JSON.stringify(rowData));
			//window.location.href = "orderDetail.jsp";
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
		function getData(){
			var rows = [];
			for(var i=1; i<=800; i++){
				var amount = Math.floor(Math.random()*1000);
				var price = Math.floor(Math.random()*1000);
				rows.push({
					id: 'Inv No '+i,
					imageUrl: $.fn.datebox.defaults.formatter(new Date()),
					title: 'Name '+i,
					descript: amount,
					author: price,
					paintingTime: amount*price,
					uploadingTime: 'Note '+i
				});
			}
			return rows;
		}
</script>
</body>
</html>