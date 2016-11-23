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
				
				<div data-page="subscribe" class="page">
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
							  <ul id="subscribe-ul">
							      <li>
							      <a href="#" class="item-link smart-select" data-back-text="返回" data-open-in="popup">
								        <select name="activity_class">
								          <option value="time_default" selected>请选择一个活动时间</option>
								          <option value="monday">周一</option>
								          <option value="tuesday">周二</option>
								          <option value="wednesday">周三</option>
								          <option value="thursday">周四</option>
								          <option value="friday">周五</option>
								          <option value="saturday">周六</option>
								          <option value="sunday">周日</option>
								        </select>
								        <div class="item-content">
								          <div class="item-inner">
								            <div class="item-title">活动时间</div>
								            <div class="item-after">点此选择活动时间</div>
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
		
		var load = function(){
			$$.ajax({
				url: "http://localhost/api/course",
				method: "GET",
		  	  	contentType: "application/json",
		  	  	beforeSend: function(xhr) {
			       xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
			  	},
		  	  	dataType: 'json',
				success: function(data, status, xhr){
					if(data.code === 0){
						var li_smart_select_start = "<li><a class='item-link smart-select' data-back-text='返回' data-open-in='popup'>";
						var li_smart_select_end = "<div class='item-after'>点此选择具体活动</div></div></div></a></li>";
						for(classification in data.result){
							var smart_select_start = "<select name='" + classification + "'" + "><option value='default' selected>请选择一项具体活动并返回提交预约</option>";
							var li_smart_select_all = li_smart_select_start + smart_select_start;
							var smart_select_end = "</select><div class='item-content'><div class='item-inner'><div class='item-title'>" + classification + "</div>";
							for(count_i in data.result[classification]){
								var smart_select_option = "<option value='" + data.result[classification][count_i].code + "'>" + data.result[classification][count_i].name + "</option>";
								li_smart_select_all += smart_select_option;
							}
							li_smart_select_all = li_smart_select_all + smart_select_end + li_smart_select_end;
							$$("#subscribe-ul").append(li_smart_select_all);
						}
					}
				},
			});
		}
		
		var mainView = myApp.addView('.view-main');
		$$('#subscribe').on('click', function(evt) {
			var formData = myApp.formToJSON('#subscribe-form');
			console.log(formData);
			
			var count = 0;
			var time_selected = true;
			for(item in formData){
				if(formData[item] == "default"){
					count++;
				}else if(formData[item] == "time_default"){
					time_selected = false;
				}
			}
			/*
			if(count < 4){
				myApp.alert("一次只能最多只能同时预约2个活动", '预约超过上限!');
				return false;
			}else if(count == 6){
				myApp.alert("请进入活动列表页面选择一个具体活动进行预约", '没有预约!');
				return false;
			}
			*/
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
