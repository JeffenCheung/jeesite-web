<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="procInsId" type="java.lang.String" required="true" description="流程实例ID"%>
<%@ attribute name="startAct" type="java.lang.String" required="false" description="开始活动节点名称"%>
<%@ attribute name="endAct" type="java.lang.String" required="false" description="结束活动节点名称"%>

<% // add by jeffen@pactera 2015/12/26 %>
<%@ attribute name="showTracePhoto" type="java.lang.Boolean" required="false" description="是否显示流程跟踪"%>
<%@ attribute name="processDefinitionId" type="java.lang.String" required="false" description="流程定义ID"%>
<%@ attribute name="executionId" type="java.lang.String" required="false" description="流程执行实例ID"%>

<fieldset>
	<legend>流转信息</legend>
	<div id="histoicFlowList">
		正在加载流转信息...
	</div>

	<% // add by jeffen@pactera 2015/12/26 %>
		<c:if test="${showTracePhoto && !empty processDefinitionId && !empty executionId}" >
	<legend>流程跟踪</legend>
	<div id="tracePhoto">
		<span id="loadingImg">正在加载流程跟踪...</span>
		<img id="tracePhotoImg" src=""/>
	</div>
		</c:if>

</fieldset>
<script type="text/javascript">
	$.get("${ctx}/act/task/histoicFlow?procInsId=${procInsId}&startAct=${startAct}&endAct=${endAct}&t="+new Date().getTime(), function(data){
		$("#histoicFlowList").html(data);
	});
	<% // add by jeffen@pactera 2015/12/26 %>
		<c:if test="${showTracePhoto && !empty processDefinitionId && !empty executionId}" >
	var url = "${ctx}/act/task/trace/photo/${processDefinitionId}/${executionId}";
	$.ajax({ 
		url : url, 
		cache: true,
		processData : false,
		success: function() {
			$("#loadingImg").hide();
		},
		error: function(r,x) {
			$("#loadingImg").html("加载流程跟踪异常!");
		}
	}).always(function(){
	    $("#tracePhotoImg").attr("src", url).fadeIn();
	});
		</c:if>
</script>