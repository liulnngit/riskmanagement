<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp" %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<%@ include file="../commons/sourceFile.jsp" %>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title" id="add">
                        <h5>查看流程图</h5>
                    </div>
					<div class="ibox-content">
					<img src="${pageContext.request.contextPath }/viewFlowImage?deploymentId=${deploymentId }&imageName=${imageName }"
						style="position: absolute; top: 0px; left: 0px;" />
					<div
						style="position: absolute;
									width: ${map.width}px;
									height: ${map.height}px; 
									top: ${map.y}px; 
									left: ${map.x}px; 
									border-color: red; border-style: solid;border-width: 1px;">
									</div>
					<%-- <div
						style="position: absolute;
									width: ${map.width}px;
									height: ${map.height}px; 
									top: ${map.y + 60}px; 
									left: ${map.x - 220}px; "><label>办理人：${assginee0 }</label></div>
					<div
						style="position: absolute;
									width: ${map.width}px;
									height: ${map.height}px;
									top: ${map.y + 60}px; 
									left: ${map.x}px; "><label>办理人：${assginee1 }</label></div> --%>
					<br>
					<br>
					<br>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>