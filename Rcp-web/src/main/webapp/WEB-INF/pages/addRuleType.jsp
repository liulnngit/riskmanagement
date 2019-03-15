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
                        <h5>新增规则类别</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
									<form class="form-horizontal" id="addRuleTypeForm" method="POST"
										role="form">
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>类别名称:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="title" name="title"
													required="required" placeholder="请输入规则类别名称">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>类别编码:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="code" name="code" required="required"
													placeholder="请输入规则类别编码">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>实现类名:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="classFullPath" name="classFullPath"
													required="required" placeholder="请输入实现类名，注意大小写">
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

		$.validator.setDefaults({
			submitHandler : function(form) {
				ajaxSubmitForm();
			}
		});

		$(function() {
			// 在键盘按下并释放及提交后验证提交表单
			$("#addRuleTypeForm").validate({
				invalidHandler : function(form, validator) { //不通过回调
					return false;
				},
				rules : {
					title : {
						required : true,
						maxlength : 20,
						remote : {
							url : "ruleType/checkTitle",
							type : "post",
							dataType : "json",
							data : {
								title : function() {
									return $("#title").val();
								}
							}
						}
					},
					code : {
						required : true,
						maxlength : 20,
						code : true,
						remote : {
							url : "ruleType/checkCode",
							type : "post",
							dataType : "json",
							data : {
								code : function() {
									return $("#code").val();
								}
							}
						}
					},
					classFullPath : {
						required : true
					}
				},
				messages : {
					title : {
						required : "请输入类别名称！",
						maxlength : "类别名称长度为20！",
						remote : "该类另名称已存在！"
					},
					code : {
						required : "请输入类别编码！",
						maxlength : "类别编码长度为20！",
						remote : "该类别编码已存在！"
					},
					classFullPath : {
						required : "请输入实现类名称！"
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
						url : "${pageContext.request.contextPath }/addRuleType",
						data : $('#addRuleTypeForm').serialize(),// 你的formid
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
														window.location.href = "${pageContext.request.contextPath }/listRuleType";
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
														window.location.href = "${pageContext.request.contextPath }/listRuleType";
													}
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							}
						}
					});
		}
	})

	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/listRuleType";
					});
</script>

<script type="text/javascript">
	$(function() {
		$("#title").change(function() {
			var title = $("#title").val().replace(/<\/?[^>]*>/g,'');
			$("#title").val($.trim(title));
		});
		
		$("#code").change(function() {
			var code = $("#code").val().replace(/<\/?[^>]*>/g,'');
			$("#code").val($.trim(code));
		});
		
		$("#classFullPath").change(function() {
			var classFullPath = $("#classFullPath").val().replace(/<\/?[^>]*>/g,'');
			$("#classFullPath").val($.trim(classFullPath));
		});
	});
</script>

</html>