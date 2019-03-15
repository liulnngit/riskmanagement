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
                        <h5>编辑行业</h5>
                    </div>
				
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
									<form class="form-horizontal" id="editBusinessTypeForm" method="POST"
										role="form">
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>行业名称:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="title" name="title"
													required="required" placeholder="请输入行业名称"
													value="${businessType.title }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>行业编码:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="code" name="code" required="required"
													placeholder="请输入行业编码" value="${businessType.code }">
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
												<button id="resetBtn" type="button"
													class="btn btn-primary margin-items-top">重置</button>
											</div>
											<div class="btn-group">
												<button id="returnBtn" type="button" class="btn btn-primary">返回</button>
											</div>
										</div>
										<input type="hidden" id="id" name="id" value="${businessType.id }">
										<input type="hidden" name="status" value="${businessType.status }">
										<input type="hidden" name="creatorId"
											value="${businessType.creatorId }"> <input type="hidden"
											name="createDate" value="${businessType.createDate }">
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
			$("#editBusinessTypeForm").validate({
				invalidHandler : function(form, validator) { //不通过回调
					return false;
				},
				rules : {
					title : {
						required : true,
						maxlength : 20,
						remote : {
							url : "businessType/checkTitle",
							type : "post",
							dataType : "json",
							data : {
								title : function() {
									return $("#title").val();
								},
								id : function() {
									return $("#id").val();
								}
							}
						}
					},
					code : {
						required : true,
						maxlength : 20,
						code : true,
						remote : {
							url : "businessType/checkCode",
							type : "post",
							dataType : "json",
							data : {
								code : function() {
									return $("#code").val();
								},
								id : function() {
									return $("#id").val();
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
						required : "请输入行业名称！",
						maxlength : "行业名称长度为20！",
						remote : "该行业名称已存在！"
					},
					code : {
						required : "请输入行业编码！",
						maxlength : "行业编码长度为20！",
						remote : "该行业编码已存在！"
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
						url : "${pageContext.request.contextPath }/editBusinessType",
						cache : false,
						type : "POST",
						data : $('#editBusinessTypeForm').serialize(),// 你的formid
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
														window.location.href = "${pageContext.request.contextPath }/listBusinessType";
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
														window.location.href = "${pageContext.request.contextPath }/listBusinessType";
													}
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							} else if ("isSystem" == data.isSystem) {
								layer
										.alert(
												'默认行业不允许编辑！',
												{
													skin : 'layui-layer-molv',
													icon : 5,
													closeBtn : 0,
													btnAlign : 'c', //按钮居中
													anim : 0, //动画类型
													time : 2000,
													end : function() {
														window.location.href = "${pageContext.request.contextPath }/listBusinessType";
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

	$("#resetBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/showBusinessType?id="
								+ $("#id").val();
					});
	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/listBusinessType";
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
	});
</script>

</html>