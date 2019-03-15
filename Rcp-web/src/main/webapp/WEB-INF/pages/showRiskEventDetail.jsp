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
</head>

<body>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<h4 class="modal-title" id="myModalLabel">详情</h4>
		</div>
		<div class="modal-body">
				<table class="table table-bordered" style="word-wrap: break-word; word-break: break-all;">
					<tbody align="center">
					<tr>
						<td style="width:20%;">商家号</td>
						<td style="width:80%;">${riskEvent.merchantId}</td>
					</tr>
					<tr>
						<td>订单号</td>
						<td><a href="${pageContext.request.contextPath }/showOrderInfo?merchantOrderId=&&orderId=${riskEvent.orderId}" data-toggle="modal"  data-target="#myModalOrder"><strong><u>${riskEvent.orderId}</u></strong></a></td>

						<%--<td><a href="./showOrderInfo?merchantOrderId=&&orderId=${riskEvent.orderId}"><strong><u>${riskEvent.orderId}</u></strong></a></td>--%>
					</tr>
					<tr>
						<td>商家订单号</td>
						<td>${merchantOrderId}</td>
					</tr>
					<tr>
						<td>违反规则</td>
						<td>${riskEvent.ruleName}</td>
					</tr>
					<tr>
						<td>支付类型</td>
						<td>${riskEvent.payclassName}</td>
					</tr>
					<tr>
						<td>设备标识</td>
						<c:choose>
							<c:when test="${'null' == riskEvent.fingerId}">
								<td></td>
							</c:when>
							<c:otherwise>
								<td>${riskEvent.fingerId}</td>
							</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<td>风险级别</td>
						<td>${riskEvent.level}</td>
					</tr>
					<tr>
						<td>状态</td>
						<td>${riskEvent.status}</td>
					</tr>
					<tr>
						<td>发生时间</td>
						<td>${riskEvent.showCreateTime}</td>
					</tr>
					<tr>
						<td style="width: 20%">事件描述</td>
						<td>${riskEvent.remark}</td>
					</tr>
					</tbody>
				</table>


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

</script>
</html>