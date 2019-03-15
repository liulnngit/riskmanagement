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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/formatDateUtil.js"></script>
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
                    <td style="width:20%;">投诉人</td>
                    <td style="width:80%;">${complaint.name}</td>
                </tr>
                <tr>
                    <td>电话</td>
                    <td>${complaint.phoneNumber}</td>
                </tr>
                <%-- <c:if test="${complaint.emailAddress != '' && complaint.emailAddress != 'null'}"> --%>
                <tr>
                    <td>邮箱</td>
                    <td>${complaint.emailAddress}</td>
                </tr>
                <%-- </c:if> --%>
                <tr>
                    <td>投诉时间</td>
                    <td>${complaint.createTime}</td>
                </tr>
                <tr>
                    <td>商家号</td>
                    <td>${complaint.merchantId}</td>
                </tr>
                <tr>
                    <td>订单号</td>
                    <%--<td><strong><u><a href="./showOrderInfo?orderId=${complaint.merchantOrderId}">${complaint.merchantOrderId}</a></u></strong></td>--%>
                    <td><a href="${pageContext.request.contextPath }/showOrderInfo?orderId=${complaint.merchantOrderId}" data-toggle="modal"  data-target="#myModalOrder"><strong><u>${complaint.merchantOrderId}</u></strong></a></td>

                </tr>
                <tr>
                    <td>投诉金额</td>
                    <td><span id="txMoneyTD"></span></td>
                </tr>
                <tr>
                    <td style="width: 20%">投诉内容</td>
                    <td>
                        ${complaint.remark}
                    </td>
                </tr>
                </tbody>
            </table>
            <input type="hidden" id="txMoneyHidden" value="${complaint.txMoney}">
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
	$(function() {
		var txMoney = $("#txMoneyHidden").val();
		if (txMoney != '' && txMoney != 'undefined') {
			$("#txMoneyTD").text("￥" + formatCurrency(txMoney));
		}
	});
</script>
</html>