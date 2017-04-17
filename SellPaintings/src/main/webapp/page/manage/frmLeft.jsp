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
<link rel="stylesheet" type="text/css" href="../../lib/bootstrap/bootstrap_diy.css">
<jsp:include page='../../lib/swiper.jsp'></jsp:include>
<style type="text/css">
body,html{
	background-color: #3d4549;
	color: #e2edff;
	height: 100%;
}
ul{
	list-style:none;
	padding: 0;
	margin: 0;
}
.list-group a{
	background-color:#3d4549;
	color: #e2edff;
	border: none;
	width: 100%;
}
a.list-group-item:hover{
	background-color:#1d2125;
	color: #e2edff;
}

/* 设置文字不可选中 */
.list-group{-ms-user-select:none;-moz-user-select:none;-webkit-user-select:none;-khtml-user-select:none;-o-user-select:none;user-select:none;}
/* 设置光标默认 */
a{cursor:default;}
</style>
</head>
<body>
<div>
<div class="list-group">
<div style="height: 75px;"></div>
<ul>
	<li my_href="/manage/painting/paintingList.jsp">
		<a class="name list-group-item active" >
			画 作 管 理
		</a>
	</li>
	<li my_href="/manage/order/orderList.jsp">
		<a class="name list-group-item" >
			订 单 管 理
		</a>
	</li>
	<li my_href="/manage/user/userList.jsp">
		<a class="name list-group-item" >
			用 户 管 理
		</a>
	</li>
</ul>
</div>
</div>
<script type="text/javascript" src="<%=path%>/script/jquery-1.11.2.js"></script>
<script type="text/javascript">
$(function(){
	//alert("jquery");
	
	$(".list-group li").on("click", function(){
		$(".list-group a").removeClass("active");
		$(this).find("a").addClass("active");
		var url = $(this).attr("my_href");
		if(url==undefined){
			url = "/manage/frmRight.jsp";
		}
		forward(url);
	});
});
function forward(url){
	parent.frames["frmRight"].location.href='<%=basePath%>page'+url;
}
</script>
</body>
</html>