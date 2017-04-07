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
</head>
<body>
    <img id="image" src="<%=StaticClass.IMAGE_BASE_URL%>images/index_p2.png" style="width: 400px;height: 210px;">
    <form id="upload_img" action="<%=path%>/file/upload" method="post" enctype="multipart/form-data" target="hidden_iframe">
	<div class="form-group submit init-hide">
		<input type="file" id="imageFile" name="imageFile">
		<iframe name="hidden_iframe" style=""></iframe>
	</div>
	<button id="submitBtn" type="button">提交</button>
	</form>
	
	<script type="text/javascript" src="<%=basePath%>script/jquery-1.11.2.js"></script>
	<script type="text/javascript">
		$(function(){
			//alert("jquery");
			
			$("#submitBtn").on("click", function(){
				var imageFile = $("#imageFile").val();
				if(imageFile!=""){
					$("#upload_img").submit();
				}else{
					alert(imageFile);
				}
			});
			
			//选择图片后预览
			$("#imageFile").change(function(event){
				var size = event.target.files.length;
				for(var i=0;i<size;i++){
					var tmppath = URL.createObjectURL(event.target.files[i]);
					$("#image").attr("src", tmppath);
				}
			});
		});
		
		function callbackUploadImage(fileName){
			alert(fileName);
		}
	</script>
</body>
</html>