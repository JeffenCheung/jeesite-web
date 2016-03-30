<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page
	import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>${fns:getConfig('productName')}登录</title>
<meta name="decorator" content="blank" />

<style>
body, h1, h2, h3, h4, h5, h6, hr, p, ul, ol, li, dl, dt, dd, table, td,
	th, caption, form, button, input, select, textarea, fieldset, legend,
	blockquote, iframe, address {
	margin: 0;
	padding: 0;
	outline: none;
}

html {
	_background: url(about:blank);
}

html {
	height: 100%
}

body {
	font-size: 12px;
	font-family: "微软雅黑";
	/*min-width: 320px;*/
	margin: 0 auto;
	position: relative;
	min-width: 1100px;
	height: 100%
}

img, fieldset {
	border: 0;
}

iframe {
	display: block;
}

ol, ul, li {
	list-style: none;
}

em, i, dfn, cite, address {
	font-style: normal;
}

hr {
	height: 0;
	overflow: hidden;
	border: 0;
}

h1, h2, h3, h4, h5, h6, font {
	font-size: 100%;
}

q:after, q:before {
	content: '';
}

table {
	border-collapse: collapse;
	border-spacing: 0;
}

input[type=radio], input[type=checkbox] {
	vertical-align: middle;
}

select {
	height: 23px;
	line-height: 23px;
	padding: 3px;
	vertical-align: middle;
}

a {
	text-decoration: none;
}

a, button {
	cursor: pointer;
}

input, button, textarea, select {
	font-family: inherit;
	font-size: 100%;
}

textarea {
	resize: none;
}

legend {
	*margin: 0 -7px;
}

.header {
	height: 80px;
	line-height: 80px;
	margin: 0 auto;
	background: #fff
}

.w_p170 {
	width: 170px
}

.logo {
	float: left;
	width: 217px;
	margin-left: 162px
}

.logo img {
	width: 90%;
	vertical-align: middle;
}

.wrap {
	font-family: "微软雅黑";
	width: 100%;
	min-width: 1000px;
	overflow: hidden;
}

.p_r {
	position: relative;
}

.p_a {
	position: absolute;
}

.ta_right {
	text-align: right;
}

.ta_left {
	text-align: left;
}

.ta_center {
	text-align: center;
}

.f_l {
	float: :left;
}

.f_r {
	float: right
}

.pt_10 {
	padding-top: 10px
}

.va_m {
	vertical-align: middle;
}



.sy_bg_left{
		float: left;
		margin-top: 65px;
		 width:690px;
}

.sy_bgImg {
	background: url(../static/bootstrap/2.3.1/css_sdbi/sh_logo.jpg) no-repeat;
	background-size: cover;
	width: 100%;
	height: 420px;
	position: relative;
	-ms-behavior: url(../static/common/backgroundsize.min.htc);
	behavior: url(../static/common/backgroundsize.min.htc);
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
    src='../static/bootstrap/2.3.1/css_sdbi/sh_logo.jpg', sizingMethod='scale');
}

.sy_bgImg1 {

	background: url(../static/bootstrap/2.3.1/css_sdbi/qd_bg.jpg) repeat-x;
	float:left;
	position: relative;
	-ms-behavior: url(../static/backgroundsize.min.htc);
	behavior: url(../static/backgroundsize.min.htc);
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(
	
    src='../static/bootstrap/2.3.1/css_sdbi/qd_bg_left.png', sizingMethod='scale');
	
	width: 100%;
	height:499px;
}


.sy_font {
	width: 250px;
	height: 250px;
	float: left;
	margin-top: 130px;
	margin-left: 180px
}

.font img {
	display: inline-block;
	vertical-align: middle;
	padding-right: 1%;
}

.fs_30 {
	font-size: 30px;
}

.fs_12 {
	font-size: 12px
}

.fs_36 {
	font-size: 36px;
}

.fs_44 {
	font-size: 44px;
}

.font {
	width: 490px;
	text-align: center;
	float: right;
	margin-right: 165px;
}
.cover-page-wrap{
	position: absolute;
	left:60%;
	top:7%;
	width: 450px;
	height:auto;
	padding: 20px 0;
	
}
.cover-page {
	width: 27em;
	/*background: #00135d;*/	
	padding: 0 82px 20px;
	padding-bottom: 1%;
}

.cover-bg {
	position: absolute;
	left:60%;
	top:7%;
	width: 450px;
	background: #00135d;
	height: 440px;
	opacity: .4;
	filter: alpha(opacity = 40); /* IE */
	-moz-opacity: 0.4; /* 老版Mozilla */
	-khtml-opacity: 0.4; /* 老版Safari */
	padding-bottom: 0.5%;
}

#subBtn{
	margin-right: 50px;
}
.footer {
	height: 80px;
	text-align: center;
	font-size: 16px;
	line-height: 80px;
}

.c_eb1313 {
	color: #eb1313;
}

.bg_0858c7 {
	background: #0858c7
}

.c_6f {
	color: #ffffff;
}

.c_eb4f17 {
	color: #eb4f17
}

.cover-head {
	padding: 0 30px;
	height: 40px;
	line-height: 40px;
	background: #000a64;
	color: #fff;
	font-size: 18px
}

.cover-text {
	color: #fff;
	font-size: 16px;
	width:100%;
	/*padding-left: 27%;*/
}

.cover-text label {
	display: block;
	margin-top: 1.5em;
	position: relative;
	height: 3em
}

.display_ib {
	display: inline-block
}

.username p {
	margin-bottom: 5px
}

.username span {
	width: 42px;
	height: 2em;
	background: url(../static/bootstrap/2.3.1/css_sdbi/icon-user.png) no-repeat;
	display: inline-block;
	position: absolute;
	background-position: 50% 0%;
	padding: 0em 1em .5em 1em; 
	border-right: 1px solid #4ea0bb;
	top:10px
}

.username>div {
	position: absolute;
	background: #000000;
	opacity: .21;
	filter: alpha(opacity = 21); /* IE */
	-moz-opacity: 0.21; /* 老版Mozilla */
	-khtml-opacity: 0.21; /* 老版Safari */
	width: 100%;
	height: 50px
}

.password>div {
	position: absolute;
	background: #000000;
	opacity: .21;
	filter: alpha(opacity = 21); /* IE */
	-moz-opacity: 0.21; /* 老版Mozilla */
	-khtml-opacity: 0.21; /* 老版Safari */
	width: 100%;
	height: 50px
}

.password span {
	width: 42px;
	height: 2em;
	background: url(../static/bootstrap/2.3.1/css_sdbi/icon-psd.png) no-repeat;
	display: inline-block;
	position: absolute;
	background-position: 50% 0%;
	/* padding-left: 10px; */
	padding: 0em 1em .5em 1em; 
	border-right: 1px solid #4ea0bb;
	top:10px
}

.check>p {
	display: inline-block;
	width: 60px;
}

.check #check {
	width: 155px
}

.check>img {
	float: right;
}

.cover-text label input {
	width: 280px;
	height: 4em;
	line-height: 3em;
	vertical-align: middle;
	border: 0;
	padding-left: 90px;
	background: #606e8c;
	color: #fff
}

#messageBox{
	width:265px;/*
	margin-left:20%;*/
}
.cover-text em {
	position: absolute;
	left: 90;
	top: 17px
}

.cover-dl {
	margin: 0 auto;
    padding: 1em 2.5em;
    text-align: center;
    display: inline-block;
    margin-top: .3em;
    position: relative;
    background: #2e4498;
    color: #fff;
    border: 0;
 
   
    overflow: visible;
         
    *width: 1;
    
}
.rememberInput input{
padding:0;
margin:0;
overflow:visible;
width:auto;
*width:13px;
}
/* input[type="file"], input[type="image"], input[type="submit"], input[type="reset"], input[type="button"], input[type="radio"], input[type="checkbox"] {
    width: 0;
} */
.cover-cz {
	margin: 0 auto;
	padding: 1em 2.5em;
	text-align: center;
	display: inline-block;
	margin-top: .3em;
	position: relative;
	background: #2e4498;
	color: #fff;
	border:0;
	overflow: visible;
    *width: 1;
}

.cover-dl:hover,.cover-cz:hover {
	background: #91c3e7;
}
.form-signin{width:27em}
.cover-dl img {
	position: absolute;
	right: 20px
}

.forget {
	margin-top: 10px
}

.clearfix:before, .clearfix:after {
	display: table;
	content: " "
}

.mt_10 {
	margin-top: 15px;
}

.mt_20 {
	margin-top: 15px
}

.w_p730 {
	width: 730px
}

.ta_right {
	text-align: right;
}

.sorryServer {
	background: #000
}

.sorry {
	margin: 0 auto;
	margin-top: 20px;
	border: 1px solid #e00070;
	padding: 5px;
	background: #ffe5f2;
	width: 307px;
	margin-right: 0;
	text-align: left;
}

input::-webkit-input-placeholder {
	　　color: #fff !important;
}

.rememberInput .input {
	display: inline-block;
}

.clearlabel {
	display: inline;
}
</style>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						// default focused dom
						$("#username").select();
						$("#loginForm")
								.validate(
										{
											rules : {
												validateCode : {
													remote : "${pageContext.request.contextPath}/servlet/validateCodeServlet"
												}
											},
											messages : {
												username : {
													required : "请填写用户名."
												},
												password : {
													required : "请填写密码."
												},
												validateCode : {
													remote : "验证码不正确.",
													required : "请填写验证码."
												}
											},
											errorLabelContainer : "#messageBox",
											errorPlacement : function(error,
													element) {
												error.appendTo($("#loginError")
														.parent());
											}
										});


										var  div =document.getElementById("sy_bgImg_div")
										var  div1 =document.getElementById("qd_bg_left")
										var  img = document.getElementById("img")
										var pname = '${fns:getConfig('productName')}';
										
										if(pname=="分销渠道管理系统"){
											name="渠道系统";
											div.setAttribute("class", "sy_bgImg1 clearfix");
											div1.setAttribute("class", "sy_bg_left");
											img.setAttribute("src","../static/bootstrap/2.3.1/css_sdbi/qd_bg_left.png");
											

										
										}else{ 
											name="常旅客系统";
											div.setAttribute("class", "sy_bgImg clearfix");
										
										}
										document.getElementById("productName") .innerHTML =name;
									

					});
	// 如果在框架或在对话框中，则弹出提示并跳转到首页
	if (self.frameElement && self.frameElement.tagName == "IFRAME"
			|| $('#left').length > 0 || $('.jbox').length > 0) {
		alert('未登录或登录超时。请重新登录，谢谢！');
		top.location = "${ctx}";
	}
</script>
</head>
<body>
	<!--[if lte IE 6]><br/><div class='alert alert-block' style="text-align:left;padding-bottom:10px;"><a class="close" data-dismiss="alert">x</a><h4>温馨提示：</h4><p>你使用的浏览器版本过低。为了获得更好的浏览体验，我们强烈建议您 <a href="http://browsehappy.com" target="_blank">升级</a> 到最新版本的IE浏览器，或者使用较新版本的 Chrome、Firefox、Safari 等。</p></div><![endif]-->
	<div class="header clearfix">
		<div class="logo  ta_center"> 
			<img src="../static/bootstrap/2.3.1/css_sdbi/logo.png">
		</div>
		
		<div class="font fs_44 c_eb4f17"  id="productName"></div>
	</div>
<div id="sy_bgImg_div">
	<div id="qd_bg_left">
<!--	<img src="../static/bootstrap/2.3.1/css_sdbi/qd_bg_left.png "> -->
	<img id="img">
	</div>
		<div class="cover-bg"></div>
		<div class="cover-page-wrap">
			<div class="cover-page">
			<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}">
				<button data-dismiss="alert" class="close">×</button>
				<label id="loginError" class="error">${message}</label>
			</div>
			<form id="loginForm" class="form-signin" action="${ctx}/login"
				method="post">
				<div class="cover-text">
					<div class="fs_30 mb_40">
						用户登录<span class="fs_12">LOGIN</span>
					</div>
					<label class="username" for="username"> <span> </span> <input
						id="username" name="username" type="text"
						class="input-block-level required"
						onclick="this.value==''?'':this.value" placeholder="请输入账号" />
					</label> <label class="password" for="password"> <span> </span> <input
						id="password" name="password" type="password"
						class="input-block-level required"
						onclick="this.value==''?'':this.value" placeholder="请输入密码" />
					</label>
					<c:if test="${isValidateCodeLogin}">
						<div class="validateCode">
							<label class="input-label mid" for="validateCode">验证码</label>
							<sys:validateCode name="validateCode"
								inputCssStyle="margin-bottom:0;" />
						</div>
					</c:if>
					<input id="mobileLogin" name="mobileLogin" type="hidden" value="false">
					<div class="rememberInput mt_10">

						<input type="checkbox" id="rememberMe" name="rememberMe"
							${rememberMe ? 'checked' : ''} /> <span for="rememberMe"><sys:mutiLang
								langKey="common.rememberme" /></span>
					</div>
					<div class="clearfix mt_20">
						<input type="submit" class="cover-dl f_l c_60" id="subBtn"
							value="登    陆"> <input type="reset"
							class="cover-cz f_l c_60" id="czBtn" value="重    置">
					</div>
				</div>
			</form>
		</div>
		</div>
		
	</div>
	<div class="footer">
		Copyright &copy;
		${fns:getConfig('copyrightYearSince')}-${fns:getConfig('copyrightYear')}
		<a href="${fns:getConfig('orgPortal')}" target="_blank">${fns:getConfig('organization')}</a>
		- Powered By <a href="${fns:getConfig('poweredByPortal')}"
			target="_blank">${fns:getConfig('poweredBy')} </a>
		${fns:getConfig('version')}
	</div>

	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	<script>
		$(function() {
			resi()
		})
		function resi() {
			var bgHeight = $(window).height() - $(".header").height()
					- $(".footer").height();
			var bgHeit = bgHeight * .8;
			var bgTop = bgHeight * .1
			$(".sy_bgImg").css({
				height : bgHeight
			})
			if ($(".sy_bgImg").height() < 450) {
				$(".sy_bgImg").css({
					height : "45em"
				})
			} else {
			}
		}
		$(window).resize(function() {
			resi()
		})
	</script>
</body>
</html>