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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/additional-methods.js"></script>

</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>编辑规则参数</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
								
									<form class="form-horizontal" id="editRuleParameterForm" method="POST" role="form">
										<div class="form-group">
											<label class="col-sm-2 control-label">【类别信息】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">规则类别:</label>
											<div class="col-sm-8">
												${ruleParameter.ruleTitle.title }<input type="hidden" id="ruleType" name="ruleType" value="${ruleParameter.ruleType }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
					    				<div class="form-group">
											<label class="col-sm-2 control-label">规则名称:</label>
											<div class="col-sm-8">
												${ruleParameter.rule.ruleName }
											</div>
										</div>
										<div class="hr-line-dashed"></div>	    				   				
					    				
					    				<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则级别:</label>
											<div class="col-sm-8">
												<select id="riskLevel" required="required" class="form-control" name="riskLevel">
													<option value="">-----请选择-----</option>
												</select>
												<input type="hidden" id="riskLevelHidden" value="${ruleParameter.riskLevel }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
					    				<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>是否报警:</label>
											<div class="col-sm-8">
												<select id="alarmFlag" required
									              class="form-control" name="alarmFlag">
									              <option value="">-----请选择-----</option>
									              <option value="1"
									              <c:if test="${ruleParameter.alarmFlag=='是'}">selected</c:if>>是</option>
				              					  <option value="0"
				                				  <c:if test="${ruleParameter.alarmFlag=='否'}">selected</c:if>>否</option>
									            </select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>	 	    				
					    				
					    				<div class="form-group">
											<label class="col-sm-2 control-label">【配置参数】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">配置参数:</label>
											<div class="col-sm-8">
												<table	class="table table-bordered float-item-left margin-items-top"  id="myTable">
													<thead>
														<tr>
															<th>参数名称</th>
															<th>参数值</th>
														</tr>
													</thead>
													<tbody align="center">
														<c:forEach items="${paramKeyValueList }" var="paramKeyValue">
															<tr>
																<td>
																	<input type="hidden" id="paramKey" name="paramKey" value="${paramKeyValue.key}">
																	<input type="hidden" id="paramName" name="paramName" value="${paramKeyValue.name}">${paramKeyValue.name}
																</td>
																<td>
																<input type="text" id="paramValue" name="paramValue" value='${paramKeyValue.value}' style="width: 300px;" class="form-control">
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
												<div class="btn-toolbar" role="toolbar">
												<div class="btn-group">
												    <button id="submitBtn" type="submit" class="btn btn-primary margin-items-top">保存</button>
												</div>
												<div class="btn-group">
									                 <button id="resetBtn" type="button" class="btn btn-primary margin-items-top">重置</button>
									              </div>
									              <div class="btn-group">
									                 <button id="returnBtn" type="button" class="btn btn-primary">返回</button>
									              </div>
															</div>
															<input type="hidden" name="id" id="id" value="${ruleParameter.id }"/>
															<input type="hidden" name="ruleCode" id="ruleCode" value="${ruleParameter.ruleCode }"/>
															<input type="hidden" name="systemId" id="systemId" value="${ruleParameter.systemId }"/>
															<c:if test="${ruleParameter.status=='启用'}">
																<input type="hidden" name="status" id="status" value="A"/>
															</c:if>
															<c:if test="${ruleParameter.status=='禁用'}">
								                <input type="hidden" name="status" id="status" value="I"/>
								              </c:if>
															<input type="hidden" name="creatorId" id="creatorId" value="${ruleParameter.creatorId }"/>
															<input type="hidden" name="createDate" id="createDate" value="${ruleParameter.createDate }"/>
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
	$(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/queryRiskLevelList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#riskLevel").append(
								'<option value="' + data[i].id +'">'
										+ data[i].title + '</option>')
					}
					//获取input隐藏域中的值
					var selectOption = $("#riskLevelHidden").val();
					//判断从数据库查出的规则算法是不是和数组中的规则类型一样，如果是一样则设置为选中状态
					$("#riskLevel option[value='" + selectOption + "']").attr(
							"selected", "selected");
				}

			}
		});
	});
</script>

<script type="text/javascript">
	$.validator.setDefaults({
		submitHandler : function(form) {
			ajaxSubmitForm();
		}
	});

	$(function() {
		// 在键盘按下并释放及提交后验证提交表单
		$("#editRuleParameterForm").validate({
			invalidHandler : function(form, validator) { //不通过回调
				return false;
			},
			rules : {
			       ruleCode : {
			         required : true
			       },
			       ruleType : {
			         required : true
			       },
			       riskLevel : {
			         required : true
			       },
			       alarmFlag : {
			         required : true
			       },
			       paramValue : {
			    	   required : true,
			    	   validatePositiveNum : true
			       }
			     },
			     messages : {
			       ruleCode : {
			         required : "请输入规则编码！"
			       },
			       ruleType : {
			         required : "请选择规则类型！"
			       },
			       riskLevel : {
			         required : "请选择风险级别！"
			       },
			       alarmFlag : {
			         required : "请选择是否报警！"
			       },
			       paramValue : {
			    	   required : "请输入参数！",
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
			/* 失去焦点时不验证 */
			onfocusout: function(element) { 
				$(element).valid(); 
			},
			//提交表单后，未通过验证的表单（第一个或提交之前获得焦点的未通过验证的表单）会获得焦点。
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
					url : "${pageContext.request.contextPath }/editRuleParameter",
					data : $('#editRuleParameterForm').serialize(),// 你的formid
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
											'编辑成功！',
											{
												skin : 'layui-layer-molv',
												icon : 1,
												closeBtn : 0,
												btnAlign : 'c', //按钮居中
												anim : 0, //动画类型
												time : 2000,
												end : function() {
													window.location.href = "${pageContext.request.contextPath }/listRuleParameter";
												}
											});
							//后端响应后放开按钮
							$("#submitBtn").removeAttr("disabled");
							return;
						} else if ("fail" == data.status) {
							layer
									.alert(
											'编辑失败！',
											{
												skin : 'layui-layer-molv',
												icon : 5,
												closeBtn : 0,
												btnAlign : 'c', //按钮居中
												anim : 0, //动画类型
												time : 2000,
												end : function() {
													window.location.href = "${pageContext.request.contextPath }/listRuleParameter";
												}
											});
							//后端响应后放开按钮
							$("#submitBtn").removeAttr("disabled");
							return;
						} else if ("valueError" == data.valueError) {
				        	   layer
				               .alert(
				                   '请输入正整数！',
				                   {
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
	
$("#resetBtn").click(
    function()
    {
    	window.location.href="${pageContext.request.contextPath}/showRuleParameter?id="+$("#id").val();
    }
);
$("#returnBtn").click(
    function() {
      window.location.href = "${pageContext.request.contextPath}/listRuleParameter";
    }
);
</script>

</html>