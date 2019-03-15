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
		     <td style="width:20%;">接口名称</td>
		     <td style="width:80%;">${interfaceRule.interfaceName}</td>
		   </tr>
		   <tr>
         <td>方法名称</td>
         <td>${interfaceRule.methodName}</td>
       </tr>
       <tr>
         <td>规则编码</td>
         <td>${interfaceRule.ruleCode}</td>
       </tr>
       <tr>
         <td>状态</td>
         <td>${interfaceRule.status}</td>
       </tr>
       <tr>
         <td>创建人</td>
         <td>${interfaceRule.creatorId}</td>
       </tr>
       <tr>
         <td>创建时间</td>
         <td>${interfaceRule.createDate}</td>
       </tr>
       <tr>
         <td>更新人</td>
         <td>${interfaceRule.updaterId}</td>
       </tr>
       <tr>
         <td>更新时间</td>
         <td>${interfaceRule.updateDate}</td>
       </tr>
       <tr>
         <td style="width: 20%">描述</td>
         <td>
         ${interfaceRule.remark}
         </td>
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