<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	
	 <!-- CSS and JS for table fixed header -->
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/table-fixed-header-master/table-fixed-header.min.css">
	<script src="${ctxStatic}/bootstrap/table-fixed-header-master/table-fixed-header.min.js"></script>
	<script src="${ctxStatic}/bootstrap/table-fixed-header-master/bottom-sticker.min.js"></script>
	
	<script type="text/javascript">
		var TITLE_AUTOCOMPLETE_URL = "${ctx}/sys/user/getTitleList";
		var LOGINNAME_AUTOCOMPLETE_URL = "${ctx}/sys/user/getLoginNameList";
		
		$(document).ready(function() {
			// refresh button click event
			$("#btnRefresh").click(function(){
				// reset tip to message
				resetTip();
				$("#searchForm").attr("action","${ctx}/sys/user/clearCache");
				$("#searchForm").submit();
			});
		
			// 自动填充下拉列表 start
			$( "#loginName" ).autocomplete({
		        minLength: 1,
		        delay: 500,
		        //define callback to format results
		        source: function (request, response) {
		            $.getJSON(TITLE_AUTOCOMPLETE_URL, request, function(result) {
		                response($.map(result, function(item) {
		                    return {
		                        // following property gets displayed in drop down
		                        label: item.loginName + "(" + item.name + ")",
		                        // following property gets entered in the textbox
		                        value: item.loginName
		                    }
		                }));
		            });
		        },
		 
		        //define select handler
		        select : function(event, ui) {
		            if (ui.item) {
		                event.preventDefault();
		                $("#loginName").val(ui.item.value);
		                $("#loginName").blur();
		                return false;
		            }
		        }
		    });
		    $( "#name" ).autocomplete({
		        minLength: 1,
		        delay: 500,
		        //define callback to format results
		        source: function (request, response) {
		            $.getJSON(TITLE_AUTOCOMPLETE_URL, request, function(result) {
		                response($.map(result, function(item) {
		                    return {
		                        // following property gets displayed in drop down
		                        label: item.name + "(" + item.loginName + ")",
		                        // following property gets entered in the textbox
		                        value: item.name
		                    }
		                }));
		            });
		        },
		 
		        //define select handler
		        select : function(event, ui) {
		            if (ui.item) {
		                event.preventDefault();
		                $("#name").val(ui.item.value);
		                $("#name").blur();
		                return false;
		            }
		        }
		    });
		    // 自动填充下拉列表 end
		    
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/sys/user/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
			
			// 双击记录进行编辑
			$("#contentTable tbody tr").on("dblclick", function() {
			    location.href="${ctx}/sys/user/form?id="+this.id;
			});
			
			// make the header fixed on scroll
			$(".table-fixed-header").fixedHeader();
			$("#bottom-sticker").bottomSticker();
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/sys/user/list");
			$("#searchForm").submit();
	    	return false;
	    }
	    // 重置按钮
	    function searchReset(formId){
	    	// 重置所有输入框
	    	var inputDom = $("#" + formId).find(":input[type='text']");
	    	if(inputDom) inputDom.val("");
	    	
	    	// 重置下拉框
	    	$("#company").val("");
	    	$("#companyId").val("");
	    	$("#office").val("");
	    	$("#officeId").val("");
	    	$("#loginFlag").val("");
	    	
	    	// 刷新表单
			$("#" + formId).submit();	    	
	    }
	</script>
</head>
<body>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/sys/user/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/sys/user/import/template">下载模板</a>
		</form>
	</div>
	<ul id="mynav" class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/user/list">用户列表</a></li>
		<li><a href="${ctx}/sys/user/listJq">用户列表(JqGrid)</a></li>
		<shiro:hasPermission name="sys:user:edit"><li><a href="${ctx}/sys/user/form">用户添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>归属公司：</label><sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}" 
				title="公司" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true"/></li>
			<li><label>归属部门：</label><sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}" 
				title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/></li>
			<li title="* 模糊查询"><label>登录名*：</label>
				<form:input id="loginName" path="loginName" htmlEscape="false" maxlength="50" class="input-small" onFocus="inputFocus(this)" onBlur="inputBlur(this)"/>
			</li>
			<li title="* 模糊查询"><label>姓&nbsp;&nbsp;&nbsp;名*：</label>
				<form:input id="name" path="name" htmlEscape="false" maxlength="50" class="input-small" onFocus="inputFocus(this)" onBlur="inputBlur(this)"/>
			</li>
		
			<li class="clearfix"></li>
		
			<li>
				<label>是否启用：</label>
				<form:select id="loginFlag" path="loginFlag" class="input-small">
					<form:option value="" label="${fns:getLang('common.please.select', '---请选择---')}"/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>关停时间：</label>
				<input name="beginReopenDate" id="beginReopenDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${user.beginReopenDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onfocus="gangDateStart('endReopenDate');" onclick="gangDateStart('endReopenDate');"/> - 
				<input name="endReopenDate" id="endReopenDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${user.endReopenDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onfocus="gangDateEnd('beginReopenDate');" onclick="gangDateEnd('beginReopenDate');"/>
			</li>
				
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
				<input id="btnSearchReset" class="btn btn-primary" type="reset" value="${fns:getLang('common.reset', null) }" onclick="searchReset('searchForm');"/>
				<input id="btnRefresh" class="btn btn-primary" type="button" value="${fns:getLang('common.user.refresh', null) }"/>
				<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
				<input id="btnImport" class="btn btn-primary" type="button" value="导入"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed table-hover table-fixed-header">
		<thead class="header"><tr><th>归属公司</th><th>归属部门</th><th class="sort-column login_name">登录名</th><th class="sort-column name">姓名</th><th>电话</th><th>手机</th><%--<th>角色</th> --%><shiro:hasPermission name="sys:user:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="user">
			<tr id="${user.id}">
				<td>${user.company.name}</td>
				<td>${user.office.name}</td>
				<td><a href="${ctx}/sys/user/form?id=${user.id}">${user.loginName}</a></td>
				<td>${user.name}</td>
				<td>${user.phone}</td>
				<td>${user.mobile}</td><%--
				<td>${user.roleNames}</td> --%>
				<shiro:hasPermission name="sys:user:edit"><td>
    				<a href="${ctx}/sys/user/form?id=${user.id}">修改</a>
					<a href="${ctx}/sys/user/delete?id=${user.id}" onclick="return confirmx('确认要删除该用户吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination" id="bottom-sticker">${page}</div>
</body>
</html>