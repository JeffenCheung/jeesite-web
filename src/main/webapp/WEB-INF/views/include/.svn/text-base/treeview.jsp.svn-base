<link href="${ctxStatic}/jquery-ztree/3.5.19/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet" type="text/css"/>
<script src="${ctxStatic}/jquery-ztree/3.5.19/js/jquery.ztree.all-3.5.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-ztree/3.5.19/js/jquery.ztree.exhide-3.5.min.js" type="text/javascript"></script>


<script type="text/javascript">
	
	// 异步加载所在部门 by jeffen@pactera 2015/12/30
	
	function officeTreeOnAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
		cLog("officeTreeOnAsyncError", ((!!treeNode && !!treeNode.name) ? treeNode.name : "root") );
	    cError("officeTreeOnAsyncError", XMLHttpRequest);
	};
	function officeTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		cLog("officeTreeOnAsyncSuccess" , "treeId="+treeId);
		cLog("officeTreeOnAsyncSuccess" , "root.name="+((!!treeNode && !!treeNode.name) ? treeNode.name : "root") );
		// 判定是否有子节点
		if(treeNode && treeNode.children && treeNode.children.length == 0){
			treeNode.isLastNode = true;
			treeNode.isParent = false;
			$("#" + treeNode.tId + "_switch").remove();
			$("#" + treeNode.tId + "_ico").removeAttr("class").attr("class", "button ico_diy_profile_ico_open");
			cDebug("officeTreeOnAsyncSuccess", "modified leaf node.");
		}
	}

	// 初始化异步加载机构树
	function refreshOfficeTree(officeTreeId, setting, isAsync, myOfficeTreeOnAsyncSuccess, myOfficeTreeOnAsyncError){
		var start= new Date();
		var officeTreeSetting = $.extend(true, {}, setting, {});
		cDebug("refreshOfficeTree", "officeTreeId=" + officeTreeId);
		cDebug("refreshOfficeTree", "officeTreeSetting=" + JSON.stringify(officeTreeSetting));
		cDebug("refreshOfficeTree", "isAsync=" + isAsync);
		
		// 基本属性
		var officeTreeAsyncOpt = {async: {
			enable: true,
			type: "get",
			contentType: "application/json",
			url: "${ctx}/sys/office/treeData",
			// 自动提交参数，为了避免controller层getId（）重复执行，可自定义id变量名。
			autoParam: ["id=nodeId"]
		}};
		
		// 回调函数监听
		var officeTreeCallbackOpt = {callback: {
			onAsyncError: myOfficeTreeOnAsyncError?myOfficeTreeOnAsyncError:officeTreeOnAsyncError,
			onAsyncSuccess: myOfficeTreeOnAsyncSuccess?myOfficeTreeOnAsyncSuccess:officeTreeOnAsyncSuccess
		}};
	
		$.getJSON("${ctx}/sys/office/treeData",function(data){
			if(data === null || data.length == 0){
				top.$.jBox.tip.mess=1;
				top.$.jBox.tip("缺少根节点（ID=0）或一级子节点（PID=0）。"
						,"warning"
						,{persistent:true
							,opacity:0});
				$("#messageBox").show();
				cWarn("refreshTree", "缺少根节点（ID=0）或一级子节点（PID=0）。");
			}
			if (isAsync) {
				// 扩展配置
				officeTreeSetting = $.extend(true, {}, setting, officeTreeAsyncOpt);
				officeTreeSetting = $.extend(true, {}, officeTreeSetting, officeTreeCallbackOpt);
				
				cDebug("refreshOfficeTree", "extend officeTreeSetting=" + JSON.stringify(officeTreeSetting));
			}

			$.fn.zTree.init($("#"+officeTreeId), officeTreeSetting, data).expandAll(!${fns:getConfigBoolean('widget.ztree.office.async')});
			
			cDebug("refreshOfficeTree", start.dateDiffNowLimitedSecond());
		});
	}
		
</script>