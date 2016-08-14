<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<!-- Required meta tags-->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<!-- Your app title -->
<title>家长信息</title>
<!-- Path to Framework7 Library CSS, iOS Theme -->
<link rel="stylesheet"
	href="<c:url value="/css/framework7.ios.min.css"/>" />
<!-- Path to Framework7 color related styles, iOS Theme -->
<link rel="stylesheet"
	href="<c:url value="/css/framework7.ios.colors.min.css"/>" />
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<!-- Path to Framework7 Library JS-->
<script type="text/javascript"
	src="<c:url value="/js/framework7.min.js"/>" /></script>
<!-- Path to your app js-->
<script type="text/javascript" src="<c:url value="/js/my-app.js"/>" /></script>
<!-- Path to your custom app styles-->
<!--<link rel="stylesheet" href="css/my-app.css">-->
<script>
	var myApp = new Framework7();
	var $$ = Framework7.$;
	var mainView = myApp.addView('.view-main');
	var load = function() {
		$$.ajax({
			url : "http://jiajiao.tunnel.qydev.com/service-wx/jsapisign",
			method : 'POST',
			data : JSON.stringify({
				url : location.href
			}),
			processData : false,
			contentType : "application/json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader('Content-Type',
						'application/json;charset=utf-8');
			},
			dataType : 'json',
			success : function(signature, status, xhr) {
				wx.config({
					debug : false,
					appId : signature.appid,
					timestamp : signature.timestamp,
					nonceStr : signature.noncestr,
					signature : signature.signature,
					jsApiList : [ 'closeWindow', 'hideOptionMenu' ]
				});
			},
			complete : function(xhr, status) {
				;
			},
			error : function(xhr, status) {
			},
		});
	}
</script>
</head>
<body onload="load()">
	<div class="views">
		<div class="view view-main">
			<div class="pages">
				<div data-page="student" class="page">
					<div class="page-content" style="padding-top: 20px;">
						<div class="content-block-title">请完善个人信息</div>
						<form id="info-form" class="list-block store-data">
							<ul>
								<!-- Text inputs -->
								<li>
									<div class="item-content">
										<div class="item-inner">
											<div class="item-title label">
												姓名<span style="color: red">*</span>
											</div>
											<div class="item-input">
												<input type="text" name="name" placeholder="姓名">
											</div>
										</div>
									</div>
								</li>
								<li>
									<div class="item-content">
										<div class="item-inner">
											<div class="item-title label">
												固定电话<span style="color: red">*</span>
											</div>
											<div class="item-input">
												<input type="tel" name="fixedPhone" placeholder="请填写固定电话">
											</div>
										</div>
									</div>
								</li>
								<li>
									<div class="item-content">
										<div class="item-inner">
											<div class="item-title label">
												手机号<span style="color: red">*</span>
											</div>
											<div class="item-input">
												<input type="tel" name="mobilePhone" placeholder="请填写手机号">
											</div>
										</div>
									</div>
								</li>
								<li style="text-align: right;">
									<label class="label-checkbox item-content" > 
									<input type="checkbox" name="ks-checkbox" id="agreement" value="accept" checked>
											<div class="item-media">
												<i class="icon icon-form-checkbox"></i>
											</div>
											<div class="item-inner">
												<div class="item-title">
													我已阅读并同意<a href="#" data-popup=".popup-about"
														class="open-popup">家教条例</a>
												</div>
											</div>
									</label>
								</li>
							</ul>
						</form>

						<p style="margin-left: 5%">
							<a href="#" id="test"
								class="button form-to-json button-big active" style="width: 95%">提交</a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="popup popup-about tablet-fullscreen infinite-scroll">
		<div
			style="font-size: 12px; margin: 3px; text-indent: 2em; line-height: 16px;">
			<h2 style="text-align: center; margin-bottom: 0px;">家长须知</h2>
			尊敬的家长:
			<p>
				您好！欢迎您选择全国最优秀的大学生家教服务平台 华师大家教中心，华师大家教中心是华东师范大学唯一的官方家教平台，现将注意事项列举如下：<br>
				&nbsp&nbsp&nbsp&nbsp 1、
				为了教员安全，请您认真填写座机号码（可为家里、办公室座机，限上海市），我们工作人员将通过座机核实您的身份，只有身份核实成功，才可以申请家教，谢谢您的谅解与配合；<br>
				&nbsp&nbsp&nbsp&nbsp 2、
				为了提供更好的服务，我们聘请了专业的管理与服务团队。为此，当我们为您聘请到教员时，教员第一次上门家教，若您满意，我们需要向您收取100元的服务费，有效期为一年，在一年内，我们可以免费为您更换教员；<br>
				&nbsp&nbsp&nbsp&nbsp 3、 如果为您聘请的教员为您的孩子家教三次及以上，此份家教成功；<br>
				&nbsp&nbsp&nbsp&nbsp 4、
				华师大家教中心提供的家教服务为一对一服务，若为一对二，我们将收取200元的服务费，并且按高年级（高级别）课时计算增加50%；<br>
				&nbsp&nbsp&nbsp&nbsp 5、 为了教员安全，家教结束时间不能迟于20:30；<br>
				&nbsp&nbsp&nbsp&nbsp 6、 家长和学生均不能对教员由任何不尊重行为，华师大家教中心有权对其追究其法律责任；<br>
				&nbsp&nbsp&nbsp&nbsp 7、
				家教价格依华师大家教中心平台为准，家长有权加价，若发现教员私自加价行为，可向华师大家教中心投诉；<br>
				&nbsp&nbsp&nbsp&nbsp 8、
				因教员个人问题在有效期内终止家教（一年，分四个阶段：上下两学期，寒暑假），家长可向华师大家教中心投诉该教员，并申请免费更换教员；<br>
				&nbsp&nbsp&nbsp&nbsp 本条款最终解释权归华东师大家教中心所有，衷心感谢您的合作，因为有您，我们将做得更好，谢谢您！<br>
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
		function checkMobile(str) {
			var re = /^1\d{10}$/;
			if (re.test(str)) {
				return true;
			} else {
				return false;
			}
		}

		function checkPhone(str) {
			var re = /^0\d{2,3}-?\d{7,8}$/;
			if (re.test(str)) {
				return true;
			} else {
				return false;
			}
		}

		var mainView = myApp.addView('.view-main');
		$$('#test').on(
				'click',
				function(evt) {
					var formData = myApp.formToJSON('#info-form');
					if (!$$('#agreement')[0].checked) {
						myApp.alert("请仔细阅读华师大家教条例", '必须同意家教条例!');
						return true;
					}

					if (formData["name"] == '') {
						myApp.alert("请输入您的姓名", '姓名不能为空!');
						return true;
					}

					if (formData["fixedPhone"] == '') {
						myApp.alert("请输入您的固定电话", '固定电话必填!');
						return true;
					}

					if (!checkMobile(formData["mobilePhone"])) {
						myApp.alert("手机号码位数错误,请重新输入11位手机号!", '手机号码位数错误!');
						return true;
					}

					if (!checkPhone(formData["fixedPhone"])) {
						myApp.alert("固定电话输入格式为:区号-固定电话", '号码格式错误!');
						return true;
					}

					$$.ajax({
						url : "parent/input",
						method : 'POST',
						data : JSON.stringify(formData),
						processData : false,
						contentType : "application/json",
						beforeSend : function(xhr) {
							xhr.setRequestHeader('Content-Type',
									'application/json;charset=utf-8');
						},
						dataType : 'json',
						success : function(data, status, xhr) {
							if (data.code != 0) {
								myApp.alert(data.message, '无法录入!', function() {
									wx.closeWindow();
								});
							} else {
								myApp.alert(data.message, '登记成功!', function() {
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
