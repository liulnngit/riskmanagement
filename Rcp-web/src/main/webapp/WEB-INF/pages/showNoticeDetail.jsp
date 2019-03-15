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
			<h4 class="modal-title" id="myModalLabel">查看公告</h4>
		</div>
		<div class="modal-body">
			<table class="table table-bordered" style="word-wrap: break-word; word-break: break-all;">
				<tbody align="center">
				<tr>
					<td style="width:20%;">公告标题</td>
					<td style="width:80%">${notice.title}</td>
				</tr>
				<tr>
					<td>发布时间</td>
					<td>${notice.createTime}</td>
				</tr>
				<tr>
					<td>公告内容</td>
					<td>${notice.content}</td>
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