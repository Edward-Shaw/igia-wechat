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
							          <option value="painting_stage_one">涂鸦(3-4岁)</option>
							          <option value="painting_stage_two">儿童画1级(4-5岁)</option>
							          <option value="painting_stage_three">小画家1级(5-6岁)</option>
							          <option value="painting_stage_four">小画家2级(6-7岁)</option>
							          <option value="painting_stage_five">小画家3级(7岁以上)</option>
							          <option value="painting_stage_six">动漫(7岁以上)</option>
							          <option value="painting_stage_seven">素描(9岁以上)</option>
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
								          <option value="classic_basic">基础(大于等于3.5岁)</option>
								          <option value="classic_progress">提高(6岁以上或有基础)</option>
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
							      <a href="#" class="item-link smart-select" data-back-text="返回" data-open-in="popup">
								        <select name="latin">
								          <option value="default" selected>请选择一项具体活动并返回提交预约</option>
								          <option value="five">大于等于5岁</option>
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
							      <a href="#" class="item-link smart-select" data-back-text="返回" data-open-in="popup">
								        <select name="taekwondo">
								          <option value="default" selected>请选择一项具体活动并返回提交预约</option>
								          <option value="basic">基础(4-6岁)</option>
								          <option value="progress">提高(7-12岁或有基础)</option>
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
								          <option value="children">儿童瑜伽(3岁以上，父母不参加)</option>
								          <option value="family">亲子瑜伽(3岁以上，父母一起参加)</option>
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
								        <select name="summer_camp">
								          <option value="default" selected>请选择一项具体活动并返回提交预约</option>
								          <option value="before_school">学龄前(3-5岁)</option>
								          <option value="school">学龄(6岁以上)</option>
								        </select>
								        <div class="item-content">
								          <div class="item-inner">
								            <div class="item-title">夏令营</div>
								            <div class="item-after">点此选择具体活动</div>
								          </div>
								        </div>
							      	</a>
							      </li>
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
			wx.closeWindow();
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
					time_selected = true;
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
