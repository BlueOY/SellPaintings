<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/lib/easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/lib/easyui/icon.css">
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
</style>
</head>
<body>
<div class="title">
	用户管理
</div>
<div>
	<table id="table" class="easyui-datagrid" title="用户列表" style="width:100%;height:500px"
			data-options="rownumbers:true,pagination:true,singleSelect:true,collapsible:true">
		<thead>
			<tr>
				<th data-options="field:'id',width:60">ID</th>
				<th data-options="field:'openId',width:300">OpenID</th>
				<th data-options="field:'createTime',width:150">创建时间</th>
				<th data-options="field:'visitTime',width:150">访问时间</th>
			</tr>
		</thead>
	</table>
</div>
<script type="text/javascript" src="<%=path%>/lib/easyui/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/lib/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">
$(function(){
	//alert("jquery");
	
	$("#table").datagrid({"url":"<%=path%>/manage/getUsers"});
	//$("#table").datagrid("loadData", getData());
	$("#table").datagrid({
		onDblClickRow: function(rowIndex, rowData){
			//alert(rowIndex+" "+JSON.stringify(rowData));
			window.location.href = "<%=path%>/page/manage/user/userOrders.jsp?openId="+rowData.openId;
		}
	});
});
</script>
</body>
</html>