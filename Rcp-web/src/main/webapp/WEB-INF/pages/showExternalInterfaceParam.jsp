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
                        <h5>接口参数</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
									<form class="form-horizontal" id="addBusinessRuleParameterForm" method="POST" role="form">
										
											<label class="control-label">必填字段</label>
										
										
										<div style="margin-top:10px;margin-botton:10px;">
												 <table	class="table table-bordered float-item-left margin-items-top"  id="myTable" style="word-wrap: break-word; word-break: break-all;"> 
													<thead>
														<tr>
															<th style="width:20%;">字段名称</th>
															<th style="width:20%">字段类型</th>
															<th style="width:60%;">字段说明</th>
														</tr>
													</thead>
													<tbody align="center">
														<c:forEach items="${configParamList}" var="configParam">
														  <c:if test="${configParam.isAllowNull == '0'}">
																<tr>
																	<td>
																	  <span style="margin-left:10px">${configParam.paramName }</span>   
																	</td>
																	<td>
					                          <span style="margin-left:10px">${configParam.paramType }</span>   
					                        </td>
					                        <td>
					                          <span style="margin-left:10px">${configParam.paramRemark }</span>   
					                        </td>
																</tr>
														  </c:if>
														</c:forEach>
													</tbody>
												</table>
					    				</div>
											<label class="control-label">选填字段</label>
					    				
				            <div style="margin-top:10px;margin-botton:10px;">
				                 <table class="table table-bordered float-item-left margin-items-top"  id="myTable">
				                  <thead>
				                    <tr>
				                      <th>字段名称</th>
				                      <th>字段类型</th>
				                      <th>字段说明</th>
				                    </tr>
				                  </thead>
				                  <tbody align="center">
				                    <c:forEach items="${configParamList}" var="configParam">
				                      <c:if test="${configParam.isAllowNull == '1'}">
				                        <tr>
				                          <td>
				                            <span style="margin-left:10px">${configParam.paramName }</span>   
				                          </td>
				                          <td>
				                            <span style="margin-left:10px">${configParam.paramType }</span>   
				                          </td>
				                          <td>
				                            <span style="margin-left:10px">${configParam.paramRemark }</span>   
				                          </td>
				                        </tr>
				                      </c:if>
				                    </c:forEach>
				                  </tbody>
				                </table>
				              </div>
					    					    					
					    				<div class="form-group">
															
											<div class="col-sm-12">
												<div class="btn-toolbar" role="toolbar">
									              <div class="btn-group" style="float:right;">
									                 <button id="returnBtn" type="button" class="btn btn-primary">返回</button>
									              </div>
												</div>
											</div>
										</div>
											
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
$("#returnBtn").click(
    function() {
      window.location.href = "${pageContext.request.contextPath}/listExternalInterface";
    }
);
</script>

</html>