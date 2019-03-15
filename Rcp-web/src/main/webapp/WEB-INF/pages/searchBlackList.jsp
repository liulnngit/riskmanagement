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
<script src="${pageContext.request.contextPath}/js/formatDateUtil.js"></script>
<style>
  table th{width:7%;}
  table th:nth-of-type(1){width:2%!important;}
</style>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>黑名单管理</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
								<form method="get" id="blackForm" class="form-horizontal"
									role="form">
				
									<div class="form-group">
										<label for="firstname" class="col-xs-1 control-label">关键字</label>
										<div class="col-xs-6">
											<select id="blackType" name="blackType" class="form-control" style="width:25%;float:left;">
												<option value="0">我的黑名单</option>
												<option value="1">共享黑名单</option>
											</select>
											<input type="text" class="form-control" id="searchField"
												name="searchField" placeholder="请输入要搜索的内容" style="width:75%;">
										</div>
				
										<div class="btn-toolbar" role="toolbar">
											<div class="btn-group">
												<button id="searchBtn" type="button"
													class="btn btn-primary margin-items-top">搜索</button>
											</div>
										</div>
									</div>
									<div id="toolbar" class="btn-group">
									 	<div class="btn-group">
										    <button id="addBtn" type="button" class="btn btn-primary margin-items-top">新增</button>
										</div>
										<%-- <shiro:hasRole name="Administrator">
											<div class="btn-group">
											    <button id="deleteBtn" type="button" class="btn btn-primary margin-items-top">移除</button>
											</div>
										</shiro:hasRole> --%>
										<!-- <div class="btn-group">
										    <button id="myBlackBtn" type="button" class="btn btn-primary margin-items-top">我的黑名单</button>
										</div> -->
									 </div>
								</form>
						</div>
						<div>
							<font color="red"><span style="display: none;" id="showText"></span></font>
						</div>
						<table id="tb_searchBlackUser" style="word-wrap: break-word; word-break: break-all;"></table>
				
					</div>
					<br>
					<br>
					<br>
				</div>
			</div>
		</div>
	</div>
</body>

<!-- <script type="text/javascript">
	$(function() {
		$("#searchField").blur(function() {
			var searchText = $("#searchField").val();
			if (searchText.replace(/(^\s*)|(\s*$)/g, "")=="") {
				$("#showText").show();
				$("#showText").text("搜索关键字不能为空");
			} else {
				$("#showText").hide();
			}
		});
	});
</script> -->

<script type="text/javascript">
$("#searchField").keydown(function(event){
	if(event.keyCode==13)
	{
		$("#searchBtn").click();
		$("#searchField").select();
		return false;
	}
	$("#searchField").focus();
});
	$(function() {

		//1.初始化Table
		var oTable = new myTableInit("searchMyBlackUser");
		oTable.Init();

		$('#tb_searchBlackUser').bootstrapTable('hideColumn', 'id');//隐藏某一列remark
		$('#tb_searchBlackUser').bootstrapTable('hideColumn', 'remark');

		//2.初始化Button的点击事件
		/* var oButtonInit = new ButtonInit();
		oButtonInit.Init(); */

	});
	
	
	var myTableInit = function(url) {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_searchBlackUser').bootstrapTable({
				url : url, //请求后台的URL（*）
				method : 'post', //请求方式（*）
				contentType : 'application/x-www-form-urlencoded',
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
				smartDisplay: false,//智能显示分页按钮
			    paginationPreText: "上一页",
			    paginationNextText: "下一页",
				minimumCountColumns : 2, //最少允许的列数
				clickToSelect : true, //是否启用点击选中行
				//height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
				uniqueId : "id", //每一行的唯一标识，一般为主键列
				showToggle : true, //是否显示详细视图和列表视图的切换按钮
				cardView : false, //是否显示详细视图
				undefinedText : "",
				showColumns : true,
				//detailView : false, //是否显示父子表
				singleSelect : true, //禁止多选
				columns : [ {
					checkbox : true,
					align : 'center'
				},{
					field : 'id',
					title : 'ID',
					align : 'center'
				}, {
					field : 'accountName',
					title : '用户名',
					align : 'center'
				}, {
					field : 'merchantId',
					title : '商家ID',
					align : 'center'
				}, {
					field : 'telphone',
					title : '电话号码',
					align : 'center'
				}, {
					field : 'email',
					title : '电子邮箱',
					align : 'center'
				}, {
					field : 'idCardNo',
					title : '身份证号码',
					align : 'center'
				}, {
					field : 'blankCardNo',
					title : '银行卡号',
					align : 'center'
				}, {
					field : 'IPAddress',
					title : 'IP地址',
					align : 'center'
				}, {
					field : 'url',
					title : '域名',
					align : 'center'
				},  {
					field : 'qq',
					title : 'QQ',
					align : 'center'
				}, {
					field : 'fingerId',
					title : '设备标识',
					align : 'center'
				}, {
					field : 'createName',
					title : '创建人',
					align : 'center'
				}, {
					field : 'createTime',
					title : '创建时间',
					align : 'center',
					formatter : function(value, row, index) {
						if (value !== '' && value !== null && value !== 'undefined') {
							var dateTime = new Date(parseInt(value));
							return '<span>' + dateTime.format("yyyy-MM-dd hh:mm:ss") + '</span>';
						} else {
							return '<span>' + value + '</span>';
						}
					}
				}, {
					field : 'remark',
					title : '备注',
					align : 'center'
				}, {
					field : '',
					title : '操作',
					align : 'center',
					formatter : function(value, row, index) {
						var p = '<shiro:hasRole name="Admin">';
						p += '<button id="delete" type="button" class="btn-primary" onclick="dele(\'' + row.id + '\')">移除</button>'
						p += '</shiro:hasRole>';
						return p;
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
				searchField : $("#searchField").val()
			};
			return temp;
		};
		return oTableInit;
	};
	
	/* 共享黑名单 */
	var TableInit = function(url) {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_searchBlackUser').bootstrapTable({
				url : url, //请求后台的URL（*）
				method : 'post', //请求方式（*）
				contentType : 'application/x-www-form-urlencoded',
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
				smartDisplay: false,//智能显示分页按钮
			    paginationPreText: "上一页",
			    paginationNextText: "下一页",
				minimumCountColumns : 2, //最少允许的列数
				clickToSelect : true, //是否启用点击选中行
				//height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
				uniqueId : "id", //每一行的唯一标识，一般为主键列
				showToggle : true, //是否显示详细视图和列表视图的切换按钮
				cardView : false, //是否显示详细视图
				undefinedText : "",
				showColumns : true,
				//detailView : false, //是否显示父子表
				singleSelect : true, //禁止多选
				columns : [ {
					checkbox : true,
					align : 'center'
				},{
					field : 'id',
					title : 'ID',
					align : 'center'
				}, {
					field : 'accountName',
					title : '用户名',
					align : 'center'
				}, {
					field : 'merchantId',
					title : '商家ID',
					align : 'center'
				}, {
					field : 'telphone',
					title : '电话号码',
					align : 'center'
				}, {
					field : 'email',
					title : '电子邮箱',
					align : 'center'
				}, {
					field : 'idCardNo',
					title : '身份证号码',
					align : 'center'
				}, {
					field : 'blankCardNo',
					title : '银行卡号',
					align : 'center'
				}, {
					field : 'IPAddress',
					title : 'IP地址',
					align : 'center'
				}, {
					field : 'url',
					title : '域名',
					align : 'center'
				},  {
					field : 'qq',
					title : 'QQ',
					align : 'center'
				}, {
					field : 'fingerId',
					title : '设备标识',
					align : 'center'
				}, {
					field : 'createName',
					title : '创建人',
					align : 'center'
				}, {
					field : 'createTime',
					title : '创建时间',
					align : 'center',
					formatter : function(value, row, index) {
						if (value !== '' && value !== null && value !== 'undefined') {
							var dateTime = new Date(parseInt(value));
							return '<span>' + dateTime.format("yyyy-MM-dd hh:mm:ss") + '</span>';
						} else {
							return '<span>' + value + '</span>';
						}
					}
				}, {
					field : 'remark',
					title : '备注',
					align : 'center'
				}/* , {
					field : '',
					title : '操作',
					align : 'center',
					formatter : function(value, row, index) {
						var p = '<shiro:hasRole name="Administrator">';
						p += '<button id="delete" type="button" class="btn-primary" onclick="dele(\'' + row.id + '\')">移除</button>'
						p += '</shiro:hasRole>';
						return p;
					}
				} */],
				queryParams : oTableInit.queryParams
			//传递参数（*）
			});
		};

		//得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
				searchField : $("#searchField").val()
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
	
	/* $("#myBlackBtn").click(function() {

		$("#tb_searchBlackUser").bootstrapTable('destroy');
		var oTable = new TableInit("searchBlackUser");
		oTable.Init();

		$('#tb_searchBlackUser').bootstrapTable('hideColumn', 'id');//隐藏某一列remark
		$('#tb_searchBlackUser').bootstrapTable('hideColumn', 'remark');
	 }); */
	
	//点击“查询”按钮
	/* 两种方式：
	　　1.直接刷新 $('#query_results').bootstrapTable("refresh", {});  
	　　2. 先销毁数据，再次查询，如下 */
	$("#searchBtn").bind("click",function(){
		var searchText = $("#searchField").val();
	      if (searchText.replace(/(^\s*)|(\s*$)/g, "")=="") {
	    	  //tips层
	    	  layer.tips('请输入搜索内容！', '#searchBtn ');
	      } else {
	    	  var blackType = $("#blackType").val();
	  		if ('1' == blackType) {
	  			$("#tb_searchBlackUser").bootstrapTable('destroy');
		  	    var oTable = new TableInit("searchBlackUser");
		  		oTable.Init();
		  		$('#tb_searchBlackUser').bootstrapTable('hideColumn', 'id');//隐藏某一列
		  		$('#tb_searchBlackUser').bootstrapTable('hideColumn', 'remark');
	  		} else if ('0' == blackType) {
	  		//1.初始化Table
	  			$("#tb_searchBlackUser").bootstrapTable('destroy');
	  			var oTable = new myTableInit("searchMyBlackUser");
	  			oTable.Init();

	  			$('#tb_searchBlackUser').bootstrapTable('hideColumn', 'id');//隐藏某一列remark
	  			$('#tb_searchBlackUser').bootstrapTable('hideColumn', 'remark');
	  		}
	      }
	});
	
	$("#blackType").change(function() {
		var blackType = $("#blackType").val();
  		if ('0' == blackType) {
  			$("#tb_searchBlackUser").bootstrapTable('destroy');
	  	    var oTable = new myTableInit("searchMyBlackUser");
	  		oTable.Init();
	  		$('#tb_searchBlackUser').bootstrapTable('hideColumn', 'id');//隐藏某一列
	  		$('#tb_searchBlackUser').bootstrapTable('hideColumn', 'remark');
  		} else if ('1' == blackType) {
  			$("#tb_searchBlackUser").bootstrapTable('destroy');
  			var oTable = new TableInit("searchBlackUser");
	  		oTable.Init();
	  		$('#tb_searchBlackUser').bootstrapTable('hideColumn', 'id');//隐藏某一列
	  		$('#tb_searchBlackUser').bootstrapTable('hideColumn', 'remark');
  		}
	});
	
</script>

<script type="text/javascript">
	function dele(id) {
		layer
		.confirm(
				"您确定要移除这条数据吗？",
				{
					icon : 3,
					closeBtn : 0,
					btnAlign : 'c', //按钮居中
					title : '提示'
				},
				function() {
					$.ajax({
						url : 'deleteBlackUser',
						type : 'POST',
						traditional : true,
						data : {
							"ids" : id
						},
						dataType : 'json',
						success : function(data) {
							if (data) {
								if ("success" == data.status) {
									layer.alert('移除成功！', {
										skin: 'layui-layer-molv',
										icon: 1,
										btnAlign: 'c', //按钮居中
										closeBtn: 0,
										anim: 0, //动画类型
										time: 2000,
										end : function() {
											$("#tb_searchBlackUser").bootstrapTable('hideRow', {index:id});
											$("#tb_searchBlackUser").bootstrapTable('refresh');
										}
									});
								} else {
									layer.alert('移除失败！', {
										skin: 'layui-layer-molv',
										icon: 5,
										btnAlign: 'c', //按钮居中
										closeBtn: 0,
										anim: 0, //动画类型
										time: 2000
									});
								}
							}
						},
						error : function(data) {
							layer.alert('请求失败！', {
								skin: 'layui-layer-molv',
								icon: 5,
								closeBtn: 0,
								btnAlign: 'c', //按钮居中
								anim: 0, //动画类型
								time: 2000
							});
						}
					});	
				});
	}
</script>

<script type="text/javascript">
	$(function() {
		 $("#addBtn").click(function() {
			 window.location.href = "${pageContext.request.contextPath}/blackListManagement";
		 });
		 
	});
</script>

</html>