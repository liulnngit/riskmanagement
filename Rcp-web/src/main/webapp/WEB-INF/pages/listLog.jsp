<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<%@ include file="../commons/sourceFile.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.serializejson.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/dealDateUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/lang/zh-cn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/calendar.js"></script>
</head>
<body class="gray-bg">
	<input type="hidden" name="systemAccount" id="systemAccount" value="${systemAccount}" />
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>日志查询</h5>
					</div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="btn-group" id="toolbar">
								<button type="button" class="btn btn-primary margin-items-top" id="searchBtn" data-toggle="modal" data-target="#searchModal">查询</button>
								<button type="button" class="btn disabled" id="exportBtn">导出</button>
								<button type="button" class="btn disabled" id="printBtn">打印</button>
							</div>
							<div class="body-content">


								<table id="tb_listlog"></table>

								<input type="hidden" id="ruleCode" name="ruleCode" value="${ruleCode}" /> <input type="hidden" id="jsonParam" name="jsonParam" value="" /> <input type="hidden" id="hStartTime"
									name="hStartTime" value="" /> <input type="hidden" id="hEndTime" name="hEndTime" value="" />

							</div>

							<!-- 查询模态框（Modal） -->
							<div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="myModalLabel">查询日志</h4>
										</div>
										<div class="modal-body">
											<form id="searchForm">
												<div style="margin-top: 10px; margin-botton: 10px;">
													<strong><span>查询信息</span></strong>
												</div>

												<div style="margin-top: 10px; margin-botton: 10px; margin-right: 50px;">
													<div class="input-group">
														<span class="input-group-addon">菜&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;单:</span> <select id="menu" required="required" class="form-control" name="menu">
															<option value="">-----请选择-----</option>
															<option value="规则引擎" <c:if test="${operateMongo.menu=='规则引擎'}">selected</c:if>>规则引擎</option>
															<option value="黑名单库" <c:if test="${operateMongo.menu=='黑名单库'}">selected</c:if>>黑名单库</option>
															<option value="白名单库" <c:if test="${operateMongo.menu=='白名单库'}">selected</c:if>>白名单库</option>
															<option value="基础管理" <c:if test="${operateMongo.menu=='基础管理'}">selected</c:if>>基础管理</option>
														</select>
													</div>
												</div>

												<div style="margin-top: 10px; margin-botton: 10px; margin-right: 50px;">
													<div class="input-group">
														<span class="input-group-addon">子&nbsp;&nbsp;菜&nbsp;&nbsp;单:</span> <select id="subMenu" required="required" class="form-control" name="subMenu">
															<option value="">-----请选择-----</option>
															<option value="规则管理" <c:if test="${operateMongo.subMenu=='规则管理'}">selected</c:if>>规则管理</option>
															<option value="规则类别" <c:if test="${operateMongo.subMenu=='规则类别'}">selected</c:if>>规则类别</option>
															<option value="规则参数" <c:if test="${operateMongo.subMenu=='规则参数'}">selected</c:if>>规则参数</option>
															<option value="风险级别" <c:if test="${operateMongo.subMenu=='风险级别'}">selected</c:if>>风险级别</option>
															<option value="黑名单管理" <c:if test="${operateMongo.subMenu=='黑名单管理'}">selected</c:if>>黑名单管理</option>
															<option value="黑名单档案" <c:if test="${operateMongo.subMenu=='黑名单档案'}">selected</c:if>>黑名单档案</option>
															<option value="白名单管理" <c:if test="${operateMongo.subMenu=='白名单管理'}">selected</c:if>>白名单管理</option>
															<option value="白名单档案" <c:if test="${operateMongo.subMenu=='白名单档案'}">selected</c:if>>白名单档案</option>
															<option value="用户管理" <c:if test="${operateMongo.subMenu=='用户管理'}">selected</c:if>>用户管理</option>
															<option value="角色管理" <c:if test="${operateMongo.subMenu=='角色管理'}">selected</c:if>>角色管理</option>
															<option value="行业管理" <c:if test="${operateMongo.subMenu=='行业管理'}">selected</c:if>>行业管理</option>
															<option value="参数管理" <c:if test="${operateMongo.subMenu=='参数管理'}">selected</c:if>>参数管理</option>
															<option value="商家管理" <c:if test="${operateMongo.subMenu=='商家管理'}">selected</c:if>>商家管理</option>
															<option value="支付类型" <c:if test="${operateMongo.subMenu=='支付类型'}">selected</c:if>>支付类型</option>
														</select>
													</div>
												</div>

												<div style="margin-top: 10px; margin-botton: 10px; margin-right: 50px;">
													<div class="input-group">
														<span class="input-group-addon">操作内容:</span> <input type="text" class="form-control" id="msg" name="msg" placeholder="请输入操作内容" value="${operateMongo.msg }">
													</div>
												</div>
												<div style="margin-top: 10px; margin-botton: 10px; margin-right: 50px;">
													<div class="input-group">
														<span class="input-group-addon">开始日期:</span> <input type="text"
															onFocus="var endTime=$dp.$('endTime');WdatePicker({onpicked:function(){endTime.focus();},dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endTime\')||\'%y-%M-%d-%H:%m:%s\'}',minDate:'#F{$dp.$D(\'endTime\',{M:-6})}'})"
															class="Wdate form-control" id="startTime" style="height: 34px; border: 1px solid #cccccc;">
													</div>
												</div>
												<div style="margin-top: 10px; margin-botton: 10px; margin-right: 50px;">
													<div class="input-group">
														<span class="input-group-addon">结束日期:</span> <input type="text"
															onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'#F{$dp.$D(\'startTime\',{M:6})||\'%y-%M-%d-%H:%m:%s\'}'})" class="Wdate form-control"
															id="endTime" style="height: 34px; border: 1px solid #cccccc;">
													</div>
												</div>
												<br> <input type="hidden" id="ruleCode" name="ruleCode" value="${ruleCode}" />
											</form>
										</div>
										<div class="modal-footer">
											<button id="submitBtn" type="button" class="btn btn-primary">查询</button>
											<button id="clearBtn" type="button" class="btn btn-primary">清空</button>
											<button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
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

		//$('#tb_listlog').bootstrapTable('hideColumn', 'id');//隐藏某一列

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_listlog').bootstrapTable({
				url : '${pageContext.request.contextPath }/getListLog', //请求后台的URL（*）
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
				//uniqueId : "OperateTime", //每一行的唯一标识，一般为主键列
				//showToggle : true, //是否显示详细视图和列表视图的切换按钮
				//cardView : false, //是否显示详细视图
				//detailView : false, //是否显示父子表
				singleSelect : true, //禁止多选
				undefinedText : "",
				columns : [ {
					field : 'menu',
					title : '菜单',
					align : 'center'
				}, {
					field : 'subMenu',
					title : '子菜单',
					align : 'center'
				}, {
					field : 'opName',
					title : '操作人',
					align : 'center'
				}, {
					field : 'ipAddress',
					title : 'IP地址',
					align : 'center'
				}, {
					field : 'operateDate',
					title : '操作时间',
					align : 'center'
				}, {
					field : 'objectName',
					title : '操作对象',
					align : 'center'
				}, {
					field : 'oldValue',
					title : '旧值',
					align : 'center',
					cellStyle : formatTableUnit,
					formatter : operateOpinionFormatter
				}, {
					field : 'newValue',
					title : '新值',
					align : 'center',
					cellStyle : formatTableUnit,
					formatter : operateOpinionFormatter
				}, {
					field : 'msg',
					title : '备注',
					align : 'center'
				} ],
				queryParams : oTableInit.queryParams
			});
		};

		//得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
				ruleCode : $("#ruleCode").val(),
				jsonParam : $("#jsonParam").val(),
				startTime : $("#hStartTime").val(),
				endTime : $("#hEndTime").val()
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
		$("#hStartTime").val($("#startTime").val());
		$("#hEndTime").val($("#endTime").val());
		$('#tb_listlog').bootstrapTable('destroy');
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
			$("#hStartTime").val($("#startTime").val());
			$("#hEndTime").val($("#endTime").val());
			$('#tb_listlog').bootstrapTable('destroy');
			var oTable = new TableInit();
			oTable.Init();
			$('#searchModal').modal('hide');
		}
	}

	function searchByFilter(jsonParam, startTime, endTime) {
		$("#jsonParam").val(jsonParam);
		$("#startTime").val(startTime);
		$("#endTime").val(endTime);
		$('#tb_listlog').bootstrapTable('destroy');
		var oTable = new TableInit();
		oTable.Init();
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
			return "<span title='"+ "" +"'>" + "</span>";
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

<!-- <script type="text/javascript">
	$(function() {

		$("#searchBtn")
				.click(
						function() {
							var ruleCode = $("#ruleCode").val();
							var jsonParam = $("#jsonParam").val();
							jsonParam = jsonParam.replace(/"/g, "'");
							var pageUrl = "${pageContext.request.contextPath }/toSearchLogPage?jsonParam="
									+ jsonParam + "&&ruleCode=" + ruleCode;
							var diag = new Dialog();
							diag.Width = 600;
							diag.Height = 400;
							diag.Title = "请输入查询条件";
							diag.URL = pageUrl;
							diag.Drag = false;
							diag.show();
						});
	});
</script> -->

<script type="text/javascript">
	$(function() {
		var ruleCode = $("#ruleCode").val();
		if ("" != ruleCode) {
			$("#menu").empty();
			$("#menu").append('<option value="">-----请选择-----</option>')
					.append('<option value="规则引擎" selected>规则引擎</option>');

			$("#subMenu").empty();
			$("#subMenu").append('<option value="">-----请选择-----</option>')
					.append('<option value="规则管理" selected>规则管理</option>');

			return false;
		} else {
			cascadeMenu();
		}
	});
</script>

<script type="text/javascript">
	$("#menu").change(function() {
		cascadeMenu();
	});

	function cascadeMenu() {
		var menu = $("#menu").val();
		var subMenu = $("#subMenu").val();
		var systemAccount = $("#systemAccount").val();
		if ("规则引擎" == menu) {
			$("#subMenu").empty();
			if("1" == systemAccount) {
				$("#subMenu").append('<option value="">-----请选择-----</option>')
						.append('<option value="规则管理">规则管理</option>').append(
								'<option value="规则类别">规则类别</option>').append(
								'<option value="规则参数">规则参数</option>').append(
								'<option value="风险级别">风险级别</option>');
			} else {
                $("#subMenu").append('<option value="">-----请选择-----</option>')
                    .append('<option value="规则管理">规则管理</option>').append(
                    '<option value="规则参数">规则参数</option>');
			}
		} else if ("黑名单库" == menu) {
			$("#subMenu").empty();
			$("#subMenu").append('<option value="">-----请选择-----</option>')
					.append('<option value="黑名单管理">黑名单管理</option>').append(
							'<option value="黑名单档案">黑名单档案</option>');
		} else if ("白名单库" == menu) {
			$("#subMenu").empty();
			$("#subMenu").append('<option value="">-----请选择-----</option>')
					.append('<option value="白名单管理">白名单管理</option>').append(
							'<option value="白名单档案">白名单档案</option>');
		} else if ("基础管理" == menu) {
			$("#subMenu").empty();
            if("1" == systemAccount) {
				$("#subMenu").append('<option value="">-----请选择-----</option>')
						.append('<option value="用户管理">用户管理</option>').append(
								'<option value="角色管理">角色管理</option>');
            } else {
                $("#subMenu").append('<option value="">-----请选择-----</option>')
                    .append('<option value="用户管理">用户管理</option>').append(
                    '<option value="角色管理">角色管理</option>').append(
                    '<option value="行业管理">行业管理</option>').append(
                    '<option value="参数管理">参数管理</option>').append(
                    '<option value="商家管理">商家管理</option>').append(
                    '<option value="支付类型">支付类型</option>');
			}
		} else {
			$("#subMenu").empty();
			$("#subMenu").append('<option value="">-----请选择-----</option>');
		}

		if (null != menu && "" != menu) {
			$("#menu option[value='" + menu + "']")
					.attr("selected", "selected");
		}
		if (null != subMenu && "" != subMenu) {
			$("#subMenu option[value='" + subMenu + "']").attr("selected",
					"selected");
		}
	}
</script>

<script type="text/javascript">
	$(function() {
		var endDate = new Date();
		$("#endTime").val(endDate.format("yyyy-MM-dd hh:mm:ss"));
		var startDate = dateSub('m', 1, endDate);
		$("#startTime").val(startDate.format("yyyy-MM-dd hh:mm:ss"))
	});
</script>

<script type="text/javascript">
	$("#clearBtn").click(function() {
		$("#menu").val("");
		$("#subMenu").val("");
		$("#msg").val("");
		$("#startTime").val("");
		$("#endTime").val("");
	});
</script>

</html>