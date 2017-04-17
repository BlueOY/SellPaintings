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
	画作管理
</div>
<div>
	<table id="table" class="easyui-datagrid" title="画作列表" style="width:100%;height:500px"
			data-options="rownumbers:true,pagination:true,singleSelect:true,collapsible:true">
		<thead>
			<tr>
				<th data-options="field:'id',width:60">ID</th>
				<th data-options="field:'imageUrl',width:60">图片</th>
				<th data-options="field:'title',width:80">标题</th>
				<th data-options="field:'descript',width:80">描述</th>
				<th data-options="field:'paintingType',width:60">类型</th>
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
	<div id="tb" style="padding:5px;height:auto">
		<span style="margin-bottom:5px">
			<a href="javascript:add();" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
			<a href="javascript:del();" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
			<a href="javascript:edit();" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a>
			<a href="javascript:recycle();" class="easyui-linkbutton" iconCls="icon-redo" plain="true">回收站</a>
		</span>
		<span style="float:right;">
			画作类型: 
			<select id="paintingType" panelHeight="auto" style="width:100px">
				<option value="all">全部</option>
			</select>
			<button id="addPaintingType">新建类型</button>
		</span>
	</div>
</div>

<script type="text/javascript">
$(function(){
	//alert("jquery");
	
	//初始化数据列表
	$("#table").datagrid({"url":"<%=path%>/manage/getPaintings"});
	$("#table").datagrid({"loadFilter":pagerFilter});
	//$("#table").datagrid({"toolbar":toolbar});
	$("#table").datagrid({"toolbar": "#tb"});
	//$("#table").datagrid("loadData", getData());
	$("#table").datagrid({
		onDblClickRow: function(rowIndex, rowData){
			//alert(rowIndex+" "+JSON.stringify(rowData));
			window.location.href = "<%=path%>/manage/toPaintingDetail?id="+rowData.id;
		}
	});
	
	//初始化下拉列表
	$("#paintingType").on("change", function(){
		var selectVal=$(this).children('option:selected').val();
		$("#table").datagrid({"url":"<%=path%>/manage/getPaintings?paintingType="+selectVal});
	});
	$.ajax({
		url: "<%=path%>/manage/getPaintingType",
		type: "POST",
		success: function(data){
			var dataObj = $.parseJSON(data);
			for(var i=0;i<dataObj.length;i++){
				$("#paintingType").append("<option value='"+dataObj[i].id+"'>"+dataObj[i].name+"</option>");
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			alert("请求失败："+textStatus);
			alert(errorThrown+" "+XMLHttpRequest.status);
		}
	});
	
	//新建画作类型
	$("#addPaintingType").on("click", function(){
		var namePaintingType = window.prompt("新建类型","请在此输入类型名称");
		if(namePaintingType==null){
			return;
		}
		if(namePaintingType==""){
			alert("无效的输入");
			return;
		}
		$.ajax({
			url: "<%=path%>/manage/addPaintingType",
			type: "POST",
			data: {
				name: namePaintingType
			},
			success: function(data){
				if(data=="true"){
					alert("新建成功");
					location.reload();
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
function pagerFilter(data){
	for(var i=0;i<data.length;i++){
		var item = data[i];
		item.imageUrl = "<img src='<%=StaticClass.IMAGE_BASE_URL%>"+item.imageUrl+"'/>";
		item.paintingType = item.paintingType.name;
	}
	return data;
}
function add(){
	window.location.href = "<%=path%>/manage/toPaintingDetail";
}
function del(){
	var selected = $('#table').datagrid('getSelected');
	if(selected){
		if(window.confirm("你确定要删除“"+selected.title+"”这幅画作吗？")){
			//alert('cut'+JSON.stringify(selected));
			$.ajax({
				url: "<%=path%>/manage/deletePainting",
				type: "POST",
				data: {
					id: selected.id
				},
				success: function(data){
					if(data=="true"){
						window.location.reload();
					}else{
						alert(data);
					}
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					alert("请求失败："+textStatus);
					alert(errorThrown+" "+XMLHttpRequest.status);
				}
			});
		}
	}else{
		alert("请先选中一行数据");
	}
}
function edit(){
	var selected = $('#table').datagrid('getSelected');
	if(selected){
		window.location.href = "<%=path%>/manage/toPaintingDetail?id="+selected.id;
	}else{
		alert("请先选中一行数据");
	}
}
function recycle(){
	window.location.href = "<%=path%>/page/manage/painting/paintingRecycle.jsp";
}

/* var toolbar = [{
	text:'新增',
	iconCls:'icon-add',
	handler:function(){
		add();
	}
},'-',{
	text:'删除',
	iconCls:'icon-cut',
	handler:function(){
		del();
	}
},'-',{
	text:'编辑',
	iconCls:'icon-save',
	handler:function(){
		edit();
	}
},'-',{
	text:'回收站',
	iconCls:'icon-redo',
	handler:function(){
		recycle();
	}
}]; */
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