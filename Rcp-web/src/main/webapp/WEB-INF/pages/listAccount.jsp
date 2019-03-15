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
						<h5>用户列表</h5>
					</div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="btn-group" id="toolbar">
								<button type="button" class="btn btn-primary margin-items-top"
									id="addBtn">新增用户</button>
								<!-- <button type="button" class="btn btn-primary margin-items-top" id="editBtn">修改用户</button>
							<button type="button" class="btn btn-primary margin-items-top" id="deleteBtn">删除用户</button>
							<button type="button" class="btn btn-primary margin-items-top" id="activiBtn">激活用户</button>
							<button type="button" class="btn btn-primary margin-items-top" id="resetBtn">重置密码</button> -->
								<button type="button" class="btn btn-primary margin-items-top"
									id="searchtBtn" data-toggle="modal" data-target="#searchModal">查询用户</button>
							</div>
							<div class="body-content">
								<table id="tb_listAccount"></table>
								<input type="hidden" id="jsonParam" name="jsonParam" value="" />

							</div>
							<!-- 查询模态框（Modal） -->
							<div class="modal fade" id="searchModal" tabindex="-1"
								role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="myModalLabel">查询用户</h4>
										</div>
										<div class="modal-body">
											<form id="searchForm">
												<div
													style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
													<div class="input-group">
														<span class="input-group-addon">用户名:</span> <input
															id="loginName" name="loginName" type="text"
															class="form-control" placeholder="请输入查询内容" />
													</div>
												</div>

												<div
													style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
													<div class="input-group">
														<span class="input-group-addon">邮&nbsp;&nbsp;&nbsp;&nbsp;箱:</span>
														<input id="emailAddress" name="emailAddress" type="text"
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

		$('#tb_listAccount').bootstrapTable('hideColumn', 'id');//隐藏某一列

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_listAccount')
					.bootstrapTable(
							{
								url : '${pageContext.request.contextPath }/getListAccount', //请求后台的URL（*）
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
											title : '用户Id',
											align : 'center'
										},
										{
											field : 'loginName',
											title : '用户名',
											align : 'center'
										},
										{
											field : 'emailAddress',
											title : '电子邮箱',
											align : 'center'
										},
										{
											field : 'lastLoginTime',
											title : '最近登录时间',
											align : 'center'
										},
										{
											field : 'accountStatus',
											title : '状态',
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
										}, /* {
																							field : 'updateTime',
																							title : '更新时间',
																							align : 'center'
																						}, *//*  {
																									field : 'systemName',
																									title : '系统类型',
																									align : 'center'
																								}, */
										{
											field : 'roleName',
											title : '角色名称',
											align : 'center'
										},
										{
											field : '',
											title : '操作',
											align : 'left',
											formatter : function(value, row,
													index) {
												var e = '<button href="#" class="btn-primary"  onclick="edit(\''
														+ row.id
														+ '\')">编辑</button>';
												var d = '<button href="#" class="btn-primary"  onclick="dele(\''
														+ row.id
														+ '\')">删除</button>';
												var r = '<button href="#" class="btn-primary"  onclick="reset(\''
														+ row.id
														+ '\')">重置</button>';
												var a = '';
												if ('I' == row.status) {
													e = '<button href="#" class="btn-default" disabled="disabled">编辑</button>';
													r = '<button href="#" class="btn-default"  disabled="disabled">重置</button>';
													a = '<button href="#" class="btn-primary"  onclick="activate(\''
															+ row.id
															+ '\')">激活</button>';
												}

												if ('S' == row.status) {
													d = '<button href="#" class="btn-default"  disabled="disabled">删除</button>';
												}

												return e + d + r + a;
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
		var accountData = $('#searchForm').serializeJSON();
		var jsonString = JSON.stringify(accountData);
		$("#jsonParam").val(jsonString);
		$('#tb_listAccount').bootstrapTable('destroy');
		var oTable = new TableInit();
		oTable.Init();
		$('#tb_listAccount').bootstrapTable('hideColumn', 'id');//隐藏某一列
		$('#searchModal').modal('hide');
	});

	document.onkeydown = function(e) {
		var ev = document.all ? window.event : e;
		if (ev.keyCode == 13) {
			var accountData = $('#searchForm').serializeJSON();
			var jsonString = JSON.stringify(accountData);
			$("#jsonParam").val(jsonString);
			$('#tb_listAccount').bootstrapTable('destroy');
			var oTable = new TableInit();
			oTable.Init();
			$('#tb_listAccount').bootstrapTable('hideColumn', 'id');//隐藏某一列
			$('#searchModal').modal('hide');

		}
	}
</script>

<script type="text/javascript">
	//编辑用户
	function edit(id) {
		window.location.href = "${pageContext.request.contextPath }/toEditAccountPage?selectAccountId="
				+ id;
	}

	//删除用户
	function dele(id) {
		layer.confirm("您确定要删除这条数据吗？", {
			icon : 3,
			closeBtn : 0,
			btnAlign : 'c', //按钮居中
			title : '提示'
		}, function() {
			$.ajax({
				url : '${pageContext.request.contextPath }/deleteAccount',
				type : 'POST',
				traditional : true,
				data : {
					"id" : id
				},
				dataType : 'json',
				success : function(data) {
					layer.msg(data.msg);
					if ("fail" == data.status) {
						layer.alert(data.msg, {
							skin : 'layui-layer-molv',
							icon : 5,
							closeBtn : 0,
							btnAlign : 'c', //按钮居中
							anim : 0, //动画类型
							time : 2000
						});
						return false;
					} else if ("success" == data.status) {
						layer.alert("删除成功", {
							skin : 'layui-layer-molv',
							icon : 1,
							btnAlign : 'c', //按钮居中
							closeBtn : 0,
							anim : 0, //动画类型
							time : 2000
						});
						$("#tb_listAccount").bootstrapTable('refresh', {
							index : id
						});
						return false;
					} else if ("isSystemAccount" == data.isSystemAccount) {
						layer.alert("系统用户不允许删除！", {
							skin : 'layui-layer-molv',
							icon : 5,
							closeBtn : 0,
							btnAlign : 'c', //按钮居中
							anim : 0, //动画类型
							time : 2000
						});
						return false;
					} else if ("isCurrentAccount" == data.isCurrentAccount) {
						layer.alert("当前登录用户不允许删除！", {
							skin : 'layui-layer-molv',
							icon : 5,
							closeBtn : 0,
							btnAlign : 'c', //按钮居中
							anim : 0, //动画类型
							time : 2000
						});
						return false;
					}
				},
				error : function(data) {
					layer.alert('请求失败！', {
						skin : 'layui-layer-molv',
						icon : 5,
						closeBtn : 0,
						btnAlign : 'c', //按钮居中
						anim : 0, //动画类型
						time : 2000
					});
				}
			});

		});
	}

	//激活
	function activate(id) {
		var urlPath = "${pageContext.request.contextPath }/sendActiviEmail?id="
				+ id;
		$.ajax({
			url : urlPath,
			type : 'get',
			dataType : 'json',
			success : function(data) {
				if ("success" == data.status) {
					layer.alert(data.msg, {
						skin : 'layui-layer-molv',
						icon : 1,
						closeBtn : 0,
						btnAlign : 'c', //按钮居中
						anim : 0, //动画类型
						time : 2000
					});
				}
				if ("fail" == data.status) {
					layer.alert(data.msg, {
						skin : 'layui-layer-molv',
						icon : 5,
						closeBtn : 0,
						btnAlign : 'c', //按钮居中
						anim : 0, //动画类型
						time : 2000
					});
				}
			},
			error : function(data) {
				layer.alert('激活邮件发送失败！', {
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

	//重置密码
	function reset(id) {
		var urlPath = "${pageContext.request.contextPath }/forgetPassword?id="
				+ id;
		$.ajax({
			url : urlPath,
			type : 'get',
			dataType : 'json',
			success : function(data) {
				if ("success" == data.status) {
					layer.alert(data.msg, {
						skin : 'layui-layer-molv',
						icon : 1,
						closeBtn : 0,
						btnAlign : 'c', //按钮居中
						anim : 0, //动画类型
						time : 2000
					});
					return false;
				} else if ("fail" == data.status) {
					layer.alert(data.msg, {
						skin : 'layui-layer-molv',
						icon : 5,
						closeBtn : 0,
						btnAlign : 'c', //按钮居中
						anim : 0, //动画类型
						time : 2000
					});
					return false;
				} else if ("repeat" == data.status) {
					layer.alert(data.msg, {
						skin : 'layui-layer-molv',
						icon : 5,
						closeBtn : 0,
						btnAlign : 'c', //按钮居中
						anim : 0, //动画类型
						time : 2000
					});
					return false;
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
	}
</script>

<script type="text/javascript">
	$(function() {

		$('#addBtn')
				.click(
						function() {
							window.location.href = "${pageContext.request.contextPath }/toAddAccountPage";
						});

		//清空
		$("#clearBtn").click(function() {
			$("#loginName").val("");
			$("#emailAddress").val("");
		});

	});
</script>

</html>