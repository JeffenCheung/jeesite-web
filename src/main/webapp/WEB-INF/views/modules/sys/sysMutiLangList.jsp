<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>语言管理</title>
	<meta name="decorator" content="default"/>
	
	 <!-- CSS and JS for table fixed header -->
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/table-fixed-header-master/table-fixed-header.min.css">
	<script src="${ctxStatic}/bootstrap/table-fixed-header-master/table-fixed-header.min.js"></script>
	<script src="${ctxStatic}/bootstrap/table-fixed-header-master/bottom-sticker.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			// refresh button click event
			$("#btnRefresh").click(function(){
				// reset tip to message
				resetTip();
				$("#searchForm").attr("action","${ctx}/sys/sysMutiLang/refreshCach");
				$("#searchForm").submit();
			});
			// make the header fixed on scroll
			$(".table-fixed-header").fixedHeader();
			$("#bottom-sticker").bottomSticker();
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }	    
	    // 重置按钮
	    function searchReset(formId){
	    	// 重置所有输入框
	    	var inputDom = $("#" + formId).find(":input[type='text']");
	    	if(inputDom) inputDom.val("");
	    	
	    	// 重置下拉框
	    	$("#langCode").val("");
	    	
	    	// 刷新表单
			$("#" + formId).submit();	    	
	    }
	</script>
</head>
<body>
	<ul id="mynav" class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/sysMutiLang/">语言列表</a></li>
		<shiro:hasPermission name="sys:sysMutiLang:edit"><li><a href="${ctx}/sys/sysMutiLang/form">语言添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysMutiLang" action="${ctx}/sys/sysMutiLang/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>语言主键：</label>
				<form:input path="langKey" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>内容：</label>
				<form:input path="langContext" htmlEscape="false" maxlength="500" class="input-medium"/>
			</li>
			<li><label>语言：</label>
				<form:select id="langCode" path="langCode" class="input-medium">
					<form:option value="" label="${fns:getLang('common.null', null) }"/>
					<form:options items="${fns:getDictList('muti_lang')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="${fns:getLang('common.query', null) }" /></li>
			<li class="btns"><input id="btnSearchReset" class="btn btn-primary" type="reset" value="${fns:getLang('common.reset', null) }" onclick="searchReset('searchForm');"/></li>
			<li class="btns"><input id="btnRefresh" class="btn btn-primary" type="button" value="${fns:getLang('common.mutilang.refresh', null) }"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed table-hover table-fixed-header">
		<thead class="header">
			<tr>
				<th>语言主键</th>
				<th>内容</th>
				<th>语言</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="sys:sysMutiLang:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysMutiLang">
			<tr>
				<td><a href="${ctx}/sys/sysMutiLang/form?id=${sysMutiLang.id}">
					${sysMutiLang.langKey}
				</a></td>
				<td>
					${sysMutiLang.langContext}
				</td>
				<td>
					${fns:getDictLabel(sysMutiLang.langCode, 'muti_lang', '')}
				</td>
				<td>
					<fmt:formatDate value="${sysMutiLang.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${sysMutiLang.remarks}
				</td>
				<shiro:hasPermission name="sys:sysMutiLang:edit"><td>
    				<a href="${ctx}/sys/sysMutiLang/form?id=${sysMutiLang.id}">修改</a>
					<a href="${ctx}/sys/sysMutiLang/delete?id=${sysMutiLang.id}" onclick="return confirmx('确认要删除该语言吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination" id="bottom-sticker">${page}</div>
</body>
</html>