<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/admin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.css">
<script src="${pageContext.request.contextPath }/js/jquery.js"></script>
<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/js/zDrag.js"></script>
<script src="${pageContext.request.contextPath }/js/zDialog.js"></script>
</head>

<body>
<br>
<div style="margin-left: 50px;">
  <div class="panel admin-panel">
    <div class="body-content">
      <div style="margin-left: 50px;margin-top:20px;">
				<form class="form-inline" method="GET" role="form" target="right">
				  <div style="margin-top:10px;margin-botton:10px;"><strong><span>分析模型</span></strong></div>
              
            <div style="width:50%;margin-top:10px;margin-botton:10px;">
              <div class="input-group">
                <span class="input-group-addon">模型名称:</span>
                <input type="text" class="form-control" id="modelName"  name="modelName" value="${analyzeModel.modelName }" required="required" placeholder="请输入模型名称">      
                </div>
              </div>
              <div style="width:50%;margin-top:10px;margin-botton:10px;">
              <div class="input-group">
                <span class="input-group-addon">模型编码:</span>
                <input type="text" class="form-control" id="modelCode"  name="modelCode" value="${analyzeModel.modelCode }" required="required" placeholder="请输入模型编码">    
                </div>
              </div>
              
              <div style="margin-top:10px;margin-botton:10px;"><strong><span>配置信息</span></strong></div>
              
              <div style="width:50%;margin-top:10px;margin-botton:10px;">
              <div class="input-group">
                <span class="input-group-addon">实现类名:</span>
                <input type="text" class="form-control" id="classFullPath"  name="classFullPath" value="${analyzeModel.classFullPath }" required="required" placeholder="请输入实现类名">    
                </div>
              </div>
				    <br>
				   <div style="margin-left: 20%;">
				     <button type="button" class="btn btn-primary margin-items-top" id="searchBtn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
				     <button type="button" class="btn btn-primary margin-items-top" id="clearBtn">清空</button>&nbsp;&nbsp;&nbsp;&nbsp;
				     <button type="button" class="btn btn-primary margin-items-top" onclick="Dialog.getInstance('0').cancelButton.onclick.apply(Dialog.getInstance('0').cancelButton,[]);">返回</button>
				   </div>
				</form>
      </div>
    </div>
  </div>
</div>
<br>
	<br>
	<br>
</body>
<script type="text/javascript">
$(function() {
  $("#searchBtn").click(
      function() {
    	  var modelName = $("#modelName").val();
    	  var modelCode = $("#modelCode").val();
    	  var classFullPath = $("#classFullPath").val();
    	  
    	  var jsonParam = '{"modelName":"' + modelName + '","modelCode":"' + modelCode + '","classFullPath":"' + classFullPath + '"}';

    	  top.window.frames["right"].searchByFilter(jsonParam);
        Dialog.getInstance('0').cancelButton.onclick.apply(Dialog.getInstance('0').cancelButton, []);
      });
  
  $("#clearBtn").click(function() {
	  $("#modelName").val('');
	  $("#modelCode").val('');
	  $("#classFullPath").val('');
  })
});
</script>
</html>