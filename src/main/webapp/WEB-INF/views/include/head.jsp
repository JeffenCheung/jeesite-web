<%@ page contentType="text/html;charset=UTF-8" %><meta http-equiv="Content-Type" content="text/html;charset=utf-8" /><meta name="author" content="http://pactera.com/"/>
<meta name="renderer" content="webkit"><meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10" />
<meta http-equiv="Expires" content="0"><meta http-equiv="Cache-Control" content="no-cache"><meta http-equiv="Cache-Control" content="no-store">
<script src="${ctxStatic}/jquery/jquery-1.11.3.min.js" type="text/javascript"></script>
<link href="${ctxStatic}/bootstrap/2.3.1/css_${not empty cookie.theme.value ? cookie.theme.value : 'cerulean'}/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
<!--<link href="${ctxStatic}/bootstrap/2.3.1/awesome/font-awesome.min.css" type="text/css" rel="stylesheet" />
[if lte IE 7]><link href="${ctxStatic}/bootstrap/2.3.1/awesome/font-awesome-ie7.min.css" type="text/css" rel="stylesheet" /><![endif]-->
<!--[if lte IE 6]><link href="${ctxStatic}/bootstrap/bsie/css/bootstrap-ie6.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/bootstrap/bsie/js/bootstrap-ie.min.js" type="text/javascript"></script><![endif]-->
<link href="${ctxStatic}/jquery-select2/4.0/css/select2.min.css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-select2/4.0/js/select2.full.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-select2/4.0/js/i18n/zh-CN.js" type="text/javascript"></script>
<link href="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-validation/1.14.0/dist/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.14.0/dist/localization/messages_zh.min.js" type="text/javascript"></script>
<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="${ctxStatic}/common/mustache.min.js" type="text/javascript"></script>
<link href="${ctxStatic}/common/jeesite.min.css" type="text/css" rel="stylesheet" />

<!-- add jquery-ui by jeffen@pactera 2015/9/30
	classic css version 1.8.2 including widgets' extended style(eg. auto complete), upper or lower version dose not work!
 start -->
<link href="${ctxStatic}/jquery-ui/${not empty cookie.theme.value ? cookie.theme.value : 'cerulean'}/jquery-ui.min.css" rel="stylesheet" type="text/css" />
<script src="${ctxStatic}/jquery/jquery-ui.min.js" type="text/javascript"></script>
<!-- add jquery-ui by jeffen@pactera 2015/9/30 end -->

<script src="${ctxStatic}/common/jeesite.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/common/dateformat.js" type="text/javascript"></script>

<!-- add by jeffen@pactera 2015/6/7 start -->
<link href="${ctxStatic}/jquery-plugin/tipsy.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-plugin/jquery.tipsy.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-plugin/jquery.jsonp.js" type="text/javascript"></script>
<!-- add by jeffen@pactera 2015/6/7 end -->

<!-- since 1.2.10 add by jeffen@pactera 2015/12/14 start -->
<script type="text/javascript">
	var ctx = '${ctx}', ctxStatic = '${ctxStatic}';

	// get login user info for js
	var userInfo = JSON.parse('${fns:getUserJson()}');
	cDebug("head.jsp", "userInfo.id=" + userInfo.id);
	cDebug("head.jsp", "userInfo.name=" + userInfo.name);
</script>
<!-- since 1.2.10 add by jeffen@pactera 2015/12/14 start -->