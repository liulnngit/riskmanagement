<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/formatDateUtil.js"></script>
<!DOCTYPE html>
<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
		<meta name="renderer" content="webkit">
		<title></title>
		<%@ include file="../commons/sourceFile.jsp" %>
	</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>预警中心</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
								
									<ul id="myTab" class="nav nav-tabs">
										<li class="active"><a href="#bigOrderTop" data-toggle="tab">大额订单监控</a></li>
										<li><a href="#doubtfulOrderTop" data-toggle="tab">可疑订单监控</a></li>
										<li><a href="#hzTradeOrderTop" data-toggle="tab">高频交易监控</a></li>
									</ul>
									<div id="myTabContent" class="tab-content">
						    				<div class="tab-pane fade in active" id="bigOrderTop">
												<table class="table table-bordered" style="word-wrap: break-word; word-break: break-all;">
													<thead align="center">
													  <tr>
													    <td style="width:15%">订单号</td>
													    <td style="width:15%;">商家号</td>
													    <td style="width:30%;">设备标识</td>
													    <td style="width:15%;">交易IP</td>
													    <td style="width:10%;">交易金额</td>
													    <td style="widht:10%;">订单创建时间</td>
													    <!-- <td>系统类型</td> -->
													  </tr>
													</thead>
												  <c:forEach items="${bigOrderTop10}" var="bigOrderVo" varStatus="status">
													  <tbody align="center">
													    <tr>
													      <td>${bigOrderVo.orderId}</td>
													      <td>${bigOrderVo.merchantId}</td>
													      <c:choose>
													       <c:when test="${'null' == bigOrderVo.fingerId}">
													         <td></td>
													       </c:when>
													       <c:otherwise>
													         <td>${bigOrderVo.fingerId}</td>
													       </c:otherwise>
													      </c:choose>
													      <td>${bigOrderVo.ipAddress}</td>
															<td>￥<span class="bigMoney">${bigOrderVo.txMoney}</span></td>
													      <td>${bigOrderVo.orderCreateDate}</td>
													      <%-- <td>${bigOrderVo.systemName}</td> --%>
													    </tr>
													  </tbody>
												  </c:forEach>
												</table>
											</div>
												
											<div class="tab-pane fade" id="doubtfulOrderTop">
												<table class="table table-bordered">
													<thead align="center">
										              <tr>
										                <td style="width:15%">订单号</td>
													    <td style="width:15%;">商家号</td>
													    <td style="width:30%;">设备标识</td>
													    <td style="width:15%;">交易IP</td>
													    <td style="width:10%;">交易金额</td>
													    <td style="widht:10%;">订单创建时间</td>
										                <!-- <td>系统类型</td> -->
										              </tr>
													</thead>
									              <c:forEach items="${doubtfulOrderTop10}" var="doubtfulOrderVo" varStatus="status">
										              <tbody align="center">
										                <tr>
										                  <td>${doubtfulOrderVo.orderId}</td>
										                  <td>${doubtfulOrderVo.merchantId}</td>
																      <c:choose>
							                         <c:when test="${'null' == doubtfulOrderVo.fingerId}">
							                           <td></td>
							                         </c:when>
							                         <c:otherwise>
							                           <td>${doubtfulOrderVo.fingerId}</td>
							                         </c:otherwise>
							                        </c:choose>
																      <td>${doubtfulOrderVo.ipAddress}</td>
															<td>￥<span class="bigMoney">${doubtfulOrderVo.txMoney}</span></td>
										                  <td>${doubtfulOrderVo.orderCreateDate}</td>
										                  <%-- <td>${doubtfulOrderVo.systemName}</td> --%>
										                </tr>
										              </tbody>
									              </c:forEach>
								            </table>
								            </div>
								            
								       <div class="tab-pane fade" id="hzTradeOrderTop">
				                <table class="table table-bordered">
				                  <thead align="center">
				                          <tr>
				                           <td style="width:15%">订单号</td>
										    <td style="width:15%;">商家号</td>
										    <td style="width:30%;">设备标识</td>
										    <td style="width:15%;">交易IP</td>
										    <td style="width:10%;">交易金额</td>
										    <td style="widht:10%;">订单创建时间</td>
				                            <!-- <td>系统类型</td> -->
				                          </tr>
				                  </thead>
				                        <c:forEach items="${highFrequencyOrderTop10}" var="highFrequencyOrderVo" varStatus="status">
				                          <tbody align="center">
				                            <tr>
				                              <td>${highFrequencyOrderVo.orderId}</td>
				                              <td>${highFrequencyOrderVo.merchantId}</td>
																		  <c:choose>
				                               <c:when test="${'null' == highFrequencyOrderVo.fingerId}">
				                                 <td></td>
				                               </c:when>
				                               <c:otherwise>
				                                 <td>${highFrequencyOrderVo.fingerId}</td>
				                               </c:otherwise>
				                              </c:choose>
																		  <td>${highFrequencyOrderVo.ipAddress}</td>
												<td>￥<span class="bigMoney">${highFrequencyOrderVo.txMoney}</span></td>
				                              <td>${highFrequencyOrderVo.orderCreateDate}</td>
				                              <%-- <td>${highFrequencyOrderVo.systemName}</td> --%>
				                            </tr>
				                          </tbody>
				                        </c:forEach>
				                    </table>
				                    </div>
										</div>
								</div>
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
    $(".bigMoney").each(function(index,el){
        var money = formatCurrency($(this).text());
        $(this).text(money);
	})
$(function(){
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        // 获取已激活的标签页的名称
        var activeTab = $(e.target).text();
        // 获取前一个激活的标签页的名称
        var previousTab = $(e.relatedTarget).text();
        $(".active-tab span").html(activeTab);
        $(".previous-tab span").html(previousTab);
    });
});
</script>
</html>