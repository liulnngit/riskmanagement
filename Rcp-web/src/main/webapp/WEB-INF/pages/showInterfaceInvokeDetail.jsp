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
<%@ include file="../commons/sourceFile.jsp"%>
</head>

<body>
	<div style="margin-right: 50px; padding-top: 30px;margin-left: 50px;">
	 <table class="table table-bordered" style="word-wrap: break-word; word-break: break-all;">
	   <tbody align="center">
		   <tr>
		     <td style="width:20%;">系统ID</td>
		     <td style="width:80%;">${accessSystemMongo.systemId}</td>
		   </tr>
		   <tr>
         <td>系统名称</td>
         <td>${accessSystemMongo.systemName}</td>
       </tr>
       <tr>
         <td>系统token</td>
         <td>${accessSystemMongo.token}</td>
       </tr>
       <tr>
         <td>耗时</td>
         <td>${accessSystemMongo.costTime} ms</td>
       </tr>
       <tr>
         <td>创建时间</td>
         <td>${accessSystemMongo.createDate}</td>
       </tr>
	   </tbody>
	 </table>
	 <center>
	   <button type="button" style="float:right;" class="btn btn-primary margin-items-top" onclick="Dialog.getInstance('0').cancelButton.onclick.apply(Dialog.getInstance('0').cancelButton,[]);">返回</button>
	 </center>
	</div>
	 
	 
</body>
<script type="text/javascript">

</script>
</html>