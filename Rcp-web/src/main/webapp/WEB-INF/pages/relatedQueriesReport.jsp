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
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.js"></script>
	<script type="text/javascript"
			src="${pageContext.request.contextPath}/js/My97DatePicker/lang/zh-cn.js"></script>
	<script type="text/javascript"
			src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript"
			src="${pageContext.request.contextPath}/js/My97DatePicker/calendar.js"></script>
	<script type="text/javascript"
			src="${pageContext.request.contextPath }/js/jquery.serializejson.js"></script>
	<style>
		table th{width:6.5%;}
		table th:nth-of-type(5){width:8%;}
		table th:nth-of-type(15){width:8%;}
	</style>
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
	<div class="row">
		<div class="col-sm-12">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>关联查询</h5>
				</div>

				<div class="ibox-content">
					<form class="form-inline" id="searchForm" role="form" action="">
						<table class="table">
							<tr>
								<td>
									<div class="input-group">
										<span class="input-group-addon">商家号：</span> <input type="text"
																						   class="form-control" id="merchantId" name="merchantId"
																						   placeholder="请输入商家号">
									</div>
								</td>
								<td>
									<div class="input-group">
										<span class="input-group-addon">订单IP：</span>
										<input type="text" class="form-control" id="ipAddress" name="ipAddress" placeholder="请输入订单IP">
									</div>
								</td>
								<td colspan="1">
									<div class="input-group">
										<span class="input-group-addon">付款人电话：</span>
										<input type="text" class="form-control" id="mobile" name="mobile" placeholder="请输入付款人电话">
									</div>
								</td>
								<td colspan="1">
									<div class="input-group">
										<span class="input-group-addon">时间范围:</span> <input type="text"
																							onFocus="var endTime=$dp.$('endTime');WdatePicker({onpicked:function(){endTime.focus();},dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endTime\')||\'%y-%M-%d-%H:%m:%s\'}',minDate:'#F{$dp.$D(\'endTime\',{M:-6})}'})"
																							class="Wdate form-control"
																							style="height: 34px; border: 1px solid #cccccc;" id="startTime"
																							name="startTime" placeholder="请选择起始时间"> <span
											class="input-group-addon">至</span> <input type="text"
																					  onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'#F{$dp.$D(\'startTime\',{M:6})||\'%y-%M-%d-%H:%m:%s\'}'})"
																					  class="Wdate form-control"
																					  style="height: 34px; border: 1px solid #cccccc;" id="endTime"
																					  name="endTime" placeholder="请选择结束时间">
									</div>
								</td>

							</tr>
							<tr>
								<td>
									<div class="input-group">
										<span class="input-group-addon">设备指纹：</span>
										<input type="text" class="form-control" id="fingerId" name="fingerId" placeholder="请输入设备指纹">
									</div>
								</td>
								<td>
									<div class="input-group">
										<span class="input-group-addon">付款人卡号：</span>
										<input type="text" class="form-control" id="cardId" name="cardId" placeholder="请输入付款人卡号">
									</div>
								</td>
								<td colspan="1">
									<div class="input-group">
										<span class="input-group-addon">付款状态：</span>
										<select id="paymentStatus" class="form-control" name="paymentStatus">
											<option value="0">请选择</option>
											<option value="1">未支付</option>
											<option value="2">已支付</option>
										</select>
									</div>
								</td>

								<td >
									<button type="button" class="btn btn-primary margin-items-top"
											id="searchBtn" style="padding:6px 12px;">查询</button>
									<button type="button" class="btn btn-primary margin-items-top"
											id="clearBtn" style="padding:6px 12px;">清空</button>
								</td>
							</tr>
							<tr>

							</tr>

						</table>
					</form>
					<div class="row">
						<div class="col-sm-12">
							<div class="tabs-container">
								<ul class="nav nav-tabs">
									<li class="active" id="table-1"><a data-toggle="tab" href="#tab-1" aria-expanded="true">订单信息</a>
									</li>
									<li class="" id="table-2"><a data-toggle="tab" href="#tab-2" aria-expanded="false">商家号</a>
									</li>
									<li class="" id="table-3"><a data-toggle="tab" href="#tab-3" aria-expanded="false">付款人电话</a>
									</li>
									<li class="" id="table-4"><a data-toggle="tab" href="#tab-4" aria-expanded="false">设备指纹</a>
									</li>
									<li class="" id="table-5"><a data-toggle="tab" href="#tab-5" aria-expanded="false">订单IP</a>
									</li>
									<li class="" id="table-6"><a data-toggle="tab" href="#tab-6" aria-expanded="false">付款人卡号</a>
									</li>
								</ul>
								<div class="tab-content">
									<input type="hidden" name="modeName" id="modeName" value="" />
									<div id="tab-1" class="tab-pane active" style="word-wrap: break-word; word-break: break-all;">
										<div class="panel-body">
											<table id="tb_listOrder"></table>
										</div>
									</div>
									<div id="tab-2" class="tab-pane">
										<div class="panel-body">
											<table id="tb_listMerchantId"></table>
										</div>
									</div>
									<div id="tab-3" class="tab-pane">
										<div class="panel-body">
											<table id="tb_listMobile"></table>
										</div>
									</div>
									<div id="tab-4" class="tab-pane">
										<div class="panel-body">
											<table id="tb_listFingerId"></table>
										</div>
									</div>
									<div id="tab-5" class="tab-pane">
										<div class="panel-body">
											<table id="tb_listIpAddress"></table>
										</div>
									</div>
									<div id="tab-6" class="tab-pane">
										<div class="panel-body">
											<table id="tb_listCardId"></table>
										</div>
									</div>
								</div>


							</div>
						</div>
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
</body>

<script type="text/javascript">

    $(function() {
        var oTable = new TableInit();
        oTable.Init();
        var oButtonInit = new ButtonInit();
        oButtonInit.Init();

    });

    var TableInit = function() {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Init = function() {
            $('#tb_listOrder')
                .bootstrapTable(
                    {
                        url : '${pageContext.request.contextPath }/getCorOrderReport', //请求后台的URL（*）
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
                        paginationPreText : "上一页",
                        paginationNextText : "下一页",
                        //height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                        //uniqueId : "id", //每一行的唯一标识，一般为主键列
                        //showToggle : true, //是否显示详细视图和列表视图的切换按钮
                        //cardView : false, //是否显示详细视图
                        //detailView : false, //是否显示父子表
                        columns : [{
                            field : 'orderId',
                            title : '订单号',
                            align : 'center'
                        },{
                            field : 'merchantId',
                            title : '商家号',
                            align : 'center'
                        },{
                            field : 'orderDate',
                            title : '订单日期',
                            align : 'center'
                        }, {
                            field : 'txMoney',
                            title : '交易金额',
                            align : 'center',
                            formatter : function(value, row, index) {
                                var e = '<span>￥' + value + '</span>';
                                return e;
                            }
                        }, {
                            field : 'paymentStatus',
                            title : '付款状态',
                            align : 'center'
                        }, {
                            field : 'fingerId',
                            title : '设备指纹',
                            align : 'center',
                            formatter : function(value, row, index) {
                                if('null' == value) {
                                    return "";
                                }
                                return value;
                            }
                        }, {
                            field : 'payclassId',
                            title : '支付类型ID',
                            align : 'center'
                        }, {
                            field : 'payclassName',
                            title : '支付类型',
                            align : 'center'
                        }, {
                            field : 'merchantUrl',
                            title : '商家域名',
                            align : 'center'
                        },{
                            field : 'orderIp',
                            title : '订单IP',
                            align : 'center'
                        },{
                            field : 'payerTelephone',
                            title : '付款人电话',
                            align : 'center'
                        },{
                            field : 'payerCardNo',
                            title : '付款人卡号',
                            align : 'center'
                        },{
                            field : 'billCountry',
                            title : '订单地址所在国',
                            align : 'center'
                        },{
                            field : 'payChannelId',
                            title : '支付通道ID',
                            align : 'center'
                        },{
                            field : 'gatewayId',
                            title : '网关ID',
                            align : 'center'
                        },{
                            field : 'payChannelOrderId',
                            title : '支付通道订单号',
                            align : 'center'
                        }/* , {
									field : 'systemName',
									title : '系统类别',
									align : 'center'
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
                merchantId : $("#merchantId").val(),
                orderIp : $("#ipAddress").val(),
                payerTelephone:$("#mobile").val(),
                fingerId : $("#fingerId").val(),
                payerCardno : $("#cardId").val(),
                startOrderDate : $("#startTime").val(),
                endOrderDate : $("#endTime").val(),
                paymentStatus:$("#paymentStatus").val()
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
        $("#table-1").addClass('active').siblings('li').removeClass('active');

        $("#tab-1").addClass('active').siblings('.tab-pane').removeClass('active');
        $('#tb_listOrder').bootstrapTable('destroy');
        var oTable = new TableInit();
        oTable.Init();
    });
</script>
<script type="text/javascript">
    var TableInitMerchantId = function() {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Init = function() {
            $('#tb_listMerchantId')
                .bootstrapTable(
                    {
                        url : '${pageContext.request.contextPath }/getListByCorInfoAndGroup', //请求后台的URL（*）
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
                        paginationPreText : "上一页",
                        paginationNextText : "下一页",
                        //height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                        //uniqueId : "id", //每一行的唯一标识，一般为主键列
                        //showToggle : true, //是否显示详细视图和列表视图的切换按钮
                        //cardView : false, //是否显示详细视图
                        //detailView : false, //是否显示父子表
                        columns : [{
                            field : 'merchant_id',
                            title : '商家号',
                            align : 'center'
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
                merchantId : $("#merchantId").val(),
                orderIp : $("#ipAddress").val(),
                payerTelephone:$("#mobile").val(),
                fingerId : $("#fingerId").val(),
                payerCardno : $("#cardId").val(),
                startOrderDate : $("#startTime").val(),
                endOrderDate : $("#endTime").val(),
                paymentStatus:$("#paymentStatus").val(),
                groupType: 'merchant_id'
            };
            return temp;
        };
        return oTableInit;
    };
</script>
<script type="text/javascript">
    var TableInitMobile = function() {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Init = function() {
            $('#tb_listMobile')
                .bootstrapTable(
                    {
                        url : '${pageContext.request.contextPath }/getListByCorInfoAndGroup', //请求后台的URL（*）
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
                        paginationPreText : "上一页",
                        paginationNextText : "下一页",
                        //height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                        //uniqueId : "id", //每一行的唯一标识，一般为主键列
                        //showToggle : true, //是否显示详细视图和列表视图的切换按钮
                        //cardView : false, //是否显示详细视图
                        //detailView : false, //是否显示父子表
                        columns : [{
                            field : 'payer_telephone',
                            title : '付款人电话',
                            align : 'center'
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
                merchantId : $("#merchantId").val(),
                orderIp : $("#ipAddress").val(),
                payerTelephone:$("#mobile").val(),
                fingerId : $("#fingerId").val(),
                payerCardno : $("#cardId").val(),
                startOrderDate : $("#startTime").val(),
                endOrderDate : $("#endTime").val(),
                paymentStatus:$("#paymentStatus").val(),
                groupType: 'payer_telephone'
            };
            return temp;
        };
        return oTableInit;
    };
</script>
<script type="text/javascript">
    var TableInitFingerId = function() {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Init = function() {
            $('#tb_listFingerId')
                .bootstrapTable(
                    {
                        url : '${pageContext.request.contextPath }/getListByCorInfoAndGroup', //请求后台的URL（*）
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
                        paginationPreText : "上一页",
                        paginationNextText : "下一页",
                        //height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                        //uniqueId : "id", //每一行的唯一标识，一般为主键列
                        //showToggle : true, //是否显示详细视图和列表视图的切换按钮
                        //cardView : false, //是否显示详细视图
                        //detailView : false, //是否显示父子表
                        columns : [{
                            field : 'finger_id',
                            title : '设备指纹',
                            align : 'center',
                            formatter : function(value, row, index) {
                                if('null' == value) {
                                    return "";
                                }
                                return value;
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
                merchantId : $("#merchantId").val(),
                orderIp : $("#ipAddress").val(),
                payerTelephone:$("#mobile").val(),
                fingerId : $("#fingerId").val(),
                payerCardno : $("#cardId").val(),
                startOrderDate : $("#startTime").val(),
                endOrderDate : $("#endTime").val(),
                paymentStatus:$("#paymentStatus").val(),
                groupType: 'finger_id'
            };
            return temp;
        };
        return oTableInit;
    };
</script>
<script type="text/javascript">
    var TableInitIpAddress = function() {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Init = function() {
            $('#tb_listIpAddress')
                .bootstrapTable(
                    {
                        url : '${pageContext.request.contextPath }/getListByCorInfoAndGroup', //请求后台的URL（*）
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
                        paginationPreText : "上一页",
                        paginationNextText : "下一页",
                        //height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                        //uniqueId : "id", //每一行的唯一标识，一般为主键列
                        //showToggle : true, //是否显示详细视图和列表视图的切换按钮
                        //cardView : false, //是否显示详细视图
                        //detailView : false, //是否显示父子表
                        columns : [{
                            field : 'order_ip',
                            title : '订单IP',
                            align : 'center'
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
                merchantId : $("#merchantId").val(),
                orderIp : $("#ipAddress").val(),
                payerTelephone:$("#mobile").val(),
                fingerId : $("#fingerId").val(),
                payerCardno : $("#cardId").val(),
                startOrderDate : $("#startTime").val(),
                endOrderDate : $("#endTime").val(),
                paymentStatus:$("#paymentStatus").val(),
                groupType: 'order_ip'
            };
            return temp;
        };
        return oTableInit;
    };
</script>
<script type="text/javascript">
    var TableInitCardId = function() {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Init = function() {
            $('#tb_listCardId')
                .bootstrapTable(
                    {
                        url : '${pageContext.request.contextPath }/getListByCorInfoAndGroup', //请求后台的URL（*）
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
                        paginationPreText : "上一页",
                        paginationNextText : "下一页",
                        //height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                        //uniqueId : "id", //每一行的唯一标识，一般为主键列
                        //showToggle : true, //是否显示详细视图和列表视图的切换按钮
                        //cardView : false, //是否显示详细视图
                        //detailView : false, //是否显示父子表
                        columns : [{
                            field : 'payer_cardno',
                            title : '付款人卡号',
                            align : 'center'
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
                merchantId : $("#merchantId").val(),
                orderIp : $("#ipAddress").val(),
                payerTelephone:$("#mobile").val(),
                fingerId : $("#fingerId").val(),
                payerCardno : $("#cardId").val(),
                startOrderDate : $("#startTime").val(),
                endOrderDate : $("#endTime").val(),
                paymentStatus:$("#paymentStatus").val(),
                groupType: 'payer_cardno'
            };
            return temp;
        };
        return oTableInit;
    };
</script>
<script type="text/javascript">
    $("#table-1").click(function(){
        $('#tb_listOrder').bootstrapTable('destroy');
        var oTable = new TableInit();
        oTable.Init();
        var oTableMerchantId =  new TableInitMerchantId();
        oTableMerchantId.Init();
    })
    $("#table-2").click(function(){
        $('#tb_listMerchantId').bootstrapTable('destroy');
        var oTableMerchantId =  new TableInitMerchantId();
        oTableMerchantId.Init();
    })
    $("#table-3").click(function(){
        $('#tb_listMobile').bootstrapTable('destroy');
        var oTableMobile =  new TableInitMobile();
        oTableMobile.Init();
    })
    $("#table-4").click(function(){
        $('#tb_listFingerId').bootstrapTable('destroy');
        var oTableFingerId =  new TableInitFingerId();
        oTableFingerId.Init();
    })
    $("#table-5").click(function(){
        $('#tb_listIpAddress').bootstrapTable('destroy');
        var oTableIpAddress =  new TableInitIpAddress();
        oTableIpAddress.Init();
    })
    $("#table-6").click(function(){
        $('#tb_listCardId').bootstrapTable('destroy');
        var oTableCardId =  new TableInitCardId();
        oTableCardId.Init();
    })
</script>
<script type="text/javascript">
    $("#clearBtn").click(function() {
        $("#cardId").val("");
        $("#mobile").val("");
        $("#ipAddress").val("");
        $("#fingerId").val("");
        $("#startTime").val("");
        $("#endTime").val("");
        $("#merchantId").val("");
        $("#paymentStatus").val("");
    });
</script>

</html>