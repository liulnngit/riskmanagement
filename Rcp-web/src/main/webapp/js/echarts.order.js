	// 基于准备好的dom，初始化echarts实例
var orderChart = echarts.init(document.getElementById('ordermain'));


/*option = {
    title: {
        text: '',
        subtext: ''
    },
    legend: {
        data:['交易总金额','订单数量']
    },
    tooltip: {},
    xAxis: {
        data: [],
        z: 10
    },
    yAxis: {
        axisLine: {
            show: false
        },
        axisTick: {
            show: false
        },
        axisLabel: {
            textStyle: {
                color: '#999'
            }
        }
    },
    dataZoom: [
        {
            type: 'inside'
        }
    ],
    series: [
             {
                 name:'交易总金额',
                 type:'bar',
                 label: {
                     normal: {
                         show: true,
                         position: 'top'
                     }
                 },
                 data:[]
             },
             {
                 name:'订单数量',
                 type:'bar',
                 stack: '',
                 label: {
                     normal: {
                         show: true,
                         position: 'top'
                     }
                 },
                 data:[]
             }
    ]
};*/

//指定图表的配置项和数据
var colors = ['#03c3c4', '#905dd1'];

var option = {
	title : {
		text : ''
	},
	tooltip : {
		trigger : 'axis'
	},
	color :['#03c3c4', '#905dd1'],
	grid: {
    	top:'10%',
        left: '1%',
        right: '1%',
        bottom: '3%',
        containLabel: true
    },
    xAxis : [
 	        {
 	            splitLine : {
 	            	show:true  ,
 					lineStyle : {
 						width : '1',
 						color:'#ccc'
 					}
 				},
 	            data : []
 	        }
 	    ],
	yAxis : [ {
		//name : '订单数量',
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
        //name : '交易总金额(万元)',
        position : 'right',
        scale : true,
        splitLine : {
         	show:false  ,
				lineStyle : {
					width : '1',
					color:'#f00'
				}
			},
        axisLabel : {
            formatter: '{value} 万元'
        },
        axisLabel: {
            inside: false
        }
    }],
	series : [ {
		name : '订单数量',
		type:'bar',
        smooth:true,
        yAxisIndex: 0,
       // itemStyle: {normal: {areaStyle: {type: 'default',opacity:0.4}}},
		"itemStyle" : {
			"normal" : {
				"color" : colors[2],
				"barBorderRadius" : 0,
				"label" : {
					"show" : true,
					"position" : "top",
					"textStyle" : {
						"fontSize" : 10
					},
				},
				"areaStyle": {
					"type": 'default',
					"opacity":0.4
					}
			}
		},
		data : []
	},{
		name:'交易总金额',
        type:'bar',
        smooth:true,
        yAxisIndex: 1,
       // itemStyle: {normal: {areaStyle: {type: 'default',opacity:0.4}}},
		"itemStyle" : {
			"normal" : {
				"color" : colors[1],
				"barBorderRadius" : 0,
				"label" : {
					"show" : true,
					"position" : "top",
					"textStyle" : {
						"fontSize" : 10
					},
					formatter : function(p) {
						return p.value + "万元"
					}
				},
			"areaStyle": {
				"type": 'default',
				"opacity":0.4
				}
			}
		},
		data : []
	}]
};

// Enable data zoom when user click bar.
var zoomSize = 6;
orderChart.on('click', function (params) {
    orderChart.dispatchAction({
        type: 'dataZoom',
        startValue: dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)],
        endValue: dataAxis[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
    });
});
// 使用刚指定的配置项和数据显示图表。
orderChart.setOption(option);

//使用刚指定的配置项和数据显示图表。
orderChart.setOption(option);

orderChart.showLoading();  //数据加载完之前先显示一段简单的loading动画

/*var dates=[];     //日期数组（实际用来盛放X轴坐标值）
var amt=[];       //交易总金额（实际用来盛放Y坐标值）
var cnt =[];   	  //交易总次数 
*/
$.ajax({
	type : "post",
	async : true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
	url : "getOrderData",
	dataType : "json",
	contentType : "application/json; charset=utf-8",
	success : function(data) {
		var dates=[];     //日期数组（实际用来盛放X轴坐标值）
		var amt=[];       //交易总金额（实际用来盛放Y坐标值）
		var cnt =[];   	  //交易总次数 
		$.each(data,function(i,n){ 
			dates.push(n["orderDate"]);
			cnt.push(n["totalCnt"]);
			amt.push((n["totalAmt"] / 10000).toFixed(2));
		})
		orderChart.hideLoading();    //隐藏加载动画
        orderChart.setOption({        //加载数据图表
        	xAxis: {
        		type : 'category',
                boundaryGap : true,
                data: dates
            },
        	series : [
    	          {
    	        	  name:'交易总金额',
    	              type:'bar',
    	              data: amt
    	          },
    	          {
    	        	  name:'订单数量',
    	              type:'bar',
    	              data: cnt
    	          }
    	      ]
        });
	},
	 error : function(errorMsg) {
     	//请求失败时执行该函数
		layer.alert('交易图表请求数据失败!', 
			{skin: 'layui-layer-molv',
				icon: 5,
				closeBtn: 0,
				btnAlign: 'c', //按钮居中
				anim: 0, //动画类型
				time: 2000
			});
     orderChart.hideLoading();
     }
	
});




