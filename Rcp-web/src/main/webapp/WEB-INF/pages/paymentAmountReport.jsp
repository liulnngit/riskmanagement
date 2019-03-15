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
<script src="${pageContext.request.contextPath }/js/echarts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<script src="${pageContext.request.contextPath }/js/chosen.jquery.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/chosen.css">
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>支付类型交易报表</h5>
                    </div>
					
					<div class="ibox-content">
						<form class="form-inline" role="form">
							<table>
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
											<span class="input-group-addon">支付类型:</span><div class="sel"> <select
												id="payclassId" required="required" class="form-control"
												name="payclassId">
												<option value="">-----请选择-----</option>
											</select>
											<input type="hidden" id="payclassType" name="payclassType" value="0">
										</div>
										</div>
									</td>
									<td>
										<div class="input-group">
											<span class="input-group-addon">时间:</span> 
											<input type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d-%H:%m:%s'})"
												class="Wdate form-control" style="height: 34px;border: 1px solid #cccccc;" id="time" name="time"
												placeholder="请选择时间">
											<!-- <input type="text"
												onFocus="var time=$dp.$('time');WdatePicker({onpicked:function(){time.focus();},dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'time\')||\'%y-%M-%d-%H:%m:%s\'}',minDate:'#F{$dp.$D(\'time\',{M:-6})}'})"
												class="Wdate form-control"
												style="height: 34px; border: 1px solid #cccccc;" id="time"
												name="time" placeholder="请选择时间"> -->
										</div>
									</td>
									<td>
										<div class="input-group">
											<span class="input-group-addon">时间刻度:</span><div class="sel"> 
											<select
												id="timeType" required="required" class="form-control"
												name="timeType">
												<option value="hour">小时</option>
												<option value="30min">30分钟</option>
												<option value="min">分钟</option>
												
											</select>
										</div>
										</div>
									</td>
									<td>
										<button type="button" class="btn btn-primary margin-items-top"
											id="searchBtn">查询</button>
									</td>
								</tr>
							</table>
						</form>
						<div style="margin-top: 20px;">
						<pre>
						<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
						<div id="main" style="height: 500px"></div>
						</pre>
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
	//基于准备好的dom，初始化echarts实例
	var riskChart = echarts.init(document.getElementById('main'));

	// 指定图表的配置项和数据
	var colors = ['#1E90FF', '#87CEFA', '#3CB371','#90EE90', '#e5323e'];

	var option = {
		title : {
			text : ''
		},
		tooltip : {
			trigger : 'axis',
		},
		legend : {
			data : ['已完成交易金额','未完成交易金额','已完成订单数','未完成订单数','交易成功率' ]
		},    
		color:colors,
		grid : {
			left : '3%',
			right : '4%',
			bottom : '8%',
			containLabel : true
		},
		xAxis : [ {
			data : []
		} ],
		yAxis : [ {
			name : '金额(万元)',
			type : 'value',
			scale : true,
			position : 'left',
			min : 0,
            axisLabel: {
	            inside: false
	        }
		},{
            type: 'value',
            name: '订单(次数)',
            min: 0,
            position: 'right',
            /* axisLine: {
                lineStyle: {
                    color: colors[1]
                }
            } */
        },{
            type : 'value',
            name : '交易成功率(%)',
            min: 0,
            max: 100,
            position : 'right',
            offset: 80,
            scale : true,
            axisLabel : {
                formatter: '{value} %'
            },
            axisLine: {
                lineStyle: {
                    color: colors[4]
                }
            }
        }],
		series : [  
        {
            name: '已完成交易金额',
            type: 'bar',
            stack: '金额',
            data: []
        },
        {
            name: '未完成交易金额',
            type: 'bar',
            stack: '金额',
            data: []
        },
        {
            name: '已完成订单数',
            type: 'bar',
            stack: '订单',
            yAxisIndex: 1,
            data: []
        },
        {
            name: '未完成订单数',
            type: 'bar',
            stack: '订单',
            yAxisIndex: 1,
            data: []
        },
        {
            name: '交易成功率',
            type: 'bar',
            yAxisIndex: 2,
            label: {
                normal: {
                    show: true,
                    position: 'top'
                }
            },
            itemStyle:{
                normal:{
                    show: true,
                    label:{
                        formatter : function(p) {
						return p.value + "%"
					    }
                    }
                }
            },
            data: []
        }]
	};

	// 使用刚指定的配置项和数据显示图表。
	riskChart.setOption(option,true);

	 riskChart.showLoading(); //数据加载完之前先显示一段简单的loading动画

	var merchantId = "";
	var payclassId = "";
	var time = "";
	var timeStates = $("#timeType").val();
	var dataZoomEnd = 100;
	getData(merchantId,payclassId, time, timeStates,dataZoomEnd);

	function getData(merchantId,payclassId, time, timeStates,dataZoomEnd) {
		$.ajax({
			url : "${pageContext.request.contextPath}/getPayclassAmountData",
			type : "POST",
			async : false, //同步执行  
			dataType : "json",
			data : {
				merchantId:merchantId,
				payclassId:payclassId,
				time:time,
				timeStates:timeStates
			},
			success : function(result) {
				console.log(result);
				var dates = []; //日期数组（实际用来盛放X轴坐标值）
				//var total = [];
				var alreadyMoney = [];//已完成
				var notMoney = [];//未完成
				var alreadyOrder = [];
				var notOrder = [];
				var rate =[];//交易成功率
				
				if (result.length > 0) {
					$.each(result, function(i, n) {
						dates.push(n["orderDate"]);
						//total.push(n["totalCnt"]);
						//total.push((n["totalAmt"] / 10000).toFixed(2));
						alreadyMoney.push((n["successAmt"] / 10000).toFixed(2));
						notMoney.push((n["failedAmt"] / 10000).toFixed(2));
						alreadyOrder.push(n["successCNT"]);
						notOrder.push(n["failedCNT"]);
						rate.push(Math.round(n["successRate"]*10000)/100);
						
					})
					//console.log(total);
					riskChart.hideLoading(); //隐藏加载动画
					riskChart.setOption({ //加载数据图表
						dataZoom: [
					               {
					                   show: true,
					                   realtime: false,
					                   start: 0,
					                   end: dataZoomEnd
					               },
					               {
					                   type: 'inside',
					                   realtime: false,
					                   start: 0,
					                   end: dataZoomEnd
					               }
					           ],
						xAxis : {
							type : 'category',
							scale : true,
							boundaryGap : true,
							data : dates
						},
						series : [
						{
							name : '已完成交易金额',
							type : 'bar',
							data : alreadyMoney
						},{
							name : '未完成交易金额',
							type : 'bar',
							data : notMoney
						},{
							name : '已完成订单数',
							type : 'bar',
							yAxisIndex: 1,
							data : alreadyOrder
						},{
							name : '未完成订单数',
							type : 'bar',
							yAxisIndex: 1,
							data : notOrder
						},{
							name : '交易成功率',
							type : 'bar',
							yAxisIndex: 2,
							data : rate
						}]
					}); 
					
				}
				
			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				layer.alert('支付交易报表数据请求失败！', {
									skin: 'layui-layer-molv',
									icon: 5,
									closeBtn: 0,
									btnAlign: 'c', //按钮居中
									anim: 0, //动画类型
									time: 2000
								});
				riskChart.hideLoading();
			}

		});
	}
	
	$("#searchBtn").click(function() {
		payclassId = $("#payclassId").val();
		timeStates = $("#timeType").val();
		time = $("#time").val();
		merchantId = $("#merchantId").val();
		if(timeStates == "hour"){
			dataZoomEnd = 100;
		}else if(timeStates == "30min"){
			dataZoomEnd = 50
		}else if(timeStates == "min"){
			dataZoomEnd = 20;
		}
		
		getData(merchantId,payclassId, time, timeStates,dataZoomEnd);
	});
	
</script>

<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/queryPayclassList",
			type : "get",
			dataType : "json",
			contentType : "application/json",
			async : true,
			cache : false,
			success : function(data) {
				if (data) {
					for (var i = 0; i < data.length; i++) {
						$("#payclassId").append(
								'<option value="'+data[i].id+'">'
										+ data[i].name + '</option>');
					}
					$('#payclassId').chosen();
				}
			}
		});
	});
</script>

</html>