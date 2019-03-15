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
                        <h5>可疑订单模型</h5>
                    </div>
					
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
									<form class="form-horizontal" role="form"
										id="editDoubtfulOrdersModelForm">
										<div class="form-group">
											<label class="col-sm-2 control-label">【交易情况】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>周期单位:</label>
											<div class="col-sm-8">
												<select
													id="periodUnit" class="form-control" name="periodUnit">
													<option value="D"
														<c:if test="${doubtfulOrdersModelParam.periodUnit=='D'}">selected</c:if>>天</option>
													<option value="H"
														<c:if test="${doubtfulOrdersModelParam.periodUnit=='H'}">selected</c:if>>小时</option>
												</select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>交易周期:</label>
											<div class="col-sm-8">
												<input type="text"
													id="transacPeriod" class="form-control" placeholder="请输入整数"
													name="transacPeriod"
													value="${doubtfulOrdersModelParam.transacPeriod}">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>应用规则:</label>
											<div class="col-sm-8">
												<select
													class="form-control input-sm" name="ruleCode" id="ruleCode">
													<option value="">-----请选择规则-----</option>
												</select> <input type="hidden" id="ruleCodeHidden"
													value="${doubtfulOrdersModelParam.ruleCode}">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label">商家行业:</label>
											<div class="col-sm-8">
												<select
													class="form-control input-sm" name="merchantBusiness"
													id="merchantBusiness">
													<option value="">-----请选择行业-----</option>
												</select> <input type="hidden" id="merchantBusinessHidden"
													value="${doubtfulOrdersModelParam.merchantBusiness}">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label">【可疑规则】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>整数位的浮动比率:</label>
											<div class="col-sm-8">
												<input
													type="text" id="floatingRate" class="form-control"
													placeholder="请输入百分数" name="floatingRate"
													value="${doubtfulOrdersModelParam.floatingRate}">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>不同城市交易间隔:</label>
											<div class="col-sm-8">
												<input
													type="text" id="transacInterval" class="form-control"
													placeholder="请输入百分数" name="transacInterval"
													value="${doubtfulOrdersModelParam.transacInterval}">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
				
										<div class="form-group">
											
											<div class="col-sm-4 col-sm-offset-2">
												<div class="btn-toolbar" role="toolbar">
											<div class="btn-group">
												<input id="submitBtn" type="submit"
													class="btn btn-primary margin-items-top" value="保 存" />
											</div>
											<div class="btn-group">
												<button type="button" id="resetBtn"
													class="btn btn-primary margin-items-top">重 置</button>
											</div>
											<div class="btn-group">
												<button id="returnBtn" type="button"
													class="btn btn-primary margin-items-top">返 回</button>
											</div>
										</div>
										<input type="hidden" name="id" class="form-control" value="${analyzeModelParameter.id}">
										<input type="hidden" id="analyzeModelId" name="analyzeModelId" class="form-control"
											value="${analyzeModel.id}">
										<input type="hidden" name="systemId" class="form-control" value="${analyzeModelParameter.systemId}">
										<input type="hidden" name="status" class="form-control" value="${analyzeModelParameter.status}">
										<input type="hidden" name="creatorId" class="form-control" value="${analyzeModelParameter.creatorId}">
										<input type="hidden" name="createDate" class="form-control" value="${analyzeModelParameter.createDate}">
										<input type="hidden" name="menuId" id="menuId" class="form-control" value="${menuId}">
											</div>
										</div>
				
										
										
									</form>
									<div>
										<div style="margin-top: 10px; margin-botton: 10px;">
											<strong><span>说明：</span></strong>
										</div>
										<div style="margin-top: 10px; margin-botton: 10px;">
											<strong><span>${analyzeModel.remark}</span></strong>
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
		$("#periodUnit").change(function() {
			$("#transacPeriod").val('');
		});
		$("#transacPeriod").change(function() {
			var periodUnit = $("#periodUnit").val();
			var textInput = $("#transacPeriod").val();
			var tag = true;
			if ('D' == periodUnit) {
				if (textInput > 365) {
					$("#transacPeriod").val('365');
					tag = false;
				} else if (textInput < 1) {
					$("#transacPeriod").val('1');
					tag = false;
				}
				tag = false;
			} else if ('H' == periodUnit) {
				if (textInput > 24) {
					$("#transacPeriod").val('24');
					tag = false;
				} else if (textInput < 1) {
					$("#transacPeriod").val('1');
					tag = false;
				}
				tag = false;
			}
			return tag;
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
		$.ajax({
			url : "${pageContext.request.contextPath}/queryListRule",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#ruleCode").append(
								'<option value="' + data[i].ruleCode +'">'
										+ data[i].ruleName + '</option>')
					}
	
					//获取input隐藏域中的值
					var selectOption = $("#ruleCodeHidden").val();
					//判断从数据库查出的规则算法是不是和数组中的规则类型一样，如果是一样则设置为选中状态
					$("#ruleCode option[value='" + selectOption + "']").attr(
							"selected", "selected");
				}
			}
		});

		$("#editDoubtfulOrdersModelForm").validate({
			invalidHandler : function(form, validator) { //不通过回调
				return false;
			},
			rules : {
				periodUnit : {
					required : true
				},
				transacPeriod : {
					required : true,
					digits : true
				},
				ruleCode : {
					required : true
				},
				floatingRate : {
					required : true,
					validateDecimals : true
				},
				transacInterval : {
					required : true,
					validateDecimals : true
				}
			},
			messages : {
				periodUnit : {
					required : "请选择周期单位！"
				},
				transacPeriod : {
					required : "请输入交易周期！",
					digits : "请输入正整数！"
				},
				ruleCode : {
					required : "请选择应用规则！"
				},
				floatingRate : {
					required : "请输入整数位的浮动比率！"
				},
				transacInterval : {
					required : "请输入不同城市交易间隔！"
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
					url : "${pageContext.request.contextPath }/updateDoubtfulOrdersParam",
					data : $('#editDoubtfulOrdersModelForm').serialize(),// 你的formid
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
					complete : function() {
						//后端响应后放开按钮
						$("#submitBtn").removeAttr("disabled");
					},
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
													window.location.href = "${pageContext.request.contextPath }/listAnalyzeModel";
												}
											});
							//后端响应后放开按钮
							$("#submitBtn").removeAttr("disabled");
							return;
						} else {
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
													window.location.href = "${pageContext.request.contextPath }/listAnalyzeModel";
												}
											});
							//后端响应后放开按钮
							$("#submitBtn").removeAttr("disabled");
							return;
						}
					}
				});
	}
</script>

<script type="text/javascript">
	$(function() {
		$("#resetBtn")
				.click(
						function() {
							window.location.href = "${pageContext.request.contextPath }/showAnalyzeModelParam?id="
									+ $("#analyzeModelId").val();
						});

		$("#returnBtn")
				.click(
						function() {
							var menuId = $("#menuId").val();
				      if("191" == menuId){
				        window.location.href = "${pageContext.request.contextPath}/listModels"
				      } else {
				        window.location.href = "${pageContext.request.contextPath }/listAnalyzeModel";
				      }
						})
	});
</script>

<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "queryBusinessTypeList",
			type : "get",
			dataType : "json",
			success : function(data) {
				if (data) {
					for (var i = 0; i < data.length; i++) {
						$("#merchantBusiness").append(
								'<option value="' + data[i].id + '">'
										+ data[i].title + "</option>")
					}
					var selectOption = $("#merchantBusinessHidden").val();
					$("#merchantBusiness option[value='" + selectOption + "']")
							.attr("selected", "selected");
				}
			}
		});
	})
</script>

<script type="text/javascript">
	$(function() {
		$("#transacPeriod").change(function() {
			var transacPeriod = $("#transacPeriod").val().replace(/<\/?[^>]*>/g,'');
			$("#transacPeriod").val($.trim(transacPeriod));
		});
		
		$("#floatingRate").change(function() {
			var floatingRate = $("#floatingRate").val().replace(/<\/?[^>]*>/g,'');
			$("#floatingRate").val($.trim(floatingRate));
		});
		
		$("#transacInterval").change(function() {
			var transacInterval = $("#transacInterval").val().replace(/<\/?[^>]*>/g,'');
			$("#transacInterval").val($.trim(transacInterval));
		});
	})
</script>

</html>