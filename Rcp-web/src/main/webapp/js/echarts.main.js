// 交易趋势图
require.config({
	paths : {
		echarts : 'echarts_map/build/dist'
	}
});
require([ 'echarts', 'echarts/chart/line', // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表
'echarts/chart/bar' ], function(ec) {
	var myChartColumn = echarts.init(document.getElementById('column'));
	var option = {
		title : {
			text : ''
		},
		color : [ '#C6E2FF', '#CD3333' ],
		tooltip : {
			trigger : 'axis',
		},
		legend : {
			data : [ '订单数量', '交易总金额' ],
			x : 'center',
			y : 'bottom',
			backgroundColor : '#FFF'
		},
		grid : {
			x : '50',
			y : '60',
			x2 : '100',
			y2 : '60',
			borderWidth : '0'
		},
		calculable : true,
		xAxis : [ {
			type : 'category',
			axisLabel : {
				textStyle : {
					color : '#FFFFFF'
				}
			},
			axisLine : {
				lineStyle : {
					width : '1',
					color : '#FFFFFF'
				}
			},
			splitLine : {
				lineStyle : {
					width : '0'
				}
			},
			data : []
		} ],
		yAxis : [ {
			name : '订单数量(笔)',
			type : 'value',
			position : 'left',
			axisLabel : {
				textStyle : {
					color : '#FFFFFF'
				}
			},
			axisLine : {
				lineStyle : {
					width : '1',
					color : '#FFFFFF'
				}
			},
			splitLine : {
				lineStyle : {
					width : '0'
				}
			}
		}, {
			name : '交易总金额(元)',
			type : 'value',
			position : 'right',
			axisLabel : {
				textStyle : {
					color : '#FFFFFF'
				}
			},
			axisLine : {
				lineStyle : {
					width : '1',
					color : '#FFFFFF'
				}
			},
			splitLine : {
				lineStyle : {
					width : '0'
				}
			}
		} ],
		series : [ {
			name : '订单数量',
			type : 'line',
			barWidth : '15',
			yAxisIndex : 0,
			minInterval : 1,
			itemStyle : {
				normal : {
					barBorderRadius : [ 20, 20, 20, 20 ],
					barBorderWidth : '0',
					borderColor : '#C6E2FF'
				},
				emphasis : {
					barBorderRadius : [ 20, 20, 20, 20 ]
				}
			},

			data : []

		}, {
			name : '交易总金额',
			type : 'bar',
			barWidth : '15',
			symbol : 'emptyCircle',
			symbolSize : 4,
			yAxisIndex : 1,
			itemStyle : {
				normal : {
					barBorderRadius : [ 20, 20, 20, 20 ],
					barBorderWidth : '0',
					borderColor : '#CD3333'

				},
				emphasis : {
					barBorderRadius : [ 20, 20, 20, 20 ]
				}
			},
			data : []

		} ]
	}
	var txXaxisData = [];
	var txYaxisData0 = [];
	var txYaxisData1 = [];
	getTransactionData();
	function getTransactionData() {
		$.ajax({
			url : 'getTransactionData',
			type : 'get',
			dataType : 'json',
			success : function(result) {
				if (result.length > 0) {
					var myOption = option;
					for (var i = 0; i < result.length; i++) {
						// xaxisData.shift();
						txXaxisData.push(result[i].orderDate);
						myOption.xAxis[0].data = txXaxisData;
						// yaxisData0.shift();
						txYaxisData0.push(result[i].totalCnt);
						myOption.series[0].data = txYaxisData0;
						// yaxisData1.shift();
						txYaxisData1
								.push(result[i].totalAmt);
						myOption.series[1].data = txYaxisData1;
					}
					myChartColumn.setOption(myOption);
				}
			}
		});
	}
	setInterval(function() {
		$.ajax({
			url : 'getTransactionData1',
			type : 'get',
			dataType : 'json',
			success : function(result) {
				for (var i = 0; i < result.length; i++) {
					var myOption = option;
					if (txXaxisData.length < 10) {
						txXaxisData.push(result[i].orderDate);
						myOption.xAxis[0].data = txXaxisData;
						txYaxisData0.push(result[i].totalCnt);
						myOption.series[0].data = txYaxisData0;
						txYaxisData1
								.push(result[i].totalAmt);
						myOption.series[1].data = txYaxisData1;
					} else {
						txXaxisData.shift();
						txXaxisData.push(result[i].orderDate);
						myOption.xAxis[0].data = txXaxisData;
						txYaxisData0.shift();
						txYaxisData0.push(result[i].totalCnt);
						myOption.series[0].data = txYaxisData0;
						txYaxisData1.shift();
						txYaxisData1
								.push(result[i].totalAmt);
						myOption.series[1].data = txYaxisData1;
					}
				}
				myChartColumn.setOption(myOption);
			}
		});
	}, 1000 * 60 * 1);
});

/* 数据监控 */
getdata();
getdata1();
getdata2();
setInterval(getdata, 1000 * 60 * 1);// 每隔10秒执行一次
setInterval(getdata1, 1000 * 60 * 1);
setInterval(getdata2, 1000 * 60 * 1);

function getdata() {

	$.ajax({
		url : 'getTransactionCount',
		type : 'get',
		dataType : 'json',
		success : function(result) {
			var txCount = 0;
			for (var i = 0; i < result.length; i++) {
				txCount = result[i].totalCnt;
			}
			var b = parseInt(txCount);
			show_num(b);
		}
	});
}
function getdata1() {

	$.ajax({
		url : 'getRiskEventCount',
		type : 'get',
		dataType : 'json',
		success : function(result) {
			var b = parseInt(result.riskCount);
			show_num1(b);
		}
	});
}
function getdata2() {

	$.ajax({
		url : 'getComplaintCount',
		type : 'get',
		dataType : 'json',
		success : function(result) {
			var b = parseInt(result.complaintCount);
			show_num2(b);
		}
	});
}

function show_num(n) {
	var it = $(".t_num i");
	var len = String(n).length;
	for (var i = 0; i < len; i++) {
		if (it.length <= i) {
			$(".t_num").append("<i></i>");
		}
		var num = String(n).charAt(i);
		var y = -parseInt(num) * 30; // y轴位置
		var obj = $(".t_num i").eq(i);
		obj.animate({ // 滚动动画
			backgroundPosition : '(0 ' + String(y) + 'px)'
		}, 'slow', 'swing', function() {
		});
	}
}
function show_num1(n) {
	var it = $(".t_num1 i");
	var len = String(n).length;
	for (var i = 0; i < len; i++) {
		if (it.length <= i) {
			$(".t_num1").append("<i></i>");
		}
		var num = String(n).charAt(i);
		var y = -parseInt(num) * 30; // y轴位置
		var obj = $(".t_num1 i").eq(i);
		obj.animate({ // 滚动动画
			backgroundPosition : '(0 ' + String(y) + 'px)'
		}, 'slow', 'swing', function() {
		});
	}
}
function show_num2(n) {
	var it = $(".t_num2 i");
	var len = String(n).length;
	for (var i = 0; i < len; i++) {
		if (it.length <= i) {
			$(".t_num2").append("<i></i>");
		}
		var num = String(n).charAt(i);
		var y = -parseInt(num) * 30; // y轴位置
		var obj = $(".t_num2 i").eq(i);
		obj.animate({ // 滚动动画
			backgroundPosition : '(0 ' + String(y) + 'px)'
		}, 'slow', 'swing', function() {
		});
	}
}

/* 风险事件趋势图 */

var myChartPie = echarts.init(document.getElementById('pie'));
var data = [];
var axisData = [];
var orderCount = [];
var colors = [ '#CD0000', '#1E90FF', '#FF4500' ];
var myChartPieOption = {
	title : {
		text : ''
	},
	grid : [ {
		x : '7%',
		y : '8%',
		width : '88%',
		height : '70%'
	}, ],
	color : [ '#FF4500', '#24be9b' ],
	tooltip : {
		trigger : 'axis'
	},
	legend : {
		data : [ '事件数'/*, '订单数量' */],
		x : 'center',
		y : 'bottom',
		backgroundColor : '#FFF'
	},

	xAxis : [ {
		type : 'category',
		boundaryGap : true,
		axisLabel : {
			textStyle : {
				color : '#eee'
			}
		},
		axisLine : {
			lineStyle : {
				width : '1',
				color : '#eee'
			}
		},
		splitLine : {
			lineStyle : {
				width : '0',
				color : '#eee'
			}
		},
		data : []
	} ],
	yAxis : [ {
		// name : '数量',
		type : 'value',
		// max: 12,
		// min: 0,
		minInterval : 1,
		axisLabel : {
			textStyle : {
				color : '#eee'
			}
		},
		axisLine : {
			lineStyle : {
				width : '1',
				color : '#eee'
			}
		},
		splitLine : {
			lineStyle : {
				width : '1',
				type : 'dashed',
				color : '#eee'
			}
		},
		data : []
	} /*
		 * , { name : '订单笔数(笔)', type : 'value', // max: 12, // min: 0,
		 * axisLabel : { textStyle : { color : '#eee' } }, axisLine : {
		 * lineStyle : { width : '1', color : '#eee' } }, splitLine : {
		 * lineStyle : { width : '1', type: 'dashed', color : '#eee' } }, data : [] }
		 */],
	series : [ {
		name : '事件数',
		symbol : 'emptyCircle',
		symbolSize : 4,
		smooth : true,
		yAxisIndex : 0,
		animation : true,
		"itemStyle" : {
			"normal" : {
				// "color" : colors[2],
				"barBorderRadius" : 0,
				"label" : {
					"show" : true,
					"position" : "left",
					"textStyle" : {
						"fontSize" : 15
					},
					formatter : function(p) {
						return p.value > 0 ? (p.value) : '';
					}
				}
			}
		},
		type : 'line',
		data : []
	}/*, {
		name : '订单数量',
		symbol : 'emptyCircle',
		symbolSize : 4,
		smooth : true,
		yAxisIndex : 0,
		animation : true,
		"itemStyle" : {
			"normal" : {
				// "color" : colors[2],
				"barBorderRadius" : 0,
				"label" : {
					"show" : true,
					"position" : "rigth",
					"textStyle" : {
						"fontSize" : 15
					},
					formatter : function(p) {
						return p.value > 0 ? (p.value) : '';
					}
				}
			}
		},
		type : 'line',
		data : []

	}*/ ]
}

getRiskEventData();
var xaxisData = [];
var yaxisData1 = [];
//var yaxisData2 = [];
function getRiskEventData() {
	$.ajax({
		url : 'getRiskEventData',
		type : 'get',
		dataType : 'json',
		success : function(result) {
			var myOption = myChartPieOption;
			xaxisData = result.times;
			yaxisData1 = result.riskCounts;
			//yaxisData2 = result.txCount;
			myOption.xAxis[0].data = xaxisData;
			myOption.series[0].data = yaxisData1;
			//myOption.series[1].data = yaxisData2;
			myChartPie.setOption(myOption);
		}
	});
}

setInterval(function() {
	$.ajax({
		url : 'getRiskEventData2',
		type : 'get',
		dataType : 'json',
		success : function(result) {
			var myOption = myChartPieOption;
			console.log(xaxisData.length);
			if (xaxisData.length < 10) {
				xaxisData.push(result.time);
				myOption.xAxis[0].data = xaxisData;
				yaxisData1.push(result.riskCount);
				myOption.series[0].data = yaxisData1;
				//yaxisData2.push(result.txCount);
				//myOption.series[1].data = yaxisData2;
			} else {
				xaxisData.shift();
				xaxisData.push(result.time);
				myOption.xAxis[0].data = xaxisData;
				yaxisData1.shift();
				yaxisData1.push(result.riskCount);
				myOption.series[0].data = yaxisData1;
				//yaxisData2.shift();
				//yaxisData2.push(result.txCount);
				//myOption.series[1].data = yaxisData2;
			}
			myChartPie.setOption(myOption);
		}
	});
}, 1000 * 60 * 1);

/* 支付类型分布图 */

	var myChartMain6 = echarts.init(document.getElementById('main3'));
	var myChartOption6 = {
		title : {
			text : ''
		},
		tooltip : {
			trigger : 'item',
			formatter : "{a} <br/>{b} : {c} ({d}%)"
		},
		/*
		 * color : ['#4169e1', '#0000ff', '#00fa9a', '#00bc00', '#f75000',
		 * '#ffd00a', '#e505e1', '#ff0082', '#EE0000'],
		 */
		legend : {
			type : 'scroll',
			orient : 'horizontal',
			x : 'center',
			y : 'bottom',
			textStyle : {
				fontSize : '10',
				color : '#fff'
			},
			data : []
		},

		/*
		 * toolbox : { show : false, feature : { mark : { show : true },
		 * dataView : { show : true, readOnly : false }, magicType : { show :
		 * true, type : [ 'pie', 'funnel' ] }, restore : { show : true },
		 * saveAsImage : { show : true } } },
		 */

		// calculable : true,
		series : [ {
			name : '支付类型',
			type : 'pie',
			radius : [ 0, '50%' ],
			center : [ '50%', '50%' ],
			roseType : 'area',

			data : [],
			itemStyle : {
				normal : {
					label : {
						show : true,
						position : 'outer',
						formatter : "{b}\n {c} ({d}%)",
						textStyle : {
							fontSize : '10'
						}
					},
					labelLine : {
						show : true,
						length : -10
					}
				},
				emphasis : {
					shadowBlur : 10,
					shadowOffsetX : 0,
					shadowColor : 'rgba(0, 0, 0, 0.5)'
				}
			}
		} ]
	}
	/* myChart.setOption(option); */
	getPayclassData();
	function getPayclassData(result) {
		$.ajax({
			url : 'getBrokenEventData',
			type : 'get',
			dataType : 'json',
			success : function(result) {
				var myOption = myChartOption6;
				if (result.length > 0) {
					var color = [];
					var arr = [];
					for (var i = 0; i < result.length; i++) {
						arr.push(result[i].name);
					}
					myChartMain6.hideLoading();    //隐藏加载动画
					// myOption.legend.data = arr;
					myOption.series[0].data = result;
				} else {
					myChartMain6.hideLoading();    //隐藏加载动画
					// myOption.legend.data = arr;
					myOption.series[0].data = [];
				}
				myChartMain6.clear();
				myChartMain6.setOption(myOption);
			}, 
			error : function(result) {
				myChartMain6.showLoading();  //数据加载完之前先显示一段简单的loading动画
			}
		});
	}

	setInterval(getPayclassData, 1000 * 60 * 1);

/* 风险级别分布 */
	var myChartMain3 = echarts.init(document.getElementById('main6'));
	var myChartOption3 = {
		title : {
			text : ''
		},
		tooltip : {
			trigger : 'item',
			formatter : "{a} <br/>{b} : {c} ({d}%)"
		},
		/*
		 * color : ['#4169e1', '#0000ff', '#00fa9a', '#00bc00', '#f75000',
		 * '#ffd00a', '#e505e1', '#ff0082', '#EE0000'],
		 */
		legend : {
			orient : 'horizontal',
			x : 'center',
			y : 'bottom',
			textStyle : {
				fontSize : '10',
				color : '#fff'
			},
			data : []
		},

		/*
		 * toolbox : { show : false, feature : { mark : { show : true },
		 * dataView : { show : true, readOnly : false }, magicType : { show :
		 * true, type : [ 'pie', 'funnel' ] }, restore : { show : false },
		 * saveAsImage : { show : false } } },
		 */

		calculable : true,

		series : [ {
			name : '风险级别',
			type : 'pie',
			radius : [ 0, '50%' ],
			center : [ '50%', '50%' ],
			// roseType : 'area',

			data : [],
			itemStyle : {
				normal : {
					label : {
						show : true,
						position : 'outer',
						formatter : "{d}%"
					},
					labelLine : {
						show : true,
						length : -1
					}
				},
				emphasis : {
					shadowBlur : 10,
					shadowOffsetX : 0,
					shadowColor : 'rgba(0, 0, 0, 0.5)'
				}
			}
		} ]
	}
	myChartMain3.setOption(myChartOption3);
	myChartMain3.showLoading();
	getRiskData();
	function getRiskData(result) {
		$.ajax({
			url : 'queryRiskLevelData',
			type : 'get',
			dataType : 'json',
			success : function(result) {
				var myOption = myChartOption3;
				var color = [];
				if (result.length > 0) {
					for (var i = 0; i < result.length; i++) {
						var name = result[i].name;
						if (name == '高Ⅲ') {
							color.push('#EE0000');
						} else if (name == '高Ⅱ') {
							color.push('#ff0082');
						} else if (name == '高Ⅰ') {
							color.push('#e505e1');
						} else if (name == '中Ⅲ') {
							color.push('#ffd00a');
						} else if (name == '中Ⅱ') {
							color.push('#f75000');
						} else if (name == '中Ⅰ') {
							color.push('#00bc00');
						} else if (name == '低Ⅲ') {
							color.push('#00fa9a');
						} else if (name == '低Ⅱ') {
							color.push('#0000ff');
						} else if (name == '低Ⅰ') {
							color.push('#4169e1');
						}
					}
					myChartMain3.hideLoading();    //隐藏加载动画
					myOption.color = color;
					console.log(color);
					console.log(myOption.color);
					myOption.series[0].data = result;
				} else {
					myChartMain3.hideLoading();    //隐藏加载动画
					myOption.color = color;
					myOption.series[0].data = [];
				}
				myChartMain3.clear();
				myChartMain3.setOption(myOption,true);
			},
			error : function(result) {
				myChartMain3.showLoading();  //数据加载完之前先显示一段简单的loading动画
			}
		});
	}

	setInterval(getRiskData, 1000 * 60 * 1);


/* 地图 */
require.config({
	paths : {
		echarts : 'echarts_map/build/dist'
	}
});
require([ 'echarts', 'echarts/chart/map' // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表
], function(ec) {
	var myChartMap = ec.init(document.getElementById('map'));
	var option = {
		title : {
			text : ''
		},
		tooltip : {
			trigger : 'item',
			formatter : '{b}'
		},
		series : [ {
			name : '实时风险',
			type : 'map',
			mapType : 'world',
			selectedMode : 'single',
			itemStyle : {
				normal : {
					borderWidth : 1,
					borderColor : '#c6fdff',
					color : '#0c7289',
					label : {
						show : false,
						areaStyle : {
							color : 'red'
						}
					}
				},
				emphasis : {// 选中样式
					borderWidth : 1,
					borderColor : '#fff',
					color : '#66b8ce',
					label : {
						show : true,
						textStyle : {
							color : '#BF3EFF'
						}
					}
				}
			},
			data : [],
			markPoint : {
				symbol : 'circle',
				symbolSize : 10,
				effect : {
					show : true,
					shadowBlur : 0,
					color : '#ff3333'// 标注的颜色
				},
				itemStyle : {
					normal : {
						label : {
							show : true
						}
					}
				},
				data : []
			}
		} ]
	}
	// myChartMap.setOption(option);
	getData();

	function getData() {
		$.ajax({
			url : 'getWolrdData1',
			type : 'get',
			dataType : 'json',
			success : function(result) {
				if (result) {
					var myOption = option;

					var a = "[";
					var geos = result.geos;
					$.each(geos, function(index, content) {
						if (index == 0) {
							a += "{name:" + "'" + content.name + "'"
									+ ",geoCoord:" + content.geoCoord
									+ ",value:" + "'" + content.value + "'"
									+ "}";
						} else {
							a += ",{name:" + "'" + content.name + "'"
									+ ",geoCoord:" + content.geoCoord
									+ ",value:" + "'" + content.value + "'"
									+ "}";
						}
					});
					a += "]";
					function colorType(color) {
						if (color == '高Ⅲ') {
							return '#EE0000';
						} else if (color == '高Ⅱ') {
							return '#ff0082';
						} else if (color == '高Ⅰ') {
							return '#e505e1';
						} else if (color == '中Ⅲ') {
							return '#ffd00a';
						} else if (color == '中Ⅱ') {
							return '#f75000';
						} else if (color == '中Ⅰ') {
							return '#00bc00';
						} else if (color == '低Ⅲ') {
							return '#00fa9a';
						} else if (color == '低Ⅱ') {
							return '#0000ff';
						} else if (color == '低Ⅰ') {
							return '#4169e1';
						}

					}
					var obj = eval(a);
					if (obj.length > 0) {
						for (var i = 0; i < obj.length; i++) {
							myOption.series.push({
								name : '实时风险',
								type : 'map',
								mapType : 'world',
								selectedMode : 'single',
								itemStyle : {
									normal : {
										borderWidth : 1,
										borderColor : '#c6fdff',
										color : '#0c7289',
										label : {
											show : false,
											areaStyle : {
												color : 'red'
											}
										}
									},
									emphasis : {
										borderWidth : 1,
										borderColor : '#fff',
										color : "#66b8ce",
										label : {
											show : false,
											textStyle : {
												color : '#BF3EFF'
											}
										}
									}
								},
								data : [ {
									selected : true,
									name : geos[i].name,
									value : geos[i].value
								} ],
								markPoint : {
									symbol : 'circle',
									symbolSize : 8,
									effect : {
										show : true,
										shadowBlur : 0,
										color : colorType(geos[i].value)
									},
									itemStyle : {
										normal : {
											label : {
												formatter : '{b}',
												position : 'right',
												show : true
											}
										}
									},
									label : {
										normal : {
											formatter : '{b}',
											position : 'right',
											show : true
										}
									},
									zlevel : 9,
									data : [ {
										name : obj[i].name,
										geoCoord : obj[i].geoCoord
									} ]
								}

							});
						}
						myChartMap.clear();
						myChartMap.setOption(myOption);
						myOption.series = [];
					} else {
						option.series.push({
							name : '实时风险',
							type : 'map',
							mapType : 'world',
							selectedMode : 'single',
							itemStyle : {
								normal : {
									borderWidth : 1,
									borderColor : '#c6fdff',
									color : '#0c7289',
									label : {
										show : false,
										areaStyle : {
											color : 'red'
										}
									}
								},
								emphasis : {// 选中样式
									borderWidth : 1,
									borderColor : '#fff',
									color : '#66b8ce',
									label : {
										show : true,
										textStyle : {
											color : '#BF3EFF'
										}
									}
								}
							},
							data : [],
							markPoint : {
								symbol : 'circle',
								symbolSize : 10,
								effect : {
									show : true,
									shadowBlur : 0,
									color : '#ff3333'// 标注的颜色
								},
								itemStyle : {
									normal : {
										label : {
											show : true
										}
									}
								},
								data : []
							}
						});
						myChartMap.clear();
						myChartMap.setOption(option);
						option.series = [];
					}

				}
			}
		})
	}

	setInterval(getData, 1000 * 60 * 1);
});

// 当天实时交易金额
setNumber();
var number = 0;

function setNumber() {
	$.ajax({
		url : 'getTransactionCount',
		type : 'get',
		dataType : 'json',
		success : function(result) {
			for (var i = 0; i < result.length; i++) {
				var txMoney = result[i].totalAmt;
				number = parseFloat((txMoney / 10000).toFixed(2));
			}
			$.animateToPrice(number);
			
		}
	});
}

function getTxMoney() {
	$.ajax({
		url : 'getTransactionMoneySum',
		type : 'get',
		dataType : 'json',
		success : function(result) {
			if (result.length > 0) {
				for (var i = 0; i < result.length; i++) {
					number = number
							+ parseFloat((result[i].totalAmt / 10000)
									.toFixed(2));
				}
				$.animateToPrice(number);
			}
		}
	});
}

setInterval(getTxMoney, 1000 * 60 * 1);

