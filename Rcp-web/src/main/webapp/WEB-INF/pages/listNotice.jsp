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
                        <h5>公告管理</h5>
                    </div>
                    <div class="ibox-content">
					<div class="panel admin-panel">
						<div class="btn-group" id="toolbar">
						  <shiro:hasRole name="Administrator">
								<button type="button" class="btn btn-primary margin-items-top" id="addBtn">新增公告</button>
								<!-- <button type="button" class="btn btn-primary margin-items-top" id="editBtn">修改公告</button>
								<button type="button" class="btn btn-primary margin-items-top" id="deleteBtn">删除公告</button> -->
						  </shiro:hasRole>
							<!-- <button type="button" class="btn btn-primary margin-items-top" id="showBtn">查看公告</button> -->
						</div>
						<div class="body-content">
							<table id="tb_notice"></table>	
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

		$('#tb_notice').bootstrapTable('hideColumn', 'id');//隐藏某一列

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_notice').bootstrapTable({
				url : '${pageContext.request.contextPath }/getListNotice', //请求后台的URL（*）
				method : 'get', //请求方式（*）
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
				minimumCountColumns : 2, //最少允许的列数
				clickToSelect : true, //是否启用点击选中行
				smartDisplay: false,//智能显示分页按钮
				escape : true,
			    paginationPreText: "上一页",
			    paginationNextText: "下一页",
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
					title : '公告Id',
					align : 'center'
				}, {
					field : 'title',
					title : '公告标题',
					align : 'center',
					formatter : function(value, row, index) {
						var detail = '<a  href="${pageContext.request.contextPath }/showNoticeDetail?id='+row.id+ ' "data-toggle="modal"  data-target="#myModal""><strong><u>' + value + '</strong></u></button>';
						return detail;
					}
				}, {
					field : 'content',
					title : '公告内容',
					align : 'center',
					cellStyle : formatTableUnit,
					formatter : operateOpinionFormatter
					
				}, {
					field : 'creator',
					title : '创建人',
					align : 'center'
				}, {
					field : 'createTime',
					title : '创建时间',
					align : 'center'
				}, {
					field : 'updateTime',
					title : '更新时间',
					align : 'center'
				}, {
					field : 'updater',
					title : '更新人',
					align : 'center'
				}, {
					field : 'status',
					title : '状态',
					align : 'center'
				}, {
					field : '',
					title : '操作',
					align : 'center',
					formatter : function(value, row, index) {
						var ptyh = '<shiro:hasRole name="Administrator">';
						ptyh += '<button id="editBtn" type="button" class="btn-primary" onclick="edit(\''+ row.id + '\')">编辑</button>';
						ptyh += '<button id="deleteBtn" type="button" class="btn-primary" onclick="dele(\''+ row.id + '\')">删除</button>';
						ptyh += '</shiro:hasRole>';
						var detail = '<button class="btn-primary" style="border-radius: 0px;padding: 4px 4px 4px 4px;" href="${pageContext.request.contextPath }/showNoticeDetail?id='+row.id+ '"data-toggle="modal"  data-target="#myModal"">查看</button>';
						return ptyh + detail;
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
			return "<span title='"+value+"'>"
			+ "" + "</span>";
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
    $("#myModal").on("hidden.bs.modal", function() {
        $(this).removeData("bs.modal");
    });
	//查看详情
	function showDetail(id) {
		var pageUrl = "${pageContext.request.contextPath }/showNoticeDetail?id=" + id;
		var diag = new Dialog();
		diag.Width = 600;
		diag.Height = 400;
		diag.Title = "公告详情";
		diag.URL = pageUrl;
		diag.Drag = false;
		diag.show();
	}
	
	//编辑
	function edit(id) {
		window.location.href = "${pageContext.request.contextPath }/toEditNoticePage?selectNoticeId=" + id;
	}
	
	//删除
	function dele(id) {
		layer
		.confirm(
				"您确定要删除这条数据吗？",
				{
					icon : 3,
					closeBtn : 0,
					btnAlign: 'c', //按钮居中
					title : '提示'
				},
				function() {
					/* var chk_value = new Array();
					for ( var i in selectRow) {
						chk_value
								.push(selectRow[i].id);
					}
					var noticeIds = chk_value
							.join(","); */

					$
							.ajax({
								url : "${pageContext.request.contextPath }/deleteNotice",
								type : 'POST',
								traditional : true,
								data : {
									"noticeIds" : id
								},
								dataType : 'json',
								success : function(
										data) {
									if ("success" == data.status) {
										layer.alert('删除成功！', {
											skin: 'layui-layer-molv',
											icon: 1,
											closeBtn: 0,
											btnAlign: 'c', //按钮居中
											anim: 0, //动画类型
											time: 2000
										});
										$(
										"#tb_notice")
										.bootstrapTable(
												"hideRow",
												{
													uniqueId : id
												}); 
								$("#tb_notice").bootstrapTable('refresh');
									} else {
										layer.alert('删除失败！', {
											skin: 'layui-layer-molv',
											icon: 5,
											btnAlign: 'c', //按钮居中
											closeBtn: 0,
											anim: 0, //动画类型
											time: 2000
										});
									}
								},
								error : function(
										data) {
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
		$("#addBtn")
				.click(
						function() {
							window.location.href = "${pageContext.request.contextPath }/toAddNoticePage";
						});
	});
</script>

</html>