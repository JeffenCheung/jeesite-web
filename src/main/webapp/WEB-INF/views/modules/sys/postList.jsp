<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>职位表${fns:getLang('common.management', null)}</title>
	<meta name="decorator" content="default"/>	
	
	 <!-- CSS and JS for table fixed header -->
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/table-fixed-header-master/table-fixed-header.min.css">
	<script src="${ctxStatic}/bootstrap/table-fixed-header-master/table-fixed-header.min.js"></script>
	<script src="${ctxStatic}/bootstrap/table-fixed-header-master/bottom-sticker.min.js"></script>
	<script src="${ctxStatic}/common/gridify.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnCsvExport").click(function(){
				top.$.jBox.confirm("确认要导出数据文件吗？如果数据过大，可能需要一些时间。","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#exportCsvForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnCsvImport").click(function(){
				$.jBox($("#importCsvBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“csv”格式文件！"});
			});
				
				
			// 删除选中行数据
			$("#btnDeleteChecked").click(function(){
				$.batPro("${ctx}/sys/post/deleteChecked", "${fns:getLang('common.delete', null)}");
			});

			// 复制选中行数据
			$("#btnCopyChecked").click(function(){
				$.batPro("${ctx}/sys/post/copyChecked", "${fns:getLang('common.copy', null)}");
			});
				
			// 双击记录进行编辑
			$("#contentTable tbody tr").on("dblclick", function() {
			    location.href="${ctx}/sys/post/form?id="+this.id;
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
	    	//$("#type").val("");
	    	
	    	// 刷新表单
			$("#" + formId).submit();	    	
	    }
	</script>
</head>
<body>
	<div id="importCsvBox" class="hide">
		<form id="importCsvForm" action="${ctx}/sys/post/import/csv" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadCsvFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportCsvSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/sys/post/import/csv/template">下载模板</a>
		</form>
		<form id="exportCsvForm" action="${ctx}/sys/post/export/csv" method="post" enctype="multipart/form-data">
		</form>
	</div>
	<ul id="mynav" class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/post/">职位表${fns:getLang('common.list', null)}</a></li>
		<shiro:hasPermission name="sys:post:edit"><li><a href="${ctx}/sys/post/form">职位表${fns:getLang('common.add', null)}</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="post" action="${ctx}/sys/post/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>职位名称：</label>
				<form:input id="postName" path="postName" htmlEscape="false" maxlength="30" class="input-medium"/>
			</li>
			<li><label>职位描述：</label>
				<form:input id="postDes" path="postDes" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>职位等级</label>
				<form:input id="postLevel" path="postLevel" htmlEscape="false" maxlength="1" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="${fns:getLang('common.query', null)}"/></li>
			<li class="btns"><input id="btnSearchReset" class="btn btn-primary" type="reset" value="${fns:getLang('common.reset', null)}" onclick="searchReset('searchForm');"/></li>
			<li class="btns"><input id="btnDeleteChecked" class="btn btn-primary" type="button" value="${fns:getLang('common.delete', null)}" disabled="true" /></li>
			<shiro:hasPermission name="sys:post:dba"><li class="btns" style="padding-left:30px;"><input id="btnCopyChecked" class="btn btn-primary" type="button" value="${fns:getLang('common.copy', null)}" disabled="true" /></li></shiro:hasPermission>
		
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<form:form id="gridForm" modelAttribute="post" action="${ctx}/sys/post/deleteChecked" method="post">
		<span id="cbRowDataIdsBox">
			<input name="cbRowDataIds" type="hidden" value=""/>
		</span>
		<table id="contentTable" class="table table-striped table-bordered table-condensed table-hover table-fixed-header">
			<thead class="header">
				<tr>
					<th class="row-checkbox" title="${fns:getLang('common.checkall', null)}"><input type="checkbox" name="checkall" id="checkall" class="checkbox" /><label for="checkall"><span></span></label></th>
					<th class="row-number">No.</th>
					<th style="display:none;">ID</th>
					<th>职位名称</th>
					<th>职位描述</th>
					<th>职位等级</th>
					<shiro:hasPermission name="sys:post:edit"><th>
						${fns:getLang('common.operate', null)}
						<shiro:hasAnyPermissions name="sys:post:dba,sys:post:io">
						<div class="btn-group pull-right">
							<a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
							<ul class="dropdown-menu">
								<% // 物理删除选项 %>
								<shiro:hasPermission name="sys:post:dba">
								<form:checkbox id="physicalDelete" path="physicalDelete" label="物理删除" title="默认逻辑删除，勾选后进行物理删除" />
								<li class="btns"><input id="btnTruncateTable" class="btn btn-warning typeahead" type="button" value="物理清空" onclick="truncateTable('${ctx}/sys/post/truncateTable');"/></li></shiro:hasPermission>
								<% // CSV管理： 模版下载、数据导入、导入数据校验、数据导出 %>
								<li class="divider"></li>
								<shiro:hasPermission name="sys:post:io">
								<li class="btns"><input id="btnCsvExport" class="btn btn-primary typeahead" type="button" value="CSV数据导出"/></li>
								<li class="btns"><input id="btnCsvImport" class="btn btn-primary typeahead" type="button" value="CSV数据导入"/></li></shiro:hasPermission>
							</ul>
						</div></shiro:hasAnyPermissions>
					</th></shiro:hasPermission>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="post" varStatus="vs">
				<tr id="${post.id}">
					<td class="row-checkbox"><input type="checkbox" name="cbRowData" id="cb_${post.id}" class="checkbox" /><label for="cb_${post.id}"><span></span></label></td></td>
					<td class="row-number">
						${vs.index + 1 + (page.pageNo-1)*page.pageSize}
					</td>
					<td class="row-id" style="display:none;">${post.id}</td>
					<td><a href="${ctx}/sys/post/form?id=${post.id}">
						${post.postName}
					</a></td>
					<td>
						${post.postDes}
					</td>
					<td>
						${post.postLevel}
					</td>
					<shiro:hasPermission name="sys:post:edit"><td class="row-operate">
	    				<a href="${ctx}/sys/post/form?id=${post.id}">${fns:getLang('common.edit', null)}</a>
						<a href="javascript:void(0)" onclick="rowDelete('${ctx}/sys/post/delete?id=${post.id}');">${fns:getLang('common.delete', null)}</a>
						<shiro:hasPermission name="sys:post:dba">&nbsp;|&nbsp;<a href="${ctx}/sys/post/copy?id=${post.id}" onclick="top.$.jBox.tip.mess=false;return this.href">${fns:getLang('common.copy', null)}</a></shiro:hasPermission>
					</td></shiro:hasPermission>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="pagination" id="bottom-sticker">${page}</div>
	</form:form>
</body>
</html>