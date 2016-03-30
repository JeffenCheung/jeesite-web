<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>DataTablesCrud</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/datatables.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			cDebug("testDataTables.jsp", "ready function start");
			$("#contentTable").DataTable();
		});
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/test/test/datatables/">DataTablesCRUD</a></li>
		<li><a href="${ctx}/test/test/">硕正列表</a></li>
		<shiro:hasPermission name="test:test:edit"><li><a href="${ctx}/test/test/form">组件表单</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="test" action="${ctx}/test/test/listData.json" method="post" class="breadcrumb form-search" onsubmit="return page();">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>名称 ：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed table-hover">
		<thead class="header">
			<tr>
				<th class="sorting">名称</th>
				<shiro:hasPermission name="test:test:edit">
					<th>操作</th>
				</shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="test">
			<tr>
				<td>${test.name}</td>
				<shiro:hasPermission name="test:test:edit"><td>
    				<a href="${ctx}/test/test/form?id=${test.id}">详情</a>
					<a href="${ctx}/test/test/delete?id=${test.id}" onclick="return confirmx('确认要删除吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>
