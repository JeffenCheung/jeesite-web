<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')}</title>
	<meta name="decorator" content="blank"/>
	
	<c:set var="demoMode" value="${fns:getConfigBoolean('demoMode')}"/>
	<c:set var="menuMode" value="${fns:getConfig('menuMode')}"/>
	<c:set var="tabmode" value="${empty cookie.tabmode.value ? '0' : cookie.tabmode.value}"/>
	<c:set var="breadcrumbmode" value="${empty cookie.breadcrumbmode.value ? '1' : cookie.breadcrumbmode.value}"/>
    	<c:if test="${tabmode eq '1'}">
	<link rel="Stylesheet" href="${ctxStatic}/jerichotab/css/jquery.jerichotab.css" />
	<script type="text/javascript" src="${ctxStatic}/jerichotab/js/jquery.jerichotab.js"></script>
    	</c:if>
    	
    	<c:if test="${demoMode}">
    <script type="text/javascript" src="${ctxStatic}/jquery-plugin/jquery.floatingmessage.js"></script>
    	</c:if>
    	
	<style type="text/css">

		#main {padding:0;margin:0;} #main .container-fluid{padding:0 4px 0 6px;}
		#header {margin:0 0 8px;position:static;} #header li {font-size:14px;_font-size:12px;}
		#header .brand {font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;font-size:26px;padding-left:33px;}
		#productName{background: url(${ctxStatic}/images/menu.png) no-repeat left 3px;padding-left:20px;}
		#footer {margin:8px 0 0 0;padding:3px 0 0 0;font-size:11px;text-align:center;border-top:2px solid #0663A2;}
		#footer, #footer a {color:#999;} #left{overflow-x:hidden;overflow-y:auto;} #left .collapse{position:static;}
		#userControl>li>a{/*color:#fff;*/text-shadow:none;} #userControl>li>a:hover, #user #userControl>li.open>a{background:transparent;}

	</style>
	<script type="text/javascript">
		$(document).ready(function() {

				<c:if test="${demoMode}">
            //left-bottom
            $("<div>Left bottom - Display 5sec<br />左下信息提示 - 显示5秒</div>").floatingMessage({
                position : "bottom-left",
                time : 5000
            });
            $("<div>Left bottom<br />左下信息提示 - 点击关闭</div>").floatingMessage({
                position : "bottom-left"
            });
				</c:if>

			// add cookie hash switch by jeffen@pactera 2016/1/20
			var isCookieHash = true;
			
			// <c:if test="${tabmode eq '1'}"> 初始化页签
			$.fn.initJerichoTab({
                renderTo: '#right', uniqueId: 'jerichotab',
                contentCss: { 'height': $('#right').height() - tabTitleHeight },
                tabs: [], loadOnce: true, tabWidth: 110, titleHeight: tabTitleHeight
                // add beforeAddTab func by jeffen@pactera 2017/1/18
                , isCookieTabsetting: isCookieHash, isCookieLoadData: isCookieHash
                , fn_beforeAddTab: beforeAddTab
                , fn_afterTabMouseup: afterTabMouseup
                , fn_afterTabLoad: afterTabLoad
            });//</c:if>
			// 绑定菜单单击事件
			$("#menu a.menu").click(function(closeFirstActive){
				// 一级菜单焦点
				$("#menu li.menu").removeClass("active");
				$(this).parent().addClass("active");
				// 左侧区域隐藏
				if ($(this).attr("target") == "mainFrame"){
					// hide breadcrumb
					$(".breadcrumb").hide();
					$("#left,#openClose").hide();
					wSizeWidth();
					// <c:if test="${tabmode eq '1'}"> 隐藏页签
					$(".jericho_tab").hide();
					$("#mainFrame").show();//</c:if>
					return true;
				}
				// 左侧区域显示
				$("#left,#openClose").show();
				if(!$("#openClose").hasClass("close")){
					$("#openClose").click();
				}
				// 显示二级菜单
				var menuId = "#menu-" + $(this).attr("data-id");
				if ($(menuId).length > 0){
					$("#left .accordion").hide();
					$(menuId).show();
					
					if(!closeFirstActive){
						// 初始化点击第一个二级菜单
						if (!$(menuId + " .accordion-body:first").hasClass('in')){
							$(menuId + " .accordion-heading:first a").click();
						}
						if (!$(menuId + " .accordion-body li:first ul:first").is(":visible")){
							$(menuId + " .accordion-body a:first i").click();
						}
						// 初始化点击第一个三级菜单
						if(!$.fn.jerichoTab.isCookieTabsetting
								|| !cookie || cookie($.fn.jerichoTab.cookieTabsetting)==null 
								|| cookie($.fn.jerichoTab.cookieTabsetting)=='null'){
							// add cookie tabsetting by jeffen@pactera 2017/1/18
							$(menuId + " .accordion-body li:first li:first a:first i").click();
						}
					}
				}else{
					// 获取二级菜单数据
					$.get($(this).attr("data-href"), function(data){
						if (data.indexOf("id=\"loginForm\"") != -1){
							alert('未登录或登录超时。请重新登录，谢谢！');
							top.location = "${ctx}";
							return false;
						}
						$("#left .accordion").hide();
						$("#left").append(data);
						// 链接去掉虚框
						$(menuId + " a").bind("focus",function() {
							if(this.blur) {this.blur()};
						});
						// 二级标题
						$(menuId + " .accordion-heading a").click(function(){
							$(menuId + " .accordion-toggle i").removeClass('icon-chevron-down').addClass('icon-chevron-right');
							if(!$($(this).attr('data-href')).hasClass('in')){
								$(this).children("i").removeClass('icon-chevron-right').addClass('icon-chevron-down');
							}
						});
						// 二级内容
						$(menuId + " .accordion-body a").click(function(){
							$(menuId + " li").removeClass("active");
							$(menuId + " li i").removeClass("icon-white");
							$(this).parent().addClass("active");
							$(this).children("i").addClass("icon-white");
						});
						// 展现三级
						$(menuId + " .accordion-inner a").click(function(){
							var href = $(this).attr("data-href");
							if($(href).length > 0){
								$(href).toggle().parent().toggle();
								return false;
							}
							
							// <c:if test="${breadcrumbmode eq '1'}">
							syncBreadcrumb($(this));
							// </c:if>
			
							
							// <c:if test="${tabmode eq '1'}"> 打开显示页签
							return addTab($(this)); // </c:if>
						});
						// 默认选中第一个菜单
						if(!$.fn.jerichoTab || !$.fn.jerichoTab.isCookieTabsetting
								|| !cookie || cookie($.fn.jerichoTab.cookieTabsetting)==null 
								|| cookie($.fn.jerichoTab.cookieTabsetting)=='null'){
							// add cookie tabsetting by jeffen@pactera 2017/1/18
							$(menuId + " .accordion-body a:first i").click();
							$(menuId + " .accordion-body li:first li:first a:first i").click();
						}
					});
				}
				// 大小宽度调整
				wSizeWidth();
				return false;
			});
			// 初始化点击第一个一级菜单
			$("#menu a.menu:first span").click();
			// <c:if test="${tabmode eq '1'}"> 下拉菜单以选项卡方式打开
			$("#userInfo .dropdown-menu a").mouseup(function(){
				return addTab($(this), true);
			});// </c:if>
			
			<c:if test="${menuMode eq '1'}">
			// 鼠标移动到边界自动弹出左侧菜单
			$("#openClose").mouseover(function(){
				if($(this).hasClass("open")){
					$(this).click();
				}
			});
			</c:if>
			
			// 获取通知数目  <c:set var="oaNotifyRemindInterval" value="${fns:getConfig('oa.notify.remind.interval')}"/>
			function getNotifyNum(){
				$.get("${ctx}/notify/ffpNotify/self/count?updateSession=0&t="+new Date().getTime(),function(data){
					var num = parseFloat(data);
					if (num > 0){
						$("#notifyNum,#notifyNum2").show().html("("+num+")");
					}else{
						$("#notifyNum,#notifyNum2").hide()
					}
				});
			}
			getNotifyNum(); //<c:if test="${oaNotifyRemindInterval ne '' && oaNotifyRemindInterval ne '0'}">
			setInterval(getNotifyNum, ${oaNotifyRemindInterval}); //</c:if>
			
			// <c:if test="${tabmode eq '1'}"> add by jeffen@pactera 2016/1/20 
			if(isCookieHash) initActiveMenuBar(true);//</c:if>
			
			
			
			
			var  div =document.getElementById("sysname");
			var pname = '${fns:getConfig('productName')}';
			
			if(pname=="分销渠道管理系统"){
		
				div.setAttribute("class", "head_sysname2");

			}else{ 
				div.setAttribute("class", "head_sysname");
			}
		});
		// call event before addTab
		function beforeAddTab(){
			$(".jericho_tab").show();
			$("#mainFrame").hide();
			return true;
		}
		// call event after tab load data
		function afterTabLoad(tabFirerRef){
			
			// call this tab event
			//afterTabMouseup(tabFirerRef);
			
			// call last tab event by cookie
			if($.fn.jerichoTab.cookieTabLast && cookie($.fn.jerichoTab.cookieTabLast)!=null 
					&& cookie($.fn.jerichoTab.cookieTabLast)!='null'){
				if(tabFirerRef == cookie($.fn.jerichoTab.cookieTabLast))
					afterTabMouseup(tabFirerRef);
			}
		}
		// call event after tab mouseup
		function afterTabMouseup(tabFirerRef){
			$('#left .accordion').find('a[data-href="' + tabFirerRef + '"]').each(function(i, n){
				// 二级菜单
				var accordion_group = $(n).closest('div[class="accordion-group"]');
				var accordion_heading_a = accordion_group.children('.accordion-heading').children('a');
				var accordion_body = accordion_group.children('.accordion-body');
				var accordion = accordion_group.parent('.accordion');
				
				// 展开一级菜单
				var menu_dataid = $(accordion).attr("id").replace('menu-', '');
				$('#menu a.menu[data-id="' + menu_dataid + '"]')[0].click(true);

				if(!accordion_body.hasClass('in')){
					// 展开二级菜单
					accordion_heading_a.click();
				}
				
				// 点击三级菜单
				$(this).click();
				return false;
			});
			return true;
		}
		// <c:if test="${tabmode eq '1'}"> 添加一个页签
		function addTab($this, refresh){
			var tabFirerRef = $this.attr("data-href");
			//四级菜单判定
			if(tabFirerRef==null||tabFirerRef=='null'){
				tabFirerRef = $this.closest('ul').closest('li').children('a').attr("data-href");
			}
			$.fn.jerichoTab.addTab({
                tabFirer: $this,
                
                // add tabFirerRef by jeffen@pactera 2.16/1/18
                tabFirerRef: tabFirerRef,
                
                title: $this.text(),
                closeable: true,
                data: {
                    dataType: 'iframe',
                    dataLink: $this.attr('href')
                },onLoadCompleted: onLoadCompleted
            }).loadData(refresh);
			return false;
		}// </c:if>
		function onLoadCompleted(){
			var holder = this;
		}
		// call event after manue bar init
		function initActiveMenuBar(closeFirstActive){
			$('#menu').find('a.menu').each(function(i, n){
				// 点击一级菜单
				$(this)[0].click(closeFirstActive);
			});
			return true;
		}
	</script>
</head>
<body>
	<div id="main">
		<div id="header" class="navbar navbar-fixed-top">
			<div class="navbar-inner">
				<%-- add 魏香香  2016/02/02  开始--%>
				<span class="head_logo"></span>
				<span class="head_line"></span>
				<%-- add 魏香香  2016/02/02  结束--%>
				<div class="brand"><!--<span id="productName">${fns:getConfig('productName')}</span>--></div>
				<ul id="userControl" class="nav pull-right">
					<%-- <li><a
						href="${pageContext.request.contextPath}${fns:getFrontPath()}?from=1"
						title="回到主页"><i class="icon-home"></i></a>
					<li id="themeSwitch" class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="主题切换"><i class="icon-th-large"></i></a>
						<ul class="dropdown-menu">
							<c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
							<li><a href="javascript:cookie('tabmode','${tabmode eq '1' ? '0' : '1'}');location=location.href">${tabmode eq '1' ? '关闭' : '开启'}页签模式</a></li>
						</ul>
						<!--[if lte IE 6]><script type="text/javascript">$('#themeSwitch').hide();</script><![endif]-->
					</li> --%>
					<span class="head_fly"></span>
					<li id="userInfo" class="dropdown">
						<a id="userIcon" class="dropdown-toggle" data-toggle="dropdown" href="#" title="个人信息"><i class="icon-white icon-user"></i>&nbsp;${fns:getUser().name}&nbsp;<span id="notifyNum" class="label label-info hide"></span></a>
						<ul class="dropdown-menu">
							<li><a href="${ctx}/sys/user/info" target="mainFrame"><i class="icon-user"></i>&nbsp; 个人信息</a></li>
							<li><a href="${ctx}/sys/user/modifyPwd" target="mainFrame"><i class="icon-lock"></i>&nbsp;  修改密码</a></li>
							<li><a href="${ctx}/notify/ffpNotify/self" target="mainFrame"><i class="icon-bell"></i>&nbsp;  我的通知 <span id="notifyNum2" class="label label-info hide"></span></a></li>
						</ul>
					</li>
					<li id="exit"><a class="exitlogin" href="${ctx}/logout" title="${fns:getLang('common.exit.confirm', null)}"><i class="icon-white icon-off"></i>&nbsp;<sys:mutiLang langKey="common.exit"/></a></li>
					<li>&nbsp;</li>
				</ul>
				<%-- <c:if test="${cookie.theme.value eq 'cerulean'}">
					<div id="user" style="position:absolute;top:0;right:0;"></div>
					<div id="logo" style="background:url(${ctxStatic}/images/logo_bg.jpg) right repeat-x;width:100%;">
						<div style="background:url(${ctxStatic}/images/logo.jpg) left no-repeat;width:100%;height:70px;"></div>
					</div>
					<script type="text/javascript">
						$("#productName").hide();$("#user").html($("#userControl"));$("#header").prepend($("#user, #logo"));
					</script>
				</c:if> --%>
				<div class="nav-collapse">
					<span id="sysname"></span>
					<ul id="menu" class="nav" style="*white-space:nowrap;clear:both;">
						<c:set var="firstMenu" value="true"/>
						<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
							<c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'}">
								<li class="menu ${not empty firstMenu && firstMenu ? ' active' : ''}">
									<c:if test="${empty menu.href}">
										<a class="menu" href="javascript:" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}"><span>${menu.name}</span></a>
									</c:if>
									<c:if test="${not empty menu.href}">
										<a class="menu" href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}" data-id="${menu.id}" target="mainFrame"><span>${menu.name}</span></a>
									</c:if>
								</li>
								<c:if test="${firstMenu}">
									<c:set var="firstMenuId" value="${menu.id}"/>
								</c:if>
								<c:set var="firstMenu" value="false"/>
							</c:if>
						</c:forEach><%--
						<shiro:hasPermission name="cms:site:select">
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">${fnc:getSite(fnc:getCurrentSiteId()).name}<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<c:forEach items="${fnc:getSiteList()}" var="site"><li><a href="${ctx}/cms/site/select?id=${site.id}&flag=1">${site.name}</a></li></c:forEach>
							</ul>
						</li>
						</shiro:hasPermission> --%>
					</ul>
				</div><!--/.nav-collapse -->
			</div>
	    </div>
	    <div class="container-fluid">
			<div id="content" class="row-fluid">
				<div id="left"><%-- 
					<iframe id="menuFrame" name="menuFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no" width="100%" height="650"></iframe> --%>
				</div>
				<div id="openClose" class="close">&nbsp;</div>
				<div id="right">
						<c:if test="${breadcrumbmode eq '1'}">
					<ol class="breadcrumb menuBar" style="display: none;">
						<li id="menuBar"><a href="javascript:void(0);">导航加载中</a></li>
						<li id="tabHead"><a href="javascript:void(0);">breadcrumbing</a></li>
						<li id="tabCont"><a href="javascript:void(0);">...</a></li>
						<li id="tabContNode"><a href="javascript:void(0);">...</a></li>
					</ol>
						</c:if>
					<iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no"  width="100%" height="650"></iframe>
				</div>
			</div>
		    <div id="footer" class="row-fluid">
	            Copyright &copy; ${fns:getConfig('copyrightYearSince')}-${fns:getConfig('copyrightYear')} <a href="${fns:getConfig('orgPortal')}" target="_blank">${fns:getConfig('organization')}</a> - Powered By <a href="${fns:getConfig('poweredByPortal')}" target="_blank">${fns:getConfig('poweredBy')} </a> ${fns:getConfig('version')}
			</div>
		</div>
	</div>
	<script type="text/javascript"><%@ include file="/WEB-INF/views/modules/sys/sysIndex.js"%></script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>