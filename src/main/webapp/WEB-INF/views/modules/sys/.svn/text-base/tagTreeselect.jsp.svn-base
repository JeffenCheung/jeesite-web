<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>数据选择</title>
	<meta name="decorator" content="blank"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">
		var key, lastValue = "", nodeList = [], type = getQueryString("type", "${url}"), dictRootType = getQueryString("dictRootType", "${url}");
		var tree, setting = {view:{selectedMulti:false,dblClickExpand:false},check:{enable:"${checked}",nocheckInherit:true},
				// 用户树
				async:{enable:(type==3||type==4)
					,url:"${ctx}/sys/office/treeData?type="+type					
					// 自动提交参数，为了避免controller层getId（）重复执行，可自定义id变量名。
					,autoParam:["id=nodeId"]
				},
				data:{simpleData:{enable:true}},callback:{<%--
					beforeClick: function(treeId, treeNode){
						if("${checked}" == "true"){
							//tree.checkNode(treeNode, !node.checked, true, true);
							tree.expandNode(treeNode, true, false, false);
						}
					}, --%>
					onClick:function(event, treeId, treeNode){
						tree.expandNode(treeNode);
					},onCheck: function(e, treeId, treeNode){
						var nodes = tree.getCheckedNodes(true);
						for (var i=0, l=nodes.length; i<l; i++) {
							tree.expandNode(nodes[i], true, false, false);
						}
						return false;
					},onAsyncSuccess: function(event, treeId, treeNode, msg){
						var nodes = tree.getNodesByParam("pId", treeNode.id, null);
						for (var i=0, l=nodes.length; i<l; i++) {
							try{tree.checkNode(nodes[i], treeNode.checked, true);}catch(e){}
							//tree.selectNode(nodes[i], false);
						}
						selectCheckNode();
					},onDblClick: function(){//<c:if test="${!checked}">
						top.$.jBox.getBox().find("button[value='ok']").trigger("click");
						//$("input[type='text']", top.mainFrame.document).focus();//</c:if>
					}
				}
			};
			
		cDebug("tagTreeselect.jsp", "type="+type);
		// 异步加载（公司和部门）
		if((!type || type==1 || type==2) && ${fns:getConfigBoolean('widget.ztree.office.async')}===true){
			// 基本属性
			var asyncOpt = {
				enable: true,
				type: "get",
				contentType: "application/json",
				url: "${ctx}/sys/office/treeData?type="+type,
				// 自动提交参数，为了避免controller层getId（）重复执行，可自定义id变量名。
				autoParam: ["id=nodeId"]
			};
			
			// 回调函数监听
			var callbackOpt = {
				onAsyncError: zTreeOnAsyncError,
				onAsyncSuccess: zTreeOnAsyncSuccess
			};

			// 扩展配置
			$.extend(setting, {async: asyncOpt});
			$.extend(setting.callback, callbackOpt);
		}

		// 异步加载（数据字典树）
		// 11：一级数据字典；12：二级数据字典：13：三级数据字典
		if(type && (type==11 || type==12 || type==13)){
			// 基本属性
			var asyncOpt = {
				enable: true,
				type: "get",
				contentType: "application/json",
				url: "${ctx}/sys/dict/treeDataSync?type="+type+"&dictRootType="+dictRootType,
				// 自动提交参数，为了避免controller层getId（）重复执行，可自定义id变量名。
				autoParam: ["id=nodeId"]
			};
			
			// 回调函数监听
			var callbackOpt = {
				onAsyncError: zTreeOnAsyncError,
				onAsyncSuccess: zTreeOnAsyncSuccess
			};

			// 扩展配置
			$.extend(setting, {async: asyncOpt});
			cDebug("tagTreeselect", "setting.async.enable=" + setting.async.enable);
			cDebug("tagTreeselect", "setting.async.url=" + setting.async.url);
			$.extend(setting.callback, callbackOpt);
		}
		
		function zTreeOnAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
			cLog("zTreeOnAsyncError", ((!!treeNode && !!treeNode.name) ? treeNode.name : "root") );
		    cError("zTreeOnAsyncError", XMLHttpRequest);
		};
		function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
			cLog("zTreeOnAsyncSuccess" , ((!!treeNode && !!treeNode.name) ? treeNode.name : "root") );
			// 判定是否有子节点（公司和部门、数据字典）
			if(type && (type==1 || type==2 || type==11 || type==12 || type==13) && treeNode.children.length == 0){
				treeNode.isLastNode = true;
				treeNode.isParent = false;
				$("#" + treeNode.tId + "_switch").remove();
				var btnIco = "ico_docu";
				if(type==1 || type==2){
					btnIco="ico_diy_profile_ico_open";
				}
				$("#" + treeNode.tId + "_ico").removeAttr("class").attr("class", "button "+btnIco);
				cDebug("zTreeOnAsyncSuccess", "modified leaf node.");
			}
		}
			
		function expandNodes(nodes) {
			if (!nodes) return;
			for (var i=0, l=nodes.length; i<l; i++) {
				tree.expandNode(nodes[i], true, false, false);
				if (nodes[i].isParent && nodes[i].zAsync) {
					expandNodes(nodes[i].children);
				}
			}
		}
		$(document).ready(function(){
			var url_ = "${ctx}${url}${fn:indexOf(url,'?')==-1?'?':'&'}extId=${extId}&isAll=${isAll}&module=${module}&isOfficeCode=${isOfficeCode}&t="
					+ new Date().getTime() + "&format=json&jsoncallback=?";
			cDebug("tagTreeselect.jsp.ready", "url="+url_);
			$.get(url_, function(zNodes){
				cDebug("tagTreeselect.jsp.ready", "success:data="+JSON.stringify(zNodes));
				if(zNodes === null || zNodes.length == 0){
					var msg = "缺少根节点数据。";
					if(dictRootType)msg+="【数据字典表或缓存缺失数据：type="+dictRootType+"】";
					top.$.jBox.tip.mess=1;
					top.$.jBox.tip(msg
							,"warning"
							,{persistent:true
								,opacity:0});
					$("#messageBox").show();
					cWarn("refreshTree", msg);
				}
					
				// 初始化树结构
				tree = $.fn.zTree.init($("#tree"), setting, zNodes);
				
				// 默认展开一级节点
				var nodes = tree.getNodesByParam("level", 0);
				for(var i=0; i<nodes.length; i++) {
					tree.expandNode(nodes[i], true, false, false);
					cDebug("document.ready", "expandNode="+i);
				}
				//异步加载子节点（如，加载用户、加载数据字典树一级子节点）
				var nodesOne = tree.getNodesByParam("isParent", true);
				for(var j=0; j<nodesOne.length; j++) {
					cDebug("document.ready", "reAsyncChildNodes="+i);
					tree.reAsyncChildNodes(nodesOne[j],"!refresh",true);
				}
				selectCheckNode();
			});
			key = $("#key");
			key.bind("focus", focusKey).bind("blur", blurKey).bind("change cut input propertychange", searchNode);
			key.bind('keydown', function (e){if(e.which == 13){searchNode();}});
			setTimeout("search();", "300");
		});
		
		// 默认选择节点
		function selectCheckNode(){
			var ids = "${selectIds}".split(",");
			for(var i=0; i<ids.length; i++) {
				var node = tree.getNodeByParam("id", (type==3?"u_":"")+ids[i]);
				if("${checked}" == "true"){
					try{tree.checkNode(node, true, true);}catch(e){}
					tree.selectNode(node, false);
				}else{
					tree.selectNode(node, true);
				}
			}
		}
	  	function focusKey(e) {
			if (key.hasClass("empty")) {
				key.removeClass("empty");
			}
		}
		function blurKey(e) {
			if (key.get(0).value === "") {
				key.addClass("empty");
			}
			searchNode(e);
		}
		
		//搜索节点
		function searchNode() {
			// 取得输入的关键字的值
			var value = $.trim(key.get(0).value);
			
			// 按名字查询
			var keyType = "name";<%--
			if (key.hasClass("empty")) {
				value = "";
			}--%>
			
			// 如果和上次一次，就退出不查了。
			if (lastValue === value) {
				return;
			}
			
			// 保存最后一次
			lastValue = value;
			
			var nodes = tree.getNodes();
			// 如果要查空字串，就退出不查了。
			if (value == "") {
				showAllNode(nodes);
				return;
			}
			hideAllNode(nodes);
			nodeList = tree.getNodesByParamFuzzy(keyType, value);
			updateNodes(nodeList);
		}
		
		//隐藏所有节点
		function hideAllNode(nodes){			
			nodes = tree.transformToArray(nodes);
			for(var i=nodes.length-1; i>=0; i--) {
				tree.hideNode(nodes[i]);
			}
		}
		
		//显示所有节点
		function showAllNode(nodes){			
			nodes = tree.transformToArray(nodes);
			for(var i=nodes.length-1; i>=0; i--) {
				/* if(!nodes[i].isParent){
					tree.showNode(nodes[i]);
				}else{ */
					if(nodes[i].getParentNode()!=null){
						tree.expandNode(nodes[i],false,false,false,false);
					}else{
						tree.expandNode(nodes[i],true,true,false,false);
					}
					tree.showNode(nodes[i]);
					showAllNode(nodes[i].children);
				/* } */
			}
		}
		
		//更新节点状态
		function updateNodes(nodeList) {
			tree.showNodes(nodeList);
			for(var i=0, l=nodeList.length; i<l; i++) {
				
				//展开当前节点的父节点
				tree.showNode(nodeList[i].getParentNode()); 
				//tree.expandNode(nodeList[i].getParentNode(), true, false, false);
				//显示展开符合条件节点的父节点
				while(nodeList[i].getParentNode()!=null){
					tree.expandNode(nodeList[i].getParentNode(), true, false, false);
					nodeList[i] = nodeList[i].getParentNode();
					tree.showNode(nodeList[i].getParentNode());
				}
				//显示根节点
				tree.showNode(nodeList[i].getParentNode());
				//展开根节点
				tree.expandNode(nodeList[i].getParentNode(), true, false, false);
			}
		}
		
		// 开始搜索
		function search() {
			$("#search").slideToggle(200);
			$("#txt").toggle();
			$("#key").focus();
		}
		
	</script>
</head>
<body>
	<div style="position:absolute;right:8px;top:5px;cursor:pointer;" onclick="search();">
		<i class="icon-search"></i><label id="txt">搜索</label>
	</div>
	<div id="search" class="form-search hide" style="padding:10px 0 0 13px;">
		<label for="key" class="control-label" style="padding:5px 5px 3px 0;">关键字：</label>
		<input type="text" class="empty" id="key" name="key" maxlength="50" style="width:110px;">
		<button class="btn" id="btn" onclick="searchNode()">搜索</button>
	</div>
	<div id="tree" class="ztree" style="padding:15px 20px;"></div>
</body>