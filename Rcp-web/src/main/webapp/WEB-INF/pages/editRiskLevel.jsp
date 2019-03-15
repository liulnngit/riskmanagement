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
                        <h5>编辑风险级别</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
									<form class="form-horizontal" id="editRiskLevelForm" method="POST"
										role="form">
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>风险级别名称:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="title" name="title"
													required="required" placeholder="请输入风险级别名称"
													value="${riskLevel.title }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>风险级别编码:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="code" name="code" required="required"
													placeholder="请输入风险级别编码" value="${riskLevel.code }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											
											<div class="col-sm-4 col-sm-offset-2">
												<div class="btn-toolbar" role="toolbar">
											<div class="btn-group">
												<button id="submitBtn" type="submit"
													class="btn btn-primary margin-items-top">保存</button>
											</div>
											<div class="btn-group">
												<button id="resetBtn" type="button"
													class="btn btn-primary margin-items-top">重置</button>
											</div>
											<div class="btn-group">
												<button id="returnBtn" type="button" class="btn btn-primary">返回</button>
											</div>
										</div>
										<input type="hidden" id="id" name="id" value="${riskLevel.id }"> <input
											type="hidden" name="status" value="${riskLevel.status }">
										<input type="hidden" name="creatorId"
											value="${riskLevel.creatorId }"> <input type="hidden"
											name="createDate" value="${riskLevel.createDate }">
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
			$("#editRiskLevelForm").validate({
				invalidHandler : function(form, validator) { //不通过回调
					return false;
				},
				rules : {
					title : {
						required : true,
						remote : {
							url : "riskLevel/checkTitle",
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
						remote : {
							url : "riskLevel/checkCode",
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
					}
				},
				messages : {
					title : {
						required : "请输入级别名称！",
						remote : "该风险级别名称已存在！"
					},
					code : {
						required : "请输入级别编码！",
						remote : "该风险级别编码已存在！"
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
						url : "${pageContext.request.contextPath }/editRiskLevel",
						data : $('#editRiskLevelForm').serialize(),// 你的formid
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
														window.location.href = "${pageContext.request.contextPath }/listRiskLevel";
													}
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							} else {
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
														window.location.href = "${pageContext.request.contextPath }/listRiskLevel";
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

	$("#resetBtn").click(function() {
		window.location.href = "${pageContext.request.contextPath}/showRiskLevel?id=" + $("#id").val();
	});
	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/listRiskLevel";
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