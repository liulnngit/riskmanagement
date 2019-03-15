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
<script src="${pageContext.request.contextPath }/js/chosen.jquery.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/chosen.css">
</head>

<body class="gray-bg">
<input type="hidden" name="systemAccount" id="systemAccount" value="${systemAccount}" />
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>交易趋势报表</h5>
                    </div>
					
					<div class="ibox-content">
						<form class="form-inline" role="form">
							<table>
								<tr>
									<td>
										<div class="input-group" id ="user">
											
										</div>
									</td>
									<td>
										<div class="input-group">
											<span class="input-group-addon">商家号：</span> 
											<input type="text" id="merchantId"
												class="form-control" id="merchantId" placeholder="请输入商家号">
										</div>
									</td>
									<td>
										<div class="input-group">
											<span class="input-group-addon">支付类型:</span><div class="sel"> <select
												id="payclassId" required="required" class="form-control"
												name="payclassId">
												<option value="">-----请选择-----</option>
											</select></div>
										</div>
									</td>
									<td>
										<div class="input-group">
											<span class="input-group-addon">选择时间:</span>
											 <select
												id="searchDate" class="form-control" name="searchDate">
												<option value="0" selected="selected">七天</option>
												<option value="1">上月</option>
												<option value="2">本月</option>
												<!-- <option value="3">上季度</option> -->
												<option value="4">月份</option>
											</select>
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
	var colors = ['#CD0000', '#1E90FF', '#FF4500'];
	
	var option = {
		title : {
			text : ''
		},
		tooltip : {
			trigger : 'axis'
		},
		legend : {
			data : [ '订单笔数','交易金额' ]
		},
		grid : {
			left : '3%',
			right : '4%',
			bottom : '3%',
			containLabel : true
		},
		xAxis : [ {
			data : []
		} ],
		yAxis : [ {
			name : '订单数量(笔)',
			type : 'value',
			scale : true,
			position : 'left',
			min : 0,
			axisLabel : {
                formatter: '{value} 笔'
            },
            axisLabel: {
	            inside: false
	        }
		},{
            type : 'value',
            name : '交易金额(万元)',
            position : 'right',
            scale : true,
            axisLabel : {
                formatter: '{value} 万元'
            },
            axisLabel: {
	            inside: false
	        }
        }],
		series : [ {
			name : '订单笔数',
			type : 'line',
			//stack : '数量',
			symbol : 'emptyCircle',
			symbolSize : 4,
			yAxisIndex: 0,
			//barCategoryGap : '5%',
			//barWidth : '10',
			/* areaStyle : {
				normal : {}
			},  */
			//barWidth : 50,
			label : {
				normal : {
					show : true,
					position : 'left'
				},
			},
			"itemStyle" : {
				"normal" : {
					"color" : colors[2],
					//"barBorderRadius" : 0,
					"label" : {
						"show" : true,
						"position" : "left",
						"textStyle" : {
							"fontSize" : 13
						},
						formatter : function(p) {
							return p.value;
						}
					}
				}
			},
			data : []
		},{
			name : '交易金额',
			type : 'line',
			//stack : '数量',
			symbol : 'emptyCircle',
			symbolSize : 4,
			yAxisIndex: 1,
			//barCategoryGap : '2%',
			/* areaStyle : {
				normal : {}
			}, */
			//barWidth : 50,
			label : {
				normal : {
					show : true,
					position : 'rigth'
				},
			},
			"itemStyle" : {
				"normal" : {
					"color" : colors[1],
					//"barBorderRadius" : 0,
					"label" : {
						"show" : true,
						"position" : "rigth",
						"textStyle" : {
							"fontSize" : 13
						},
						formatter : function(p) {
							return p.value;
						}
					}
				}
			},
			data : []
		}]
	};

	// 使用刚指定的配置项和数据显示图表。
	riskChart.setOption(option, true);

	riskChart.showLoading(); //数据加载完之前先显示一段简单的loading动画

	

	function getData(userId,merchantId, payclassId, searchDate) {
		$.ajax({
			url : "${pageContext.request.contextPath}/getTransactionTrendData",
			type : "POST",
			async : false, //同步执行  
			dataType : "json",
			data : {
				merchantId:merchantId,
				payclassId:payclassId,
				searchDate:searchDate,
				systemId:userId
			},
			success : function(result) {
				var dates = []; //日期数组（实际用来盛放X轴坐标值）
				var nums = []; //风控事件数组（实际用来盛放Y坐标值）
				var money = [];
				if (result.length > 0) {
					$.each(result, function(i, n) {
						dates.push(n["orderDate"]);
						nums.push(n["totalCnt"]);
						money.push((n["totalAmt"] / 10000).toFixed(2));
					})
					riskChart.hideLoading(); //隐藏加载动画
					riskChart.setOption({ //加载数据图表
						xAxis : {
							type : 'category',
							scale : true,
							boundaryGap : true,
							data : dates
						},
						series : [{
							name : '订单笔数',
							type : 'line',
							data : nums
						},{
							name : '交易金额',
							type : 'line',
							data : money
						}]
					}); 
					
				}
				
			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				layer.alert('交易趋势报表数据请求失败！', {
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
		var merchantId = $("#merchantId").val();
		var payclassId = $("#payclassId").val();
		var searchDate = $("#searchDate").val();
		var userId = $("#userId").val();
		
		//console.log(userId);
		getData(userId,merchantId, payclassId, searchDate);
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
								$("#userId").append(
										'');
							} else {
								$("#userId").append(
										'<option value="'+data[i].systemId+'">'
												+ data[i].systemName + '</option>');
							}
							
						}
						var merchantId = "";
						var payclassId = "";
						var searchDate = $("#searchDate").val();
						var userId = $("#userId").val();
						//console.log(userId);
						getData(userId,merchantId, payclassId, searchDate);
					}
				}
			}); 
		}else{
			$("#user").append('<input type="hidden" name="userId" id="userId" value="" />');
		}
	});
</script>
<script type="text/javascript">
	$(function() {
		
		getPayclass();
		function getPayclass(){
			var userId = $("#userId").val();
			$("#payclassId").empty();
			$("#payclassId").append('<option value="">-----请选择-----</option>');
			$.ajax({
				url : "${pageContext.request.contextPath}/queryPayclassList?systemId="+userId,
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
						//$('#payclassId').chosen();
					}
				}
			});
		}
		
		$("#userId").change(function(){
			getPayclass();
		});
	});
</script>

</html>