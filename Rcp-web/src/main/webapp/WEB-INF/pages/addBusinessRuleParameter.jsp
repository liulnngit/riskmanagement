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
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/additional-methods.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>新增行业参数</h5>
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
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则名称:</label>
											<div class="col-sm-8">
												<select
													id="ruleCode" required="required" class="form-control"
													name="ruleCode">
													<option value="">-----请选择-----</option>
												</select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<%-- <div style="width: 30%; margin-top: 10px; margin-botton: 10px;">
											<div class="input-group">
												<span class="input-group-addon">规则类别:</span> <span
													style="margin-left: 10px">${ruleParameterVo.ruleTitle.title }</span>
											</div>
										</div> --%>
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>行业配置:</label>
											<div class="col-sm-8">
												<select
													id=kk required="required" class="form-control"
													name="businessId">
													<option value="">-----请选择-----</option>
												</select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										
										
										<!-- <div style="width:30%;margin-top:10px;margin-botton:10px;">
				              <div class="input-group">
				                <span class="input-group-addon">规则级别:</span>
				                
				                <select id="riskLevel" required="required" class="form-control" name="riskLevel">
				                  <option value="">-----请选择-----</option>
				                </select>   
				                </div>
				              </div> -->
				              <div class="form-group">
								<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>是否报警:</label>
								<div class="col-sm-8">
									<select id="alarmFlag" required
				                        class="form-control" name="alarmFlag">
				                        <option value="">-----请选择-----</option>
				                        <option value="1">是</option>
				                        <option value="0">否</option>
				                      </select> 
								</div>
							</div>
							<div class="hr-line-dashed"></div>
				              <div class="form-group">
								<label class="col-sm-2 control-label">【配置参数】</label>
							</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">配置参数:</label>
									<div class="col-sm-8" >
										<div  id="tbody-result" >
													<table
														class="table table-bordered float-item-left margin-items-top "
														 id="myTable">
														<thead>
															<tr>
																<th>参数名称</th>
																<th>参数值</th>
															</tr>
														</thead>
														<tbody align="center"></tbody>
													</table>
													<%-- <table
														class="table table-bordered float-item-left margin-items-top"
														style="width: 600px; margin-left: 10px;" id="myTable">
														<thead>
															<tr>
																<th>参数名称</th>
																<th>参数值</th>
															</tr>
														</thead>
														 <tbody align="center">
															<c:forEach items="${paramKeyValueList }" var="paramKeyValue">
																<tr>
																	<td><input type="hidden" id="paramKey" name="paramKey"
																		value="${paramKeyValue.key}"> <input type="hidden"
																		id="paramName" name="paramName"
																		value="${paramKeyValue.name}">${paramKeyValue.name}
																	</td>
																	<td><input type="text" id="paramValue"
																		name="paramValue" value='${paramKeyValue.value}'
																		style="width: 300px;"></td>
																</tr>
															</c:forEach>
														</tbody> 
														<tbody align="center"></tbody>
													</table>--%>
												</div>
									</div>
								</div>
								<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											
											<div class="col-sm-4 col-sm-offset-2">
												<div class="btn-toolbar" role="toolbar">
											<div class="btn-group">
												<button id="submitBtn" type="submit"
													class="btn btn-primary margin-items-top">保 存</button>
											</div>
											<div class="btn-group">
												<button id="resetBtn" type="reset"
													class="btn btn-primary margin-items-top">重置</button>
											</div>
											<div class="btn-group">
												<button id="returnBtn" type="button" class="btn btn-primary">返回</button>
											</div>
										</div>
											</div>
										</div>
				
										
										<%-- <input type="hidden" name="ruleType" id="ruleType"
											value="${ruleParameter.ruleType }" /> <input type="hidden"
											name="riskLevel" id="riskLevel"
											value="${ruleParameter.riskLevel }" /> <input type="hidden"
											name="alarmFlag" id="alarmFlag"
											value="${ruleParameter.alarmFlag }" /> <input type="hidden"
											name="status" id="status" value="${ruleParameter.status }" /> <input
											type="hidden" name="ruleCode" id="ruleCode"
											value="${ruleParameter.ruleCode }" /> <input type="hidden"
											name="systemId" id="systemId" value="${ruleParameter.systemId }" />
										<input type="hidden" name="ruleParameterId" id="ruleParameterId"
											value="${ruleParameter.id}" /> --%>
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
	$.validator.setDefaults({
		submitHandler : function(form) {
			ajaxSubmitForm();
		}
	});

	$(function() {
		// 在键盘按下并释放及提交后验证提交表单
		$("#addBusinessRuleParameterForm").validate({
			invalidHandler : function(form, validator) { //不通过回调
				return false;
			},
			rules : {
				ruleCode : {
					required : true
				},
				businessId : {
					required : true
				},
				paramValue : {
					required : true,
					validatePositiveNum : true
				}
			},
			messages : {
				ruleCode : {
					required : "请选择规则！"
				},
				businessId : {
					required : "请选择行业！"
				},
				paramValue : {
					required : "参数值不能为空！",
					validatePositiveNum : "请输入正整数！"
				}

			},
			//重写showErrors
			showErrors : function(errorMap, errorList) {
				var msg = "";
				$.each(errorList, function(i, v) {
					//msg += (v.message + "\r\n");
					//在此处用了layer的方法,显示效果更美观
					layer.tips(v.message, v.element, {
						time : 2000
					});
					return false;
				});
			},
			/* 失去焦点时验证 */
			onfocusout : function(element) {
				$(element).valid();
			},
			focusInvalid : function(element) {
				$(element).valid();
			}
		});
	});

	function ajaxSubmitForm() {
		$
				.ajax({
					cache : false,
					type : "POST",
					url : "${pageContext.request.contextPath }/addBusinessRuleParameter",
					data : $('#addBusinessRuleParameterForm').serialize(),// 你的formid
					async : false,
					error : function(request) {
						layer.alert('网络异常！', {
							skin : 'layui-layer-molv',
							icon : 5,
							closeBtn : 0,
							btnAlign : 'c', //按钮居中
							anim : 0, //动画类型
							time : 2000
						});
						//后端响应后放开按钮
						$("#submitBtn").removeAttr("disabled");
					},
					beforeSend : function() {
						//在表单提交后后端未作出响应时，禁用提交按钮，提高用户体验。
						$("#submitBtn").attr({
							disabled : "disabled"
						});
					},
					/* complete : function() {
						//后端响应后放开按钮
						$("#submitBtn").removeAttr("disabled");
					}, */
					success : function(data) {
						if ("success" == data.status) {
							layer
									.alert(
											'保存成功！',
											{
												skin : 'layui-layer-molv',
												icon : 1,
												closeBtn : 0,
												btnAlign : 'c', //按钮居中
												anim : 0, //动画类型
												time : 2000,
												end : function() {
													window.location.href = "${pageContext.request.contextPath}/listBusinessRuleParameter";
												}
											});
							//后端响应后放开按钮
							$("#submitBtn").removeAttr("disabled");
							return;
						} else if ("fail" == data.status) {
							layer
									.alert(
											'保存失败！',
											{
												skin : 'layui-layer-molv',
												icon : 5,
												closeBtn : 0,
												btnAlign : 'c', //按钮居中
												anim : 0, //动画类型
												time : 2000,
												end : function() {
													window.location.href = "${pageContext.request.contextPath}/listBusinessRuleParameter";
												}
											});
							//后端响应后放开按钮
							$("#submitBtn").removeAttr("disabled");
							return false;
						} else if ("valueError" == data.valueError) {
							layer.alert('配置的参数必须为正整数！', {
								skin : 'layui-layer-molv',
								icon : 5,
								closeBtn : 0,
								btnAlign : 'c', //按钮居中
								anim : 0, //动画类型
								time : 2000
							});
							//后端响应后放开按钮
							$("#submitBtn").removeAttr("disabled");
							return;
						} else if ("inactive" == data.inactive) {
							layer.alert('保存失败，该规则公有参数为禁用状态！', {
								skin : 'layui-layer-molv',
								icon : 5,
								closeBtn : 0,
								btnAlign : 'c', //按钮居中
								anim : 0, //动画类型
								time : 2000
							});
							//后端响应后放开按钮
							$("#submitBtn").removeAttr("disabled");
							return;
						}
					}
				});
	}

	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/listBusinessRuleParameter";
					});
</script>

<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/queryRuleListByActive",
			type : "get",
			dataType : "json",
			error : function(request) {
				layer.alert('网络异常！', {
					skin : 'layui-layer-molv',
					icon : 5,
					closeBtn : 0,
					btnAlign : 'c', //按钮居中
					anim : 0, //动画类型
					time : 2000
				});
			},
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						var ruleCode = data[i].ruleCode;
						var ruleName = data[i].ruleName;
						$("#ruleCode").append(
								'<option value="' + ruleCode + '">' + ruleName
										+ '</option>');
					}
				}
			}
		});
		
		/* $.ajax({
		      url : "${pageContext.request.contextPath}/queryRiskLevelList",
		      type : "GET",
		      contentType : "application/json",
		      cache : false,
		      dataType : "json",
		      success : function(data) {
		        if (data.length > 0) {
		          for (var i = 0; i < data.length; i++) {
		            $("#riskLevel").append(
		                '<option value="' + data[i].id +'">'
		                    + data[i].title + '</option>')
		          }
		        }
		      }
		    }); */
		
		
	});
</script>

<script type="text/javascript">
	$(function() {
		$("#ruleCode").change(function() {
			var ruleCode = $("#ruleCode").val();
			$
					.ajax({
						url : "${pageContext.request.contextPath}/queryBusinessTypeList?ruleCode="
								+ ruleCode,
						type : "GET",
						contentType : "application/json",
						dataType : "json",
						success : function(data) {
							if (data.length > 0) {
								for (var i = 0; i < data.length; i++) {
									$("#businessId").append(
											'<option value="' + data[i].id +'">'
													+ data[i].title + '</option>');
								}
							}
						}
					});
		});
		
		$("#ruleCode").change(function() {
		      var selecteText = $('#ruleCode').find('option:selected').text();
		      var selecteVal = $('#ruleCode').find('option:selected').val();
		      $.ajax({
		        url : "${pageContext.request.contextPath}/parseConfigValuesByRuleCode?ruleCode=" + selecteVal,
		        type : "GET",
		        dataType : "json",
		        success : function(data) {
		        	if (data.length > 0) {
		        		var tbody = window.document
	                    .getElementById("tbody-result");
		        		var tableHead = '<table class="table table-bordered float-item-left margin-items-top" style="width: 600px; margin-left: 10px;" id="myTable"><thead><tr><th>参数名称</th><th>参数值</th></tr></thead><tbody align="center">';
		                var tableHtml = "";
	                for (var position = 0; position < data.length; position++) {
	                  tableHtml += '<tr>'
	                      + '<td><input type="hidden" class="" name="'
	                      + 'paramKey' + '" id="' + 'paramKey'
	                      + '" value=" '
	                      + data[position].key + '"/>' 
	                      + '<input type="hidden" class="" name="'
	                      + 'paramName' + '" id="' + 'paramName'
	                      + '" value=" '
	                      + data[position].name + '"/>' + data[position].name
	                      + '</td>'
	                      + '<td><input type="text" class="" name="'
	                      + 'paramValue' + '" id="' + 'paramValue'
	                      + '"/></td>' + '</tr>';
	                  
	                }
	                tbody.innerHTML =tableHead + tableHtml +'</tbody></table>';
		        	} else {
		        		$("#tbody-result").empty();
		        	}
		        
		        }
		      });
		    })
	});
</script>
</html>