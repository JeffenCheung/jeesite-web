<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="content" type="java.lang.String" required="true"
	description="消息内容"%>
<%@ attribute name="type" type="java.lang.String"
	description="消息类型：info、success、warning、error、loading"%>
<script type="text/javascript">
	top.$.jBox.closeTip();

	<% //add showMessageBox by jeffen 2016/1/1 since v1.2.10 %>
	function showMessageBox(content, type) {
		top.$.jBox.tip(content);
		$("#messageBoxStatic_content").html(content);
		$("#messageBoxStatic").attr("class", "alert alert-"+type);
		$("#messageBoxStatic").show();
	}
</script>
<c:if test="${not empty content}">
	<c:if test="${not empty type}">
		<c:set var="ctype" value="${type}" />
	</c:if>
	<c:if test="${empty type}">
		<c:set var="ctype"
			value="${fn:indexOf(content,'失败') eq -1?'success':'error'}" />
	</c:if>
	<div id="messageBox" class="alert alert-${ctype} hide">
		<button data-dismiss="alert" class="close">×</button>
		${content}
	</div>
	<script type="text/javascript">
		if(!top.$.jBox.tip.mess){
			top.$.jBox.tip.mess=1;
			top.$.jBox.tip("${content}"
					,"${ctype}"
					,{persistent:true
						,opacity:0});
			$("#messageBox").show();
		}
	</script>
</c:if>

	<% //add showMessageBox by jeffen 2016/1/1 since v1.2.10 %>
	<div id="messageBoxStatic" class="alert hide">
		<button data-dismiss="alert" class="close">×</button>
		<span id="messageBoxStatic_content" />
	</div>