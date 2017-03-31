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
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
    This is my JSP page. <br>
    <a href="<%=path%>/page/shop/index.jsp">shop</a>
    <a href="<%=path%>/page/manage/main.jsp">manage</a>
    
    <br/>
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
