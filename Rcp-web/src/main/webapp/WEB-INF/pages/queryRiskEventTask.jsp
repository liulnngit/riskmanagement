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

<script type="text/javascript">
	$(function() {
		$.get("${pageContext.request.contextPath }/queryTask");
	});
</script>

</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
                        <h5>风险流程处理</h5>
                    </div>
                    <div class="ibox-content">
					<div class="panel admin-panel">
						<div class="body-content">

									<table class="table table-bordered">
										<caption>
											<label>待处理流程列表</label>
										</caption>
										<thead>
											<tr>
												<th>风控事件内容</th>
												<th>风控事件时间</th>
												<th>上一次处理人</th>
												<th>上一次处理意见</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody align="center">
											<c:forEach items="${rceList }" var="rce" varStatus="loop">
												<tr>
													<td>${rce.remark }</td>
													<td><fmt:formatDate value="${rce.createDate }"
															pattern="yyyy-MM-dd HH:mm:ss" /></td>
													<td>${rce.processorName }</td>
													<td>${rce.processDes }</td>
													<%-- <c:forEach items="${taskList }" var="task"> --%>
													<td><a
														href="${pageContext.request.contextPath }/showRiskEventImage?taskId=${taskList[loop.index].id}"
														data-toggle="modal" data-target="#myModal">
															<button type="button" class="btn btn-primary">查看流程图</button>
													</a> <c:choose>
															<c:when
																test="${null == taskList[loop.index].assignee || '' == taskList[loop.index].assignee}">
																<a
																	href="${pageContext.request.contextPath }/toCliantRiskEventTask?taskId=${taskList[loop.index].id}">
																	<button type="button" class="btn btn-primary">签收任务</button>
																</a>
															</c:when>
															<c:otherwise>
																<a
																	href="${pageContext.request.contextPath }/toCompleteRiskEventTask?id=${rce.id }&taskId=${taskList[loop.index].id}">
																	<button type="button" class="btn btn-primary">办理任务</button>
																</a>
															</c:otherwise>
														</c:choose></td>
													<%-- </c:forEach> --%>
												</tr>
											</c:forEach>
										</tbody>
									</table>
				
									<!-- 模态框（Modal） -->
									<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
										aria-hidden="true" data-backdrop="static">
										<div class="modal-dialog" style="margin-left: 100px;">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-hidden="true"></button>
												</div>
				
												<div class="modal-body"></div>
												<!-- /.modal-content -->
											</div>
											<!-- /.modal-dialog -->
										</div>
									</div>
									<!-- /.modal -->
				
									<div style="margin-left: 200px;" class="margin-items-top">
										<div class="btn-group">
											<button id="submitBtn" type="button" class="btn btn-primary">确定</button>
										</div>
										<div class="btn-group" style="margin-left: 50px;">
											<a href="listRiskEvent.jsp" target="right"><button
													type="button" class="btn btn-primary">返回</button></a>
										</div>
									</div>

						</div>
						</div>
					</div>
						<br>
					<br>
					<br>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	$(function() {
		$("#submitBtn").click(function() {
			$("#eventForm").submit();
		});

	});
</script>

</html>