/*!
 * Copyright &copy; 2015-2016 <a href="https://pactera.com">Pactera-JeeSite</a> All rights reserved.
 * 
 * 业务方法
 * @author Jeffen@pactera
 * @version 2016-1-31
 */
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

});
var leftWidth = 160; // 左侧窗口大小
var tabTitleHeight = 0; // 页签的高度

// <c:if test="${tabmode eq '1'}"> 
tabTitleHeight += 33; // 页签高度
//</c:if>

// <c:if test="${breadcrumbmode eq '1'}"> 
tabTitleHeight += 40;// 导航高度
</c:if>

var htmlObj = $("html"), mainObj = $("#main");
var headerObj = $("#header"), footerObj = $("#footer");
var frameObj = $("#left, #openClose, #right, #right iframe");
function wSize(){
	var minHeight = 500, minWidth = 980;
	var strs = getWindowSize().toString().split(",");
	htmlObj.css({"overflow-x":strs[1] < minWidth ? "auto" : "hidden", "overflow-y":strs[0] < minHeight ? "auto" : "hidden"});
	mainObj.css("width",strs[1] < minWidth ? minWidth - 10 : "auto");
	frameObj.height((strs[0] < minHeight ? minHeight : strs[0]) - headerObj.height() - footerObj.height() - (strs[1] < minWidth ? 42 : 28));
	$("#openClose").height($("#openClose").height() - 5);// <c:if test="${tabmode eq '1'}"> 
	$(".jericho_tab iframe").height($("#right").height() - tabTitleHeight); // </c:if>
	
	// <c:if test="${breadcrumbmode eq '1'}"> 
	$("#mainFrame").height($("#right").height() - tabTitleHeight); // </c:if>

	wSizeWidth();
}
function wSizeWidth(){
	if (!$("#openClose").is(":hidden")){
		var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
		$("#right").width($("#content").width()- leftWidth - $("#openClose").width() -5);
	}else{
		$("#right").width("100%");
	}
}// <c:if test="${tabmode eq '1'}"> 
function openCloseClickCallBack(b){
	$.fn.jerichoTab.resize();
} // </c:if>

// 获取通知数目
function getNotifyNum(){
	$.get("${ctx}/oa/oaNotify/self/count?updateSession=0&t="+new Date().getTime(),function(data){
		var num = parseFloat(data);
		if (num > 0){
			$("#notifyNum,#notifyNum2").show().html("("+num+")");
		}else{
			$("#notifyNum,#notifyNum2").hide()
		}
	});
}

// <c:if test="${tabmode eq '1'}"> 初始化页签
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
//</c:if>

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

// <c:if test="${breadcrumbmode eq '1'}">
function syncBreadcrumb($this){
	$(".breadcrumb").show();
	var tabCont = $this.text();// 获取选中的菜单内容
	var tabHref = $this.attr('href');// 获取选中的菜单链接
	var tabHead = null; // 二级菜单
		
	// 二级菜单
	var accordion_group = $this.closest('div[class="accordion-group"]');
	var accordion_heading_a = accordion_group.children('.accordion-heading').children('a');
	var accordion_body = accordion_group.children('.accordion-body');
	var accordion = accordion_group.parent('.accordion');
	tabHead = accordion_heading_a.text();
	
	// 四级菜单判定
	var tabFirerRef = $this.attr("data-href");
	if(tabFirerRef==null||tabFirerRef=='null'){
		var menuLevel3 = $this.closest('ul').closest('li').children('a');
		$("#tabContNode a").show().html(tabCont).attr('href', tabHref);
		
		tabCont = menuLevel3.text();
		tabHref = 'javascript:void(0);';
	} else {
		$("#tabContNode a").hide();
	}
	
	// refresh breadcrumb html
	$("#menuBar a").html($("#menu li.active span").text());
	$("#tabHead a").html(tabHead);
	$("#tabCont a").html(tabCont).attr('href', tabHref);
	
}
// </c:if>

function onLoadCompleted(){
	var holder = this;
}
// call event after manue bar init
function initActiveMenuBar(closeFirstActive){
	// 顶部菜单menu bar只有一个顶级功能菜单或顶级首页菜单时，不重复走初始化动作，否则菜单收拉异常。
	if ($('#menu').find('a.menu').length > 1)
	$('#menu').find('a.menu').each(function(i, n){
		// 点击一级菜单
		$(this)[0].click(closeFirstActive);
	});
	return true;
}