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
<jsp:include page='../../../lib/bootstrap.jsp'></jsp:include>
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
	/* 显示图片的方框的样式  */
	.image-title{
		border: 1px solid #ccc;
		padding: 5px; margin-top: 15px;
	}
	.image-content{
		border: 1px solid #ccc;
		background: #efefef;
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
	<div class="title">画作详情</div>
</div>
<div class="container-fluid" style="overflow-y: auto; height:550px; padding-top: 15px; padding-bottom: 35px;">
	<div class="row">
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputEmail1">标题</label>
			<input type="text" class="form-control field" readOnly="true" id="title" value="${painting.title}">
		</div>
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputPassword1">画作类型</label>
			<div>
			<fieldset disabled>
				<div class="btn-group disabled">
				  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<span id="valPaintingType" data-id="${painting.paintingType!=null?painting.paintingType.id:''}">${painting.paintingType!=null?painting.paintingType.name:'请选择'}</span> <span class="caret"></span>
				  </button>
				  <ul class="dropdown-menu" id="paintingType">
				  </ul>
				</div>
			</fieldset>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputPassword1">作者</label>
			<input type="text" class="form-control field" readOnly="true" id="author" value="${painting.author}">
		</div>
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputEmail1">创作时间</label>
			<input type="text" class="form-control field" readOnly="true" id="paintingTime" value="${painting.paintingTime}">
		</div>
	</div>
	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-12">
			<label for="exampleInputPassword1">描述</label>
			<input type="text" class="form-control field" readOnly="true" id="descript" value="${painting.descript}">
		</div>
	</div>
	<div class="row">
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputEmail1">售价</label>
			<input type="text" class="form-control field" readOnly="true" id="originalPrice" value="${painting.originalPrice}">
		</div>
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputPassword1">折扣价</label>
			<input type="text" class="form-control field" readOnly="true" id="discountPrice" value="${painting.discountPrice}">
		</div>
	</div>
	<div class="row">
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputPassword1">状态</label>
			<input type="text" class="form-control field" readOnly="true" id="state" value="${painting.state}">
		</div>
	</div>
	<div class="row edit">
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputEmail1">上传时间</label>
			<input type="text" class="form-control" value="${painting.createTime}" readOnly="true">
		</div>
		<div class="col-xs-6 col-sm-6 col-md-6">
			<label for="exampleInputPassword1">修改时间</label>
			<input type="text" class="form-control" value="${painting.updateTime}" readOnly="true">
		</div>
	</div>
	<div class="image-title">图片</div>
	<div class="image-content">
		<img id="image" src="<%=StaticClass.IMAGE_BASE_URL%>${painting.imageUrl}" style="width: 400px;height: 210px;">
	</div>
	<form id="upload_img" action="<%=path%>/file/upload" method="post" enctype="multipart/form-data" target="hidden_iframe">
	<div class="form-group submit init-hide">
		<input type="file" id="imageFile" name="imageFile">
		<iframe name="hidden_iframe" style="display:none;"></iframe>
	</div>
	</form>
	<div class="submit init-hide">
		<button class="btn btn-default" id="submitBtn" type="button">提交</button>
		<button class="btn btn-default" id="cancleBtn" type="button">取消</button>
	</div>
	<div class="edit" style="margin-top:15px;">
		<button class="btn btn-default" onclick="edit();">编辑</button>
	</div>
</div>
<script type="text/javascript" src="<%=path%>/script/jquery-1.11.2.js"></script>
<script type="text/javascript">
$(function(){
	//alert("jquery");
	
	$("#backBtn").on("click", function(){
		window.history.go(-1);
	});
	
	//选择图片后预览
	$("#imageFile").change(function(event){
		var size = event.target.files.length;
		for(var i=0;i<size;i++){
			var tmppath = URL.createObjectURL(event.target.files[i]);
			$("#image").attr("src", tmppath);
		}
	});
	
	//提交按钮
	$("#submitBtn").on("click", function(){
		var imageFile = $("#imageFile").val();
		if(imageFile!=""){
			$("#upload_img").submit();
		}else{
			submitPainting();
		}
	});
	//取消按钮
	$("#cancleBtn").on("click", function(){
		if("${type}"=="add"){
			//如果是新增，则返回上一层页面
			window.history.go(-1);
		}else{
			//如果是编辑，则刷新页面
			window.location.reload();
		}
	});
	
	if("${type}"=="add"){
		//如果是新增，则初始化可编辑状态
		edit();
	}
	
	//初始化下拉列表
	$.ajax({
		url: "<%=path%>/manage/getPaintingType",
		type: "POST",
		success: function(data){
			var dataObj = $.parseJSON(data);
			for(var i=0;i<dataObj.length;i++){
				$("#paintingType").append("<li><a href='#' data-id="+dataObj[i].id+">"+dataObj[i].name+"</a></li>");
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			alert("请求失败："+textStatus);
			alert(errorThrown+" "+XMLHttpRequest.status);
		}
	});
	$("#paintingType").on("click", "li", function(){
		var id = $(this).find("a").data("id");
		$("#valPaintingType").data("id", id);
		var text = $(this).find("a").text();
		$("#valPaintingType").text(text);
	});
	
});

function callbackUploadImage(fileName){
	submitPainting(fileName);
}

function submitPainting(fileName){
	var param = {};
	var title = $("#title").val();
	if(title==""){
		alert("请输入标题");
		return;
	}else{
		param.title = title;
	}
	var paintingTypeId = $("#valPaintingType").data("id");
	if(paintingTypeId==""){
		alert("请选择类型");
		return;
	}else{
		param.paintingTypeId = paintingTypeId;
	}
	var author = $("#author").val();
	if(author==""){
		alert("请输入作者");
		return;
	}else{
		param.author = author;
	}
	var descript = $("#descript").val();
	if(descript!=""){
		param.descript = descript;
	}
	var originalPrice = $("#originalPrice").val();
	if(originalPrice==""){
		alert("请输入售价");
		return;
	}else{
		param.originalPrice = originalPrice;
	}
	var discountPrice = $("#discountPrice").val();
	if(discountPrice!=""){
		param.discountPrice = discountPrice;
	}
	var paintingTime = $("#paintingTime").val();
	if(paintingTime!=""){
		param.paintingTime = paintingTime;
	}
	var state = $("#state").val();
	if(state!=""){
		param.state = state;
	}else{
		param.state = "未售出";
	}
	if(fileName){
		param.imageUrl = fileName;
	}
	var url;
	if("${type}"=="add"){
		//如果是新增
		url="<%=path%>/manage/addPaintings";
	}else{
		//否则是修改
		param.id="${painting.id}";
		url="<%=path%>/manage/updatePaintings";
	}
	$.ajax({
		url: url,
		type: "POST",
		data: param,
		success: function(data){
			if(data=="true"){
				if("${type}"=="add"){
					alert("添加成功");
					window.history.go(-2);
				}else{
					alert("修改成功");
					window.location.reload();
				}
			}else{
				alert(data);
			}
		}
	});
}

function edit(){
	$(".field").attr("readonly",false);
	$(".submit").show();
	$(".edit").hide();
	$("fieldset").attr("disabled", false);
}

</script>
</body>
</html>