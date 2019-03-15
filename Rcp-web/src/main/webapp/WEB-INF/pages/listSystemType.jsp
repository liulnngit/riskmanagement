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
                        <h5>接入系统管理</h5>
                    </div>
                    <div class="ibox-content">
					<div class="panel admin-panel">
						<div class="body-content">
							
								<div class="btn-group" id="toolbar">
									<button type="button" class="btn btn-primary margin-items-top" id="addBtn">新增</button>
									<!-- <button type="button" class="btn btn-primary margin-items-top" id="editBtn">修改</button>
									<button type="button" class="btn btn-primary margin-items-top" id="showDetailBtn">详情</button>
									<button type="button" class="btn btn-primary margin-items-top" id="changeStatusBtn">启用/禁用</button> -->
								</div>
								
				
									<table id="tb_listSystemType"></table>
				
								
							
						</div>
					</div>
					</div>
					<br>
					<br>
					<br>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1"
		 role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

		<!-- /.modal -->
	</div>
</body>

<script type="text/javascript">
	$(function() {

		//1.初始化Table
		var oTable = new TableInit();
		oTable.Init();

		$('#tb_listSystemType').bootstrapTable('hideColumn', 'id');//隐藏某一列

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_listSystemType').bootstrapTable({
				url : '${pageContext.request.contextPath }/getListSystemType', //请求后台的URL（*）
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
				columns : [ {
					checkbox : true,
					align : 'center'
				}, {
					field : 'systemName',
					title : '系统名称',
					align : 'center',
					formatter : function(value, row, index) {

                        var show = '<a  href="${pageContext.request.contextPath }/showSystemTypeDetail?id='+row.id+ ' "data-toggle="modal"  data-target="#myModal""><strong><u>' + value + '</strong></u></button>';

                        return show;
					}
				}, {
					field : 'systemCode',
					title : '系统编码',
					align : 'center'
				}, {
					field : 'status',
					title : '状态',
					align : 'center'
				}, {
					field : 'ipAddress',
					title : 'IP地址',
					align : 'center'
				}, {
					field : 'companyAddress',
					title : '公司地址',
					align : 'center',
					cellStyle : formatTableUnit,
					formatter : operateOpinionFormatter
				}, {
					field : 'companyDomain',
					title : '公司域名',
					align : 'center'
				}, {
					field : 'contacts',
					title : '联系人',
					align : 'center'
				}, {
					field : 'phoneNumber',
					title : '联系人电话',
					align : 'center'
				}, {
					field : 'email',
					title : '联系人邮箱',
					align : 'center'
				}, {
					field : 'createTime',
					title : '接入时间',
					align : 'center'
				}, {
					field : '',
					title : '操作',
					align : 'center',
					formatter : function(value, row, index) {
						var e = '<button href="#" class="btn-primary"  onclick="edit(\''+ row.id + '\')">编辑</button>';
						var status = '<button id="changeStatusBtn" href="#" class="btn-danger"  onclick="changeStatus(\''+ row.id + '\')">禁用</button>';
						if ('禁用' == row.status) {
							status = '<button id="changeStatusBtn" href="#" class="btn-primary"  onclick="changeStatus(\''+ row.id + '\')">启用</button>';
						}
						return e + status;
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
	function edit(id) {
		window.location.href = "${pageContext.request.contextPath }/toEditSystemTypePage?id=" + id;
	}

    $("#myModal").on("hidden.bs.modal", function() {
        $(this).removeData("bs.modal");
    });
	function showDetail(id) {
		var pageUrl = "${pageContext.request.contextPath }/showSystemTypeDetail?id=" + id;
		var diag = new Dialog();
		diag.Width = 700;
		diag.Height = 650;
		diag.Title = "接入系统详情";
		diag.URL = pageUrl;
		diag.Drag = false;
		diag.show();
	}
	
	//更新状态
	function changeStatus(id) {
		$
		.ajax({
			url : '${pageContext.request.contextPath }/changeStatus?id=' + id,
			type : 'get',
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
			beforeSend : function() {
				//在表单提交后后端未作出响应时，禁用提交按钮，提高用户体验。
				$("#changeStatusBtn").attr({
					disabled : "disabled"
				});
			},
			complete : function() {
				//后端响应后放开按钮
				$("#changeStatusBtn")
						.removeAttr("disabled");
			},
			success : function(data) {
				if ("success" == data.status) {
					layer
							.alert(
									'状态更新成功！',
									{
										skin : 'layui-layer-molv',
										icon : 1,
										btnAlign : 'c', //按钮居中
										closeBtn : 0,
										anim : 0, //动画类型
										time : 2000,
										end : function() {
											$(
													"#tb_listSystemType")
													.bootstrapTable(
															'refresh',
															{
																index : id
															});
										}
									});
				} else {
					layer
							.alert(
									'状态更新失败！',
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
</script>

<script type="text/javascript">
	$(function() {
		
		$('#addBtn')
      .click(
        function() {
        	window.location.href = "${pageContext.request.contextPath }/toAddSystemTypePage";
        });
	});	

</script>
</html>