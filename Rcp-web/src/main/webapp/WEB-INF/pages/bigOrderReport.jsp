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
<%@ include file="../commons/sourceFile.jsp" %>	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/lang/zh-cn.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/calendar.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/formatDateUtil.js"></script>
</head>

<body class="gray-bg">
<input type="hidden" name="systemAccount" id="systemAccount" value="${systemAccount}" />
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>大额订单报表</h5>
                    </div>
					<div class="ibox-content">
						<form class="form-inline" id="searchForm" role="form" action="">
							<table class="table">
								<tr>
									<td>
										<div class="input-group" id ="user">
											
										</div>
										<div class="input-group">
											<span class="input-group-addon">订单号：</span> <input type="text"
												class="form-control" id="orderId" name="orderId"
												placeholder="请输入订单号">
										</div>
									</td>
									<td>
										
										<div class="input-group" style="margin-right:4%;">
											<span class="input-group-addon">商家号：</span> <input type="text"
												class="form-control" id="merchantId" name="merchantId"
												placeholder="请输入商家号">
										</div>
										<div class="input-group">
											<span class="input-group-addon">交易IP地址：</span> <input type="text"
												class="form-control" id="ipAddress" name="ipAddress"
												placeholder="请输入交易IP地址">
										</div>
									</td>
									
								</tr>
								<tr>
									<td>
										<div class="input-group" style="margin-right:8%;">
											<span class="input-group-addon">设备标识：</span> <input type="text"
												class="form-control" id="fingerId" name="fingerId"
												placeholder="请输入设备标识">
										</div>
									</td>
									<td>
										
										<div class="input-group" style="margin-right:11%;">
											<span class="input-group-addon">时间范围:</span> 
											<input type="text" onFocus="var endTime=$dp.$('endTime');WdatePicker({onpicked:function(){endTime.focus();},dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endTime\')||\'%y-%M-%d-%H:%m:%s\'}',minDate:'#F{$dp.$D(\'endTime\',{M:-6})}'})"
												class="Wdate form-control" style="height: 34px;border: 1px solid #cccccc;" id="startTime" name="startTime"
												placeholder="请选择起始时间"> 
												<span
												class="input-group-addon">至</span> 
												<input type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'#F{$dp.$D(\'startTime\',{M:6})||\'%y-%M-%d-%H:%m:%s\'}'})"
												class="Wdate form-control" style="height: 34px;border: 1px solid #cccccc;"  id="endTime" name="endTime"
												placeholder="请选择结束时间">
										</div>
										<button type="button" class="btn btn-primary margin-items-top"
											id="searchBtn" style="padding: 6px 12px;">查询</button>
										<button type="button" class="btn btn-primary margin-items-top"
											id="clearBtn" style="padding: 6px 12px;">清空</button>	
									</td>
								</tr>
							</table>
							<hr>
						</form>
						<div style="margin-left: 0px;margin-right: 0px">
						<table id="tb_listBigOrder"></table>
					</div>
					</div>
					
					<br>
					<br>
					<br>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	$(function() {

		//1.初始化Table
		

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		//console.log($("#userId").val());
		oTableInit.Init = function() {
			$('#tb_listBigOrder').bootstrapTable({
				url : '${pageContext.request.contextPath }/getBigOrderReport', //请求后台的URL（*）
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
				smartDisplay: false,//智能显示分页按钮
			    paginationPreText: "上一页",
			    paginationNextText: "下一页",
				//height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
				//uniqueId : "id", //每一行的唯一标识，一般为主键列
				//showToggle : true, //是否显示详细视图和列表视图的切换按钮
				//cardView : false, //是否显示详细视图
				//detailView : false, //是否显示父子表
				columns : [ {
					field : 'orderId',
					title : '订单号',
					align : 'center'
				}, {
					field : 'merchantId',
					title : '商家号',
					align : 'center'
				}, {
					field : 'fingerId',
					title : '设备标识',
					align : 'center',
          formatter : function(value, row, index) {
       	    if('null' == value) {
       	    	return "";
       	    }
             return value;
           }
				}, {
					field : 'ipAddress',
					title : '交易IP地址',
					align : 'center'
				}, {
					field : 'txMoney',
					title : '交易金额',
					align : 'center',
					formatter : function(value, row, index) {
                        if (value != '' && value != 'null' && value != 'undefined') {
                            value = '￥' + formatCurrency(value);
                        }
                        var e = '<span>' + value + '</span>';
                        return e;
					}
				}, {
					field : 'orderCreateDate',
					title : '订单创建时间',
					align : 'center'
				}/* , {
					field : 'systemName',
					title : '系统类别',
					align : 'center'
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
				orderId : $("#orderId").val(),
				ipAddress : $("#ipAddress").val(),
				fingerId : $("#fingerId").val(),
				startTime : $("#startTime").val(),
				endTime : $("#endTime").val(),
				merchantId : $("#merchantId").val(),
				systemId:$("#userId").val()
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
	
	$("#searchBtn").click(function() {
		$('#tb_listBigOrder').bootstrapTable('destroy');
		var oTable = new TableInit();
		oTable.Init();
	});
	
</script>
		
<script type="text/javascript">
$("#clearBtn").click(function() {
	$("#orderId").val("");
	$("#ipAddress").val("");
	$("#fingerId").val("");
	$("#startTime").val("");
	$("#endTime").val("");
	$("#merchantId").val("");
});
</script>		
<script type="text/javascript">
	$(function() {
		
		var systemAccount = $("#systemAccount").val();
		if(systemAccount =='1'){
			$("#user").append('<span class="input-group-addon">系统:</span><div class="sel"> <select id="userId" required="required" class="form-control" name="userId"> </select></div>');
			//$("#userId").append('<option value="1">1</option>');
			$.ajax({
				url : "${pageContext.request.contextPath}/getAllAdmin",
				type : "post",
				dataType : "json",
				contentType : "application/json",
				async : true,
				cache : false,
				success : function(data) {
					if (data) {
						for (var i = 0; i < data.length; i++) {
							if ('PTYH' == data[i].systemCode) {
								$("#userId").append('');
							} else {
								$("#userId").append(
										'<option value="'+data[i].systemId+'">'
												+ data[i].systemName + '</option>');
							}
							
						}
						var oTable = new TableInit();
						oTable.Init();

						//$('#tb_notice').bootstrapTable('hideColumn', 'id');//隐藏某一列

						//2.初始化Button的点击事件
						var oButtonInit = new ButtonInit();
						oButtonInit.Init();
					}
				}
			}); 
		}else{
			$("#user").append('<input type="hidden" name="userId" id="userId" value="" />');
		}
		
	});
</script>
</html>