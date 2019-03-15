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
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/formatDateUtil.js"></script>
</head>

<body>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<h4 class="modal-title" id="myModalLabel">订单详情</h4>
		</div>
		<div class="modal-body">
			<table class="table table-bordered">
				<tbody align="center" style="word-wrap: break-word; word-break: break-all;">
				<tr>
					<td  style="width:20%;">订单日期</td>
					<td  style="width:80%;"><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
				<tr>
					<td>订单号</td>
					<td>${order.orderId}</td>
				</tr>
				<tr>
					<td>交易金额</td>
					<td><span id="txMoneyText"></span></td>
				</tr>
				<tr>
					<td>付款状态</td>
					<c:choose>
						<c:when test="${order.paymentStatus != '' and order.paymentStatus != null}">
							<c:choose>
								<c:when test="${order.paymentStatus == '0'}">
									<td>未支付</td>
								</c:when>
								<c:when test="${order.paymentStatus == '2'}">
									<td>支付成功</td>
								</c:when>
								<c:otherwise>
									<td>未知状态</td>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<td></td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<td>设备指纹</td>
					<td>${order.fingerId}</td>
				</tr>
				<tr>
					<td>支付类型ID</td>
					<td>${order.payclassId}</td>
				</tr>
				<tr>
					<td >商家域名</td>
					<td>${order.merchantUrl}</td>
				</tr>
				<tr>
					<td>订单IP</td>
					<td>${order.orderIP}</td>
				</tr>
				<tr>
					<td>付款人电话</td>
					<td>${order.payerTelephone}</td>
				</tr>
				<tr>
					<td>付款人卡号</td>
					<td>${order.payerCardNo}</td>
				</tr>
				<tr>
					<td>账单地址所在国</td>
					<td>${order.billCountry}</td>
				</tr>
				<tr>
					<td>支付通道ID</td>
					<td>${order.payChannelId}</td>
				</tr>
				<tr>
					<td>网关ID</td>
					<td>${order.gatewayId}</td>
				</tr>
				<tr>
					<td>支付类型</td>
					<td>${payclass.name}</td>
				</tr>
				<tr>
					<td>支付通道订单号</td>
					<td>${order.payChannelOrderId}</td>
				</tr>
				</tbody>
			</table>
			<input type="hidden" id="txMoneyHidden" value="${order.txMoney}">
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-primary"
					data-dismiss="modal">关闭</button>
			<span id="tip"> </span>
		</div>
	</div>
	<!-- /.modal-content -->
</div>

	
</body>

<script type="text/javascript">
    $(function () {
        var txMoney = $("#txMoneyHidden").val();
        if (txMoney != '' && txMoney != null && txMoney != 'undefined') {
            $("#txMoneyText").text("￥" + formatCurrency(txMoney));
        }
    });
</script>

</html>
