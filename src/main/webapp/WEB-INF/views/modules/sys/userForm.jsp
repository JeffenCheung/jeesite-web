<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	
	<script src="${ctxStatic}/bootstrap/table-fixed-header-master/bottom-sticker.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("#no").focus();
			$("#inputForm").validate({
				rules: {
					loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
				},
				messages: {
					loginName: {remote: "用户登录名已存在"},
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				},
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			// 是否允许登录下拉
			$("#loginFlag").select2({
			  // Hiding the search box
			  minimumResultsForSearch: Infinity,
			  theme: "classic"
			});
			  
			// 初始化账号冻结情况
			closeInfoPanelShow(${user.loginFlag});
			
			// 账户冻结信息联动
			$("#loginFlag").change(function(){
				closeInfoPanelShow($("#loginFlag").val());
			})

			function closeInfoPanelShow(loginFlag){
				
				if(loginFlag==0){//0否
					$(".closeInfoPanel").show();
					$( ".closeInfoPanel" ).effect("highlight", 3000);
				}else{
					$(".closeInfoPanel").hide();
				}
			}
			
			$("#bottom-sticker").bottomSticker();
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/user/list">用户列表</a></li>
		<li class="active"><a href="${ctx}/sys/user/form?id=${user.id}">用户<shiro:hasPermission name="sys:user:edit">${not empty user.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:user:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">头像:</label>
			<div class="controls">
				<form:hidden id="nameImage" path="photo" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="nameImage" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">归属公司:</label>
			<div class="controls">
                <sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}"
					title="公司" url="/sys/office/treeData?type=1" cssClass="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">归属部门:</label>
			<div class="controls">
                <sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" notAllowSelectParent="false"/>
					<!-- 原来为true -->
			</div>
		</div>
		
		<% // since 1.2.10 add by jeffen@pactera 2015/12/3 start %>
		<div class="control-group">
			<label class="control-label">部门职务:</label>
			<div class="controls">
                <sys:treeselect id="post" name="post.id" value="${user.post.id}" labelName="post.postName" labelValue="${user.post.postName}"
					title="职务" url="/sys/office/treeData?type=4" cssClass="required" notAllowSelectParent="false" />
					<!-- 原来为true -->
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">楼层:</label>
			<div class="controls">
                <sys:treeselect id="floorId" name="floor" value="${user.floor.id}" labelName="floor.label" labelValue="${user.floor.label}"
					title="楼层" url="/sys/dict/treeDataSync?type=13&dictRootType=ZONE" cssClass="" notAllowSelectParent="true" showPath="false"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">级别:</label>
			<div class="controls">
				<form:input path="userLevel" htmlEscape="false" maxlength="50" class=""/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">工号:</label>
			<div class="controls">
				<form:input path="no" htmlEscape="false" maxlength="50" class=""/>
			</div>
		</div>
		
		
		<div class="control-group">
			<label class="control-label">姓名:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">登录名:</label>
			<div class="controls">
				<input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
				<form:input path="loginName" htmlEscape="false" maxlength="50" class="required userName"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱:</label>
			<div class="controls">
				<form:input path="email" htmlEscape="false" maxlength="100" class="email"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话:</label>
			<div class="controls">
				<form:input path="phone" htmlEscape="false" maxlength="100"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机:</label>
			<div class="controls">
				<form:input path="mobile" htmlEscape="false" maxlength="100"/>
			</div>
		</div>
			<div class="control-group">
			<label class="control-label">密码:</label>
			<div class="controls">
				<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="${empty user.id?'required':''}"/>
				<c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
				<c:if test="${not empty user.id}"><span class="help-inline">若不修改密码，请留空。</span></c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">确认密码:</label>
			<div class="controls">
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" equalTo="#newPassword"/>
				<c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">SSID:</label>
			<div class="controls">
				<form:input path="ssid" htmlEscape="false" maxlength="50" class=""/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">账号类别:</label>
			<div class="controls">
				<form:input path="accountType" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		
		<% // since 1.2.10 add by jeffen@pactera 2015/12/3 end %>
		
		<div class="control-group">
			<label class="control-label">是否允许登录:</label>
			<div class="controls">
				<form:select id="loginFlag" path="loginFlag">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> “是”代表此账号允许登录，“否”则表示此账号不允许登录</span>
			</div>
		</div>
		<div class="closeInfoPanel"">
			<div class="control-group">
				<label class="control-label">帐号冻结类型或原因：</label>
				<div class="controls">
					<form:select id="closeType" path="closeType">
						<form:option value="" label="${fns:getLang('common.please.select', '---请选择---')}"/>
						<form:options items="${fns:getDictList('sys_user_closeType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">帐号冻结截至时间：</label>
				<div class="controls">
					<input name="reopenDate"  path="reopenDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						value="<fmt:formatDate value="${user.reopenDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
						<span class="help-inline"> 当您不填写此表单项时，将永久冻结该账号！</span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户类型:</label>
			<div class="controls">
				<form:select path="userType" class="input-xlarge">
					<form:option value="" label="${fns:getLang('common.please.select', '---请选择---')}"/>
					<form:options items="${fns:getDictList('sys_user_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户角色:</label>
			<div class="controls">
				<form:checkboxes path="roleIdList" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="5" maxlength="200" class="input-xxlarge"/>
			</div>
		</div>
		<c:if test="${not empty user.id}">
			<div class="control-group">
				<label class="control-label">创建时间:</label>
				<div class="controls">
					<label class="lbl"><fmt:formatDate value="${user.createDate}" type="both" dateStyle="full"/></label>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">最后登陆:</label>
				<div class="controls">
					<label class="lbl">IP: ${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.loginDate}" type="both" dateStyle="full"/></label>
				</div>
			</div>
		</c:if>
		<div class="form-actions" id="bottom-sticker">
			<shiro:hasPermission name="sys:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>