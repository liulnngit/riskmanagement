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
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/My97DatePicker/lang/zh-cn.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/My97DatePicker/calendar.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery.serializejson.js"></script>
<style type="text/css">
td {
	width: 100px;
	height: 20px;
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
}
</style>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>我的待办件</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="btn-group" id="toolbar">
								<!-- <button type="button" class="btn btn-primary margin-items-top"
									id="showDetailBtn">详情</button>
								<button type="button" class="btn disabled" id="addBtn">处理</button> -->
								<div class="btn-group">
									<button id="searchBtn" type="button" class="btn btn-primary"
										data-toggle="modal" data-target="#searchModal">查询</button>
								</div>
								<!-- <button type="button" class="btn disabled" id="changeStatusBtn">查询</button> -->
								<div class="modal fade" id="searchModal" tabindex="-1"
									role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h4 class="modal-title" id="myModalLabel">查询待办件</h4>
											</div>
											<div class="modal-body">
												<form id="searchForm">
													
													<div
														style="margin-top: 10px; margin-botton: 10px; margin-right: 50px;">
														<div class="input-group">
															<span class="input-group-addon">开始日期:</span> <input
																type="text"
																onFocus="var endTime=$dp.$('endTime');WdatePicker({onpicked:function(){endTime.focus();},dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endTime\')||\'%y-%M-%d-%H:%m:%s\'}',minDate:'#F{$dp.$D(\'endTime\',{M:-6})}'})"
																class="Wdate form-control" name="startTime"
																id="startTime"
																style="height: 34px; border: 1px solid #cccccc;">
														</div>
													</div>
													<div
														style="margin-top: 10px; margin-botton: 10px; margin-right: 50px;">
														<div class="input-group">
															<span class="input-group-addon">结束日期:</span> <input
																type="text"
																onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'#F{$dp.$D(\'startTime\',{M:6})||\'%y-%M-%d-%H:%m:%s\'}'})"
																class="Wdate form-control" name="endTime" id="endTime"
																style="height: 34px; border: 1px solid #cccccc;">
														</div>
													</div>
												</form>
											</div>
											<div class="modal-footer">
												<button id="submitBtn" type="button" class="btn btn-primary">查询</button>
												<button id="clearBtn" type="button" class="btn btn-primary">清空</button>
												<button type="button" class="btn btn-primary"
													data-dismiss="modal">关闭</button>
												<span id="tip"> </span>
											</div>
										</div>
										<!-- /.modal-content -->
									</div>
									<!-- /.modal -->
								</div>
							</div>
							<div class="body-content">
								<table id="tb_mylistToDoTask" ></table>
								<input type="hidden" id="startDate" name="startDate" value="" />
								<input type="hidden" id="endDate" name="endDate" value="" />
							</div>
						</div>
					</div>
                    <div class="modal fade" id="myModal" tabindex="-1"
                         role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    </div>
                        <div class="modal fade" id="myModalOrder" tabindex="-1"
                             role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                            <!-- /.modal -->
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

		$('#tb_mylistToDoTask').bootstrapTable('hideColumn', 'id');//隐藏某一列

		//2.初始化Button的点击事件
		/* var oButtonInit = new ButtonInit();
		oButtonInit.Init(); */

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_mylistToDoTask').bootstrapTable(
							{	
								url : '${pageContext.request.contextPath }/getListToDoTask', //请求后台的URL（*）
								method : 'get', //请求方式（*）
								toolbar : '#toolbar', //工具按钮用哪个容器
								striped : true, //是否显示行间隔色
								cache : true, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
								pagination : true, //是否显示分页（*）
								sortable : false, //是否启用排序
								//sortOrder : "asc", //排序方式
								sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
								pageNumber : 1, //初始化加载第一页，默认第一页
								pageSize : 10, //每页的记录行数（*）
								pageList : [ 10, 25, 50, 100 ], //可供选择的每页的行数（*）
								//search : true, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
								strictSearch : false,//设置为 true启用 全匹配搜索，否则为模糊搜索
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
											title : '流程ID',
											align : 'center'
										},
										{
											field : 'flowName',
											title : '流程名称',
											align : 'center'
										},
										{
											field : 'flowtype',
											title : '流程类型',
											align : 'center'
										},
										{
											field : 'workflowtitle',
											title : '流程标题',
											align : 'center'
										},
										{
											field : 'createDate',
											title : '发生时间',
											align : 'center'
										},
										{
											field : 'hiAssignee',
											title : '上一处理人',
											align : 'center'
										},
										{
											field : 'formatterRiskLevel',
											title : '风险级别',
											align : 'center'
										},
										{
											field : 'systemCode',
											title : '操作',
											align : 'center',
											formatter : function(value, row,
													index) {
												var e = '';
												if (null == row.assignee) {
													/* e = '<a href="${pageContext.request.contextPath }/cliantTask?taskId='
															+ row.id
															+ '" class="btn btn-primary margin-items-top">任务签收</a>'; */
													e = '<button id="cliantBtn" onclick="cliantTask(\''
															+ row.id
															+ '\')" class="btn-primary">签收</button>';
												} else {
													e = '<button href="#" class="btn-primary" onclick="completeTask(\''
															+ row.id
															+ '\',\''
															+ row.flowName
															+ '\')">办理</button>';
												}
												var detail = '<button href="#" class="btn-primary" onclick="showDetail(\''
													+ row.id
													+ '\',\''
													+ row.flowName
													+ '\')">详情</button>';
												return e + detail;
											}
										} ],
								queryParams : oTableInit.queryParams
							//传递参数（*）
							});
		};
		
		//得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
				startDate : $("#startDate").val(),
				endDate : $("#endDate").val()
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
	
	$("#submitBtn").click(function() {
		var startDate = $('#startTime').val();
		var endDate = $('#endTime').val();
		$("#startDate").val(startDate);
		$("#endDate").val(endDate);
		$('#tb_mylistToDoTask').bootstrapTable('destroy');
		var oTable = new TableInit();
		oTable.Init();
		$('#tb_mylistToDoTask').bootstrapTable('hideColumn', 'id');//隐藏某一列
		$('#searchModal').modal('hide');
	});

	//回车键事件
	document.onkeydown = function(e) {
		var ev = document.all ? window.event : e;
		if (ev.keyCode == 13) {
			var startDate = $('#startTime').val();
			var endDate = $('#endTime').val();
			$("#startDate").val(startDate);
			$("#endDate").val(endDate);
			$('#tb_mylistToDoTask').bootstrapTable('destroy');
			var oTable = new TableInit();
			oTable.Init();
			$('#tb_mylistToDoTask').bootstrapTable('hideColumn', 'id');//隐藏某一列
			$('#searchModal').modal('hide');
		}
	}
	
	
	function completeTask(id, flowName) {
		//alert(flowName);
		if ('风险事件流程处理' == flowName) {
			window.location.href = "${pageContext.request.contextPath }/toCompleteRiskEventTask?taskId="
					+ id;
		} else if ("投诉流程处理" == flowName) {
			window.location.href = "${pageContext.request.contextPath }/toCompleteTask?taskId="
					+ id;
		} else if ("关注名单解除流程" == flowName) {
			window.location.href = "${pageContext.request.contextPath }/toCompleteAttentionDelTask?taskId="
					+ id;
		} else if ("关注级别修改流程" == flowName) {
			window.location.href = "${pageContext.request.contextPath }/toCompleteAttentionLevelTask?taskId="
					+ id;
		}
	}
	
	//查看详情
	function showDetail(id,flowName) {
		if ('风险事件流程处理' == flowName) {
			/*var pageUrl = "showRiskEventDetail?taskId="
					+ id;
			var diag = new Dialog();
			diag.Width = 700;
			diag.Height = 650;
			diag.Title = "风险事件详情";
			diag.URL = pageUrl;
			diag.Drag = false;
			diag.show();*/
            $("#myModal").modal({
                remote: "showRiskEventDetail?taskId=" + id
            });
		} else if ('关注名单解除流程' == flowName) {
			/*var pageUrl = "showAttentionDetail?taskId="
					+ id;
			var diag = new Dialog();
			diag.Width = 700;
			diag.Height = 650;
			diag.Title = "关注名单详情";
			diag.URL = pageUrl;
			diag.Drag = false;
			diag.show();*/
            $("#myModal").modal({
                remote: "showAttentionDetail?taskId=" + id
            });
		} else if ('关注级别修改流程' == flowName) {
			/*var pageUrl = "showAttentionDetail?taskId="
					+ id;
			var diag = new Dialog();
			diag.Width = 700;
			diag.Height = 650;
			diag.Title = "关注名单详情";
			diag.URL = pageUrl;
			diag.Drag = false;
			diag.show();*/
            $("#myModal").modal({
                remote: "showAttentionDetail?taskId=" + id
            });
		} else if ('投诉流程处理' == flowName) {
			/*var pageUrl = "showComplaintHandlingDetail?taskId="
				+ id;
		var diag = new Dialog();
		diag.Width = 700;
		diag.Height = 650;
		diag.Title = "投诉详情";
		diag.URL = pageUrl;
		diag.Drag = false;
		diag.show();*/
            $("#myModal").modal({
                remote: "showComplaintHandlingDetail?taskId=" + id
            });
        }

        //查看投诉详情
        $("#myModal").on("hidden.bs.modal", function() {
            $(this).removeData("bs.modal");
        });
        $('#myModalOrder').on('show.bs.modal', function () {
            $('#myModal').modal('hide')
        })
        $('#myModalOrder').on('hide.bs.modal', function () {
            $(this).removeData("bs.modal");
        })
        $("#hideModel").click(function(){
            $(this).removeData("bs.modal");
        });
	}
</script>

<script type="text/javascript">
	function cliantTask(id) {
		var selectRow = $("#tb_mylistToDoTask").bootstrapTable('getSelections');
		$
				.ajax({
					url : "${pageContext.request.contextPath }/cliantTask?taskId="
							+ id,
					type : "get",
					dataType : "json",
					success : function(data) {
						if ('success' == data.status) {
							layer.alert('任务签收成功！', {
								skin : 'layui-layer-molv',
								icon : 1,
								closeBtn : 0,
								btnAlign : 'c', //按钮居中
								anim : 0, //动画类型
								time : 2000,
								end : function() {
									$("#tb_mylistToDoTask").bootstrapTable(
											'refresh', {
												index : id
											});
								}
							});
							return false;
						} else if ('fail' == data.status) {
							layer.alert('任务签收失败！', {
								skin : 'layui-layer-molv',
								icon : 1,
								closeBtn : 0,
								btnAlign : 'c', //按钮居中
								anim : 0, //动画类型
								time : 2000,
								end : function() {
									$("#tb_mylistToDoTask").bootstrapTable(
											'refresh', {
												index : id
											});
								}
							});
						}
					}
				});
	};
</script>

<script type="text/javascript">
	$(function() {
		$("#batchProcessBtn")
				.click(
						function() {
							var selectRow = $("#tb_mylistToDoTask")
									.bootstrapTable("getSelections");
							if (selectRow.length == 0) {
								layer.alert('请至少选择一条数据进行操作！', {
									skin : 'layui-layer-molv',
									icon : 5,
									closeBtn : 0,
									btnAlign : 'c', //按钮居中
									anim : 0, //动画类型
									time : 2000
								});
								return false;
							} else {
								var rcEventArr = [];
								var attentionArr = [];
								var flowName = '';
								for (var i = 0; i < selectRow.length; i++) {
									flowName = selectRow[i].flowName;
									if ('风险事件流程处理' == flowName) {
										rcEventArr.push(selectRow[i].id);
									} else if ("关注名单解除流程" == flowName) {
										attentionArr.push(selectRow[i].id);
									}
								}
								var rcEventTaskIds = rcEventArr.join(",");
								var attentionTaskIds = attentionArr.join(",");
								$
										.ajax({
											url : "batchProcessTask",
											type : "post",
											data : {
												"rcEventTaskIds" : rcEventTaskIds,
												"attentionTaskIds" : attentionTaskIds
											},
											dataType : "json",
											success : function(data) {
												if (data) {
													if ("success" == data.status) {
														layer
																.alert(
																		"处理成功！",
																		{
																			skin : 'layui-layer-molv',
																			icon : 1,
																			btnAlign : 'c', //按钮居中
																			closeBtn : 0,
																			anim : 0, //动画类型
																			time : 2000,
																			end : function() {
																				window.location.href = "mytodolist";
																			}
																		});
													} else {
														if ("success" == data.status) {
															layer
																	.alert(
																			"处理失败！",
																			{
																				skin : 'layui-layer-molv',
																				icon : 1,
																				btnAlign : 'c', //按钮居中
																				closeBtn : 0,
																				anim : 0, //动画类型
																				time : 2000,
																				end : function() {
																					window.location.href = "mytodolist";
																				}
																			});
														}
													}
												}
											},
											error : function() {
												layer.alert('网络异常，请求失败！', {
													skin : 'layui-layer-molv',
													icon : 5,
													closeBtn : 0,
													btnAlign : 'c', //按钮居中
													anim : 0, //动画类型
													time : 2000
												});
											}
										});
							}
						})
	});
</script>
<script type="text/javascript">
	$(function() {
		$("#clearBtn").click(function() {
			$("#startTime").val('');
			$("#endTime").val('');
		});

        //查看投诉详情
        $("#myModal").on("hidden.bs.modal", function() {
            $(this).removeData("bs.modal");
        });
        $('#myModalOrder').on('show.bs.modal', function () {
            $('#myModal').modal('hide')
        })
        $('#myModalOrder').on('hide.bs.modal', function () {
            $(this).removeData("bs.modal");
        })
        $("#hideModel").click(function(){
            $(this).removeData("bs.modal");
        });
	});
</script>
</html>