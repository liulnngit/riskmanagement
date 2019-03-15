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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/js/ueditor/ueditor.all.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/js/ueditor/lang/zh-cn/zh-cn.js"></script>

</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>新增案件</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
									<form class="form-horizontal" id="addRiskCaseForm" method="POST"
										role="form">
				
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>案件标题:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="title" name="title"
													required="required" placeholder="请输入案件标题">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>案件级别:</label>
											<div class="col-sm-8">
												<select
													id="priority" required="required" class="form-control"
													name="priority">
													<option value="">-----请选择-----</option>
												</select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>案件详情:</label>
											<div class="col-sm-8">
												<script id="caseDetail" name="caseDetail" type="text/plain" 
												></script>
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
		$("#title").change(function() {
			var title = $("#title").val().replace(/<\/?[^>]*>/g,'');
			$("#title").val($.trim(title));
		});
	});
</script>

<script type="text/javascript">
	var ue = UE.getEditor('caseDetail');
</script>

<script type="text/javascript">
	$(function() {

		$.validator.setDefaults({
			submitHandler : function(form) {
				ajaxSubmitForm();
			}
		});

		$(function() {
			// 在键盘按下并释放及提交后验证提交表单
			$("#addRiskCaseForm").validate({
				invalidHandler : function(form, validator) { //不通过回调
					return false;
				},
				rules : {
					title : {
						required : true,
						maxlength : 50,
						remote : {
							url : "checkRiskCaseTitle",
							type : "post",
							dataType : "json",
							data : {
								title : function() {
									return $("#title").val();
								}
							}
						}
					},
					priority : {
						required : true,
						maxlength : 1
					},
					caseDetail : {
						required : true,
						maxlength : 2000
					}
				},
				messages : {
					title : {
						required : "请输入案件标题！",
						maxlength : "案件标题长度为50！",
						remote : "该标题已存在"
					},
					priority : {
						required : "请选择案件级别！",
						maxlength : "案件级别长度为1！"
					},
					caseDetail : {
						required : "请输入案件详情！",
						maxlength : "案件详情长度为2000！"
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
						url : "${pageContext.request.contextPath }/addRiskCase",
						data : $('#addRiskCaseForm').serialize(),// 你的formid
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
														window.location.href = "${pageContext.request.contextPath }/listRiskCase";
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
														window.location.href = "${pageContext.request.contextPath }/listRiskCase";
													}
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							}
						}
					});
		}

		$.ajax({
			url : "${pageContext.request.contextPath}/queryRiskLevelList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#priority").append(
								'<option value="' + data[i].id +'">'
										+ data[i].title + '</option>')
					}
				}
			}
		});

	})

	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/listRiskCase";
					});
</script>
</html>