<!DOCTYPE HTML>
<html xmlns:th="http://www.thymeleaf.org">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>会员信息</title>
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
		  	  url: "http://jiajiao.tunnel.qydev.com/service-wx/jsapisign",
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
				<div data-page="teacher" class="page">
					<div class="page-content" style="padding-top: 20px;">
						<div class="content-block-title">我的会员信息</div>
						<form id="info-form" class="list-block store-data">
							<ul>
								<!-- Text inputs -->
								<li>
									<div class="item-content">
										<div class="item-inner">
											<div class="item-title label">
												姓名：
											</div>
											<div class="item-input">
												<span style="color: red">${user.name}</span>
											</div>
										</div>
									</div>
								</li>
								<li>
									<div class="item-content">
										<div class="item-inner">
											<div class="item-title label">
												手机号：
											</div>
											<div class="item-input">
												<span style="color: red">${user.mobile}</span>
											</div>
										</div>
									</div>
								</li>
								<li>
									<div class="item-content">
										<div class="item-inner">
											<div class="item-title label">
												邮箱地址：
											</div>
											<div class="item-input">
												<span style="color: red">${user.email}</span>
											</div>
										</div>
									</div>
								</li>
								<li>
									<div class="item-content">
										<div class="item-inner">
											<div class="item-title label">
												地址：
											</div>
											<div class="item-input">
												<span style="color: red">${user.address}</span>
											</div>
										</div>
									</div>
								</li>
								<li>
									<div class="item-content">
										<div class="item-inner">
											<div class="item-title label">
												积分：
											</div>
											<div class="item-input">
												<span style="color: red">还没有积分</span>
											</div>
										</div>
									</div>
								</li>
							</ul>
						</form>
						<div class="content-block-title">我的活动预约</div>
						<form id="info-form" class="list-block store-data">
							<ul>
								<!-- Text inputs -->
								<li>
									<div class="item-content">
										<div class="item-inner">
											<div class="item-title label">
												已预约：
											</div>
											<div class="item-input">
												<span style="color: red">${details}</span>
											</div>
										</div>
									</div>
								</li>
								<li>
									<div class="item-content">
										<div class="item-inner">
											<div class="item-title label">
												预约状态：
											</div>
											<div class="item-input">
												<span style="color: red">${subscribe.state}</span>
											</div>
										</div>
									</div>
								</li>
								<li>
									<div class="item-content">
										<div class="item-inner">
											<div class="item-title label">
												预约时间：
											</div>
											<div class="item-input">
												<span style="color: red">${subscribe.createTime}</span>
											</div>
										</div>
									</div>
								</li>
							</ul>
						</form>

						<p style="margin-left: 5%">
							<a href="#" class="button form-to-json button-big active" style="width: 95%">确定</a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="popup popup-about tablet-fullscreen infinite-scroll">
		<div
			style="font-size: 12px; margin: 3px; line-height: 18px;">
			<h2 style="text-align: center; margin-bottom: 0px;">华东师范大学家教工作准则</h2>
			<p>
				&nbsp&nbsp&nbsp&nbsp 1、准时、不迟到、不早退，不擅自更改家教约定时间和日期；<br>
				&nbsp&nbsp&nbsp&nbsp 2、注重仪容仪表，不穿奇装异服，不穿暴露服饰；<br>
				&nbsp&nbsp&nbsp&nbsp 3、注意言谈文明，不说粗话脏话；<br>
				&nbsp&nbsp&nbsp&nbsp 4、耐心细致，多鼓励学生，不能体罚或者过度批评学生；<br>
				&nbsp&nbsp&nbsp&nbsp 5、不允许私自向家长索要礼物或者财务；<br>
				&nbsp&nbsp&nbsp&nbsp 6、没得到家长允许，不许碰家长家庭物品或者进入其他房间参观，不许随意带学生外出；<br>
				&nbsp&nbsp&nbsp&nbsp 7、积极沟通，不与家长起冲突，有问题及时向家教部汇报；<br>
				&nbsp&nbsp&nbsp&nbsp 8、家教时，手机处于静音或者关机状态，不许玩手机；<br>
				&nbsp&nbsp&nbsp&nbsp 9、不得因为个人原因（特殊情况请向家教中心出示证明说明情况）在服务期内随意终止家教；<br>
			<p style="text-align: right;">
				华师大家教中心<br>2016年3月14日
			</p>
			<center>
				<button class="button button-fill close-popup">确定</button>
			</center>
			<p />
			<p />
		</div>
	</div>

	<script>
		var mainView = myApp.addView('.view-main');
		$$('.form-to-json').on('click', function(){
			wx.closeWindow();
		});
	</script>
</body>
</html>
