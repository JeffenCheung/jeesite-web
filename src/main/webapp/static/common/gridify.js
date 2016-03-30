/*!
 * Copyright &copy; 2015-2016 <a href="https://pactera.com">Pactera-JeeSite</a> All rights reserved.
 * 
 * 通用列表处理方法
 *
 * 样式操作颗粒度需跟bootstrap一致，到TD/TH的cell一级而非TR一级，否则会被bootstrap的样式覆盖。
 * bootstrap的颗粒度普遍如此设计，或因考虑到方便widget进行单个cell的差异化操作，此标准值得借鉴和沿用。
 *
 * @author Jeffen@pactera
 * @version 2015-9-25
 */
$(document).ready(function() {
	// [通用方法]自动填充标题列表
	if(!typeof TITLE_AUTOCOMPLETE_URL === 'undefined')
	$( "#title" ).autocomplete({
		autoFocus: true,
        minLength: 1,
        delay: 500,
        //define callback to format results
        source: function (request, response) {
            $.getJSON(TITLE_AUTOCOMPLETE_URL, request, function(result) {
                response($.map(result, function(item) {
                    return {
                        // following property gets displayed in drop down
                        label: item.name,
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
                $("#title").val(ui.item.value);
                $("#title").blur();
                $("#title").focus();
                return false;
            }
        }
    });
		    
	// 【行数据复选框操作动作集合 START】
	// 单击[全选]选中和取消选中全部行数据
	$("#checkall").on("click", function() {
		$("#contentTable tbody tr").each(function(i){
			trDomPro($(this), true);
		});
		// 同步全选复选框状态
		syncCheckAllStatus();
	});
		
	// 单击[row checkbox]选中和取消选中
	$("input[name='cbRowData']").bind("click", function () {
		var tr = $(this).parent().parent();
		trDomPro(tr);
		
		// 同步全选复选框状态
		syncCheckAllStatus();
	}); 
	
	// 单击[行数据]选中和取消选中
	$("#contentTable tbody tr").each(function(i){
		$(this).children("td").each(function(j){
			var td = $(this);
			var tr = $(this).parent();
			// 过滤checkbox、rowno、operate等例外列，防止差异交互的交叉影响。
			// 如点击操作列的删除按钮不应联动本行选中状态。
			// 此处属通用处理，如遇复杂操作逻辑需复制到相关模块页面进行重构。
			if (!td.hasClass("row-checkbox")&&!td.hasClass("row-id")&&!td.hasClass("row-operate")) {
				td.bind("click", function () {
					trDomPro(tr);
					
					// 同步全选复选框状态
					syncCheckAllStatus();
				});
			}
		});
	});

	/*
	 * 处理当前行状态
	 * tr:当前行
	 * isCheckAllAction:是否全选动作
	 */
	function trDomPro(tr, isCheckAllAction){
		// fixed：checkbox status judging by .is(":checked") not attr("checked")
		if ((!isCheckAllAction && tr.hasClass("table-row-selected")) || (isCheckAllAction && !$("#checkall").is(":checked"))) {
			tr.removeClass("table-row-selected");
			tr.children().removeClass("table-row-selected");
			tr.children("td:eq(0)").children("input[name='cbRowData']").removeAttr("checked");
		} else {
			tr.addClass("table-row-selected");
			tr.children().addClass("table-row-selected");
			// fixed: http://stackoverflow.com/questions/426258/checking-a-checkbox-with-jquery
			tr.children("td:eq(0)").children("input[name='cbRowData']").attr("checked", "checked").attr('checked', true).prop('checked', true);
		}
	}
	// 行数据状态同步全选复选框状态
	function syncCheckAllStatus() {
		var cc = 0; // checked counts
		var ucc = 0; // unchecked counts
		var pageRowCnt=$("#contentTable tbody tr").length;
		$("#contentTable tbody tr").each(function(i){
			var tr = $(this);
			if (tr.hasClass("table-row-selected")) {
				cc++;
			} else {
				ucc++;
			}
		});
		
		if(pageRowCnt==cc&&!$("#checkall").attr("checked")){
			$("#checkall").attr("checked", "checked").parent().attr("title", "全不选");;
		}
		if(pageRowCnt==ucc&&$("#checkall").attr("checked")){
			$("#checkall").removeAttr("checked").parent().attr("title", "全选");;
		}
		if(cc>0){
			$("#btnDeleteChecked").removeAttr("disabled").attr('value', '删除('+cc+')');
			$("#btnCopyChecked").removeAttr("disabled").attr('value', '复制('+cc+')');
		}else{
			$("#btnDeleteChecked").attr("disabled", true).attr('value', '删除');
			$("#btnCopyChecked").attr("disabled", true).attr('value', '复制');
		}
	}
	// 【行数据复选框操作动作集合 END】
});

// 【autocomplete action start】
function inputFocus(i){
    if(i.value==i.defaultValue){ i.value=""; i.style.color="#000"; }
}
function inputBlur(i){
    if(i.value==""){ i.value=i.defaultValue; i.style.color="#848484"; }
}
// 【autocomplete action end】

/*
 * 行删除
 * url: 处理响应地址，需带id
 */
function rowDelete(url){
	var physicalDelete = "";
	if($("#physicalDelete").attr("checked")){
		physicalDelete = " <span class='text-warning'>[注：物理删除]</span>";
	}
	top.$.jBox.confirm("确认要删除本条数据吗？"+physicalDelete,"系统提示",function(v,h,f){
		if(v=="ok"){
			
			// 提交表单
			$("#gridForm").attr("action", url).submit();
			// 初始化提示
			top.$.jBox.tip.mess=false;
		}
	},{buttonsFocus:1});
	top.$('.jbox-body .jbox-icon').css('top','55px');
}

/*
 * 表物理清理
 * url: 处理响应地址
 */
function truncateTable(url){
	top.$.jBox.confirm("确认要清理<span class='text-warning'>(物理删除)</span>所有数据?" ,"系统提示",function(v,h,f){
		if(v=="ok"){
			
			// 提交表单
			$("#gridForm").attr("action", url).submit();
			// 初始化提示
			top.$.jBox.tip.mess=false;
		}
	},{buttonsFocus:1});
	top.$('.jbox-body .jbox-icon').css('top','55px');
}

/*
 * 数据批量处理
 * url: 处理响应地址
 * msg: 提示关键字
 */
$.extend({
	batPro:function(url, msg){

		// 初始化选中的行数据集合字符串
		var cbRowDataIds = "";
		$("#cbRowDataIdsBox").empty();
		
		$("#contentTable tbody tr").each(function(i){
			// 遍历选中的行数据集合
			if ($(this).children("td:eq(0)").children("input[name='cbRowData']").attr("checked")) {
				cbRowDataIds+=this.id+",";
				
				// render cbRowDataIds for modelAttribute mapping dataentity
				var cbRowDataIdsDom = $("<input name='cbRowDataIds' type='hidden' />");
				cbRowDataIdsDom.attr("value", this.id);
				$("#cbRowDataIdsBox").append(cbRowDataIdsDom);
				
			}
		});
		
		if(cbRowDataIds==""){
			top.$.jBox.info("请至少选中一条数据进行" + msg + "。", "操作提示");
			return;
		}
				
		top.$.jBox.confirm("确认要批量" + msg + "所选数据吗？如果数据过大，可能需要一些时间。","系统提示",function(v,h,f){
			if(v=="ok"){
				
				// 提交表单
				$("#gridForm").attr("action", url).submit();
				// 初始化提示
				top.$.jBox.tip.mess=false;
			}
		},{buttonsFocus:1});
		top.$('.jbox-body .jbox-icon').css('top','55px');
	}
});