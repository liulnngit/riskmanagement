// 基于准备好的dom，初始化echarts实例
var riskChart = echarts.init(document.getElementById('riskmain'));

// 指定图表的配置项和数据
var option = {
		title : {
	        text: '',
	        subtext: ''
	    },
	    tooltip : {
	        trigger: 'axis'
	    },
	    color :['#b830b3'],
	    grid: {
	    	top:'3%',
	        left: '1%',
	        right: '1%',
	        bottom: '3%',
	        containLabel: true
	    },
	    calculable : true,
	    xAxis : [
	 	        {
	 	            type : 'category',
	 	            boundaryGap : false,
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
		type : 'value',
		scale : true,
		min : 0
	} ],
	series : [ {
		name:'风控事件',
        type:'line',
        stack : '数量',
        smooth:true,
        //itemStyle: {normal: {areaStyle: {type: 'default',opacity:0.4}}},
		data : []
	} ]
};

// 使用刚指定的配置项和数据显示图表。
riskChart.setOption(option);

riskChart.showLoading(); // 数据加载完之前先显示一段简单的loading动画

var dates = []; // 日期数组（实际用来盛放X轴坐标值）
var nums = []; // 风控事件数组（实际用来盛放Y坐标值）

$.ajax({
	type : "get",
	async : true, // 异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
	url : "getRiskData",
	dataType : "json",
	contentType : "application/json; charset=utf-8",
	success : function(result) {
		$.each(result, function(i, n) {
			dates.push(n["riskDate"]);
			nums.push(n["riskNums"]);
		})
		riskChart.hideLoading(); // 隐藏加载动画
		riskChart.setOption({ // 加载数据图表
			xAxis : {
				type : 'category',
				boundaryGap : true,
				data : dates
			},
			series : [ {
				name : '风控事件',
				type : 'line',
				data : nums
			} ]
		});
	},
	error : function(errorMsg) {
		// 请求失败时执行该函数
		layer.alert('风控图表请求数据失败!', {
			skin : 'layui-layer-molv',
			icon : 5,
			closeBtn : 0,
			btnAlign : 'c', // 按钮居中
			anim : 0, // 动画类型
			time : 2000
		});
		riskChart.hideLoading();
	}

});
