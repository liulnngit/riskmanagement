<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<%@ include file="../commons/sourceFile.jsp"%>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>模型管理</h5>
                    </div>
					<div class="ibox-content">
					<div class="panel admin-panel">
						<div class="btn-group" id="toolbar">
							<shiro:hasRole name="Administrator">
								<button type="button" class="btn btn-primary margin-items-top"
									id="addBtn">新增模型</button>
								<button type="button" class="btn btn-primary margin-items-top"
									id="editBtn">修改模型</button>
								<button type="button" class="btn btn-primary margin-items-top"
									id="deleteBtn">删除模型</button>
							</shiro:hasRole>
							<button type="button" class="btn btn-primary margin-items-top"
								id="searchBtn">查询模型</button>
						</div>
						<div class="body-content">
							<table id="tb_listAnalyzeModel"></table>
							<input type="hidden" id="jsonParam" name="jsonParam"> <input
								type="hidden" id="errorMessage" name="errorMessage"
								value="${message}">
						</div>
					</div>
					</div>
					<br>
					<br>
					<br>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	$(function() {

		//1.初始化Table
		var oTable = new TableInit();
		oTable.Init();

		$('#tb_listAnalyzeModel').bootstrapTable('hideColumn', 'id');//隐藏某一列

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_listAnalyzeModel')
					.bootstrapTable(
							{
								url : '${pageContext.request.contextPath }/getListAnalyzeModel', //请求后台的URL（*）
								method : 'get', //请求方式（*）
								toolbar : '#toolbar', //工具按钮用哪个容器
								striped : true, //是否显示行间隔色
								cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
								pagination : true, //是否显示分页（*）
								sortable : false, //是否启用排序
								//sortOrder : "asc", //排序方式
								sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
								pageNumber : 1, //初始化加载第一页，默认第一页
								pageSize : 10, //每页的记录行数（*）
								pageList : [ 10, 25, 50, 100 ], //可供选择的每页的行数（*）
								//search : true, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
								//strictSearch : true,
								//showColumns : true, //是否显示所有的列
								//showRefresh : true, //是否显示刷新按钮
								minimumCountColumns : 2, //最少允许的列数
								clickToSelect : true, //是否启用点击选中行
								smartDisplay : false,//智能显示分页按钮
								escape : true,
								paginationPreText : "上一页",
								paginationNextText : "下一页",
								//height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
								uniqueId : "id", //每一行的唯一标识，一般为主键列
								//showToggle : true, //是否显示详细视图和列表视图的切换按钮
								//cardView : false, //是否显示详细视图
								//detailView : false, //是否显示父子表
								singleSelect : true, //禁止多选
								undefinedText : "",
								columns : [
										{
											checkbox : true,
											align : 'center'
										},
										{
											field : 'id',
											title : '分析模型ID',
											align : 'center'
										},
										{
											field : 'modelName',
											title : '分析模型名称',
											align : 'center',
											formatter : function(value, row,
													index) {
												var e = '<a href="./showAnalyzeModelParam?id='
														+ row.id
														+ '">'
														+ value
														+ '</a> ';
												return e;
											}
										},
										{
											field : 'modelCode',
											title : '分析模型编码',
											align : 'center'
										},
										{
											field : 'classFullPath',
											title : '实现类名',
											align : 'center'
										},
										{
											field : 'remark',
											title : '说明',
											align : 'center',
											cellStyle : formatTableUnit,
											formatter : operateOpinionFormatter
										}, {
											field : 'creator',
											title : '创建人',
											align : 'center'
										}, {
											field : 'createDate',
											title : '创建时间',
											align : 'center'
										}, {
											field : 'updater',
											title : '更新人',
											align : 'center'
										}, {
											field : 'updateDate',
											title : '更新时间',
											align : 'center'
										}, {
											field : 'status',
											title : '状态',
											align : 'center'
										} ],
								queryParams : oTableInit.queryParams,
								onLoadSuccess : function() { //加载成功时执行  
									var em = $("#errorMessage").val();
									if (null != em && "" != em) {
										layer.msg(em, {
											time : 1500,
											icon : 2
										});
									}
								}
							//传递参数（*）
							});
		};

		//得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
				jsonParam : $("#jsonParam").val()
			};
			return temp;
		};
		return oTableInit;
	};

	var ButtonInit = function() {
		var oInit = new Object();
		var postdata = {};

		oInit.Init = function() {
			//初始化页面上面的按钮事件
		};

		return oInit;
	};

	function searchByFilter(jsonParam) {
		$("#jsonParam").val(jsonParam);
		$('#tb_listAnalyzeModel').bootstrapTable('destroy');
		var oTable = new TableInit();
		oTable.Init();
		$('#tb_listAnalyzeModel').bootstrapTable('hideColumn', 'id');//隐藏某一列
	};
	
	function operateOpinionFormatter(value, row, index) {
		if (value !== null && value !== '' && value !== 'undefined') {
			if (value.length > 10) {
				return "<span style='cursor:pointer' title='"+value+"'>"
						+ value.substring(0, 10) + "..." + "</span>";
			} else {
				return "<span title='"+value+"'>"
						+ value.substring(0, value.length) + "</span>";
			}
		} else {
			return "<span title='"+value+"'>"
			+ "" + "</span>";
		}
	};

	//悬浮
	function formatTableUnit(value, row, index) {
		//  var front_color = 'red';
		//  var bg_color = 'white';
		return {
			css : {
				//	          "color":'red',
				//	          "background-color": bg_color,
				"overflow" : 'hidden',
				"text-overflow" : 'ellipsis',
				"white-space" : 'nowrap'
			}
		}
	};
</script>

<script type="text/javascript">
	$(function() {
		//编辑规则
		$("#editBtn")
				.click(
						function() {
							var selectRow = $("#tb_listAnalyzeModel")
									.bootstrapTable('getSelections');
							if (selectRow.length != 1) {
								layer.alert('请选择一条数据进行操作！', {
									skin : 'layui-layer-molv',
									icon : 5,
									closeBtn : 0,
									btnAlign : 'c', //按钮居中
									anim : 0, //动画类型
									time : 2000
								});
								return false;
							} else {
								window.location.href = "${pageContext.request.contextPath}/showAnalyzeModel?id="
										+ selectRow[0].id;
							}
						});
		$("#addBtn")
				.click(
						function() {
							window.location.href = "${pageContext.request.contextPath }/addAnalyzeModel";
						});
		$("#deleteBtn")
				.click(
						function() {
							//获取选中的行
							var selectRow = $("#tb_listAnalyzeModel")
									.bootstrapTable('getSelections');
							if (selectRow.length != 1) {
								layer.alert('请选择一条数据进行操作！', {
									skin : 'layui-layer-molv',
									icon : 5,
									closeBtn : 0,
									btnAlign : 'c', //按钮居中
									anim : 0, //动画类型
									time : 2000
								});
								return false;
							} else {
								layer
										.confirm(
												"您确定要删除这" + selectRow.length
														+ "条数据吗？",
												{
													icon : 3,
													closeBtn : 0,
													btnAlign : 'c', //按钮居中
													title : '提示'
												},
												function() {
													$
															.ajax({
																url : "${pageContext.request.contextPath}/deleteAnalyzeModel?id="
																		+ selectRow[0].id,
																type : "get",
																async : true,
																cache : false,
																success : function(
																		data) {
																	if ("success" == data.status) {
																		layer
																				.alert(
																						"删除成功！",
																						{
																							skin : 'layui-layer-molv',
																							icon : 1,
																							btnAlign : 'c', //按钮居中
																							closeBtn : 0,
																							anim : 0, //动画类型
																							time : 2000
																						});
																		$(
																				"#tb_listAnalyzeModel")
																				.bootstrapTable(
																						'refresh',
																						{
																							index : selectRow[0].id
																						});
																	} else {
																		layer
																				.alert(
																						"删除失败！",
																						{
																							skin : 'layui-layer-molv',
																							icon : 5,
																							btnAlign : 'c', //按钮居中
																							closeBtn : 0,
																							anim : 0, //动画类型
																							time : 2000
																						});
																	}

																}
															});
												});
							}
						});

		$("#searchBtn")
				.click(
						function() {
							var jsonParam = $("#jsonParam").val();
							jsonParam = jsonParam.replace(/"/g, "'");
							var pageUrl = "${pageContext.request.contextPath }/toSearchAnalyzeModelPage?jsonParam="
									+ jsonParam;
							var diag = new Dialog();
							diag.Width = 900;
							diag.Height = 500;
							diag.Title = "请输入查询条件";
							diag.Drag = false;
							diag.URL = pageUrl;
							diag.show();
						});

	});
</script>
</html>