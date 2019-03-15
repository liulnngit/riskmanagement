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
</head>

<body>
	<div style="margin-right: 50px; padding-top: 30px;margin-left:50px;">
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
					<td>解除人</td>
					<td>${attentionLibrary.creator}</td>
				</tr>
				<tr>
					<td>解除原因</td>
					<td>${attentionLibrary.releaseMsg}</td>
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
					<td>关注原因</td>
					<td>${attentionLibrary.attentionMsg}</td>
				</tr>
			</tbody>
		</table>
		<center>
		<button type="button" style="float:right;" class="btn btn-primary margin-items-top"
			onclick="Dialog.getInstance('0').cancelButton.onclick.apply(Dialog.getInstance('0').cancelButton,[]);">返回</button>
	</center>
	</div>
	
</body>
<script type="text/javascript">
	
</script>
</html>