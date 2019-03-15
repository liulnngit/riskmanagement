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

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>查看规则参数</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
									<form class="form-horizontal" id="addBusinessRuleParameterForm"
										method="POST" role="form">
										<div class="form-group">
											<label class="col-sm-2 control-label">【类别信息】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">规则类别:</label>
											<div class="col-sm-8">
												${ruleParameter.ruleTitle.title }
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label">规则名称:</label>
											<div class="col-sm-8">
												${ruleParameter.ruleName }
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label">是否警报:</label>
											<div class="col-sm-8">
												${ruleParameter.alarmFlag }
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<%-- <div style="width: 30%; margin-top: 10px; margin-botton: 10px;">
											<div class="input-group">
												<span class="input-group-addon">行业名称:</span> <span
													style="margin-left: 10px">${ruleParameter.businessTitle }</span>
											</div>
										</div> --%>
										
										<div class="form-group">
											<label class="col-sm-2 control-label">风险级别:</label>
											<div class="col-sm-8">
												${ruleParameter.rlRiskLevel }
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label">是否可配置:</label>
											<div class="col-sm-8">
												<c:if test="${ruleParameter.isConf == '0'}">
												<span
													style="margin-left: 10px">不可配置</span>
												</c:if>	
												<c:if test="${ruleParameter.isConf == '1'}">
												<span
													style="margin-left: 10px">可配置</span>
												</c:if>	
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态:</label>
											<div class="col-sm-8">
												${ruleParameter.status }
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label">创&nbsp;&nbsp;建&nbsp;&nbsp;人:</label>
											<div class="col-sm-8">
												${ruleParameter.creator }
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label">创建时间:</label>
											<div class="col-sm-8">
												${ruleParameter.createTime }
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label">更新时间:</label>
											<div class="col-sm-8">
												${ruleParameter.updateTime }
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<%-- <div style="width: 30%; margin-top: 10px; margin-botton: 10px;">
											<div class="input-group">
												<span class="input-group-addon">更&nbsp;&nbsp;新&nbsp;&nbsp;人:</span> <span
													style="margin-left: 10px">${ruleParameter.updater }</span>
											</div>
										</div> --%>
										
										<div class="form-group">
											<label class="col-sm-2 control-label">【配置参数】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">配置参数:</label>
											<div class="col-sm-8">
												<table
														class="table table-bordered float-item-left margin-items-top"
														 id="myTable">
														<thead>
															<tr>
																<th>参数名称</th>
																<th>参数值</th>
															</tr>
														</thead>
														<tbody align="center">
															<c:forEach items="${paramKeyValueList }"
																var="paramKeyValue">
																<tr>
																	<td>${paramKeyValue.name}</td>
																	<td><input type="text" disabled="disabled"
																		id="paramValue" name="paramValue"
																		value='${paramKeyValue.value}' style="width: 300px;">
																	</td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
				
											<div class="form-group">
											
											<div class="col-sm-4 col-sm-offset-2">
												<div class="btn-group">
													<button id="returnBtn" type="button" class="btn btn-primary">返回</button>
												</div>
											</div>
										</div>
											
										<%-- <input type="hidden" name="ruleParameterId" id="ruleParameterId"
											value="${ruleParameter.id}"> <input type="hidden"
											name="menuId" id="menuId" value="${menuId}"> --%>
										
									</form>
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
	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/listRuleParameter"
					});

</script>
</html>