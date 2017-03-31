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
<link rel="stylesheet" type="text/css" href="<%=basePath%>easyui/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>easyui/icon.css">
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
	画作管理
</div>
<div>
	<table id="table" class="easyui-datagrid" title="画作列表" style="width:100%;height:450px"
			data-options="rownumbers:true,pagination:true,singleSelect:true,collapsible:true">
		<thead>
			<tr>
				<th data-options="field:'id',width:60">ID</th>
				<th data-options="field:'imageUrl',width:60">图片</th>
				<th data-options="field:'title',width:80">标题</th>
				<th data-options="field:'descript',width:80">描述</th>
				<th data-options="field:'author',width:60">作者</th>
				<th data-options="field:'paintingTime',width:150">创作时间</th>
				<th data-options="field:'originalPrice',width:50">售价</th>
				<th data-options="field:'discountPrice',width:50">折扣价</th>
				<th data-options="field:'state',width:80">状态</th>
				<th data-options="field:'createTime',width:150">上传时间</th>
				<th data-options="field:'updateTime',width:150">修改时间</th>
			</tr>
		</thead>
	</table>
</div>

<script type="text/javascript" src="<%=basePath%>easyui/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">
$(function(){
	//alert("jquery");
	
	$("#table").datagrid({"url":"<%=path%>/manage/getPaintings"});
	$("#table").datagrid({"loadFilter":pagerFilter});
	$("#table").datagrid({"toolbar":toolbar});
	//$("#table").datagrid("loadData", getData());
	$("#table").datagrid({
		onDblClickRow: function(rowIndex, rowData){
			//alert(rowIndex+" "+JSON.stringify(rowData));
			//window.location.href = "paintingDetail.jsp";
			window.location.href = "<%=path%>/manage/toPaintingDetail?id="+rowData.id;
		}
	});
});
function pagerFilter(data){
	for(var i=0;i<data.length;i++){
		var item = data[i];
		item.imageUrl = "<img src='<%=StaticClass.IMAGE_BASE_URL%>"+item.imageUrl+"'/>";
	}
	return data;
}
var toolbar = [{
	text:'新增',
	iconCls:'icon-add',
	handler:function(){
		window.location.href = "<%=path%>/manage/toPaintingDetail";
	}
},'-',{
	text:'删除',
	iconCls:'icon-cut',
	handler:function(){
		var selected = $('#table').datagrid('getSelected');
		if(selected){
			if(window.confirm("你确定要删除“"+selected.title+"”这幅画作吗？")){
				alert('cut'+JSON.stringify(selected));
				
			}
		}else{
			alert("请先选中一行数据");
		}
	}
},'-',{
	text:'编辑',
	iconCls:'icon-save',
	handler:function(){
		var selected = $('#table').datagrid('getSelected');
		if(selected){
			window.location.href = "<%=path%>/manage/toPaintingDetail?id="+selected.id;
		}else{
			alert("请先选中一行数据");
		}
	}
}];
/* function getData(){
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
} */
</script>
</body>
</html>