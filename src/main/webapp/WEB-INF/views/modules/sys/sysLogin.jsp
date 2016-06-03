<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')} 登录</title>
	<meta name="decorator" content="blank"/>
	<style type="text/css">
		html,body,table{background-color:#f5f5f5;width:100%;height: 100%;text-align:center;}.form-signin-heading{position: relative;font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;font-size:36px;margin-bottom:20px;color:#0663a2;}
		.form-signin{position:relative;text-align:left;width:300px;padding:25px 29px 29px;margin:0 auto 20px;background-color:#fff;border:1px solid #e5e5e5;
			-webkit-border-radius:5px;-moz-border-radius:5px;border-radius:5px;-webkit-box-shadow:0 1px 2px rgba(0,0,0,.05);-moz-box-shadow:0 1px 2px rgba(0,0,0,.05);box-shadow:0 1px 2px rgba(0,0,0,.05);}
		.form-signin .checkbox{margin-bottom:10px;color:#0663a2;} .form-signin .input-label{font-size:16px;line-height:23px;color:#999;}
		.form-signin .input-block-level{font-size:16px;height:auto;margin-bottom:15px;padding:7px;*width:283px;*padding-bottom:0;_padding:7px 7px 9px 7px;}
		.form-signin .btn.btn-large{font-size:16px;} .form-signin #themeSwitch{position:absolute;right:15px;bottom:10px;} .form-signin #langSwitch{position:absolute;right:100px;bottom:10px;}
		.form-signin div.validateCode {padding-bottom:15px;} .mid{vertical-align:middle;}
		.header{height:80px;padding-top:20px;} .alert{position:relative;width:300px;margin:0 auto;*padding-bottom:0px;}
		label.error{background:none;width:270px;font-weight:normal;color:inherit;margin:0;}
		
		/* Set styles for Full Screen Background Slideshow */
		.footer{position: relative};
		body {
		  background: url("your-image.jpg") no-repeat center center fixed;
		  -webkit-background-size: cover;
		  -moz-background-size: cover;
		  -o-background-size: cover;
		  background-size: cover;
		}
		/* Full Screen Background Slideshow
			http://slickmedia.co.uk/blog/glenns-blog/full-screen-responsive-background-image-with-css/
			http://emrmedia.com/
			  */
		.slideshow {
			opacity:0.15;
			filter:alpha(opacity=15); /* 针对 IE8 以及更早的版本 */
		    position: fixed;
		    top: 0px;
		    left: 0px;
		    z-index: 0;
		    margin: 0px;
		    padding: 0px;
		    max-width: 100%;
		    max-height: 100%;
		    width: 100%;
		    height: 100%;
		    list-style: none;
		    overflow: hidden;
		}
		.slideshow li  {
			/**background-image: url('your-background-image.jpg');**/
		    position: absolute;
		    top: 0px;
		    left: 0px;
		    z-index: 0;
		    width: 100%!important;
		    height: 100%!important;
		    max-width: 100%;
		    max-height: 100%;
		    background-position: 50% 50%;
		    background-repeat: no-repeat;
		    -webkit-background-size: cover;
		    -moz-background-size: cover;
		    -o-background-size: cover;
		    background-size: cover;
		    background-origin: content-box;
		    display: block;
		}
		
		del,ins{text-decoration:none;} /*unset del's default strike-trough style, plus ins' underlined*/
    </style>
    	
	<script src="${ctxStatic}/jquery-plugin/t.min.js" type="text/javascript"></script>
		
	<script type="text/javascript">
		$(document).ready(function() {
			// add Typewriter action for project title by jeffen@pactera 2016/5/24 @since 1.2.11
			var fin=!1;
			function foo(){
				$('mark').eq(0).css({display:'none'});
			}
			$('#t').t({
				speed:50,
				speed_vary:true,
				mistype:20,
				typing:function(elem,chars_total,chars_left,_char){
					if(_char=='*')foo();
				},
				fin:function(){
					if(fin==!1){
					fin=!!1; //avoids triggering after 'add' cmd
					window.setTimeout(function(){$('#t').t('add','Welcome board.');},5000);
					window.setInterval(function(){$('#t').find('.t-caret').toggle();},5e2);
					}
				}
			});
			
			// keep on cycling slideshow for background images.
			$('.slideshow').cycle({
			    speed: 2500,
			    manualSpeed: 100,
			    random:  1
			});
	
			// default focused dom
			$("#username").select();
			
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
			
			
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
	</script>
</head>
<body>
	<ul class="slideshow">
		<%// localhost drive%>
		<li style="background-image: url('${ctxStatic}/images/02684_crew_1280x800.jpg')"></li>
		<li style="background-image: url('${ctxStatic}/images/ceair_crew.jpg')"></li>
		<li style="background-image: url('${ctxStatic}/images/02772_sunsetdeparture_1280x800.jpg')"></li>
		<li style="background-image: url('${ctxStatic}/images/04042_sunriseatjinshanlinggreatwall_1280x800.jpg')"></li>
		
		<%// cloud drive %>
		<li style="background-image: url('http://7xt46e.com2.z0.glb.clouddn.com/03317_angrybird_1280x800.jpg"></li>
		<li style="background-image: url('http://7xt46e.com2.z0.glb.clouddn.com/03322_mtrainierfromkerrypark_1280x800.jpg')"></li>
			
		<%// online source %>
		<li style="background-image: url('https://interfacelift.com/wallpaper/7yz4ma1/04044_monolake_1280x800.jpg')"></li>
		<li style="background-image: url('https://interfacelift.com/wallpaper/7yz4ma1/04002_brooklynbridgerenovation_1280x800.jpg')"></li>

	</ul>
		
	<!--[if lte IE 6]><br/><div class='alert alert-block' style="text-align:left;padding-bottom:10px;"><a class="close" data-dismiss="alert">x</a><h4>温馨提示：</h4><p>你使用的浏览器版本过低。为了获得更好的浏览体验，我们强烈建议您 <a href="http://browsehappy.com" target="_blank">升级</a> 到最新版本的IE浏览器，或者使用较新版本的 Chrome、Firefox、Safari 等。</p></div><![endif]-->
	<div class="header">
		<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
			<label id="loginError" class="error">${message}</label>
		</div>
	</div>
	<section>
			<h1 id="t" class="form-signin-heading" style="display:none;">
				${fns:getConfig('productName')}<ins>0.5</ins><br />
				<del>Pactera # JeeSite Frame Work</del><mark class="icon-plane"></mark><ins>0.5</ins>
				<del>山东航空 -> 常旅客与渠道BI项目</del>
				<del>四川航空 -> 市场数据分析BI项目</del>
				<del>深圳航空 -> 器械管理项目</del>
				<del>fantastic travel is amazing.</del>
				* Dear Passenger, 
			</h1>
	</section>
	<form id="loginForm" class="form-signin" action="${ctx}/login" method="post">
		<label class="input-label" for="username"><sys:mutiLang langKey="common.username" /></label>
		<input type="text" id="username" name="username" class="input-block-level required" value="${fns:getConfig('defaultUserName')}">
		<label class="input-label" for="password"><sys:mutiLang langKey="common.password" /></label>
		<input type="password" id="password" name="password" class="input-block-level required"  value="${fns:getConfig('defaultPassword')}">
		<c:if test="${isValidateCodeLogin}"><div class="validateCode">
			<label class="input-label mid" for="validateCode">验证码</label>
			<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
		</div></c:if><%--
		<label for="mobile" title="手机登录"><input type="checkbox" id="mobileLogin" name="mobileLogin" ${mobileLogin ? 'checked' : ''}/></label> --%>
		<input class="btn btn-large btn-primary" type="submit" value="${fns:getLang('common.login', null)}"/>&nbsp;&nbsp;
		<label for="rememberMe" title="下次不需要再登录">
		<input type="checkbox" id="rememberMe" name="rememberMe" class="checkbox" ${rememberMe ? 'checked' : ''}/> 
		<label for="rememberMe"><span></span></label>
		<sys:mutiLang langKey="common.rememberme" /></label>
		<div id="themeSwitch" class="dropdown" style="display:${fns:getConfigBoolean('hideThemeSwitch') ? 'none' : ''};">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">${fns:getDictLabel(cookie.theme.value,'theme','默认主题')}<b class="caret"></b></a>
			<ul class="dropdown-menu">
			  <c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
			</ul>
			<!--[if lte IE 6]><script type="text/javascript">$('#themeSwitch').hide();</script><![endif]-->
		</div>
		
		<%// 国际化多国语言 add by jeffen@pactera 2015/5/27 %>
		<div id="langSwitch" class="dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">${fns:getDictLabel(cookie.lang.value,'muti_lang','简体中文')}<b class="caret"></b></a>
			<ul class="dropdown-menu">
			  <c:forEach items="${fns:getDictList('muti_lang')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/lang/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
			</ul>
		</div>
	</form>
	<div class="footer">
		Copyright &copy; ${fns:getConfig('copyrightYearSince')}-${fns:getConfig('copyrightYear')}
		&nbsp;<a href="${fns:getConfig('orgPortal')}" target="_blank">${fns:getConfig('organization')}</a>
		&nbsp;-&nbsp;Powered By <a href="${fns:getConfig('poweredByPortal')}" target="_blank">${fns:getConfig('poweredBy')} </a> ${fns:getConfig('version')}
		&nbsp;-&nbsp;Build By <a href="http://jeffencheung.github.com/aggregator" target="_blank">PacteraJeesite</a>&nbsp;${fns:getConfig('frameworkBuildVersion')}
	</div>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-plugin/jquery.cycle.all.js" type="text/javascript"></script>
</body>
</html>