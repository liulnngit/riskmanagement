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
						<h5>商家关联行业管理</h5>
					</div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="btn-group" id="toolbar">
								<shiro:hasRole name="Admin">
									<button type="button" class="btn btn-primary margin-items-top"
										id="setBusiness">关联行业</button>
				        			<button type="button" class="btn btn-primary margin-items-top" style="display: none;" id="deleteBtn">删除</button>
								</shiro:hasRole>
								<div class="input-group" style="margin-right: 20px;">
									<span class="input-group-addon">行业:</span> <select
										id="ssBusinessId" name="ssBusinessId" class="form-control"
										style="width: 20%;">
										<option value="">-----请选择-----</option>
									</select>
								</div>
							</div>
							<div class="body-content">

								<table id="tb_listMerchantBusiness"></table>

								<input id="searchBusinessId" type="hidden" value="${businessId}">
							</div>

							<!-- 查询模态框（Modal） -->
							<div class="modal fade" id="myModal" tabindex="-1"
								role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="myModalLabel">商家关联行业</h4>
										</div>
										<div class="modal-body">
											<form id="businessForm">
												<div
													style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
													<div class="input-group">
														<span class="input-group-addon">行业:</span> <select
															id="businessId" name="businessId"
															class="form-control">
														</select>
													</div>
													<input type="hidden" id="merchantIds" name="merchantIds">
												</div>
											</form>
										</div>
										<div class="modal-footer">
											<button id="submitBtn" type="button" class="btn btn-primary">保存</button>
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

		$('#tb_listMerchantBusiness').bootstrapTable('hideColumn', 'id');//隐藏某一列

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_listMerchantBusiness')
					.bootstrapTable(
							{
								url : '${pageContext.request.contextPath }/getListMerchant', //请求后台的URL（*）
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
								//singleSelect : true,//单选
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
											align : 'center'
										},
										{
											field : 'merchantName',
											title : '商家名称',
											align : 'center'
										},
										{
											field : 'businessName',
											title : '行业名称',
											align : 'center',
											formatter : function(value, row, index) {
												if (null == value) {
													$('#deleteBtn').css('display','none');
													value = '';
												} else {
													$('#deleteBtn').css('display','block');
												}
												
												return '<div><span>' + value + '</span></div>'
											}
										},
										{
											field : 'creator',
											title : '创建人',
											align : 'center'
										},
										{
											field : 'createDate',
											title : '创建时间',
											align : 'center'
										},
										{
											field : 'status',
											title : '状态',
											align : 'center'
										}/* ,
										{
											field : '',
											title : '操作',
											align : 'center',
											formatter : function(value, row,
													index) {
												var ptyh = '<shiro:hasRole name="Administrator">';
												ptyh += '<button type="button" class="btn-primary" onclick="edit(\''
														+ row.id
														+ '\')">编辑</button>';
												ptyh += '<button type="button" class="btn-primary" onclick="dele(\''
														+ row.id
														+ '\',\''
														+ row.merchantId
														+ '\')">删除</button>';
												ptyh += '</shiro:hasRole>';
												var user = '<shiro:hasRole name="Admin">';
												user += '<button type="button" class="btn-primary" onclick="edit(\''
														+ row.id
														+ '\')">编辑</button>';
												user += '<button type="button" class="btn-primary" onclick="dele(\''
														+ row.id
														+ '\',\''
														+ row.merchantId
														+ '\')">删除</button>';
												user += '</shiro:hasRole>';
												return ptyh + user;
											}
										}  */],
								queryParams : oTableInit.queryParams
							//传递参数（*）
							});
		};

		//得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
				businessId : $("#searchBusinessId").val()
			//根据行业id查询
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

	//根据行业id查询绑定该行业的商家
	$("#ssBusinessId").change(function() {
		$("#searchBusinessId").val($("#ssBusinessId").val());
		$('#tb_listMerchantBusiness').bootstrapTable('destroy');
		var oTable = new TableInit();
		oTable.Init();
		$('#tb_listMerchantBusiness').bootstrapTable('hideColumn', 'id');//隐藏某一列
	});
</script>

<!-- 查询行业 -->
<script type="text/javascript">
	$.ajax({
		url : "${pageContext.request.contextPath}/queryBusinessTypes",
		type : "get",
		dataType : "json",
		error : function(request) {
			layer.alert('网络异常！', {
				skin : 'layui-layer-molv',
				icon : 5,
				closeBtn : 0,
				btnAlign : 'c', //按钮居中
				anim : 0, //动画类型
				time : 2000
			});
		},
		success : function(data) {
			if (data.length > 0) {
				for (var i = 0; i < data.length; i++) {
					var id = data[i].id;
					var title = data[i].title;
					$("#ssBusinessId")
							.append(
									'<option value="' + id + '">' + title
											+ '</option>');
					
					$("#businessId")
					.append(
							'<option value="' + id + '">' + title
									+ '</option>');
				}
			}
		}
	});
</script>

<!-- 绑定行业操作 -->
<script type="text/javascript">
	$(function() {
		$("#setBusiness").click(function() {
			var selectRows = $('#tb_listMerchantBusiness').bootstrapTable('getAllSelections');
			if (selectRows.length > 0) {
				$('#myModal').modal('show');
				var array = new Array();
				for (var i = 0; i < selectRows.length; i++) {
					var merchantId = selectRows[i].merchantId;
					array.push(merchantId);
				}
				var merchantIds = array.join(",");
				$("#merchantIds").val(merchantIds);
			} else {
				layer.alert('请至少选择一条数据进行操作！', {
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
	});
</script>

<!-- 提交表单 -->
<script type="text/javascript">
	$(function() {
		$("#submitBtn").click(function() {
			var businessId = $("#businessId").val();
			var oldBusiness = $("#searchBusinessId").val();
			if (businessId == oldBusiness) {
				layer
				.alert(
						'不能与原行业相同！',
						{
							skin : 'layui-layer-molv',
							icon : 5,
							closeBtn : 0,
							btnAlign : 'c', //按钮居中
							anim : 0, //动画类型
							time : 2000
						});
			}
			else {
				$.ajax({
					cache : false,
					type : "POST",
					url : "${pageContext.request.contextPath }/addMerchantBusiness",
					data : {merchantIds:$("#merchantIds").val(),businessId:businessId,
						oldBusiness:oldBusiness},// 你的formid
					error : function(request) {
						layer.alert('网络异常！', {
							skin : 'layui-layer-molv',
							icon : 5,
							closeBtn : 0,
							btnAlign : 'c', //按钮居中
							anim : 0, //动画类型
							time : 2000
						});
					},
					beforeSend : function() {
						//在表单提交后后端未作出响应时，禁用提交按钮，提高用户体验。
						$("#submitBtn").attr({
							disabled : "disabled"
						});
					},
					complete : function() {
						//后端响应后放开按钮
						$("#submitBtn").removeAttr("disabled");
						$('#myModal').modal('hide');
					},
					success : function(data) {
						if ("sameError" == data.sameError) {
							layer
									.alert(
											'不能与原行业相同！',
											{
												skin : 'layui-layer-molv',
												icon : 5,
												closeBtn : 0,
												btnAlign : 'c', //按钮居中
												anim : 0, //动画类型
												time : 2000
											});
						} else if ("success" == data.status) {
							layer
									.alert(
											'保存成功！',
											{
												skin : 'layui-layer-molv',
												icon : 1,
												closeBtn : 0,
												btnAlign : 'c', //按钮居中
												anim : 0, //动画类型
												time : 2000,
												end : function() {
													$("#tb_listMerchantBusiness").bootstrapTable(
															'refresh');
												}
											});
						} else if ('fail' == data.status) {
							layer
									.alert(
											'保存失败！',
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
				});
			}
		});
	});
</script>

<script type="text/javascript">
	$(function() {
		$("#deleteBtn").click(function() {
			var selectRows = $('#tb_listMerchantBusiness').bootstrapTable('getAllSelections');
			layer
			.confirm(
					"您确定要删除这" + selectRows.length + "条数据吗？",
					{
						icon : 3,
						closeBtn : 0,
						btnAlign : 'c', //按钮居中
						title : '提示'
					},
					function() {
						var searchBusinessId = $("#searchBusinessId").val();
						if (selectRows.length > 0) {
							var array = new Array();
							for (var i = 0; i < selectRows.length; i++) {
								var merchantId = selectRows[i].merchantId;
								array.push(merchantId);
							}
							var merchantIds = array.join(",");
							$.ajax({
								url : "${pageContext.request.contextPath }/deleteByMerchantId",
								type : 'post',
								data : {merchantIds:merchantIds,searchBusinessId:searchBusinessId},
								traditional : true,
								dataType : 'json',
								beforeSend : function() {
									//在表单提交后后端未作出响应时，禁用提交按钮，提高用户体验。
									$("#deleteBtn").attr({
										disabled : "disabled"
									});
								},
								success : function(data) {
									if ("success" == data.status) {
										layer.alert('删除成功！', {
											skin : 'layui-layer-molv',
											icon : 1,
											closeBtn : 0,
											btnAlign : 'c', //按钮居中
											anim : 0, //动画类型
											time : 2000
										});
										$("#tb_listMerchantBusiness").bootstrapTable(
												'refresh');
										//后端响应后放开按钮
										$("#deleteBtn").removeAttr("disabled");
									} else if ("fail" == data.status) {
										layer.alert('删除失败！', {
											skin : 'layui-layer-molv',
											icon : 5,
											btnAlign : 'c', //按钮居中
											closeBtn : 0,
											anim : 0, //动画类型
											time : 2000
										});
										$("#tb_listMerchantBusiness").bootstrapTable(
											'refresh');
										//后端响应后放开按钮
										$("#deleteBtn").removeAttr("disabled");
									} else if ("deleError" == data.deleError) {
										layer.alert('删除' + data.errorMerchantId + '商家失败！', {
											skin : 'layui-layer-molv',
											icon : 5,
											btnAlign : 'c', //按钮居中
											closeBtn : 0,
											anim : 0, //动画类型
											time : 2000
										});
										$("#tb_listMerchantBusiness").bootstrapTable(
											'refresh');
										//后端响应后放开按钮
										$("#deleteBtn").removeAttr("disabled");
									} else if ('noDelete' == data.noDelete) {
										layer.alert('删除' + data.errorMerchantId + '商家失败！', {
											skin : 'layui-layer-molv',
											icon : 5,
											btnAlign : 'c', //按钮居中
											closeBtn : 0,
											anim : 0, //动画类型
											time : 2000
										});
										//后端响应后放开按钮
										$("#deleteBtn").removeAttr("disabled");
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
						} else {
							layer.alert('请至少选择一条数据进行操作！', {
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
		});
	});
</script>

<script type="text/javascript">
	//编辑
	function edit(id) {
		window.location.href = "${pageContext.request.contextPath }/showMerchantBusiness?id="
				+ id;
	}

	//删除
	function dele(id, merchantId) {
		layer
				.confirm(
						"您确定要删除商家号为" + merchantId + "的数据吗？",
						{
							icon : 3,
							closeBtn : 0,
							btnAlign : 'c', //按钮居中
							title : '提示'
						},
						function() {
							/* var chk_value = new Array();
							for ( var i in selectRow) {
								chk_value
										.push(id);
							}
							var selectIds = chk_value
									.join(","); */

							$
									.ajax({
										url : "${pageContext.request.contextPath }/deleteMerchantBusiness?id="
												+ id,
										type : 'get',
										traditional : true,
										dataType : 'json',
										success : function(data) {
											if ("success" == data.status) {
												layer.alert('删除成功！', {
													skin : 'layui-layer-molv',
													icon : 1,
													closeBtn : 0,
													btnAlign : 'c', //按钮居中
													anim : 0, //动画类型
													time : 2000
												});
												$("#tb_listMerchantBusiness")
														.bootstrapTable(
																"hideRow",
																{
																	uniqueId : id
																});
												$("#tb_listMerchantBusiness")
														.bootstrapTable(
																'refresh');
											} else {
												layer.alert('删除失败！', {
													skin : 'layui-layer-molv',
													icon : 5,
													btnAlign : 'c', //按钮居中
													closeBtn : 0,
													anim : 0, //动画类型
													time : 2000
												});
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
</script>

<script type="text/javascript">
	$(function() {
		$("#addBtn")
				.click(
						function() {
							window.location.href = "${pageContext.request.contextPath }/addMerchantBusiness";
						});

	});
</script>

</html>