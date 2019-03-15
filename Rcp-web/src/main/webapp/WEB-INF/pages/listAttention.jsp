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
	src="${pageContext.request.contextPath }/js/jquery.serializejson.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>关注名单管理</h5>
					</div>
					<div class="ibox-content">

						<div class="panel admin-panel">
							<div class="btn-group" id="toolbar">
								<div class="btn-group">
									<button type="button" class="btn btn-primary" id="addBtn">新增</button>
								</div>
								<!-- <div class="btn-group">
									<button type="button" class="btn btn-primary" id="editBtn">编辑</button>
								</div> -->
								<div class="btn-group">
									<button type="button" class="btn btn-primary" id="searchBtn"
										data-toggle="modal" data-target="#searchModal">查询</button>
								</div>
								<!-- <div class="btn-group">
									<button type="button" class="btn btn-primary"
										id="showDetailtBtn">关注明细</button>
								</div> -->
								<!-- <div class="btn-group">
									<button type="button" class="btn btn-primary" id="relieveBtn">解除名单</button>
								</div> -->
								<!-- <div class="btn-group">
									<button type="button" class="btn btn-primary"
										id="changeLevelBtn">设置级别</button>
								</div> -->
								<!-- <div class="btn-group">
									<button type="button" class="btn btn-primary" id="selectTran">查看交易</button>
								</div>
								<div class="btn-group">
									<button type="button" class="btn btn-primary" id="selectEvent">查看事件</button>
								</div> -->
								<div class="btn-group">
									<button type="button" class="btn btn-primary"
										data-toggle="modal" data-target="#uploadModal">批量导入</button>
								</div>
								<div class="btn-group">
									<button type="button" class="btn btn-primary dropdown-toggle"
										data-toggle="dropdown">
										关注级别 <span class="caret"></span>
									</button>
									<ul class="dropdown-menu" role="menu">
										<li><a href="#" id="high">高</a></li>
										<li><a href="#" id="mid">中</a></li>
										<li><a href="#" id="low">低</a></li>
									</ul>
								</div>
							</div>
							<div class="body-content">

								<table id="tb_attention"></table>
								<input type="hidden" id="jsonParam" name="jsonParam" value="" />

								<input id="attentionLevel" type="hidden">
							</div>
						</div>

						<!-- 模态框示例（Modal） -->
						<div class="modal fade" id="uploadModal" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h4 class="modal-title" id="myModalLabel">导入数据</h4>
									</div>
									<div class="modal-body">
										<form id="uploadFileForm" enctype="multipart/form-data">
											<div id="file_css" style="width: 86%">
												<input type="text" value="未选择文件" id="showText"
													style="width: 90%" /><input type="button" value="浏览"
													style="width: 9%" /><input id="file" type="file"
													name="excel">
											</div>

											<div style="margin-top: 20px;">
												<input type="reset" class="btn btn-primary" /> <input
													type="button" onclick="downloadFile()"
													class="btn btn-primary" value="模板下载" />
											</div>
										</form>
									</div>
									<div class="modal-footer">
										<button id="uploadBtn" type="button" class="btn btn-primary">上传</button>
										<button type="button" class="btn btn-primary"
											data-dismiss="modal">关闭</button>
										<span id="tip"> </span>
									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal -->
						</div>

						<!-- 模态框示例（Modal） -->
						<div class="modal fade" id="roleModal" tabindex="-1" role="dialog"
							aria-labelledby="attentionDelModal" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h1 class="modal-title" id="attentionDelModal">解除关注名单</h1>
									</div>
									<div class="modal-body">
										<form id="deleteAttentionForm" method="post">
											<div
												style="width: 60%; margin-top: 10px; margin-botton: 10px;">
												<div class="input-group">
													<span class="input-group-addon">办理角色</span> <select
														id="groupArr" name="groupArr" class="form-control">
														<!-- <option value="">-----请选择角色-----</option> -->
													</select> <input id="id" name="id" type="hidden">
												</div>
											</div>
										</form>
									</div>
									<div class="modal-footer">
										<button id="delSubmitBtn" type="button"
											class="btn btn-primary">确定</button>
										<button type="button" class="btn btn-primary"
											data-dismiss="modal">关闭</button>
										<span id="tip"> </span>
									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal -->
						</div>

						<!-- 模态框示例（Modal） -->
						<div class="modal fade" id="changeLevelModal" tabindex="-1"
							role="dialog" aria-labelledby="levelModal" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h1 class="modal-title" id="levelModal">修改关注级别</h1>
									</div>
									<div class="modal-body">
										<form id="changeLevelForm" method="post">
											<div
												style="width: 60%; margin-top: 10px; margin-botton: 10px;">
												<input id="changeLevelId" name="changeLevelId" type="hidden">
												<input id="currentLevel" type="hidden">
												<div class="input-group">
													<span class="input-group-addon">关注级别</span> <select
														id="changeLevel" name="changeLevel" class="form-control">
														<!-- <option value="">-----请选择角色-----</option> -->
														<option value="0">高</option>
														<option value="1">中</option>
														<option value="2">低</option>
													</select>
												</div>
												<div class="input-group">
													<span class="input-group-addon">办理角色</span> <select
														id="group" name="group" class="form-control">
														<!-- <option value="">-----请选择角色-----</option> -->
													</select>
												</div>
											</div>
										</form>
									</div>
									<div class="modal-footer">
										<button id="levelSubmitBtn" type="button"
											class="btn btn-primary">确定</button>
										<button type="button" class="btn btn-primary"
											data-dismiss="modal">关闭</button>
										<span id="tip"> </span>
									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal -->
						</div>

						<!-- 查询模态框（Modal） -->
						<div class="modal fade" id="searchModal" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h4 class="modal-title" id="myModalLabel">查询关注名单</h4>
									</div>
									<div class="modal-body">
										<form id="searchForm">
											<div
												style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
												<div class="input-group">
													<span class="input-group-addon">商家号:</span> <input
														id="merchantId" name="merchantId" type="text"
														class="form-control" placeholder="请输入查询内容" />
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

						<div class="modal fade" id="myModal" tabindex="-1"
							 role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

							<!-- /.modal -->
						</div>


					</div>

					<br> <br> <br>
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

		$('#tb_attention').bootstrapTable('hideColumn', 'id');//隐藏某一列

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_attention')
					.bootstrapTable(
							{
								url : '${pageContext.request.contextPath }/listAttentionType', //请求后台的URL（*）
								method : 'POST', //请求方式（*）
								toolbar : '#toolbar', //工具按钮用哪个容器
								contentType : 'application/x-www-form-urlencoded',
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
											title : 'ID',
											align : 'center'
										},
										{
											field : 'merchantId',
											title : '商家号',
											align : 'center',
											formatter : function(value, row, index) {
												var detail = '<a href="${pageContext.request.contextPath }/showAttentionDetail?id=' + row.id + '"data-toggle="modal"  data-target="#myModal"><strong><u>' + value + '</strong></u></a>';
												return detail;
											}
										},
										{
											field : 'address',
											title : '商家地址',
											align : 'center',
											cellStyle : formatTableUnit,
											formatter : operateOpinionFormatter
										},
										{
											field : 'merchantUrl',
											title : '商家域名',
											align : 'center',
											cellStyle : formatTableUnit,
											formatter : operateOpinionFormatter
										},
										{
											field : 'attentionLevel',
											title : '关注级别',
											align : 'center'
										},
										{
											field : 'createName',
											title : '创建人',
											align : 'center'
										},
										{
											field : 'startDate',
											title : '关注起始时间',
											align : 'center'
										},
										{
											field : 'endDate',
											title : '关注结束时间',
											align : 'center'
										},
										/* {
											field : 'attentionMsg',
											title : '关注原因',
											align : 'center',
											cellStyle : formatTableUnit,
											formatter : operateOpinionFormatter
										}, */
										{
											field : 'status',
											title : '状态',
											align : 'center'
										},
										{
											field : 'alarm',
											title : '已发警报',
											align : 'center'
										},
										{
											field : 'count',
											title : '关注次数',
											align : 'center',
											formatter : function(value, row,
													index) {
												var e = '<a href="searchHistoryByMerchantId?merchantId='
														+ row.merchantId
														+ '"><strong><u>'
														+ value + '</strong></u></a> ';
												return e;
											}
										},
										{
											field : '',
											title : '操作',
											align : 'center',
											formatter : function(value, row, index) {
												var e = '<button href="#" class="btn-primary"  onclick="edit(\''+ row.id + '\')">编辑</button>';
												var d = '<button href="#" class="btn-primary"  onclick="relieve(\''+ row.id + '\')">解除</button>';
												var c = '<button href="#" class="btn-primary"  onclick="changeLevelFn(\''+ row.id + '\',\'' + row.attentionLevel + '\')">级别</button>';
												if ('解除中' == row.status || '修改中' == row.status) {
													e = '<button href="#" class="btn-default"  disabled="disabled">编辑</button>';
													d = '<button href="#" class="btn-default"  disabled="disabled">解除</button>';
													c = '<button href="#" class="btn-default"  disabled="disabled">级别</button>';
												}
												var t = '<button href="#" class="btn-primary"  onclick="selectTran(\''+ row.merchantId + '\')">交易</button>';
												var r = '<button href="#" class="btn-primary"  onclick="selectRiskEvent(\''+ row.merchantId + '\')">事件</button>';
												return e + d + c + t + r;
											}
										}],
								queryParams : oTableInit.queryParams
							//传递参数（*）
							});
		};

		//得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
				attetionLevel : $("#attentionLevel").val(),
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

	$("#submitBtn").click(function() {
		var obj = $('#searchForm').serializeJSON();
		var jsonString = JSON.stringify(obj);
		$("#jsonParam").val(jsonString);
		$('#tb_attention').bootstrapTable('destroy');
		var oTable = new TableInit();
		oTable.Init();
		$('#tb_attention').bootstrapTable('hideColumn', 'id');//隐藏某一列
		$('#searchModal').modal('hide');
	});

	//回车键事件
	document.onkeydown = function(e) {
		var ev = document.all ? window.event : e;
		if (ev.keyCode == 13) {
			var obj = $('#searchForm').serializeJSON();
			var jsonString = JSON.stringify(obj);
			$("#jsonParam").val(jsonString);
			$('#tb_attention').bootstrapTable('destroy');
			var oTable = new TableInit();
			oTable.Init();
			$('#tb_attention').bootstrapTable('hideColumn', 'id');//隐藏某一列
			$('#searchModal').modal('hide');
		}
	}

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
			return "<span title='"+value+"'>" + "" + "</span>";
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
		$("#high").click(function() {
			$("#attentionLevel").val('0');
			$('#tb_attention').bootstrapTable('destroy');
			var oTable = new TableInit();
			oTable.Init();
			$('#tb_attention').bootstrapTable('hideColumn', 'id');//隐藏某一列
		})
		$("#mid").click(function() {
			$("#attentionLevel").val('1');
			$('#tb_attention').bootstrapTable('destroy');
			var oTable = new TableInit();
			oTable.Init();
			$('#tb_attention').bootstrapTable('hideColumn', 'id');//隐藏某一列
		})
		$("#low").click(function() {
			$("#attentionLevel").val('2');
			$('#tb_attention').bootstrapTable('destroy');
			var oTable = new TableInit();
			oTable.Init();
			$('#tb_attention').bootstrapTable('hideColumn', 'id');//隐藏某一列
		})
	});
</script>

<script type="text/javascript">
	//查询详情
	/*function showDetailFn(id) {
		var pageUrl = "${pageContext.request.contextPath }/showAttentionDetail?id=" + id;
		var diag = new Dialog();
		diag.Width = 800;
		diag.Height = 500;
		diag.Title = "关注详情";
		diag.URL = pageUrl;
		diag.Drag = false;
		diag.show();
	}*/

    $("#myModal").on("hidden.bs.modal", function() {
        $(this).removeData("bs.modal");
    });

    $("#hideModel").click(function(){
        $(this).removeData("bs.modal");
    });


	//编辑
	function edit(id) {
		window.location.href = "${pageContext.request.contextPath }/toEditAttentionLibrary?id=" + id;
	}
	
	//解除关注
	function relieve(id) {
		layer
		.confirm(
				"您确定要解除这条关注名单数据吗？",
				{
					icon : 3,
					closeBtn : 0,
					btnAlign : 'c', //按钮居中
					title : '提示'
				},
				function(index) {
					$
							.ajax({
								url : "${pageContext.request.contextPath}/checkAttention?id=" + id,
								type : "get",
								async : true,
								cache : false,
								success : function(
										data) {
									if (data) {
										if ('success' == data.status) {
											$("#id")
													.val(id);
											layer
													.close(index);
											$(
													'#roleModal')
													.modal(
															'show');
										} else if ('deleteError' == data.isDelete) {
											layer
													.alert(
															'该关注名单已是经解除状态！',
															{
																skin : 'layui-layer-molv',
																icon : 5,
																closeBtn : 0,
																btnAlign : 'c', //按钮居中
																anim : 0, //动画类型
																time : 2000
															});
										} else if ('permissionsError' == data.permissionsError) {
											layer
													.alert(
															'抱歉！您没有解除关注名单的权限！',
															{
																skin : 'layui-layer-molv',
																icon : 5,
																closeBtn : 0,
																btnAlign : 'c', //按钮居中
																anim : 0, //动画类型
																time : 2000,
																end : function() {
																	$(
																			'#roleModal')
																			.modal(
																					'hide');
																}
															});
										} else if ('isChangeLevel' == data.status) {
											layer
													.alert(
															'该关注名单级别状态修改中！',
															{
																skin : 'layui-layer-molv',
																icon : 5,
																closeBtn : 0,
																btnAlign : 'c', //按钮居中
																anim : 0, //动画类型
																time : 2000,
																end : function() {
																	$(
																			'#roleModal')
																			.modal(
																					'hide');
																}
															});
										}
									}

								},
								error : function(
										data) {
									layer
											.alert(
													'网络异常！',
													{
														skin : 'layui-layer-molv',
														icon : 5,
														closeBtn : 0,
														btnAlign : 'c', //按钮居中
														anim : 0, //动画类型
														time : 2000,
														end : function() {
															$(
																	'#roleModal')
																	.modal(
																			'hide');
														}
													});
								}
							});
				});
	}
	
	//修改关注级别
	function changeLevelFn(id,attentionLevel) {
		//alert(id + "=====" + attentionLevel);
		$
		.ajax({
			url : "${pageContext.request.contextPath}/checkAttentionLevel?id=" + id,
			type : "get",
			async : true,
			cache : false,
			success : function(data) {
				if (data) {
					if ('success' == data.status) {
						$("#changeLevelId").val(id);
						$("#currentLevel").val(attentionLevel);
						$('#changeLevelModal')
								.modal('show');
					} else if ('isChangeLevel' == data.isChangeLevel) {
						layer
								.alert(
										'该关注名单级别状态修改中！',
										{
											skin : 'layui-layer-molv',
											icon : 5,
											closeBtn : 0,
											btnAlign : 'c', //按钮居中
											anim : 0, //动画类型
											time : 2000,
											end : function() {
												$(
														'#changeLevelModal')
														.modal(
																'hide');
											}
										});
					} else if ('permissionsError' == data.permissionsError) {
						layer
								.alert(
										'抱歉！您没有修改关注级别的权限！',
										{
											skin : 'layui-layer-molv',
											icon : 5,
											closeBtn : 0,
											btnAlign : 'c', //按钮居中
											anim : 0, //动画类型
											time : 2000,
											end : function() {
												$(
														'#changeLevelModal')
														.modal(
																'hide');
											}
										});
					} else if ('deleteError' == data.isDelete) {
						layer
								.alert(
										'该关注名单是解除状态！',
										{
											skin : 'layui-layer-molv',
											icon : 5,
											closeBtn : 0,
											btnAlign : 'c', //按钮居中
											anim : 0, //动画类型
											time : 2000,
											end : function() {
												$(
														'#changeLevelModal')
														.modal(
																'hide');
											}
										});
					}
				}
			},
			error : function(data) {
				layer.alert('网络异常！', {
					skin : 'layui-layer-molv',
					icon : 5,
					closeBtn : 0,
					btnAlign : 'c', //按钮居中
					anim : 0, //动画类型
					time : 2000,
					end : function() {
						$('#changeLevelModal')
								.modal('hide');
					}
				});
			}
		});
	}
	
	//查看交易
	function selectTran(merchantId) {
		window.location.href = "${pageContext.request.contextPath }/showTransactionData?merchantId=" + merchantId;
	}
	
	//查看风险事件
	function selectRiskEvent(merchantId) {
		window.location.href = "${pageContext.request.contextPath }/searchRcEvent?merchantId=" + merchantId;
	}
</script>

<script type="text/javascript">
	$(function() {
		$("#addBtn")
				.click(
						function() {
							window.location.href = "${pageContext.request.contextPath }/addAttention";
						});
		
		$("#clearBtn").click(function() {
			$("#merchantId").val("");
		});
	})

</script>



<script type="text/javascript">
	$(function() {
		$("#uploadBtn")
				.click(
						function() {
							/* $("#uploadFileForm").submit(); */
							var form = new FormData(document
									.getElementById("uploadFileForm"));
							$
									.ajax({
										url : "${pageContext.request.contextPath}/batchInsert",
										type : "post",
										data : form,
										cache : false,
										processData : false,
										contentType : false,
										success : function(data) {
											if (data) {
												if ('success' == data.status) {
													layer
															.alert(
																	'导入成功 '
																			+ data.exp
																			+ ' 个商家',
																	{
																		skin : 'layui-layer-molv',
																		icon : 1,
																		closeBtn : 0,
																		btnAlign : 'c', //按钮居中
																		anim : 0, //动画类型
																		time : 2000,
																		end : function() {
																			window.location.href = "${pageContext.request.contextPath }/listAttention";
																		}
																	});
												} else if ('fail' == data.status) {
													layer
															.alert(
																	'导入失败！',
																	{
																		skin : 'layui-layer-molv',
																		icon : 1,
																		closeBtn : 0,
																		btnAlign : 'c', //按钮居中
																		anim : 0, //动画类型
																		time : 2000,
																		end : function() {
																			window.location.href = "${pageContext.request.contextPath }/listAttention";
																		}
																	});
												}else if ('empty' == data.status) {
													layer
													.alert(
															'导入的数据格式有误，请您核查数据！',
															{
																skin : 'layui-layer-molv',
																icon : 1,
																closeBtn : 0,
																btnAlign : 'c', //按钮居中
																anim : 0, //动画类型
																time : 2000,
																end : function() {
																	window.location.href = "${pageContext.request.contextPath }/listAttention";
																}
															});
												} else {
													layer
															.alert(
																	'有 '
																			+ data.status
																			+ ' 个商家导入失败（关注名单已存在）,'
																			+ '导入成功 '
																			+ data.exp
																			+ ' 个商家',
																	{
																		skin : 'layui-layer-molv',
																		icon : 1,
																		closeBtn : 0,
																		btnAlign : 'c', //按钮居中
																		anim : 0, //动画类型
																		time : 2000,
																		end : function() {
																			window.location.href = "${pageContext.request.contextPath }/listAttention";
																		}
																	});
												}
											}
										},
										error : function(e) {
											layer.alert('网络异常！', {
												skin : 'layui-layer-molv',
												icon : 1,
												closeBtn : 0,
												btnAlign : 'c', //按钮居中
												anim : 0, //动画类型
												time : 2000
											});
										}
									});
						});
	});
</script>

<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/queryLeaderRoleList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				for (var i = 0; i < data.length; i++) {
					$("#groupArr").append(
							'<option value="' + data[i] +'">' + data[i]
									+ '</option>');

					$("#group").append(
							'<option value="' + data[i] +'">' + data[i]
									+ '</option>');
				}
			}
		});
	});
</script>

<!-- 解除关注名单 -->
<script type="text/javascript">
	$(function() {
		$("#delSubmitBtn").click(function() {
			$
			.ajax({
				url : "${pageContext.request.contextPath }/deleteAttention",
				cache : false,
				type : "POST",
				data : $('#deleteAttentionForm').serialize(),// 你的formid
				async : false,
				success : function(data) {
					if (data) {
						if ('success' == data.status) {
							layer.alert('关注名单解除流程启动！', {
								skin: 'layui-layer-molv',
								icon: 1,
								closeBtn: 0,
								btnAlign: 'c', //按钮居中
								anim: 0, //动画类型
								time: 2000,
								end : function() {
									$('#roleModal').modal('hide');
								}
							});
						} else if ('fail' == data.status) {
							layer.alert('关注名单解除失败！', {
								skin: 'layui-layer-molv',
								icon: 5,
								closeBtn: 0,
								btnAlign: 'c', //按钮居中
								anim: 0, //动画类型
								time: 2000,
								end : function() {
									$('#roleModal').modal('hide');
								}
							});
						}
					}
					
				},
				error : function(data) {
					layer.alert('网络异常！', {
						skin: 'layui-layer-molv',
						icon: 5,
						closeBtn: 0,
						btnAlign: 'c', //按钮居中
						anim: 0, //动画类型
						time: 2000,
						end : function() {
							$('#roleModal').modal('hide');
						}
					});
				}
			});
		});
	});
</script>

<script type="text/javascript">
	$(function() {
		$("#changeLevel").change(function() {
			var currentLevel = $("#currentLevel").val();
			var changeLevel = $('#changeLevel').find('option:selected').text();
			if (currentLevel == changeLevel) {
				layer.alert('选择的关注级别与当前的相同！', {
					skin : 'layui-layer-molv',
					icon : 5,
					closeBtn : 0,
					btnAlign : 'c', //按钮居中
					anim : 0, //动画类型
					time : 2000
				});
				return false;
			}
		});

		$("#levelSubmitBtn")
				.click(
						function() {
							$
									.ajax({
										url : "${pageContext.request.contextPath }/changeAttentionLevel",
										cache : false,
										type : "POST",
										data : $('#changeLevelForm')
												.serialize(),// 你的formid
										async : false,
										success : function(data) {
											if (data) {
												if ('success' == data.status) {
													layer
															.alert(
																	'关注级别修改流程启动！',
																	{
																		skin : 'layui-layer-molv',
																		icon : 1,
																		closeBtn : 0,
																		btnAlign : 'c', //按钮居中
																		anim : 0, //动画类型
																		time : 2000,
																		end : function() {
																			$(
																					'#changeLevelModal')
																					.modal(
																							'hide');
																		}
																	});
												} else if ('fail' == data.status) {
													layer
															.alert(
																	'关注级别修改失败！',
																	{
																		skin : 'layui-layer-molv',
																		icon : 5,
																		closeBtn : 0,
																		btnAlign : 'c', //按钮居中
																		anim : 0, //动画类型
																		time : 2000,
																		end : function() {
																			$(
																					'#changeLevelModal')
																					.modal(
																							'hide');
																		}
																	});
												} else if ('levelSameError' == data.levelSameError) {
													layer
															.alert(
																	'关注级别与之前相同！',
																	{
																		skin : 'layui-layer-molv',
																		icon : 5,
																		closeBtn : 0,
																		btnAlign : 'c', //按钮居中
																		anim : 0, //动画类型
																		time : 2000
																	});
												}
											}

										},
										error : function(data) {
											layer.alert('网络异常！', {
												skin : 'layui-layer-molv',
												icon : 5,
												closeBtn : 0,
												btnAlign : 'c', //按钮居中
												anim : 0, //动画类型
												time : 2000,
												end : function() {
													$('#roleModal').modal(
															'hide');
												}
											});
										}
									});
						});
	});
</script>

<script>
	function downloadFile() {
		window.location.href = "${pageContext.request.contextPath }/downloadModelFile";
	}
</script>

<script>
	window.onload = function() {
		var file = document.querySelector("#file_css input[type='file']");
		var text = document.querySelector("#file_css input[type='text']");
		file.addEventListener("change", assign, false);
		function assign() {
			text.value = file.value;
		}
	}
</script>
</html>