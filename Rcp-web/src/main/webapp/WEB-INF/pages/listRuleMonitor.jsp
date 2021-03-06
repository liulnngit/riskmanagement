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
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>规则监控</h5>
					</div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="btn-group" id="toolbar">
								<button type="button" class="btn btn-primary margin-items-top"
									id="searchBtn" data-toggle="modal" data-target="#searchModal">查询</button>
							</div>
							<div class="body-content">
								<table id="tb_listRuleMonitor"></table>
								<input type="hidden" id="jsonParam" name="jsonParam" value="" />
							</div>

							<!-- 查询模态框（Modal） -->
							<div class="modal fade" id="searchModal" tabindex="-1"
								role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="myModalLabel">查询规则监控</h4>
										</div>
										<div class="modal-body">
											<form id="searchForm">
												<div style="margin-top: 10px; margin-botton: 10px;">
													<strong><span>查询信息</span></strong>
												</div>

												<div
													style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
													<div class="input-group">
														<span class="input-group-addon">规&nbsp;则&nbsp;名&nbsp;称:</span>
														<select id="ruleCode" required="required"
															class="form-control" name="ruleCode">
															<option value="">-----请选择-----</option>
														</select>
													</div>
												</div>

												<div
													style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
													<div class="input-group">
														<span class="input-group-addon">起始时间:</span> <input
															class="Wdate form-control"
															style="height: 34px; border: 1px solid #cccccc;"
															id="dateFrom" name="dateFrom" type="text"
															placeholder="请选择起始时间"
															onFocus="var dateTo=$dp.$('dateTo');WdatePicker({onpicked:function(){dateTo.focus();},dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'dateTo\')||\'%y-%M-%d-%H:%m:%s\'}',minDate:'#F{$dp.$D(\'dateTo\',{M:-6})}'})">
													</div>
												</div>

												<div
													style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
													<div class="input-group">
														<span class="input-group-addon">结束时间:</span> <input
															class="Wdate form-control"
															style="height: 34px; border: 1px solid #cccccc;"
															id="dateTo" name="dateTo" type="text"
															placeholder="请选择结束时间"
															onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'dateFrom\')}',maxDate:'#F{$dp.$D(\'dateFrom\',{M:6})||\'%y-%M-%d-%H:%m:%s\'}'})">
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

		$('#tb_listRuleMonitor').bootstrapTable('hideColumn', 'id');//隐藏某一列

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_listRuleMonitor').bootstrapTable({
				url : '${pageContext.request.contextPath }/getListRuleMonitor', //请求后台的URL（*）
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
				columns : [ {
					field : 'id',
					title : '规则监控ID',
					align : 'center'
				}, {
					field : 'systemName',
					title : '系统名称',
					align : 'center'
				}, {
					field : 'countDate',
					title : '统计时间',
					align : 'center'
				}, {
					field : 'ruleCode',
					title : '规则编码',
					align : 'center'
				}, {
					field : 'ruleName',
					title : '规则名称',
					align : 'center'
				}, {
					field : 'executeTimes',
					title : '执行次数',
					align : 'center',
					formatter : function(value, row, index) {
						var e = value + " 次";
						return e;
					}
				}, {
					field : 'riskTimes',
					title : '风险次数',
					align : 'center',
					formatter : function(value, row, index) {
						var e = value + " 次";
						return e;
					}
				}, {
					field : 'maxTime',
					title : '最大耗时',
					align : 'center',
					formatter : function(value, row, index) {
						var e = value + " ms";
						return e;
					}
				}, {
					field : 'avgTime',
					title : '平均耗时',
					align : 'center',
					formatter : function(value, row, index) {
						var e = value + " ms";
						return e;
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
		$('#tb_listRuleMonitor').bootstrapTable('destroy');
		var oTable = new TableInit();
		oTable.Init();
		$('#tb_listRuleMonitor').bootstrapTable('hideColumn', 'id');
		$('#searchModal').modal('hide');
	});

	//回车键事件
	document.onkeydown = function(e) {
		var ev = document.all ? window.event : e;
		if (ev.keyCode == 13) {
			var obj = $('#searchForm').serializeJSON();
			var jsonString = JSON.stringify(obj);
			$("#jsonParam").val(jsonString);
			$('#tb_listRuleMonitor').bootstrapTable('destroy');
			var oTable = new TableInit();
			oTable.Init();
			$('#tb_listRuleMonitor').bootstrapTable('hideColumn', 'id');
			$('#searchModal').modal('hide');
		}
	}

</script>

<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/queryListRule",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#ruleCode").append(
								'<option value="' + data[i].ruleCode +'">'
										+ data[i].ruleName + '</option>')
					}
				}
			}
		});

		$.ajax({
			url : "${pageContext.request.contextPath}/queryPayclassList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#payclassId").append(
								'<option value="' + data[i].id +'">'
										+ data[i].name + '</option>')
					}
				}
			}
		});

	});
</script>

<script type="text/javascript">
	$("#clearBtn").click(function() {
		$("#ruleCode").val('');
		$("#merchantId").val('');
		$("#payclassId").val('');
		$("#isRisk").val('');
	});
</script>

</html>