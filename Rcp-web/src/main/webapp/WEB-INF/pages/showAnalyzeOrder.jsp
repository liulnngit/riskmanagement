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
<script
	src="${pageContext.request.contextPath }/js/echarts.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>风险分析</h5>
					</div>
					<div class="ibox-content">
						<div class="row">
							<div>
							<c:forEach items="${fingerList}" var="fingerList">
							   	<input type="hidden"  value="${fingerList.totalAmt}" class="amt">
								<input type="hidden"  value="${fingerList.totalCnt}" class="cnt">
								<input type="hidden"  value="${fingerList.dimensionParameter}" class="parameter">
							</c:forEach>
							</div>
							<div>
							<c:forEach items="${payclassList}" var="payclassList">
							   	<input type="hidden"  value="${payclassList.totalAmt}" class="payamt">
								<input type="hidden"  value="${payclassList.totalCnt}" class="paycnt">
								<input type="hidden"  value="${payclassList.dimensionParameter}" class="payparameter">
							</c:forEach>
							</div>
							<div>
							<c:forEach items="${ipList}" var="ipList">
							   	<input type="hidden"  value="${ipList.totalAmt}" class="ipamt">
								<input type="hidden"  value="${ipList.totalCnt}" class="ipcnt">
								<input type="hidden"  value="${ipList.dimensionParameter}" class="ipparameter">
							</c:forEach>
							</div>
							<div>
							<c:forEach items="${cardnoList}" var="cardnoList">
							   	<input type="hidden"  value="${cardnoList.totalAmt}" class="cardamt">
								<input type="hidden"  value="${cardnoList.totalCnt}" class="cardcnt">
								<input type="hidden"  value="${cardnoList.dimensionParameter}" class="cardparameter">
							</c:forEach>
							</div>
							<div>
							<c:forEach items="${merchantList}" var="merchantList">
							   	<input type="hidden"  value="${merchantList.totalAmt}" class="meramt">
								<input type="hidden"  value="${merchantList.totalCnt}" class="mercnt">
								<input type="hidden"  value="${merchantList.dimensionParameter}" class="merparameter">
							</c:forEach>
							</div>
							<div class="col-xs-6">
								<div id="analysis0" class="analysisChart" style="padding: 0px; position: relative;"></div>
							</div>
							<div class="col-xs-6">
								<div id="analysis1" class="analysisChart" style="padding: 0px; position: relative;"></div>
							</div>
							<div class="col-xs-6">
								<div id="analysis2" class="analysisChart" style="padding: 0px; position: relative;"></div>
							</div>
							<div class="col-xs-6">
								<div id="analysis3" class="analysisChart" style="padding: 0px; position: relative;"></div>
							</div>
							<div class="col-xs-6">
								<div id="analysis4" class="analysisChart" style="padding: 0px; position: relative;"></div>
							</div>
						</div>
						<center>
						<button id="returnBtn" type="button" class="btn btn-primary">返回</button>
					</center>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
<script src="${pageContext.request.contextPath }/js/echarts.analysis.js"></script>
<script type="text/javascript">

$("#returnBtn")
.click(
		function() {
			window.location.href = "${pageContext.request.contextPath}/listRiskEvent";
		});
</script>
</html>