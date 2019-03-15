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
						<h5>新增风控事件处理类型</h5>
					</div>

					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
								<form class="form-horizontal" id="addProcessTypeForm"
									method="POST" role="form">

									<!-- <div style="margin-top: 10px; margin-botton: 10px;">
											<strong><span>行业信息</span></strong>
										</div> -->
										
									<div class="form-group">
										<label class="col-sm-2 control-label"><span
											style="color: red; font-size: 18px;">* </span>类型编码:</label>
										<div class="col-sm-8">
											<input type="text" class="form-control" id="code" name="code"
												placeholder="请输入类型编码">
										</div>
									</div>
									
									<div class="hr-line-dashed"></div>	

									<div class="form-group">
										<label class="col-sm-2 control-label"><span
											style="color: red; font-size: 18px;">* </span>处理类型名称:</label>
										<div class="col-sm-8">
											<input type="text" class="form-control" id="processType"
												name="processType" required="required"
												placeholder="请输入处理类型名称">
										</div>
									</div>
									<div class="hr-line-dashed"></div>

									<div class="form-group">
										<label class="col-sm-2 control-label"><span
											style="color: red; font-size: 18px;">* </span>类型英文名称:</label>
										<div class="col-sm-8">
											<input type="text" class="form-control" id="processTypeEn"
												name="processTypeEn" placeholder="请输入处理类型英文名称">
										</div>
									</div>
									
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label">备注:</label>
										<div class="col-sm-8">
											<textarea id="remark" name="remark" class="form-control"
												rows="3" placeholder="备注"></textarea>
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
													<button id="returnBtn" type="button"
														class="btn btn-primary">返回</button>
												</div>
											</div>
										</div>
									</div>

								</form>
							</div>
						</div>
					</div>
					<br> <br> <br>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	$(function() {

		$.validator.setDefaults({
			submitHandler : function(form) {
				ajaxSubmitForm();
			}
		});

		$(function() {
			// 在键盘按下并释放及提交后验证提交表单
			$("#addProcessTypeForm").validate({
				invalidHandler : function(form, validator) { //不通过回调
					return false;
				},
				rules : {
					processType : {
						required : true,
						maxlength : 30,
						remote : {
							url : "processType/checkProcessType",
							type : "post",
							dataType : "json",
							data : {
								processType : function() {
									return $("#processType").val();
								}
							}
						}
					},
					processTypeEn : {
						required : true,
						maxlength : 30,
						codeEnglish : true,
						remote : {
							url : "processType/checkProcessTypeEn",
							type : "post",
							dataType : "json",
							data : {
								processTypeEn : function() {
									return $("#processTypeEn").val();
								}
							}
						}
					},
					code : {
						required : true,
						maxlength : 10,
						code : true,
						remote : {
							url : "processType/checkCode",
							type : "post",
							dataType : "json",
							data : {
								code : function() {
									return $("#code").val();
								}
							}
						}
					},
					remark : {
						required : false,
						maxlength : 500
					}

				},
				messages : {

					processType : {
						required : "请输入处理类型名称！",
						maxlength : "处理类型名称最大长度为30！",
						remote : "该处理类型名称已存在！"
					},
					processTypeEn : {
						required : "请输入类型英文名称！",
						maxlength : "处理类型英文名称长度最大长度为30！",
						remote : "该处理类型英文名称已存在！"
					},
					code : {
						required : "请输入处理类型编码！",
						maxlength : "处理类型编码最大长度为10！",
						remote : "该处理类型编码已存在！"
					},
					remark : {
						maxlength : "备注最大长度为500！"
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
				onfocusout : function(element) {
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
						url : "${pageContext.request.contextPath }/addRcEventWorkflow",
						data : $('#addProcessTypeForm').serialize(),// 你的formid
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
							return;
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
														window.location.href = "${pageContext.request.contextPath }/listRcEventWorkflow";
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
														window.location.href = "${pageContext.request.contextPath }/listRcEventWorkflow";
													}
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							}
						}
					});
		}
	});

	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/listRcEventWorkflow";
					});
</script>

<script type="text/javascript">
	$(function() {
		$("#code").change(function() {
			var code = $("#code").val().replace(/<\/?[^>]*>/g, '');
			code = code.replace(/\s+/g, "");
			code = code.replace(/\<+/g, "");
			code = code.replace(/\>+/g, "");
			$("#code").val(code);
		});

		$("#processType").change(
				function() {
					var processType = $("#processType").val().replace(
							/<\/?[^>]*>/g, '');
					processType = processType.replace(/\s+/g, "");
					processType = processType.replace(/\<+/g, "");
					processType = processType.replace(/\>+/g, "");
					$("#processType").val(processType);
				});

		$("#processTypeEn").change(
				function() {
					var processTypeEn = $("#processTypeEn").val().replace(
							/<\/?[^>]*>/g, '');
					processTypeEn = processTypeEn.replace(/\s+/g, "");
					processTypeEn = processTypeEn.replace(/\<+/g, "");
					processTypeEn = processTypeEn.replace(/\>+/g, "");
					$("#processTypeEn").val(processTypeEn);
				});

		$("#remark").change(function() {
			var remark = $("#remark").val().replace(/<\/?[^>]*>/g, '');
			remark = remark.replace(/\s+/g, "");
			remark = remark.replace(/\<+/g, "");
			remark = remark.replace(/\>+/g, "");
			$("#remark").val(remark);
		});

	});
</script>

</html>
