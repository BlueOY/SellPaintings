<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style type="text/css">
	body{
		background: #47B0F0;
	}
	#bg{
		margin: 75px 175px;
		min-width: 600px;
	}
	#frmLeftBg{
		width:150px;
		float: left;
		display: inline-block;
	}
	#frmRightBg{
		width: calc(100% - 150px);
		min-width: 450px;
		float: left;
		display: inline-block;
	}
</style>
</head>
<body>
<div id="bg">
	<div id="frmLeftBg">
		<iframe id="frmLeft" name="frmLeft" src="frmLeft.jsp" border="0" width=100% height='720px' frameborder="no" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="no"></iframe>
	</div>
	<div id="frmRightBg">
		<!-- <iframe id="frmRight" name="frmRight" src="frmRight.jsp" width=100% height='720px'  border="0" frameborder="no" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="no" ></iframe> -->
		<iframe id="frmRight" name="frmRight" src="painting/paintingList.jsp" width=100% height='720px'  border="0" frameborder="no" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="no" ></iframe>
	</div>
</div>

<script type="text/javascript" src="<%=basePath%>script/jquery-1.11.2.js"></script>
<script type="text/javascript">
$(function(){
	//alert("jquery");
	
});
</script>
</body>
</html>