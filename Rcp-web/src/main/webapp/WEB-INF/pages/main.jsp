<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<script src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/js/pintuer.js"></script>
<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/pintuer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/admin.css">
	<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/font-awesome.min93e3.css">
	



<!--IE8只能支持jQuery1.9-->
<!--[if lte IE 8]>
<script src="${pageContext.request.contextPath  }/js/jquery.1.9.0.js"></script>
<![endif]-->
<%-- <script
	src="${pageContext.request.contextPath }/js/echarts.common.min.js"></script>
<script
	src="${pageContext.request.contextPath }/js/jquery.bgiframe.min.js"></script> --%>
</head>

<body style="background:#f3f3f4;">
	<div style="margin-left: 20px; margin-right: 20px;margin-top: 15px;">
		<div class="row">
			<div class="col-xs-2">
				<div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-success pull-right">月</span>
                        <h5>关注量</h5>
                    </div>
                    <div class="ibox-content">
                        <h1 class="no-margins" id="follow">0</h1>
                        <div class="stat-percent font-bold" id="follow_fre">0
                        </div>
                        <small>30天</small>
                    </div>
                </div>
			</div>
			<div class="col-xs-3">
				<div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-info pull-right">月</span>
                        <h5>订单</h5>
                    </div>
                    <div class="ibox-content">
                        <h1 class="no-margins" id="order">0</h1>
                        <div class="stat-percent font-bold" id="order_fre">0
                        </div>
                        <small>30天</small>
                    </div>
                </div>
			</div>
			<div class="col-xs-2">
				<div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-primary pull-right">月</span>
                        <h5>风险事件</h5>
                    </div>
                    <div class="ibox-content">
                        <h1 class="no-margins" id="risk">0</h1>
                        <div class="stat-percent font-bold " id="risk_fre">0
                        </div>
                        <small>30天</small>
                    </div>
                </div>
			</div>
			<div class="col-xs-3">
				<div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-danger pull-right">最近一个月</span>
                        <h5>投诉事件</h5>
                    </div>
                    <div class="ibox-content">
                        <h1 class="no-margins" id="complaint">0</h1>
                        <div class="stat-percent font-bold " id="complaint_fre">0
                        </div>
                        <small>30天</small>
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
                        <h1 class="no-margins" id="business">0</h1>
                        <div class="stat-percent font-bold " id="business_fre">
                        </div>
                        <small>总数量</small>
                    </div>
                </div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
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
					
						<div id="ordermain" class="flotChart" style="padding: 0px; position: relative;"></div>
					</div>
						<script type="text/javascript" src="${pageContext.request.contextPath }/js/echarts.order.js"></script>
					
					
				</div>
			</div>
			<div class="col-xs-12">
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
						<div id="riskmain" class="flotChart" style="padding: 0px; position: relative;"></div>
						<script type="text/javascript" src="${pageContext.request.contextPath }/js/echarts.risk.js"></script>
					</div>
				</div>
			</div>
		</div>
		<hr />
		
	</div>
	<br>
	<br>
	<br>
</body>
<script type="text/javascript">
	
	$(function() {
		
		//follow_fre.innerHTML = '20%'+'<i class="fa fa-level-up"></i>';
		attentionCount();
		orderCount();
		riskEventCount();
		complaintCount();
		merchantCount();
		//console.log($('#order_fre').innerText);
		//setInterval("startRequest()",1000*60*3);
	});
	
	function attentionCount() {
		$.ajax({
			url : "${pageContext.request.contextPath}/getAttentionCount",
			type : "post",
			dataType : "json",
			success : function(result) {
				var follow = window.document.getElementById("follow")
				var follow_fre = window.document.getElementById("follow_fre");
				follow.innerHTML = result.count;
				//console.log(result.radio);
				if(result.radio < 0){
					$('#follow_fre').addClass("text-danger")
					var rateInt =  (parseFloat(-result.radio)*100).toFixed(2);
					follow_fre.innerHTML = rateInt.toString()+"%"+'<i class="fa fa-level-down"></i>';
				}else if(result.radio == 0){
					$('#follow_fre').addClass("text-success")
					follow_fre.innerHTML = '上月没有关注量';
				}else{
					$('#follow_fre').addClass("text-navy")
					follow_fre.innerHTML = ((result.radio*100).toFixed(2)).toString()+"%"+'<i class="fa fa-level-up"></i>';
				}
			}
		});
	}
	
	function orderCount() {
		
		$.ajax({
			url : "${pageContext.request.contextPath}/getOrderCount",
			type : "post",
			dataType : "json",
			success : function(result) {
				//console.log(result);
				var order = window.document.getElementById("order")
				var order_fre = window.document.getElementById("order_fre");
				order.innerHTML = result.count;
				if(result.radio < 0){
					$('#order_fre').addClass("text-danger")
					var rateInt =  (parseFloat(-result.radio)*100).toFixed(2);
					order_fre.innerHTML = rateInt+"%"+'<i class="fa fa-level-down"></i>';
					//console.log(order_fre.innerHTML);
				}else if(result.radio == 0){
					$('#order_fre').addClass("text-success")
					order_fre.innerHTML = '上月无订单交易';
					
				}else{
					$('#order_fre').addClass("text-navy")
					order_fre.innerHTML = ((result.radio*100).toFixed(2)).toString()+"%"+'<i class="fa fa-level-up"></i>';
				}
				
			}
		});
	}
	
	function riskEventCount() {
		
		$.ajax({
			url : "${pageContext.request.contextPath}/getRiskEventCount",
			type : "post",
			dataType : "json",
			success : function(result) {
				//console.log(result);
				var risk = window.document.getElementById("risk")
				var risk_fre = window.document.getElementById("risk_fre");
				risk.innerHTML = result.count;
				if(result.radio < 0){
					$('#risk_fre').addClass("text-danger")
					var rateInt =  (parseFloat(-result.radio)*100).toFixed(2);
					risk_fre.innerHTML = rateInt.toString()+"%"+'<i class="fa fa-level-down"></i>';
				}else if(result.radio == 0){
					$('#risk_fre').addClass("text-success")
					risk_fre.innerHTML = '上月无风险事件发生';
				}else{
					$('#risk_fre').addClass("text-navy")
					risk_fre.innerHTML = ((result.radio*100).toFixed(2)).toString()+"%"+'<i class="fa fa-level-up"></i>';
				}
				
			}
		});
	}
	
	function complaintCount() {
		$.ajax({
			url : "${pageContext.request.contextPath}/getComplaintCount",
			type : "post",
			dataType : "json",
			success : function(result) {
				//console.log(result);
				var complaint = window.document.getElementById("complaint")
				var complaint_fre = window.document.getElementById("complaint_fre");
				complaint.innerHTML = result.count;
				if(result.radio < 0){
					$('#complaint_fre').addClass("text-danger")
					var rateInt =  (parseFloat(-result.radio)*100).toFixed(2);
					complaint_fre.innerHTML = rateInt.toString()+"%"+'<i class="fa fa-level-down"></i>';
				}else if(result.radio == 0){
					$('#complaint_fre').addClass("text-success")
					complaint_fre.innerHTML = '上月无投诉事件发生';
				}else{
					$('#complaint_fre').addClass("text-navy")
					complaint_fre.innerHTML = ((result.radio*100).toFixed(2)).toString()+"%"+'<i class="fa fa-level-up"></i>';
				}
				
			}
		});
	}
	function merchantCount() {
		$.ajax({
			url : "${pageContext.request.contextPath}/getMerchantCount",
			type : "post",
			dataType : "json",
			success : function(result) {
				//console.log(result);
				var complaint = window.document.getElementById("business")
				//var complaint_fre = window.document.getElementById("complaint_fre");
				complaint.innerHTML = result.count;
				/* if(result.radio < 0){
					$('#complaint_fre').addClass("text-danger")
					var rateInt =  (parseFloat(-result.radio)*100).toFixed(2);
					complaint_fre.innerHTML = rateInt.toString()+"%"+'<i class="fa fa-level-down"></i>';
				}else if(result.radio == 0){
					$('#complaint_fre').addClass("text-success")
					complaint_fre.innerHTML = '上月无投诉事件发生';
				}else{
					$('#complaint_fre').addClass("text-navy")
					complaint_fre.innerHTML = ((result.radio*100).toFixed(2)).toString()+"%"+'<i class="fa fa-level-up"></i>';
				} */
				
			}
		});
	}
</script>

</html>
