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
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/My97DatePicker/lang/zh-cn.js"></script>	
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/My97DatePicker/calendar.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/formatDateUtil.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title" id="add">
						<h5>投诉事件</h5>
					</div>
					<div class="ibox-content">

						<div class="panel admin-panel">
							<div class="btn-group" id="toolbar">
								<div class="btn-group">
									<button id="addBtn" type="button" class="btn btn-primary">新增</button>
								</div>
								<!-- <div class="btn-group">
									<button id="editBtn" onclick="doRiskEvent();" type="button"
										class="btn btn-primary">修改</button>
								</div> -->
								<div class="btn-group">
									<button id="importBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#uploadModal">导入</button>
								</div>
								
								<div class="btn-group">
									<button id="editRuleBtn" type="button" class="btn disabled">导出</button>
								</div>
								
								<div class="btn-group">
									<button id="searchBtn" type="button" class="btn btn-primary"
										data-toggle="modal" data-target="#searchModal">查询</button>
								</div>
								<!-- <div class="btn-group">
									<button id="showDetailBtn" type="button"
										class="btn btn-primary">详情</button>
								</div> -->
								<!-- <div class="btn-group">
								<button id="convertRcEventBtn" type="button" class="btn btn-primary">设为风控事件</button>
							</div> -->
								<!-- <div class="btn-group">
								<button type="button" class="btn btn-primary">查看任务</button>
							</div> -->
							</div>
							<div style="margin-top: 10px;">
								<table id="tb_complaint"></table>
								<input type="hidden" id="jsonParam" name="jsonParam" value="">
							</div>

							<!-- 查询模态框（Modal） -->
							<div class="modal fade" id="searchModal" tabindex="-1"
								role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="myModalLabel">查询投诉事件</h4>
										</div>
										<div class="modal-body">
											<form id="searchForm">
												<div
													style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
													<div class="input-group">
														<span class="input-group-addon">投&nbsp;&nbsp;诉&nbsp;&nbsp;人:</span>
														<input type="text" class="form-control" id="name"
															name="name" placeholder="请输入投诉人"
															value="${complaint.name }">
													</div>
												</div>

												<div
													style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
													<div class="input-group">
														<span class="input-group-addon">投诉电话:</span> <input
															type="text" class="form-control" id="phoneNumber"
															name="phoneNumber" placeholder="请输入电话号码"
															value="${complaint.phoneNumber }">
													</div>
												</div>

												<div
													style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
													<div class="input-group">
														<span class="input-group-addon">投诉邮箱:</span> <input
															type="email" class="form-control" id="emailAddress"
															name="emailAddress" placeholder="请输入邮箱地址"
															value="${complaint.emailAddress }">
													</div>
												</div>

												<div
													style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
													<div class="input-group">
														<span class="input-group-addon">起始时间：</span> <input
															class="Wdate  form-control"
															onFocus="var dateTo=$dp.$('dateTo');WdatePicker({onpicked:function(){dateTo.focus();},dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'dateTo\')||\'%y-%M-%d-%H:%m:%s\'}',minDate:'#F{$dp.$D(\'dateTo\',{M:-6})}'})"
															style="height: 34px; border: 1px solid #cccccc;"
															id="dateFrom" name="dateFrom" type="text"
															placeholder="请选择起始时间" value="${complaint.dateFrom }">
													</div>
												</div>

												<div
													style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
													<div class="input-group">
														<span class="input-group-addon">结束时间：</span> <input
															class="Wdate form-control"
															onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'dateFrom\')}',maxDate:'#F{$dp.$D(\'dateFrom\',{M:6})||\'%y-%M-%d-%H:%m:%s\'}'})"
															style="height: 34px; border: 1px solid #cccccc;"
															id="dateTo" name="dateTo" type="text"
															placeholder="请选择结束时间" value="${complaint.dateTo }">
													</div>
												</div>

												<div
													style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
													<div class="input-group">
														<span class="input-group-addon">商&nbsp;&nbsp;家&nbsp;&nbsp;号：</span>
														<input type="text" class="form-control" id="merchantId"
															name="merchantId" placeholder="请输入商家号"
															value="${complaint.merchantId }">
													</div>
												</div>

												<div
													style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
													<div class="input-group">
														<span class="input-group-addon">订&nbsp;&nbsp;单&nbsp;&nbsp;号：</span> <input
															type="text" class="form-control" id="merchantOrderId"
															name="merchantOrderId" placeholder="请输入订单号"
															value="${complaint.merchantOrderId }">
													</div>
												</div>

												<div
													style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
													<div class="input-group">
														<span class="input-group-addon">投诉内容：</span> <input
															type="text" class="form-control" id="remark"
															name="remark" placeholder="请输入投诉内容"
															value="${complaint.remark }">
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
							
							<!-- 模态框示例（Modal） -->
						<div class="modal fade" id="complaintModal" tabindex="-1" role="dialog"
							aria-labelledby="complaintHandlingModal" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h1 class="modal-title" id="complaintHandlingModal">投诉处理</h1>
									</div>
									<div class="modal-body">
										<div id="complaintDetail"></div>
										<form id="complaintHandlingForm" method="post">
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
										<button id="cSubmitBtn" type="button"
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
						
						<!-- 导入结果模态框示例（Modal） -->
						<div class="modal fade" id="importComplaintModal" tabindex="-1" role="dialog"
							aria-labelledby="searchModal" aria-hidden="true">
							<div class="modal-dialog" style="width:900px!important">
								<div class="modal-content">
									<div class="modal-header">
										<h1 class="modal-title" id="complaintHandlingModal">导入失败结果</h1>
									</div>
									<div class="modal-body" style="padding: 0px 30px 0px;">
										<table class="table table-bordered table-hover table-striped" style="margin-top: 25px;word-wrap: break-word; word-break: break-all;">
							                                	<thead>
							                                		<th style="width:8%">投诉人</th>
							                                		<th style="width:8%">投诉电话</th>
							                                		<th style="width:8%">投诉邮箱</th>
							                                		<th style="width:10%">投诉订单</th>
							                                		<!-- <th style="width:10%">投诉商家</th> -->
							                                		<!-- <th style="width:5%">状态</th> -->
							                                		<!-- <th style="width:8%">投诉金额</th>
							                                		<th style="width:8%">支付类型ID</th> -->
							                                		<th style="width:8%">投诉时间</th>
							                                	</thead>
							                                	<tbody style="text-align: center;" id="failResult">
							                                	</tbody>
							           </table>
									</div>
									<div class="modal-footer">
										<button id="importCloseBtn" type="button" class="btn btn-primary">关闭</button>
										<span id="tip"> </span>
									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal -->
						</div>
						
						<!-- 模态框示例（Modal） -->
						<div class="modal fade" id="complaintCheckModal" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
							data-backdrop="static" data-keyboard="false">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h4 class="modal-title" id="myModalLabel">查看投诉结果</h4>
									</div>
									<div class="modal-body" style="padding: 0px 30px 0px;">
											
												 <table class="table table-bordered float-item-left margin-items-top" style="margin-top: 20px;word-wrap: break-word; word-break: break-all;">
													<thead>
														<tr>
															<th style="width:20%">投诉人</th>
															<th style="width:40%">电话</th>
															<th style="width:40%">邮箱</th>
														</tr>
													</thead>
													<tbody align="center">
														<tr id="complaintResult">
															<!-- <td></td>
															<td></td>
									                        <td></td> -->
														</tr>
													</tbody>
												</table>
					    				
												 <table	class="table table-bordered float-item-left margin-items-top"  style="word-wrap: break-word; word-break: break-all;">
													<thead>
														<tr>
															<!-- <th>消费者</th> -->
															<th style="width:25%">设备指纹</th>
															<th style="width:25%">IP</th>
															<th style="width:25%">卡号</th>
															<th style="width:25%">电话号码</th>
															<!-- <th>检测结果</th> -->
														</tr>
													</thead>
													<tbody align="center">
														<tr id="consumerResult">
															<!-- <td></td>
															<td></td>
									                        <td></td>
									                        <td></td>
									                        <td></td> -->
														</tr>
													</tbody>
												</table>
												 <table	class="table table-bordered float-item-left margin-items-top" style="word-wrap: break-word; word-break: break-all;">
													<thead>
														<tr>
															<th style="width:30%">商家ID</th>
															<th style="width:30%">商家域名</th>
															<th style="width:30%">订单号</th>
															<!-- <th>检测结果</th> -->
														</tr>
													</thead>
													<tbody align="center">
														<tr id="merchantResult">
															<!-- <td></td>
															<td></td> -->
														</tr>
													</tbody>
												</table>
					    				
									</div>
									<div class="modal-footer">
										<button id="resultCloseBtn" type="button" class="btn btn-primary">关闭</button>
										<span id="tip"> </span>
									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal -->
						</div>

						</div>


					</div>
					<div class="modal fade" id="myModal" tabindex="-1"
						 role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

						<!-- /.modal -->
					</div>
					<div class="modal fade" id="myModalOrder" tabindex="-1"
						 role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

						<!-- /.modal -->
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

		$('#tb_complaint').bootstrapTable('hideColumn', 'id');//隐藏某一列

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_complaint').bootstrapTable({
				url : '${pageContext.request.contextPath }/getListComplaint', //请求后台的URL（*）
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
				escape : false,
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
					checkbox : true,
					align : 'center'
				}, {
					field : 'id',
					title : 'ID',
					align : 'center'
				}, {
					field : 'name',
					title : '投诉人',
					align : 'center'
				}, {
					field : 'phoneNumber',
					title : '电话',
					align : 'center'
				}, {
					field : 'emailAddress',
					title : '邮箱',
					align : 'center'
				}, {
					field : 'merchantId',
					title : '商家号',
					align : 'center'
				}, {
					field : 'merchantOrderId',
					title : '订单号',
					align : 'center'
				}, {
					field : 'txMoney',
					title : '投诉金额',
					align : 'center',
					formatter : function(value, row, index) {
						var e = '<span>￥' + formatCurrency(value) + '</span>';
						return e;
					}
				}, {
					field : 'status',
					title : '状态',
					align : 'center'
				}, {
					field : 'creator',
					title : '创建人',
					align : 'center'
				}, {
					field : 'createTime',
					title : '投诉时间',
					align : 'center'
				}, {
					field : 'remark',
					title : '投诉内容',
					align : 'center',
					cellStyle : formatTableUnit,
					formatter : operateOpinionFormatter
				}, {
					field : '',
					title : '操作',
					align : 'center',
					formatter : function(value, row, index) {
						var e = '<button href="#" class="btn-primary"  onclick="edit(\''+ row.id + '\')">编辑</button>';
						//var detail = '<button href="#" class="btn-primary"  onclick="showDetail(\''+ row.id + '\')">详情</button>';
                        var detail = '<botton class="btn-primary" style="border-radius: 0px;padding: 4px 4px 4px 4px;" href="${pageContext.request.contextPath }/showDetail?id='+row.id+ '"data-toggle="modal"  data-target="#myModal">详情</botton>'
						var h = '<button href="#" class="btn-primary"  onclick="complaintHandling(\''+ row.id + '\')">处理</button>';
						if (('处理中' == row.status) || ('已处理' == row.status)) {
							h = '<a href="#" class="btn btn-default disabled" role="button">处理</a>';
						}
						var yc = '';
						if ('1' == row.isAbnormal) {
							yc = '<button href="#" class="btn-primary"  onclick="showAbnormalDetail(\''+ row.id + '\')">异常</button>';
						}
						return e + detail + h + yc;
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
		$('#tb_complaint').bootstrapTable('destroy');
		var oTable = new TableInit();
		oTable.Init();
		$('#tb_complaint').bootstrapTable('hideColumn', 'id');//隐藏某一列
		$('#searchModal').modal('hide');
	});

	//回车键事件
	document.onkeydown = function(e) {
		var ev = document.all ? window.event : e;
		if (ev.keyCode == 13) {
			var obj = $('#searchForm').serializeJSON();
			var jsonString = JSON.stringify(obj);
			$("#jsonParam").val(jsonString);
			$('#tb_complaint').bootstrapTable('destroy');
			var oTable = new TableInit();
			oTable.Init();
			$('#tb_complaint').bootstrapTable('hideColumn', 'id');//隐藏某一列
			$('#searchModal').modal('hide');
		}
	}
	
	//清空
	$("#clearBtn").click(function() {
		$("#name").val('');
		  $("#phoneNumber").val('');
		  $("#emailAddress").val('');
		  $("#dateFrom").val('');
		  $("#dateTo").val('');
		  $("#merchantId").val('');
		  $("#merchantOrderId").val('');
		  $("#remark").val('');
	});

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
	//编辑
	function edit(id) {
		window.location.href = "${pageContext.request.contextPath }/toEditComplaintPage?id=" + id;
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
	function showDetail(id) {
		var pageUrl = "${pageContext.request.contextPath }/showDetail?id=" + id;
		var diag = new Dialog();
		diag.Width = 600;
		diag.Height = 500;
		diag.Title = "投诉详情";
		diag.URL = pageUrl;
		diag.Drag = false;
		diag.show();
	}
	
	//投诉处理
	function complaintHandling(id) {
		var data = '';
		$("#complaintDetail").empty();
		$.ajax({
			url : "${pageContext.request.contextPath}/showComplaintData?id=" + id,
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(result) {
				data += '<table class="table table-bordered" style="word-wrap: break-word; word-break: break-all;"><tbody align="center">';
				data += '<tr><td style="width:20%;">投诉人</td><td style="width:80%;">' + result.name + '</td></tr><tr>';
				data += '<tr><td>电&nbsp;&nbsp;话</td><td>' + result.phoneNumber + '</td></tr><tr>';
				data += '<tr><td>邮&nbsp;&nbsp;箱</td><td>' + result.emailAddress + '</td></tr><tr>';
				data += '<tr><td>投诉时间</td><td>' + result.createTime + '</td></tr><tr>';
				data += '<tr><td>商家号</td><td>' + result.merchantId + '</td></tr><tr>';
				data += '<tr><td>订单号</td><td>' + result.merchantOrderId + '</td></tr><tr>';
				data += '<tr><td>交易金额</td><td>￥' + formatCurrency(result.txMoney) + '</td></tr><tr>';
				data += '</tbody></table>';
				$("#id").val(id);
				$("#complaintDetail").append(data);
			},
			error : function(data) {
				layer.alert('网络异常！', {
					skin : 'layui-layer-molv',
					icon : 5,
					closeBtn : 0,
					btnAlign : 'c', //按钮居中
					anim : 0, //动画类型
					time : 2000
				});
			}
		});
		$('#complaintModal').modal('show');
	}
	
	//查看投诉异常详情
	function showAbnormalDetail(complaintId) {
		$.ajax({
			url : "${pageContext.request.contextPath}/showAbnormalDetail?complaintId=" + complaintId,
			type : "GET",
			cache : false,
			async : false,
			erro : function(request) {
				layer.alert('网络异常！', {
					skin : 'layui-layer-molv',
					icon : 5,
					closeBtn : 0,
					btnAlign : 'c', //按钮居中
					anim : 0, //动画类型
					time : 2000
				});
			},
			success : function (data) {
				$('#complaintCheckModal').modal('show');
				var complaintMap = data.complaintMap;
				$("#complaintResult").empty();
				$("#consumerResult").empty();
				$("#merchantResult").empty();
				$("#complaintResult").append("<td>" + complaintMap.name 
						+ "</td>" + "<td>" + complaintMap.phoneNumber + "</td>"
						 + "<td>" + complaintMap.email + "</td>");
				
				var consumerMap = data.consumerMap;
				$("#consumerResult").append("<td>" + consumerMap.fingerId + "</td>" 
							 + "<td>" + consumerMap.IPAddress + "</td>"
						 	+ "<td>" + consumerMap.blankCardNo + "</td>"
						 	+ "<td>" + consumerMap.payerTelphone + "</td>");
				
				var merchantMap = data.merchantMap;
				$("#merchantResult").append("<td>" + merchantMap.merchantId 
						+ "</td>" + "<td>" + merchantMap.merchantUrl
						+ "</td>" + "<td>" + merchantMap.orderId
						+ "</td>");
			}
		});	
	}
	
</script>

<script type="text/javascript">
	$(function() {
		//投诉审核角色选择
		$.ajax({
			url : "${pageContext.request.contextPath}/queryRoleList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#groupArr").append(
								'<option value="' + data[i].roleName +'">'
										+ data[i].roleName + '</option>')
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
					time : 2000
				});
			}
		});
		
		$("#addBtn").click(function() {
			window.location.href = "addComplaintEvent";
		});

		/* $('#convertRcEventBtn')
				.click(
						function() {

							var selectRow = $("#tb_complaint").bootstrapTable(
									'getSelections');
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
								if ('未处理' == selectRow[0].status) {
									window.location.href = "${pageContext.request.contextPath }/toConvertRcEventPage?id="
											+ selectRow[0].id;
								} else {
									layer.alert('该投诉已经处理！', {
										skin : 'layui-layer-molv',
										icon : 5,
										closeBtn : 0,
										btnAlign : 'c', //按钮居中
										anim : 0, //动画类型
										time : 2000
									});
									return false;
								}
							}

						}); */

		/* $('#queryTaskBtn')
				.click(
						function() {
							window.location.href = "${pageContext.request.contextPath }/toQueryTask";
						}); */
		
		$("#cSubmitBtn").click(function() {
			var id = $("#id").val();
			var role = $("#groupArr").val();
				$.ajax({
					url : "${pageContext.request.contextPath }/complaintHandling",
					cache : false,
					type : "POST",
					data : {id:id,role:role},// 你的formid
					async : false,
					success : function(data) {
						if (data) {
							if ('success' == data.status) {
								layer.alert('投诉处理流程启动成功！', {
									skin: 'layui-layer-molv',
									icon: 1,
									closeBtn: 0,
									btnAlign: 'c', //按钮居中
									anim: 0, //动画类型
									time: 2000,
									end : function() {
										$('#complaintModal').modal('hide');
										$("#tb_complaint").bootstrapTable('refresh',
												{
													index : id
												});
									}
								});
							} else if ('fail' == data.status) {
								layer.alert('投诉处理流程启动失败！', {
									skin: 'layui-layer-molv',
									icon: 5,
									closeBtn: 0,
									btnAlign: 'c', //按钮居中
									anim: 0, //动画类型
									time: 2000,
									end : function() {
										$('#complaintModal').modal('hide');
										$("#tb_complaint").bootstrapTable('refresh',
												{
													index : id
												});
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
								$('#complaintModal').modal('hide');
							}
						});
					}
				});
		});

	});
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
										url : "${pageContext.request.contextPath}/importComplaint",
										type : "post",
										data : form,
										cache : false,
										processData : false,
										contentType : false,
										success : function(data) {
											if (data) {
												if ('success' == data.status) {
													$("#uploadModal").modal("hide");
													$("#failResult").empty();
													var failMap = data.failResult;
													var successMap = data.successResult;
													layer
															.alert(
																	'导入成功  ' 
																			+ data.successCount
																			+ ' 条投诉记录！导入失败 ' + data.failCount + ' 条投诉记录！' ,
																	{
																		skin : 'layui-layer-molv',
																		icon : 1,
																		closeBtn : 0,
																		btnAlign : 'c', //按钮居中
																		anim : 0, //动画类型
																		time : 2000,
																		end : function() {
																			if (data.failCount > 0) {
																				$("#importComplaintModal").modal("show");
																				for (var i = 0; i < failMap.length; i++) {
																					$("#failResult").append('<tr><td>' + failMap[i].complaintName 
																							+ '</td><td>' + failMap[i].phoneNumber 
																							+ '</td><td>' + failMap[i].email
																							+ '</td><td>' + failMap[i].orderId
																							/* + '</td><td>' + failMap[i].merchantId
																							+ '</td><td>' + formatCurrency(failMap[i].txMoney)
																							+ '</td><td>' + failMap[i].payclassId */
																							+ '</td><td>' + failMap[i].complaintDate
																							+ '</td></tr>');
																				}
																			} else if (successMap.length > 0) {
																				window.location.href = "${pageContext.request.contextPath }/listComplaint";
																			}
																		}
																	});
													
												} else if ('fail' == data.status) {
													$("#uploadModal").modal("hide");
													$("#failResult").empty();
													var failMap = data.failResult;
													layer
															.alert(
																	'导入失败！',
																	{
																		skin : 'layui-layer-molv',
																		icon : 5,
																		closeBtn : 0,
																		btnAlign : 'c', //按钮居中
																		anim : 0, //动画类型
																		time : 2000,
																		end : function() {
																			if (data.failCount > 0) {
																				$("#importComplaintModal").modal("show");
																				for (var i = 0; i < failMap.length; i++) {
																					$("#failResult").append('<tr><td>' + failMap[i].complaintName 
																							+ '</td><td>' + failMap[i].phoneNumber 
																							+ '</td><td>' + failMap[i].email
																							+ '</td><td>' + failMap[i].orderId
																							/* + '</td><td>' + failMap[i].merchantId
																							+ '</td><td>' + formatCurrency(failMap[i].txMoney)
																							+ '</td><td>' + failMap[i].payclassId */
																							+ '</td><td>' + failMap[i].complaintDate
																							+ '</td></tr>');
																				}
																			}
																		}
																	});
												}else if ('empty' == data.status) {
													layer
													.alert(
															'导入的数据格式有误，请您核查数据！',
															{
																skin : 'layui-layer-molv',
																icon : 5,
																closeBtn : 0,
																btnAlign : 'c', //按钮居中
																anim : 0, //动画类型
																time : 2000,
																end : function() {
																	window.location.href = "${pageContext.request.contextPath }/listComplaint";
																}
															});
												} else if ("error" == data.status) {
													layer
															.alert("出错了！稍后重试！",
																	{
																		skin : 'layui-layer-molv',
																		icon : 5,
																		closeBtn : 0,
																		btnAlign : 'c', //按钮居中
																		anim : 0, //动画类型
																		time : 2000,
																		end : function() {
																			window.location.href = "${pageContext.request.contextPath }/listComplaint";
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
<script>
	window.onload = function() {
		var file = document.querySelector("#file_css input[type='file']");
		var text = document.querySelector("#file_css input[type='text']");
		file.addEventListener("change", assign, false);
		function assign() {
			text.value = file.value;
		}
	}
	
	$("#resultCloseBtn").click(function() {
		$('#complaintCheckModal').modal('hide');
	});
	$("#importCloseBtn").click(function() {
		window.location.href = "${pageContext.request.contextPath }/listComplaint";
	});
</script>

<script>
	function downloadFile() {
		window.location.href = "${pageContext.request.contextPath }/complaint/downloadModelFile";
	}
</script>

</html>