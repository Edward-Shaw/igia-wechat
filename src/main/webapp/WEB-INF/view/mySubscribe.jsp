<!DOCTYPE HTML>
<html xmlns:th="http://www.thymeleaf.org">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
<!-- Required meta tags-->
<c:set var="cp" scope="session"
	value="${pageContext.request.contextPath }" />
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<!-- Your app title -->
<title>我预约的活动</title>
<!-- Path to Framework7 Library CSS, iOS Theme -->
<link rel="stylesheet" href="<c:url value="/css/framework7.ios.min.css"/>" />
<!-- Path to Framework7 color related styles, iOS Theme -->
<link rel="stylesheet" href="<c:url value="/css/framework7.ios.colors.min.css"/>" />
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<!-- Path to Framework7 Library JS-->
<script type="text/javascript" src="<c:url value="/js/framework7.min.js"/>" /></script>
<!-- Path to your app js-->
<script type="text/javascript" src="<c:url value="/js/my-app.js"/>" /></script>
<!-- Path to your custom app styles-->
<!--<link rel="stylesheet" href="css/my-app.css">-->
<script>
	var myApp = new Framework7();
	var $$ = Framework7.$;
	
	var load = function(){
		$$.ajax({
		  	  url: "http://igia.tunnel.qydev.com/igia/jsapisign",
		  	  method: 'POST',
		  	  data: JSON.stringify({url: location.href}),
		  	  processData: false,
		  	  contentType: "application/json",
		  	  beforeSend: function(xhr) {
			       xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
			  },
		  	  dataType: 'json',
		  	  success: function (signature, status, xhr){
		        wx.config({
	                debug: false,
	                appId: signature.appid,
	                timestamp: signature.timestamp,
	                nonceStr: signature.noncestr,
	                signature: signature.signature,
	                jsApiList: ['closeWindow', 'hideOptionMenu']
	            });
		  	  },
		  	  complete: function(xhr, status){
		  		;
		  	  },
		  	  error: function(xhr, status){},
		});
	}
</script>
</head>
<body onload="load()">
	<div class="views">
		<div class="view view-main">
			<div class="pages">
				<div class="navbar" style="text-align:center">
					<div class="navbar-inner" style="text-align:center">
					  <div class="center" style="text-align:center">我的活动预约(含体验预约)</div>
					</div>
				</div>
				
				<div data-page="teacher" class="page">
					<div class="navbar">
		              <div class="navbar-inner">
		                <div class="left"></div>
		                <div class="center" style="left: 0px;">List View</div>
		                <div class="right"></div>
		              </div>
		            </div>
					<div class="page-content" style="padding-top: 20px;">
						<div class="content-block-title"></div>
						<div class="list-block" style="margin-left: 20px; margin-top: 40px">
						  <p>客户名：${subscribe.user.username}</p>
						  <p>联系方式：${subscribe.user.mobile}</p>
						  <p>联系地址：${subscribe.user.address}</p>
						  <p>预约提交时间：${subscribe_time}</p>
						  <p>预约活动：</p>
						  <c:forEach var="course" items="${subscribe_courses}">	
						  	  <center><p style="font-size:16px;font-color:CCCCCC">${course.classification}：${course.name}</p></center>
						  </c:forEach>
						  <div class="list-block-label" style="margin-left:-20px;">您的活动已预约成功，我们将尽快和您联系。</div>
						</div>
						<p style="margin-left: 5%">
							<a href="#" id="exit" class="button form-to-json button-big active" style="width: 95%">退出</a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		var mainView = myApp.addView('.view-main');
		$$('#exit').on('click', function(){
			wx.closeWindow();
		});
	</script>
</body>
</html>
