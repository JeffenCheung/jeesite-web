<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>日志监控</title>
	<meta name="decorator" content="default"/>
    
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
<!-- 	<ul class="nav nav-tabs"> -->
<%-- 		<li class="active"><a href="${ctx}/sys/log/">日志列表</a></li> --%>
<!-- 	</ul> -->
	<form:form id="searchForm" action="${ctx}/sys/log/charts" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div>
			<label>操作菜单：</label><input id="title" name="title" type="text" maxlength="50" class="input-mini" value="${log.title}"/>
			<label>访问数>=：</label><input id="cnt" name="cnt" type="text" maxlength="50" class="input-mini" value="${log.cnt}"/>
		</div>
		<div style="margin-top:8px;">
			<label>日期范围：&nbsp;</label>
			<input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="20" class="input-mini Wdate"
				value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>" 
				onfocus="gangDateStart('endDate', false, 'yyyy-MM-dd');" onclick="gangDateStart('endDate', false, 'yyyy-MM-dd');"/>
			<label>&nbsp;--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" class="input-mini Wdate"
				value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>" 
				onfocus="gangDateEnd('beginDate', false, 'yyyy-MM-dd');" onclick="gangDateEnd('beginDate', false, 'yyyy-MM-dd');"/>&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>&nbsp;&nbsp;
		</div>
	</form:form>
	<sys:message content="${message}"/>
	
	<% // echarts container %>
    <div id="main" style="margin:0 auto; width:95%; height:500px"></div>
    <!-- ECharts单文件引入 -->
    <script src="${ctxStatic}/echarts-master/build/dist/echarts.js"></script>
    <script type="text/javascript">
        // 路径配置
        require.config({
            paths: {
                echarts: '${ctxStatic}/echarts-master/build/dist'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
             var myChart = ec.init(document.getElementById('main')); 
                
                var option = {
				    title : {
				        text: '模块访问次数',
				        subtext: '数据来自本站'
				    },
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['模块访问次数']
				    },
				    toolbox: {
				        show : true,
				        feature : {
				            mark : {show: true},
				            dataView : {show: true, readOnly: false},
				            magicType: {show: true, type: ['line', 'bar']},
				            restore : {show: true},
				            saveAsImage : {show: true}
				        }
				    },
				    calculable : true,
				    color : [ 
					    '#87cefa', '#ff7f50', '#da70d6', '#32cd32', '#6495ed', 
					    '#ff69b4', '#ba55d3', '#cd5c5c', '#ffa500', '#40e0d0', 
					    '#1e90ff', '#ff6347', '#7b68ee', '#00fa9a', '#ffd700', 
					    '#6b8e23', '#ff00ff', '#3cb371', '#b8860b', '#30e0e0' 
					],
				    xAxis : [
				        {
				            type : 'value',
				            boundaryGap : [0, 0.01]
				        }
				    ],
				    yAxis : [
				        {
				            type : 'category',
				            data : [
				            	<c:forEach items="${page.list}" var="log" varStatus="status">
				            		'${log.title}'
				            		<c:choose>
				            			<c:when test="${status.last}">
				            			</c:when>
				            			<c:otherwise>
				            				,
				            			</c:otherwise>
				            		</c:choose>
				            	</c:forEach>
							],
				            axisLabel : {
				    			margin : -8,
				    			clickable: true,
				    			interval: 0,
				    			textStyle: {align: 'left'}
				    		}
				        }
				    ],
				    series : [
				        {
				            name:'模块访问次数',
				            type:'bar',
				            data:[
				            	<c:forEach items="${page.list}" var="log" varStatus="status">
				            		${log.cnt}
				            		<c:choose>
				            			<c:when test="${status.last}">
				            			</c:when>
				            			<c:otherwise>
				            				,
				            			</c:otherwise>
				            		</c:choose>
				            	</c:forEach>
				            ]
				        }
				    ]
                };
        
                // 为echarts对象加载数据 
                myChart.setOption(option); 
            }
        );
    </script>
	
	<table id="contentTable" class="table table-striped table-bordered table-condensed table-hover">
		<thead><tr><th>操作菜单</th><th>访问数</th></thead>
		<tbody><%request.setAttribute("strEnter", "\n");request.setAttribute("strTab", "\t");%>
		<c:forEach items="${page.list}" var="log">
			<tr>
				<td>${log.title}</td>
				<td>${log.cnt}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</html>