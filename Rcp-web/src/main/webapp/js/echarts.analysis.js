	// 基于准备好的dom，初始化echarts实例

var analysis0Chart = echarts.init(document.getElementById('analysis0'));
var analysis1Chart = echarts.init(document.getElementById('analysis1'));
var analysis2Chart = echarts.init(document.getElementById('analysis2'));
var analysis3Chart = echarts.init(document.getElementById('analysis3'));
var analysis4Chart = echarts.init(document.getElementById('analysis4'));
//指定图表的配置项和数据
//设备指纹
var analysis0Option = {
	title : {
		text : '设备指纹分布情况'
	},
	 tooltip : {
	        trigger: 'axis',
	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        }
	    },
	    legend: {
	        data:['交易总次数','交易总金额']
	    },
	    dataZoom: [
	               {
	                   show: true,
	                   realtime: false,
	                   start: 0,
	                   end: 100
	               },
	               {
	                   type: 'inside',
	                   realtime: false,
	                   start: 0,
	                   end: 100
	               }
	           ],
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '7%',
	        containLabel: true
	    },
	color :['#03c3c4', '#905dd1'],
	
	xAxis : [
	         {
	             type : 'category',
	             boundaryGap : false,
	             show:false,
	             data : []
	         }
	     ],
	     yAxis : [ {
				name : '次数(次)',
				type : 'value',
				scale : true,
				position : 'left',
				min : 0,
	            axisLabel: {
		            inside: false
		        }
			},{
	            type : 'value',
	            name : '金额(万元)',
	            position : 'right',
	            scale : true,
	            min : 0,
	            splitLine : {
	             	show:false,
	    		},
	            axisLabel: {
		            inside: false
		        }
	        }],
	     
	     series : [
	         {
	             name:'交易总次数',
	             type:'line',
	             smooth:true,
	             areaStyle: {normal: {opacity:0.4,}},
	             data:[]
	         },
	         {
	             name:'交易总金额',
	             type:'line',
	             smooth:true,
	             yAxisIndex:1,
	             areaStyle: {normal: {opacity:0.4,}},
	             data:[]
	         }
	     ]
};

// Enable data zoom when user click bar.

// 使用刚指定的配置项和数据显示图表。
analysis0Chart.setOption(analysis0Option,true);

//使用刚指定的配置项和数据显示图表。
/*orderChart.setOption(option);*/

analysis0Chart.showLoading();  //数据加载完之前先显示一段简单的loading动画

getData();

function getData() {
	
	var parameter = []; //日期数组（实际用来盛放X轴坐标值）
	var nums = []; //风控事件数组（实际用来盛放Y坐标值）
	var money = [];
	
	$(".cnt").each(function(index,el){
		nums.push(parseInt(el.value));
	    
	 });
	$(".amt").each(function(index,el){
		money.push(((el.value)/10000).toFixed(2));
	    
	 });
	$(".parameter").each(function(index,el){
		parameter.push(el.value);
	    
	 });
	if(nums==''){
		$('#analysis0').hide();
	}else{
		$('#analysis0').show();
	}
	analysis0Chart.hideLoading(); //隐藏加载动画
	analysis0Chart.setOption({ //加载数据图表
			xAxis : {
				type : 'category',
				scale : true,
				boundaryGap : false,
				data : parameter
			},
			series : [{
				name : '交易总次数',
				type : 'line',
				data : nums
			},{
				name : '交易总金额',
				type : 'line',
				data : money
			}]
		}); 
		
	
			
}

//商家分布
//指定图表的配置项和数据
var analysis1Option = {
	title : {
		text : '商家交易分布情况'
	},
	 tooltip : {
	        trigger: 'axis',
	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        }
	    },
	    legend: {
	        data:['交易总次数','交易总金额']
	    },
	    dataZoom: [
	               {
	                   show: true,
	                   realtime: false,
	                   start: 0,
	                   end: 100
	               },
	               {
	                   type: 'inside',
	                   realtime: false,
	                   start: 0,
	                   end: 100
	               }
	           ],
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '7%',
	        containLabel: true
	    },
	color :['#03c3c4', '#905dd1'],
	
	xAxis : [
	         {
	             type : 'category',
	             boundaryGap : false,
	             axisLabel: {  
	            	 interval: 0,  
	             },
	             data : []
	         }
	     ],
	     yAxis : [ {
				name : '次数(次)',
				type : 'value',
				scale : true,
				position : 'left',
				min : 0,
	            axisLabel: {
		            inside: false
		        }
			},{
	            type : 'value',
	            name : '金额(万元)',
	            position : 'right',
	            scale : true,
	            min : 0,
	            splitLine : {
	             	show:false,
	    		},
	            axisLabel: {
		            inside: false
		        }
	        }],
	     series : [
	         {
	             name:'交易总次数',
	             type:'scatter',
	             smooth:true,
	            // areaStyle: {normal: {opacity:0.4,}},
	             data:[]
	         },
	         {
	             name:'交易总金额',
	             type:'scatter',
	             smooth:true,
	             yAxisIndex:1,
	           //  areaStyle: {normal: {opacity:0.4,}},
	             data:[]
	         }
	     ]
};

// Enable data zoom when user click bar.

// 使用刚指定的配置项和数据显示图表。
analysis1Chart.setOption(analysis1Option);

analysis1Chart.showLoading();  //数据加载完之前先显示一段简单的loading动画

getData1();

function getData1() {
	
	var parameter = []; //日期数组（实际用来盛放X轴坐标值）
	var nums = []; //风控事件数组（实际用来盛放Y坐标值）
	var money = [];
	
	$(".mercnt").each(function(index,el){
		nums.push(parseInt(el.value));
	    
	 });
	$(".meramt").each(function(index,el){
		money.push(((el.value)/10000).toFixed(2));
	    
	 });
	$(".merparameter").each(function(index,el){
		parameter.push(el.value);
	    
	 });
	//console.log(nums);
	if(nums==''){
		$('#analysis1').hide();
	}else{
		$('#analysis1').show();
	}
	analysis1Chart.hideLoading(); //隐藏加载动画
	analysis1Chart.setOption({ //加载数据图表
			xAxis : {
				type : 'category',
				scale : true,
				boundaryGap : true,
				data : parameter
			},
			series : [{
				name : '交易总次数',
				data : nums
			},{
				name : '交易总金额',
				data : money
			}]
		}); 
		
	
			
}



//支付通道
//指定图表的配置项和数据
var analysis2Option = {
	title : {
		text : '支付类型分布情况'
	},
	 tooltip : {
	        trigger: 'axis',
	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        }
	    },
	    legend: {
	        data:['交易总次数','交易总金额']
	    },
	    dataZoom: [
	               {
	                   show: true,
	                   realtime: false,
	                   start: 0,
	                   end: 100
	               },
	               {
	                   type: 'inside',
	                   realtime: false,
	                   start: 0,
	                   end: 100
	               }
	           ],
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '7%',
	        containLabel: true
	    },
	color :['#999', '#428bca'],
	
	xAxis : [
	         {
	             type : 'category',
	             show:false,
	            // boundaryGap : false,
	             axisLabel: {  
	            	 interval: 0,  
                     
	            	},
	             data : []
	         }
	     ],
	     yAxis : [ {
				name : '次数(次)',
				type : 'value',
				scale : true,
				position : 'left',
				min : 0,
	            axisLabel: {
		            inside: false
		        }
			},{
	            type : 'value',
	            name : '金额(万元)',
	            position : 'right',
	            scale : true,
	            min : 0,
	            splitLine : {
	             	show:false,
	    		},
	            axisLabel: {
		            inside: false
		        }
	        }],
	     series : [
	         {
	             name:'交易总次数',
	             type:'bar',
	             barGap: 0,
	             smooth:true,
	             areaStyle: {normal: {opacity:0.4,}},
	             data:[]
	         },
	         {
	             name:'交易总金额',
	             type:'bar',
	             yAxisIndex:1,
	             smooth:true,
	             areaStyle: {normal: {opacity:0.4,}},
	             data:[]
	         }
	     ]
};

// Enable data zoom when user click bar.

// 使用刚指定的配置项和数据显示图表。
analysis2Chart.setOption(analysis2Option);
analysis2Chart.showLoading();  //数据加载完之前先显示一段简单的loading动画

getData2();

function getData2() {
	var parameter = []; //日期数组（实际用来盛放X轴坐标值）
	var nums = []; //风控事件数组（实际用来盛放Y坐标值）
	var money = [];
	
	$(".paycnt").each(function(index,el){
		nums.push(parseInt(el.value));
	    
	 });
	$(".payamt").each(function(index,el){
		money.push(((el.value)/10000).toFixed(2));
	    
	 });
	$(".payparameter").each(function(index,el){
		parameter.push(el.value);
	    
	 });
	if(nums==''){
		$('#analysis2').hide();
	}else{
		$('#analysis2').show();
	}
	analysis2Chart.hideLoading(); //隐藏加载动画
	analysis2Chart.setOption({ //加载数据图表
			xAxis : {
				type : 'category',
				scale : true,
				boundaryGap : true,
				data : parameter
			},
			series : [{
				name : '交易总次数',
				data : nums
			},{
				name : '交易总金额',
				data : money
			}]
		}); 
		
	
			
}


//IP分布
//指定图表的配置项和数据
var analysis3Option = {
	title : {
		text : 'IP分布情况'
	},
	 tooltip : {
	        trigger: 'axis',
	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        }
	    },
	    legend: {
	        data:['交易总次数','交易总金额']
	    },
	    dataZoom: [
	               {
	                   show: true,
	                   realtime: false,
	                   start: 0,
	                   end: 100
	               },
	               {
	                   type: 'inside',
	                   realtime: false,
	                   start: 0,
	                   end: 100
	               }
	           ],
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '7%',
	        containLabel: true
	    },
	color :['#464f88', '#a3e1d4'],
	
	xAxis : [
	         {
	             type : 'category',
	             show:false,
	            // boundaryGap : false,
	             axisLabel: {  
	            	 interval: 0, 
                     
	            	},
	             data : []
	         }
	     ],
	     yAxis : [ {
				name : '次数(次)',
				type : 'value',
				scale : true,
				position : 'left',
				min : 0,
	            axisLabel: {
		            inside: false
		        }
			},{
	            type : 'value',
	            name : '金额(万元)',
	            position : 'right',
	            scale : true,
	            min : 0,
	            splitLine : {
	             	show:false,
	    		},
	            axisLabel: {
		            inside: false
		        }
	        }],
	     series : [
	         {
	             name:'交易总次数',
	             type:'line',
	             smooth:true,
	             areaStyle: {normal: {opacity:0.4,}},
	             data:[]
	         },
	         {
	             name:'交易总金额',
	             type:'bar',
	             smooth:true,
	             yAxisIndex:1,
	             areaStyle: {opacity:0.4},
	             data:[]
	         }
	     ]
};

// Enable data zoom when user click bar.

// 使用刚指定的配置项和数据显示图表。
analysis3Chart.setOption(analysis3Option);
analysis3Chart.showLoading();  //数据加载完之前先显示一段简单的loading动画

getData3();

function getData3() {
	var parameter = []; //日期数组（实际用来盛放X轴坐标值）
	var nums = []; //风控事件数组（实际用来盛放Y坐标值）
	var money = [];
	
	$(".ipcnt").each(function(index,el){
		nums.push(parseInt(el.value));
	    
	 });
	$(".ipamt").each(function(index,el){
		money.push(((el.value)/10000).toFixed(2));
	    
	 });
	$(".ipparameter").each(function(index,el){
		parameter.push(el.value);
	    
	 });
	if(nums==''){
		$('#analysis3').hide();
	}else{
		$('#analysis3').show();
	}
	analysis3Chart.hideLoading(); //隐藏加载动画
	analysis3Chart.setOption({ //加载数据图表
			xAxis : {
				type : 'category',
				scale : true,
				boundaryGap : true,
				data : parameter
			},
			series : [{
				name : '交易总次数',
				data : nums
			},{
				name : '交易总金额',
				data : money
			}]
		}); 
		
	
			
}





//卡号分布
//指定图表的配置项和数据
var analysis4Option = {
	title : {
		text : '卡号情况'
	},
	 tooltip : {
	        trigger: 'axis',
	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        }
	    },
	    legend: {
	        data:['交易总次数','交易总金额']
	    },
	    dataZoom: [
	               {
	                   show: true,
	                   realtime: false,
	                   start: 0,
	                   end: 100
	               },
	               {
	                   type: 'inside',
	                   realtime: false,
	                   start: 0,
	                   end: 100
	               }
	           ],
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '7%',
	        containLabel: true
	    },
	color :['#03c3c4', '#905dd1'],
	
	xAxis : [
	         {
	             type : 'category',
	             show:false,
	             boundaryGap : false,
	             data : []
	         }
	     ],
	     yAxis : [ {
				name : '次数(次)',
				type : 'value',
				scale : true,
				position : 'left',
				min : 0,
	            axisLabel: {
		            inside: false
		        }
			},{
	            type : 'value',
	            name : '金额(万元)',
	            position : 'right',
	            scale : true,
	            min : 0,
	            splitLine : {
	             	show:false,
	    		},
	            axisLabel: {
		            inside: false
		        }
	        }],
	     series : [
	         {
	             name:'交易总次数',
	             type:'line',
	             smooth:true,
	             //areaStyle: {normal: {opacity:0.4,}},
	             data:[]
	         },
	         {
	             name:'交易总金额',
	             type:'line',
	             smooth:true,
	             yAxisIndex:1,
	             //areaStyle: {normal: {opacity:0.4,}},
	             data:[]
	         }
	     ]
};

// Enable data zoom when user click bar.

// 使用刚指定的配置项和数据显示图表。
analysis4Chart.setOption(analysis4Option);
analysis4Chart.showLoading();  //数据加载完之前先显示一段简单的loading动画

getData4();

function getData4() {
	var parameter = []; //日期数组（实际用来盛放X轴坐标值）
	var nums = []; //风控事件数组（实际用来盛放Y坐标值）
	var money = [];
	
	$(".cardcnt").each(function(index,el){
		nums.push(parseInt(el.value));
	    
	 });
	$(".cardamt").each(function(index,el){
		money.push(((el.value)/10000).toFixed(2));
	    
	 });
	$(".cardparameter").each(function(index,el){
		parameter.push(el.value);
	    
	 });
	if(nums==''){
		$('#analysis4').hide();
	}else{
		$('#analysis4').show();
	}
	analysis4Chart.hideLoading(); //隐藏加载动画
	analysis4Chart.setOption({ //加载数据图表
			xAxis : {
				type : 'category',
				scale : true,
				boundaryGap : false,
				data : parameter
			},
			series : [{
				name : '交易总次数',
				data : nums
			},{
				name : '交易总金额',
				data : money
			}]
		}); 
		
	
			
}