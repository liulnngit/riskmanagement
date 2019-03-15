<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<%@ include file="../commons/sourceFile.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.js"></script>
</head>

<body class="gray-bg">
<input type="hidden" name="systemAccount" id="systemAccount" value="${systemAccount}" />
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>关注名单报表</h5>
                    </div>
					<div class="ibox-content">
						<form class="form-inline" id="searchForm" role="form" action="">
							<table>
								<tr>
									<td>
										<div class="input-group" id ="user">
											
										</div>
									</td>
									<td>
										<div class="input-group">
											<span class="input-group-addon">关注级别:</span> <select
												id="attentionLevel" class="form-control" name="attentionLevel">
												<option value="">-----请选择-----</option>
												<option value="0">高</option>
												<option value="1">中</option>
												<option value="2">低</option>
											</select>
										</div>
									</td>
									<td>
										<!-- <div class="input-group">
											<span class="input-group-addon">时间范围:</span> <input type="text"
												class="form-control" id="startTime" name="startTime" placeholder="请输入起始时间" readonly> <span
												class="input-group-addon">到</span> <input type="text"
												class="form-control" id="endTime" name="endTime" placeholder="请输入结束时间" readonly>
										</div> -->
										<div class="input-group">
											<span class="input-group-addon">时间:</span> <select
												id="searchDate" class="form-control" name="searchDate">
												<option value="0" selected="selected">七天</option>
												<option value="1">上月</option>
												<option value="2">本月</option>
												<option value="3">上季度</option>
												<option value="4">本季度</option>
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
						<div style="margin-left: 0px; margin-right: 0px; margin-top: 20px;">
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
	var myChart = echarts.init(document.getElementById('main'));

	// 指定图表的配置项和数据
	var option = {
		title : {
			text : ''
		},
		tooltip : {
			trigger : 'axis'
		},
		legend : {
			data : [ '关注名单' ]
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
			type : 'value',
			scale : true,
			min : 0
		} ],
		series : [ {
			name : '关注名单',
			type : 'line',
			stack : '数量',
			symbol : 'emptyCircle',
			symbolSize : 4,
			smooth : true,
			yAxisIndex : 0,
			animation : true,
			label : {
				normal : {
					show : true,
					position : 'top'
				},
			},
			data : []
		} ]
	};

	// 使用刚指定的配置项和数据显示图表。
	myChart.setOption(option, true);

	myChart.showLoading(); //数据加载完之前先显示一段简单的loading动画

	

	function getData(userId,attentionLevel,searchDate) {
		//alert(data);
		$.ajax({
			url : "${pageContext.request.contextPath}/getAttentionReportData",
			type : "post",
			async : false, //同步执行  
			dataType : "json",
			data : {attentionLevel:attentionLevel, searchDate:searchDate,systemId:userId},
			success : function(result) {
				var dates = []; //日期数组（实际用来盛放X轴坐标值）
				var nums = []; //风控事件数组（实际用来盛放Y坐标值）
				if (result) {
					$.each(result, function(i, n) {
						dates.push(n["attentionDate"]);
						nums.push(n["attentionNums"]);
					});
				}
				myChart.hideLoading(); //隐藏加载动画
				myChart.setOption({ //加载数据图表
					xAxis : {
						type : 'category',
						boundaryGap : false,
						data : dates
					},
					series : [ {
						name : '关注名单',
						type : 'line',
						data : nums
					} ]
				});
			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				layer.alert('关注名单图表请求数据失败!', 
					{skin: 'layui-layer-molv',
						icon: 5,
						closeBtn: 0,
						btnAlign: 'c', //按钮居中
						anim: 0, //动画类型
						time: 2000
					});
				myChart.hideLoading();
			}

		});
	}
	
	$("#searchBtn").click(function() {
		var attentionLevel = $("#attentionLevel").val();
		var searchDate = $("#searchDate").val();
		var userId = $("#userId").val();
		getData(userId,attentionLevel, searchDate);
		
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
						var attentionLevel = $("#attentionLevel").val();
						var searchDate = $("#searchDate").val();
						var userId = $("#userId").val();
						//console.log(userId);
						getData(userId,attentionLevel, searchDate);
					}
				}
			}); 
		}else{
			$("#user").append('<input type="hidden" name="userId" id="userId" value="" />');
		}
		
	});
</script>
</html>