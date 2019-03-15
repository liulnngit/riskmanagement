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
			<h4 class="modal-title" id="myModalLabel">关注详情</h4>
		</div>
		<div class="modal-body">
		<table class="table table-bordered" style="word-wrap: break-word; word-break: break-all;">
			<tbody align="center">
				<tr>
					<td style="width:20%;">商家号</td>
					<td style="width:80%;">${attentionLibrary.merchantId }</td>
				</tr>
				<tr>
					<td>商家地址</td>
					<td>${attentionLibrary.address }</td>
				</tr>
				<tr>
					<td>关注级别</td>
					<td>${attentionLibrary.attentionLevel }</td>
				</tr>
				
				<tr>
					<td>创建人</td>
					<td>${attentionLibrary.createName}</td>
				</tr>
				<tr>
					<td>状态</td>
					<td>${attentionLibrary.status}</td>
				</tr>
				<tr>
					<td>关注起始时间</td>
					<td>${attentionLibrary.startDate}</td>
				</tr>
				<tr>
					<td>关注结束时间</td>
					<td>${attentionLibrary.endDate}</td>
				</tr>
				<tr>
					<td>是否报警</td>
					<td>${attentionLibrary.alarm}</td>
				</tr>
				<tr>
					<td>关注次数</td>
					<td>${attentionLibrary.count}</td>
				</tr>
				<tr>
					<td>关注原因</td>
					<td>${attentionLibrary.attentionMsg}</td>
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