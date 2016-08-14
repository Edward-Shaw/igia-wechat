<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <head>
    <!-- Required meta tags-->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>系统异常</title>
<link rel="stylesheet" href="<c:url value="/css/framework7.ios.min.css"/>" />
<!-- Path to Framework7 color related styles, iOS Theme -->
<link rel="stylesheet" href="<c:url value="/css/framework7.ios.colors.min.css"/>" />
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<!-- Path to Framework7 Library JS-->
<script type="text/javascript" src="<c:url value="/js/framework7.min.js"/>" /></script>
<!-- Path to your app js-->
<script type="text/javascript" src="<c:url value="/js/my-app.js"/>" /></script>
    <script>
	var myApp = new Framework7();
	var $$ = Framework7.$;
	var mainView = myApp.addView('.view-main');
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
  <body>
    <div class="views">
     <div class="view view-main">
      <div class="pages">
       <div data-page="teacher" class="page">
       <div class="page-content" style="padding-top:20px;">
         <div class="card" style="margin-top:40%;padding:20px 10px;">
           <div class="card-content">
            <div class="card-content-inner">
              <p style="text-indent: 2em; font-size: 20px;">很奇怪,系统出错了.... </p>
            </div>
         </div>
       </div>
      </div>
    </div>  
    </div>
    </div>
    </div>
  <script>
	  setTimeout(function(){
	  	wx.closeWindow();
	  }, 2000);
  </script>
  </body>
</html> 