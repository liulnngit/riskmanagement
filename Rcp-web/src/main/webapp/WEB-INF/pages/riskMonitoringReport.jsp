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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.sparkline.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>风险监控报表</h5>
					</div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							
							<div class="body-content">
								<div id="tbody-result">
								
								</div>
								<div class="modal fade" id="searchModal" tabindex="-1"
									role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog" style="width: 100%!important;margin: 0; padding: 23px 20px;">
										<div class="modal-content" >
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
		                                        </button>
												<h4 class="modal-title" id="myModalLabel"><span id="systemDetail" style="font-weight: bold;font-size:16px;"></span></h4>
											</div>
											<div class="modal-body" style="background:#f3f3f4">
												<div class="row">
													<div class="col-xs-2">
														<div class="ibox float-e-margins">
										                    <div class="ibox-title">
										                        <span class="label label-success pull-right">最近30天</span>
										                        <h5>关注量</h5>
										                    </div>
										                    <div class="ibox-content">
										                        <h1 class="no-margins" id="follow" style="font-size:24px;">0</h1>
										                        <div class="stat-percent font-bold" id="follow_fre">0
										                        </div>
										                        <small style="color:#fff">--</small>
										                    </div>
										                </div>
													</div>
													<div class="col-xs-3">
														<div class="ibox float-e-margins">
										                    <div class="ibox-title">
										                        <span class="label label-info pull-right">最近30天</span>
										                        <h5>订单</h5>
										                    </div>
										                    <div class="ibox-content">
										                        <h1 class="no-margins" id="order" style="font-size:24px;">0</h1>
										                        <div class="stat-percent font-bold" id="order_fre">0
										                        </div>
										                        <small style="color:#fff">--</small>
										                    </div>
										                </div>
													</div>
													<div class="col-xs-2">
														<div class="ibox float-e-margins">
										                    <div class="ibox-title">
										                        <span class="label label-primary pull-right">最近30天</span>
										                        <h5>风险事件</h5>
										                    </div>
										                    <div class="ibox-content">
										                        <h1 class="no-margins" id="risk" style="font-size:24px;">0</h1>
										                        <div class="stat-percent font-bold " id="risk_fre">0
										                        </div>
										                        <small style="color:#fff">--</small>
										                    </div>
										                </div>
													</div>
													<div class="col-xs-3">
														<div class="ibox float-e-margins">
										                    <div class="ibox-title">
										                        <span class="label label-danger pull-right">最近30天</span>
										                        <h5>投诉事件</h5>
										                    </div>
										                    <div class="ibox-content">
										                        <h1 class="no-margins" id="complaint" style="font-size:24px;">0</h1>
										                        <div class="stat-percent font-bold " id="complaint_fre">0
										                        </div>
										                        <small style="color:#fff">--</small>
										                    </div>
										                </div>
													</div>
													<div class="col-xs-2">
														<div class="ibox float-e-margins">
										                    <div class="ibox-title">
										                        <span class="label label-danger pull-right">总</span>
										                        <h5>商家数量</h5>
										                    </div>
										                    <div class="ibox-content">
										                        <h1 class="no-margins" id="business" style="font-size:24px;">0</h1>
										                        <div class="stat-percent font-bold text-success" id="business_fre">总数量
										                        </div>
										                        <small style="color:#fff">--</small>
										                    </div>
										                </div>
													</div>
												</div>
												<div class="row">
													<div class="col-xs-6">
														<div class="ibox float-e-margins">
															<div class="ibox-title">
										                        <h5>交易趋势图</h5>
										                    </div>
										                    <div class="ibox-content">
																<div class="flotLegend">
																	<table style="font-size:smaller;color:#545454">
																		<tbody>
																			<tr>
																				<td class="legendColorBox">
																					<div style="border:1px solid #ccc;padding:1px">
																						<div style="width:4px;height:0;border:5px solid #03c3c4;overflow:hidden"></div>
																					</div>
																				</td>
																				<td class="legendLabel">订单数量</td>
																				<td class="legendColorBox">
																					<div style="border:1px solid #ccc;padding:1px">
																						<div style="width:4px;height:0;border:5px solid #905dd1;overflow:hidden"></div>
																					</div>
																				</td>
																				<td class="legendLabel">交易总金额</td>
																			</tr>
																		</tbody>
																	</table>
																</div>
															
																<div id="ordermain" class="flotChart" style="padding: 0px; position: relative; height:300px;"></div>
															</div>
														</div>
													</div>
													<div class="col-xs-6">
														<div class="ibox float-e-margins">
															<div class="ibox-title">
										                        <h5>风控事件趋势图</h5>
										                    </div>
										                    <div class="ibox-content">
																<div class="flotLegend">
																	<table style="font-size:smaller;color:#545454">
																		<tbody>
																			<tr>
																				<td class="legendColorBox">
																					<div style="border:1px solid #ccc;padding:1px">
																						<div style="width:4px;height:0;border:5px solid #b830b3;overflow:hidden"></div>
																					</div>
																				</td>
																				<td class="legendLabel">风控事件</td>
																			</tr>
																		</tbody>
																	</table>
																</div>
																<div id="riskmain" class="flotChart" style="padding: 0px; position: relative;height:300px;"></div>
															</div>
														</div>
													</div>
												</div>
											</div>
											<!-- <div class="modal-footer">
												<button type="button" class="btn btn-primary"
													data-dismiss="modal">关闭</button>
												<span id="tip"> </span>
											</div> -->
										</div>
										<!-- /.modal-content -->
									</div>
									<!-- /.modal -->
								</div>

							</div>
						</div>
					</div>
					<br> <br> <br>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
		$(function() {
			getAdminReport();
			function getAdminReport() {
				$.ajax({
					url : '${pageContext.request.contextPath }/getAdminReport',
					type : 'post',
					dataType : 'json',
					success : function(result) {
						//console.log(result[0]);
						var tbody = window.document.getElementById("tbody-result");
						var thead ="<table class='table table-bordered table-hover table-striped' id=''><thead><tr><th>系统名称</th><th>订单趋势</th><th>交易总金额趋势</th><th>当月关注量</th><th>当月订单数</th><th>当月风险事件数</th><th>当月投诉事件数</th><th>商家总人数</th><th>详情</th></tr></thead><tbody align='center'>";
						var tcenter = "";
						var tfooter ="</tbody></table>";
						if(result.length > 0){
							for(var i=0;i<result.length;i++){
								tcenter+="<tr><td>"+result[i].systemName+"</td>";
								var cnt = "";
								var amt = "";
								for(var j=0;j<7;j++){
									cnt += result[i].orderReportDatas[j].totalCnt;
									if(j==6){
										cnt+="";
									}else{
										cnt+=",";
									}
								}
								for(var q=0;q<7;q++){
									amt += result[i].orderReportDatas[q].totalAmt;
									if(q==6){
										amt+="";
									}else{
										amt+=",";
									}
								}
								tcenter+="<td class='orderReport'>"+cnt+"</td><td class='amountReport'>"+amt+"</td><td>"+result[i].attenCount+"</td><td>"+result[i].orderCount+"</td><td>"+result[i].riskEventCount+"</td><td>"+result[i].complaintCount+"</td><td>"+result[i].merchantCount+"</td>";
								tcenter += "<td><button type='button' data-toggle='modal' data-target='#searchModal' class='btn-primary' onclick='show(\""+ result[i].systemId + "\")'>查看</button></td></tr>";
							}
						}
						tbody.innerHTML = thead + tcenter +tfooter;
						$(".orderReport").sparkline('html',{type:"bar",height:"30px",barColor:"#17997f",fillColor:"#1ab394"});
						$(".amountReport").sparkline('html',{type:"line",width:"35px",height:"30px",lineColor:"#17997f",fillColor:"#ffffff"});
					}
				});
			}
		});
	</script>
<script type="text/javascript">
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


var riskOption = {
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
</script>
<script type="text/javascript">
	//查看
   function show(systemId) {
			$.ajax({
				url : '${pageContext.request.contextPath }/getSubAdminReport?systemId='+systemId,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					//console.log(result);
					var systemDetail = window.document.getElementById("systemDetail");
					systemDetail.innerHTML = result.systemName;
					//关注量
					var follow = window.document.getElementById("follow");
					var follow_fre = window.document.getElementById("follow_fre");
					follow.innerHTML = result.attenInfo.count;
					//console.log(result.radio);
					if(result.attenInfo.radio < 0){
						$('#follow_fre').addClass("text-danger")
						var rateInt =  (parseFloat(-result.attenInfo.radio)*100).toFixed(2);
						follow_fre.innerHTML = rateInt.toString()+"%"+'<i class="fa fa-level-down"></i>';
					}else if(result.attenInfo.radio == 0){
						$('#follow_fre').addClass("text-success")
						follow_fre.innerHTML = '上月没有关注量';
					}else{
						$('#follow_fre').addClass("text-navy")
						follow_fre.innerHTML = ((result.attenInfo.radio*100).toFixed(2)).toString()+"%"+'<i class="fa fa-level-up"></i>';
					}
					
					//订单
					var order = window.document.getElementById("order");
					var order_fre = window.document.getElementById("order_fre");
					order.innerHTML = result.orderInfo.count;
					if(result.orderInfo.radio < 0){
						$('#order_fre').addClass("text-danger")
						var orderInt =  (parseFloat(-result.orderInfo.radio)*100).toFixed(2);
						order_fre.innerHTML = orderInt+"%"+'<i class="fa fa-level-down"></i>';
						//console.log(order_fre.innerHTML);
					}else if(result.orderInfo.radio == 0){
						$('#order_fre').addClass("text-success")
						order_fre.innerHTML = '上月无订单交易';
						
					}else{
						$('#order_fre').addClass("text-navy")
						order_fre.innerHTML = ((result.orderInfo.radio*100).toFixed(2)).toString()+"%"+'<i class="fa fa-level-up"></i>';
					}
					
					//风险事件数
					var risk = window.document.getElementById("risk");
					var risk_fre = window.document.getElementById("risk_fre");
					risk.innerHTML = result.riskInfo.count;
					if(result.riskInfo.radio < 0){
						$('#risk_fre').addClass("text-danger")
						var riskInt =  (parseFloat(-result.riskInfo.radio)*100).toFixed(2);
						risk_fre.innerHTML = riskInt.toString()+"%"+'<i class="fa fa-level-down"></i>';
					}else if(result.riskInfo.radio == 0){
						$('#risk_fre').addClass("text-success")
						risk_fre.innerHTML = '上月无风险事件发生';
					}else{
						$('#risk_fre').addClass("text-navy")
						risk_fre.innerHTML = ((result.riskInfo.radio*100).toFixed(2)).toString()+"%"+'<i class="fa fa-level-up"></i>';
					}
					
					//投诉事件
					var complaint = window.document.getElementById("complaint");
					var complaint_fre = window.document.getElementById("complaint_fre");
					complaint.innerHTML = result.complaintInfo.count;
					if(result.complaintInfo.radio < 0){
						$('#complaint_fre').addClass("text-danger")
						var complaintInt =  (parseFloat(-result.complaintInfo.radio)*100).toFixed(2);
						complaint_fre.innerHTML = complaintInt.toString()+"%"+'<i class="fa fa-level-down"></i>';
					}else if(result.complaintInfo.radio == 0){
						$('#complaint_fre').addClass("text-success")
						complaint_fre.innerHTML = '上月无投诉事件发生';
					}else{
						$('#complaint_fre').addClass("text-navy")
						complaint_fre.innerHTML = ((result.complaintInfo.radio*100).toFixed(2)).toString()+"%"+'<i class="fa fa-level-up"></i>';
					}
					
					//商家人数
					var merchant = window.document.getElementById("business");
					merchant.innerHTML = result.merchantInfo.count;
					
					//交易趋势
					var orderChart = echarts.init(document.getElementById('ordermain'));
					orderChart.setOption(option);
					orderChart.showLoading();  //数据加载完之前先显示一段简单的loading动画
					var dates=[];     //日期数组（实际用来盛放X轴坐标值）
					var amt=[];       //交易总金额（实际用来盛放Y坐标值）
					var cnt =[];   	  //交易总次数 
					//console.log(result.reportDatas.orderDate);
					 for(var i = 0;i<result.reportDatas.length;i++){
						dates.push(result.reportDatas[i].orderDate);
						cnt.push(result.reportDatas[i].totalCnt);
						amt.push(((result.reportDatas[i].totalAmt)/ 10000).toFixed(2));
					}
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
					 
					//风控事件
					 var riskChart = echarts.init(document.getElementById('riskmain'));
					 riskChart.setOption(riskOption);
					 riskChart.showLoading();  //数据加载完之前先显示一段简单的loading动画
					 
					 var riskDates = []; // 日期数组（实际用来盛放X轴坐标值）
					 var nums = []; // 风控事件数组（实际用来盛放Y坐标值）
					 for(var i = 0;i<result.riskDataInfo.length;i++){
							riskDates.push(result.riskDataInfo[i].riskDate);
							nums.push(result.riskDataInfo[i].riskNums);
						}
					 riskChart.hideLoading(); // 隐藏加载动画
					 riskChart.setOption({ // 加载数据图表
							xAxis : {
								type : 'category',
								boundaryGap : true,
								data : riskDates
							},
							series : [ {
								name : '风控事件',
								type : 'line',
								data : nums
							} ]
						});
				}
			});
	} 
</script>
</html>