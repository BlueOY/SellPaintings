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
	
	img{
		width: 35px; height: 35px;
	}
</style>
</head>
<body>
<div class="top-bar">
	<span id="backBtn"></span>
	<div class="title">画作回收站</div>
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
</div>
<script type="text/javascript">
$(function(){
	//alert("jquery");
	
	$("#backBtn").on("click", function(){
		window.history.go(-1);
	});
	
	$("#table").datagrid({"url":"<%=path%>/manage/getPaintings?type=recycle"});
	$("#table").datagrid({"loadFilter":pagerFilter});
	$("#table").datagrid({"toolbar":toolbar});
	//$("#table").datagrid("loadData", getData());
	$("#table").datagrid({
		onDblClickRow: function(rowIndex, rowData){
			//alert(rowIndex+" "+JSON.stringify(rowData));
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
	text:'取消删除',
	iconCls:'icon-undo',
	handler:function(){
		var selected = $('#table').datagrid('getSelected');
		if(selected){
			if(window.confirm("你确定要恢复“"+selected.title+"”这幅画作吗？")){
				//alert('cut'+JSON.stringify(selected));
				$.ajax({
					url: "<%=path%>/manage/recyclePainting",
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
},'-',{
	text:'彻底删除',
	iconCls:'icon-cancel',
	handler:function(){
		var selected = $('#table').datagrid('getSelected');
		if(selected){
			if(window.confirm("你确定要彻底删除“"+selected.title+"”这幅画作吗？")){
				alert("暂不支持彻底删除画作");
			}
		}else{
			alert("请先选中一行数据");
		}
	}
}];
</script>
</body>
</html>