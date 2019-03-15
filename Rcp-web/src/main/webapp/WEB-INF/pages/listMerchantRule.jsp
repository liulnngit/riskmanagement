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

<script src="${pageContext.request.contextPath }/js/jquery.validate.js"></script>
<script src="${pageContext.request.contextPath }/js/messages_zh.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>商家规则</h5>
					</div>
					<div class="ibox-content">
						<form class="form-inline" id="searchForm" role="form" action="">
							<table class="table" style="margin-bottom: 0;">
								<tr>
										<!-- <button type="button" class="btn btn-primary margin-items-top"
											id="addBtn" style="padding:6px 12px;" data-toggle="modal" data-target="#addModal">添加</button> -->
										
									<td>
										<div class="input-group" style="margin-right:10px;float:left;">
											<select class="form-control" id="screenMerchant">
									          <option value="all">所有商家</option>
									          <option value="some">个性化商家</option>
									        </select>
										</div>
										<div style="width:20%;float:left;" id="addModal">
										<div class="input-group">
											<span class="input-group-addon">商家号：</span> <input type="text"
												class="form-control" id="merchantId" name="merchantId"
												placeholder="请输入商家号">
										</div>
										<button type="button" class="btn btn-primary margin-items-top"
											id="searchBtn" style="padding:6px 12px;">查询</button>
										</div>
									</td>
								</tr>
							</table>
						</form>
						<table id="tb_listMerchantRule"></table>
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
		$('#tb_listMerchantRule').bootstrapTable('hideColumn', 'id');//隐藏某一列
		//$('#tb_listRule').bootstrapTable('hideColumn', 'id');//隐藏某一列

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();

	});
	
	var url = "${pageContext.request.contextPath }/getListMerchant";
	
	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_listMerchantRule')
					.bootstrapTable(
							{
								url : url, //请求后台的URL（*）
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
								columns : [{
												field : '',
												title : '',
												align : 'center',
												formatter: function (value, row, index) {  
							                            return index+1;  
							                        } 
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
												field : 'creator',
												title : '创建人',
												align : 'center'
											},
											
											{
												field : 'updateDate',
												title : '修改时间',
												align : 'center'
											},
											{
												field : '',
												title : '个性化设置',
												align : 'center',
												formatter : function(value, row,
														index) {
													var a = "";
													var b = "";
													if(row.privateRule == "S"){
														var e = '<button  type="button" class="btn-primary" onclick="show(\''+ row.merchantId + '\')">设置</button>';
														b = '<button href="#" class="btn-danger"  onclick="disable(\''
															+ row.merchantId
															+ '\',\''
															+row.privateRule
															+ '\')">禁用</button>';
													}else{
														var e = '<button type="button" class="btn btn-primary margin-items-top" id="addBtn"  onclick="disable(\''
															+ row.merchantId
															+ '\',\''
															+row.privateRule
															+ '\')">启用</button>';
													}
													
													return e+a+b;
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
				merchantId : $("#merchantId").val()
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

	$("#screenMerchant").change(function(){
		var screenMerchant = $("#screenMerchant").val();
		if(screenMerchant=="all"){
			$("#addModal").show();
			url = '${pageContext.request.contextPath }/getListMerchant';
			$('#tb_listMerchantRule').bootstrapTable('destroy');
			var oTable = new TableInit();
			oTable.Init();
			$('#tb_listMerchantRule').bootstrapTable('hideColumn', 'id');//隐藏某一列
		}else{
			$("#addModal").hide();
			 $("#merchantId").val("");
			url = '${pageContext.request.contextPath }/getListMerchantRule';
			$('#tb_listMerchantRule').bootstrapTable('destroy');
			var oTable = new TableInit();
			oTable.Init();
			$('#tb_listMerchantRule').bootstrapTable('hideColumn', 'id');//隐藏某一列
		}
		
	}) 
	$("#searchBtn").click(function() {
		url = '${pageContext.request.contextPath }/getListMerchantRule';
		$('#tb_listMerchantRule').bootstrapTable('destroy');
		var oTable = new TableInit();
		oTable.Init();
		$('#tb_listMerchantRule').bootstrapTable('hideColumn', 'id');//隐藏某一列
		//$('#addModal').modal('hide');
	});
</script>
<script type="text/javascript">
	  
	//禁用用户
		function disable(merchantId,status) {
			console.log(status);
		    var mag= "";
		    var sta = status;
		    var status = status;
			if(sta == "S"){
				mag = "您确定要禁用个性化设置吗？";
				var status = "F";
			}else{
				mag = "您确定要启用个性化设置吗？";
				var status = "S";
			}
			layer.confirm(mag, {
				icon : 3,
				closeBtn : 0,
				btnAlign : 'c', //按钮居中
				title : '提示'
			}, function() {
				console.log(status);
				$.ajax({
					url : '${pageContext.request.contextPath }/updateMerchantPrivateRule',
					type : 'POST',
					traditional : true,
					data : {
						"merchantId" : merchantId,
						"status" :status
					},
					dataType : 'json',
					success : function(data) {
						var suc = "";
						if(sta == "S"){
							suc = "禁用成功！";
						}else{
							suc = "启用成功！";
						}
						if ("success" == data.status) {
							layer
									.alert(
											suc,
											{
												skin : 'layui-layer-molv',
												icon : 1,
												closeBtn : 0,
												btnAlign : 'c', //按钮居中
												anim : 0, //动画类型
												time : 2000,
												end : function() {
													window.location.href = "${pageContext.request.contextPath }/listMerchantRule";
												} 
											});
							//后端响应后放开按钮
							//$("#submitBtn").removeAttr("disabled");
							return;
						} else if (data.status == 'fail'){
							var fai = "";
							if(sta == "S"){
								fai = "禁用失败！";
							}else{
								fai = "启用失败！";
							}
							layer
									.alert(
											fai,
											{
												skin : 'layui-layer-molv',
												icon : 5,
												closeBtn : 0,
												btnAlign : 'c', //按钮居中
												anim : 0, //动画类型
												time : 2000,
												end : function() {
													window.location.href = "${pageContext.request.contextPath }/listMerchantRule";
												}
											});
							//后端响应后放开按钮
							//$("#submitBtn").removeAttr("disabled");
							return;
						}else if ('repeat' == data.status) {
							layer
							.alert(
									'该商家已存在！',
									{
										skin : 'layui-layer-molv',
										icon : 5,
										closeBtn : 0,
										btnAlign : 'c', //按钮居中
										anim : 0, //动画类型
										time : 2000,
										end : function() {
											window.location.href = "${pageContext.request.contextPath }/listMerchantRule";
										}
									});
							//后端响应后放开按钮
							//$("#submitBtn").removeAttr("disabled");
							return;
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
function show(merchantId) {
	window.location.href = "${pageContext.request.contextPath }/getListMerchantRuleParameter?merchantId=" + merchantId;
}
</script>

</html>
