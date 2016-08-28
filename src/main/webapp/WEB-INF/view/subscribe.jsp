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
<title>活动预约</title>
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
				<div class="navbar" style="text-align:center">
					  <div class="navbar-inner" style="text-align:center">
					    <div class="center" style="text-align:center">活动预约(含体验预约)</div>
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
						<div class="list-block">
						  <ul>
						    <li>
						      <a href="#" class="item-link smart-select">
						        <select name="fruits">
						          <option value="apple" selected>涂鸦(3-4岁)</option>
						          <option value="pineapple">儿童画1级(4-5岁)</option>
						          <option value="apple" selected>小画家1级(5-6岁)</option>
						          <option value="pineapple">小画家2级(6-7岁)</option>
						          <option value="apple" selected>小画家3级(7岁以上)</option>
						          <option value="pineapple">动漫(7岁以上)</option>
						          <option value="apple" selected>素描(9岁以上)</option>
						        </select>
						        <div class="item-content">
						          <div class="item-inner">
						            <div class="item-title">绘画</div>
						            <div class="item-after">点此选择具体活动</div>
						          </div>
						        </div>
						      </a>
						    </li>
						    <li>
						      <a href="#" class="item-link smart-select">
							        <select name="fruits">
							          <option value="apple" selected>基础(大于等于3.5岁)</option>
							          <option value="pineapple">提高(6岁以上或有基础)</option>
							        </select>
							        <div class="item-content">
							          <div class="item-inner">
							            <div class="item-title">中国舞</div>
							            <div class="item-after">点此选择具体活动</div>
							          </div>
							        </div>
						      	</a>
						      </li>
						     <li>
						      <a href="#" class="item-link smart-select">
							        <select name="fruits">
							          <option value="apple" selected>大于等于5岁</option>
							        </select>
							        <div class="item-content">
							          <div class="item-inner">
							            <div class="item-title">拉丁舞</div>
							            <div class="item-after">点此选择具体活动</div>
							          </div>
							        </div>
						      	</a>
						      </li>
						     <li>
						      <a href="#" class="item-link smart-select">
							        <select name="fruits">
							          <option value="apple" selected>基础(4-6岁)</option>
							          <option value="pineapple">提高(7-12岁或有基础)</option>
							        </select>
							        <div class="item-content">
							          <div class="item-inner">
							            <div class="item-title">跆拳道</div>
							            <div class="item-after">点此选择具体活动</div>
							          </div>
							        </div>
						      	</a>
						      </li>
						     <li>
						      <a href="#" class="item-link smart-select">
							        <select name="fruits">
							          <option value="apple" selected>儿童瑜伽(3岁以上，父母不参加)</option>
							          <option value="pineapple">亲子瑜伽(3岁以上，父母一起参加)</option>
							        </select>
							        <div class="item-content">
							          <div class="item-inner">
							            <div class="item-title">瑜伽</div>
							            <div class="item-after">点此选择具体活动</div>
							          </div>
							        </div>
						      	</a>
						      </li>
						     <li>
						      <a href="#" class="item-link smart-select">
							        <select name="fruits">
							          <option value="apple" selected>学龄前(3-5岁)</option>
							          <option value="pineapple">学龄(6岁以上)</option>
							        </select>
							        <div class="item-content">
							          <div class="item-inner">
							            <div class="item-title">夏令营</div>
							            <div class="item-after">点此选择具体活动</div>
							          </div>
							        </div>
						      	</a>
						      </li>
						  </ul>
						  <div class="list-block-label">预约说明：一次只能预约一个活动。</div>
						</div>
						<p style="margin-left: 5%">
							<a href="#" class="button form-to-json button-big active" style="width: 95%">提交预约</a>
						</p>
					</div>
				</div>
			</div>
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
