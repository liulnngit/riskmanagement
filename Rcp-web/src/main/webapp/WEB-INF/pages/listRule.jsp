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
						<h5>规则管理</h5>
					</div>
					<div class="ibox-content">

						<div class="btn-group" id="toolbar">
							<shiro:hasRole name="Administrator">
								<div class="btn-group">
									<button id="addRuleBtn" type="button" class="btn btn-primary">新增</button>
								</div>
								<!-- <div class="btn-group">
									<button id="editRuleBtn" type="button" class="btn btn-primary">编辑</button>
								</div>
								<div class="btn-group">
									<button id="deleteRuleBtn" type="button"
										class="btn btn-primary">删除</button>
								</div>

								<div class="btn-group">
									<button type="button" class="btn btn-primary dropdown-toggle"
										data-toggle="dropdown">
										禁用/启用 <span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
										<li><a href="#" id="stopRule">禁用</a></li>
										<li><a href="#" id="startRule">启用</a></li>
									</ul>
								</div>

								<div class="btn-group">
									<button id="showRuleConfigBtn" type="button"
										class="btn btn-primary">查看配置</button>
								</div>
								<div class="btn-group">
									<button type="button" class="btn disable">下载配置</button>
								</div> -->
							</shiro:hasRole>
							<div class="btn-group">
								<button id="searchRuleBtn" type="button" class="btn btn-primary"
									data-toggle="modal" data-target="#searchModal">查询</button>
							</div>
							<!-- <div class="btn-group">
								<button id="showRuleOperateLog" type="button"
									class="btn btn-primary">查看操作</button>
							</div> -->
						</div>


						<div class="body-content">
							<table id="tb_listRule"></table>

							<input type="hidden" id="jsonParam" name="jsonParam" value="" />
						</div>

						<!-- 查询模态框（Modal） -->
						<div class="modal fade" id="searchModal" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h4 class="modal-title" id="myModalLabel">查询规则</h4>
									</div>
									<div class="modal-body">
										<form id="searchForm">
											<div style="margin-top: 10px; margin-botton: 10px;">
												<strong><span>类别信息</span></strong>
											</div>

											<div
												style="margin-top: 10px; margin-botton: 10px; margin-right: 50px;">
												<div class="input-group">
													<span class="input-group-addon">规则编码:</span> <input
														id="ruleCode" name="ruleCode" type="text"
														class="form-control" placeholder="请输入查询内容" />
												</div>
											</div>

											<div
												style="margin-top: 10px; margin-botton: 10px; margin-right: 50px;"">
												<div class="input-group">
													<span class="input-group-addon">规则名称:</span> <input
														id="ruleName" name="ruleName" type="text"
														class="form-control" placeholder="请输入查询内容" />
												</div>
											</div>

											<div
												style="margin-top: 10px; margin-botton: 10px; margin-right: 50px;"">
												<div class="input-group">
													<span class="input-group-addon">规则类别:</span> <select
														id="ruleType" required="required" class="form-control"
														name="ruleType">
														<option value="">-----请选择-----</option>
													</select>
												</div>
											</div>

											<div
												style="margin-top: 10px; margin-botton: 10px; margin-right: 50px;"">
												<div class="input-group">
													<span class="input-group-addon">规则算法:</span> <select
														id="ruleArithmetic" required="required"
														class="form-control" name="ruleArithmetic">
														<option value="">-----请选择-----</option>
													</select>
												</div>
											</div>

											<div
												style="margin-top: 10px; margin-botton: 10px; margin-right: 50px;"">
												<div class="input-group">
													<span class="input-group-addon">支持配置:</span> <select
														id="isConf" class="form-control" required title="请选择"
														name="isConf">
														<option value="">-----请选择-----</option>
														<option value="0">不可配置</option>
														<option value="1">可配置</option>
													</select>
												</div>
											</div>

											<div
												style="margin-top: 10px; margin-botton: 10px; margin-right: 50px;"">
												<div class="input-group">
													<span class="input-group-addon">规则级别:</span> <select
														id="riskLevel" required="required" class="form-control"
														name="riskLevel">
														<option value="">-----请选择-----</option>
													</select>
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

		//$('#tb_listRule').bootstrapTable('hideColumn', 'id');//隐藏某一列

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_listRule')
					.bootstrapTable(
							{
								url : '${pageContext.request.contextPath }/getListRule', //请求后台的URL（*）
								method : 'post', //请求方式（*）
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
								uniqueId : "ruleCode", //每一行的唯一标识，一般为主键列
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
											field : 'ruleCode',
											title : '规则编码',
											align : 'center'
										},
										{
											field : 'ruleName',
											title : '规则名称',
											align : 'center'
										},
										{
											field : 'ruleArithmetic',
											title : '规则算法',
											align : 'center'
										},
										{
											field : 'ruleFeatureName',
											title : '规则属性',
											align : 'center'
										},
										{
											field : 'type',
											title : '规则类型',
											align : 'center'
										},
										{
											field : 'rlTitle',
											title : '风险级别',
											align : 'center'
										},
										{
											field : 'ruleStatus',
											title : '状态',
											align : 'center'
										},
										{
											field : 'isConfigRule',
											title : '是否可配置',
											align : 'center'
										},
										{
											field : 'creator',
											title : '创建人',
											align : 'center'
										},
										{
											field : 'createTime',
											title : '创建时间',
											align : 'center'
										},
										{
											field : 'creator',
											title : '操作',
											align : 'center',
											formatter : function(value, row,
													index) {
												var ptyh = '<shiro:hasRole name="Administrator">';
												ptyh += '<button type="button" class="btn-primary" onclick="edit(\''
														+ row.ruleCode
														+ '\')">编辑</button>';
												ptyh += '<button type="button" class="btn-primary" onclick="dele(\''
														+ row.ruleCode
														+ '\')">删除</button>';
												if ('A' == row.status) {
													ptyh += '<button type="button" class="btn-danger" onclick="stopRule(\''
															+ row.ruleCode
															+ '\')">禁用</button>';
												} else if ('I' == row.status) {
													ptyh += '<button type="button" class="btn-primary" onclick="startRule(\''
															+ row.ruleCode
															+ '\')">启用</button>';
												}
												ptyh += '<button type="button" class="btn-primary" onclick="showRuleConfig(\''
														+ row.ruleCode
														+ '\')">查看</button>';
												ptyh += '<button type="button" class="btn-primary" onclick="showRuleOperateLog(\''
													+ row.ruleCode
													+ '\')">查看操作</button>';
												ptyh += '</shiro:hasRole>';
												var download = '<button type="button" class="btn-default" onclick="download(\''
														+ row.ruleCode
														+ '\')" disabled="disabled">下载</button>';
											
												return ptyh + download ;
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
		$('#tb_listRule').bootstrapTable('destroy');
		var oTable = new TableInit();
		oTable.Init();
		$('#searchModal').modal('hide');
	});

	//回车键事件
	document.onkeydown = function(e) {
		var ev = document.all ? window.event : e;
		if (ev.keyCode == 13) {
			var obj = $('#searchForm').serializeJSON();
			var jsonString = JSON.stringify(obj);
			$("#jsonParam").val(jsonString);
			$('#tb_listRule').bootstrapTable('destroy');
			var oTable = new TableInit();
			oTable.Init();
			$('#searchModal').modal('hide');
		}
	}
</script>

<script type="text/javascript">
	//编辑
	function edit(ruleCode) {
		window.location.href = "${pageContext.request.contextPath}/showRule?ruleCode="
				+ ruleCode;
	}

	//删除
	function dele(ruleCode) {
		layer.confirm("您确定要删除这条数据吗？", {
			icon : 3,
			closeBtn : 0,
			btnAlign : 'c', //按钮居中
			title : '提示'
		}, function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/deleteRule?ruleCode="
						+ ruleCode,
				type : "get",
				async : true,
				cache : false,
				success : function(data) {
					if ("success" == data.status) {
						layer.alert("删除成功！", {
							skin : 'layui-layer-molv',
							icon : 1,
							btnAlign : 'c', //按钮居中
							closeBtn : 0,
							anim : 0, //动画类型
							time : 2000
						});
						$("#tb_listRule").bootstrapTable('refresh', {
							index : ruleCode
						});
					} else {
						layer.alert("删除失败！", {
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

	//禁用
	function stopRule(ruleCode) {
		$
				.ajax({
					url : "${pageContext.request.contextPath}/changeRuleStatus?ruleCode="
							+ ruleCode + "&status=I",
					type : "get",
					async : true,
					cache : false,
					success : function(data) {
						if ("success" == data.status) {
							layer.alert("禁用规则成功！", {
								skin : 'layui-layer-molv',
								icon : 1,
								btnAlign : 'c', //按钮居中
								closeBtn : 0,
								anim : 0, //动画类型
								time : 2000,
								end : function() {
									$("#tb_listRule").bootstrapTable('refresh',
											{
												index : ruleCode
											});
								}
							});
						} else {
							layer.alert("禁用规则失败！", {
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
	}

	//启动
	function startRule(ruleCode) {
		$
				.ajax({
					url : "${pageContext.request.contextPath}/changeRuleStatus?ruleCode="
							+ ruleCode + "&status=A",
					type : "get",
					async : true,
					cache : false,
					success : function(data) {
						if ("success" == data.status) {
							layer.alert("启用规则成功！", {
								skin : 'layui-layer-molv',
								icon : 1,
								btnAlign : 'c', //按钮居中
								closeBtn : 0,
								anim : 0, //动画类型
								time : 2000,
								end : function() {
									$("#tb_listRule").bootstrapTable('refresh',
											{
												index : ruleCode
											});
								}
							});
						} else {
							layer.alert("启用规则失败！", {
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
	}

	//查看配置
	function showRuleConfig(ruleCode) {
		window.location.href = "${pageContext.request.contextPath}/showRuleConfig?ruleCode="
			+ ruleCode;
	}

	//下载

	//查看操作
	function showRuleOperateLog(ruleCode) {
		window.location.href = "${pageContext.request.contextPath}/showRuleOperateLog?ruleCode="
			+ ruleCode;
	}
</script>


<script type="text/javascript">
	$(function() {
		$("#addRuleBtn")
				.click(
						function() {
							window.location.href = "${pageContext.request.contextPath}/addRule";
						});
	});
</script>

<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/queryRuleTypeList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#ruleType").append(
								'<option value="' + data[i].id +'">'
										+ data[i].title + '</option>')
					}
				}

			}
		});

		function getAlgorithmType(selecteVal) {
			$("#ruleArithmetic").empty();
			$("#ruleArithmetic").append(
					"<option value=''>-----请选择-----</option>");
			$
					.ajax({
						url : "${pageContext.request.contextPath}/queryAlgorithmTypeListByRuleType?ruleType="
								+ selecteVal,
						type : "GET",
						contentType : "application/json",
						dataType : "json",
						cache : false,
						success : function(data) {
							if (data.length > 0) {
								for (var i = 0; i < data.length; i++) {
									$("#ruleArithmetic").append(
											'<option value="' + data[i].type +'">'
													+ data[i].title
													+ '</option>');
								}

								var selectOption = $("#ruleArithmeticHidden")
										.val();
								$(
										"#ruleArithmetic option[value='"
												+ selectOption + "']").attr(
										"selected", "selected");
							}
						}
					});
		}

		$("#ruleType").change(function() {
			var selecteVal = $('#ruleType').find('option:selected').val();
			getAlgorithmType(selecteVal);
		});

		$.ajax({
			url : "${pageContext.request.contextPath}/queryRiskLevelList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#riskLevel").append(
								'<option value="' + data[i].id +'">'
										+ data[i].title + '</option>')
					}
				}
			}
		});

	});
</script>

<script type="text/javascript">
	$(function() {
		$("#clearBtn").click(function() {
			$("#ruleCode").val('');
			$("#ruleName").val('');
			$("#ruleType").val('');
			$("#ruleArithmetic").val('');
			$("#isConf").val('');
			$("#riskLevel").val('');
		});
	});
</script>

</html>
