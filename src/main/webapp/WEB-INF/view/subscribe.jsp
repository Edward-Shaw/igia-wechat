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
						<form id="subscribe-form" class="list-block store-data">
							<div class="list-block">
							  <ul>
							    <li>
							      <a href="#" class="item-link smart-select" data-back-text="返回" data-open-in="popup">
							        <select name="painting">
							          <option value="default" selected>请选择一项具体活动并返回提交预约</option>
							          <option value="painting_stage_one">绘画(4-6岁)</option>
							          <option value="painting_stage_two">绘画(7-9岁)</option>
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
							      <a href="#" class="item-link smart-select" data-back-text="返回" data-open-in="popup">
								        <select name="classic">
								          <option value="default" selected>请选择一项具体活动并返回提交预约</option>
								          <option value="classic_stage_one">舞蹈3.5-4.5岁</option>
								          <option value="classic_stage_two">舞蹈4.5-5.5岁</option>
								          <option value="classic_stage_three">舞蹈6-7岁</option>
								        </select>
								        <div class="item-content">
								          <div class="item-inner">
								            <div class="item-title">舞蹈</div>
								            <div class="item-after">点此选择具体活动</div>
								          </div>
								        </div>
							      	</a>
							      </li>
							     <li>
							      <a href="#" class="item-link smart-select" data-back-text="返回" data-open-in="popup">
								        <select name="taekwondo">
								          <option value="default" selected>请选择一项具体活动并返回提交预约</option>
								          <option value="taekwondo_stage_one">跆拳道(4-6岁)</option>
								          <option value="taekwondo_stage_two">跆拳道(7-12岁)</option>
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
							      <a href="#" class="item-link smart-select" data-back-text="返回" data-open-in="popup">
								        <select name="yoga">
								          <option value="default" selected>请选择一项具体活动并返回提交预约</option>
								          <option value="yoga_stage_one">儿童瑜伽(6岁以上未成年孩子，免费提供练习资料)</option>
								          <option value="yoga_stage_two">亲子瑜伽(3-6岁宝宝和妈妈一起，免费提供练习资料)</option>
								          <option value="yoga_stage_three">企事业瑜伽(企事业员工团操训练)</option>
								          <option value="yoga_stage_four">成人瑜伽</option>
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
							      <a href="#" class="item-link smart-select" data-back-text="返回" data-open-in="popup">
								        <select name="tech">
								          <option value="default" selected>请选择一项具体活动并返回提交预约</option>
								          <option value="chinese">汉语拼音3-6岁</option>
								          <option value="english">少儿英语3岁以上</option>
								          <option value="programing">少儿编程6岁以上</option>
								        </select>
								        <div class="item-content">
								          <div class="item-inner">
								            <div class="item-title">语言与科技</div>
								            <div class="item-after">点此选择具体活动</div>
								          </div>
								        </div>
							      	</a>
							      </li>
							     <li>
							      <a href="#" class="item-link smart-select" data-back-text="返回" data-open-in="popup">
								        <select name="camp">
								          <option value="default" selected>请选择一项具体活动并返回提交预约</option>
								          <option value="summer_camp">暑假集训(绘画、舞蹈、跆拳道、语言与科技活动集中训练)</option>
								          <option value="automn_camp">寒假集训(绘画、舞蹈、跆拳道、语言与科技活动集中训练)</option>
								        </select>
								        <div class="item-content">
								          <div class="item-inner">
								            <div class="item-title">寒暑假集训</div>
								            <div class="item-after">点此选择具体活动</div>
								          </div>
								        </div>
							      	</a>
							      </li>
							      <br>
							      <li>
							      <a href="#" class="item-link smart-select" data-back-text="返回" data-open-in="popup">
								        <select name="activity_class">
								          <option value="time_default" selected>请选择一个活动班</option>
								          <option value="one">一班</option>
								          <option value="two">二班</option>
								          <option value="two">三班</option>
								          <option value="two">四班</option>
								        </select>
								        <div class="item-content">
								          <div class="item-inner">
								            <div class="item-title">活动班</div>
								            <div class="item-after">点此选择一个活动班(预约时间)</div>
								          </div>
								        </div>
							      	</a>
							      </li>
							  </ul>
							  <div class="list-block-label">预约说明：一次最多只能预约两个活动；预约成功后我们将通过电话与您联系确认。</div>
							</div>
						</form>
						<p style="margin-left: 5%">
							<a href="#" id="subscribe" class="button form-to-json button-big active" style="width: 95%">提交预约</a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		var mainView = myApp.addView('.view-main');
		$$('.form-to-json').on('click', function(){
			//wx.closeWindow();
		});
		
		var mainView = myApp.addView('.view-main');
		$$('#subscribe').on('click', function(evt) {
			var formData = myApp.formToJSON('#subscribe-form');
			console.log(formData);
			
			var count = 0;
			var time_selected = false;
			for(item in formData){
				if(formData[item] == "default"){
					count++;
				}else if(formData[item] == "time_default"){
					time_selected = false;
				}
			}

			if(count < 4){
				myApp.alert("一次只能最多只能同时预约2个活动", '预约超过上限!');
				return false;
			}else if(count == 6){
				myApp.alert("请进入活动列表页面选择一个具体活动进行预约", '没有预约!');
				return false;
			}
			
			if(!time_selected){
				myApp.alert("请前往通知公告栏的'作息更新'查看活动班信息", "请选择一个活动班");
				return false;
			}
			
			$$.ajax({
				url : "subscribe",
				method : 'POST',
				data : JSON.stringify(formData),
				processData : false,
				contentType : "application/json",
				beforeSend : function(xhr) {
					xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
				},
				dataType : 'json',
				success : function(data, status, xhr) {
					if (data.code != 0) {
						myApp.alert(data.message, '预约失败!', function() {
							wx.closeWindow();
						});
					} else {
						myApp.alert('您已成功预约逸伽体验活动，我们将电话与您联系确认', '预约成功!', function() {
							wx.closeWindow();
						});
					}
				},
				complete : function(xhr, status) {
					;
				},
				error : function(xhr, status) {
				},
			});
		});
	</script>
</body>
</html>
