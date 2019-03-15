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
</head>

<body>
	<div style="margin-right: 50px; padding-top: 30px; margin-left: 50px;">
		<div id="main" style="height: 400px"></div>
		
		<c:forEach items="${orderReportDatas}" var="orderReport">
		
		   	<input type="hidden"  value="${orderReport.totalAmt}" class="amt">
			<input type="hidden"  value="${orderReport.totalCnt}" class="cnt">
			<input type="hidden"  value="${orderReport.orderDate}" class="data">
		</c:forEach>
		<center>
		<button type="button" style="float:right;" class="btn btn-primary margin-items-top"
			onclick="Dialog.getInstance('0').cancelButton.onclick.apply(Dialog.getInstance('0').cancelButton,[]);">返回</button>
	</center>
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

	//var payName = "";
	//var startTime = "";
	// var endTime = "";

	getData();

	function getData() {
		var dates = []; //日期数组（实际用来盛放X轴坐标值）
		var nums = []; //风控事件数组（实际用来盛放Y坐标值）
		var money = [];
		
		$(".cnt").each(function(index,el){
			nums.push(parseInt(el.value));
		    
		 });
		$(".amt").each(function(index,el){
			money.push(((el.value)/10000).toFixed(2));
		    
		 });
		$(".data").each(function(index,el){
			dates.push(el.value);
		    
		 });
		//console.log(dates);
			/* $.each(result, function(i, n) {
				dates.push(n["orderDate"]);
				nums.push(n["totalCnt"]);
				money.push((n["totalAmt"] / 10000).toFixed(2));
			}) */
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
	
	
	
</script>
</html>