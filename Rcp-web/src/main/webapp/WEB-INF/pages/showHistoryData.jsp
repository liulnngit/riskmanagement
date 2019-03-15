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
			<h4 class="modal-title" id="myModalLabel">审批历史</h4>
		</div>
		<div class="modal-body">
		<table class="table table-bordered" style="word-wrap: break-word; word-break: break-all;">
			<thead>
				<th style="width:20%;">处理人</th>
				<th style="width:20%;">处理时间</th>
				<th style="width:60%;">处理意见</th>
			</thead>
			<tbody align="center">
				<c:forEach items="${list}" var="list">
					<tr>
						<td>${list.processor}</td>
						<td>${list.endTime}</td>
						<td>${list.processDes}</td>
					</tr>
				</c:forEach>
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