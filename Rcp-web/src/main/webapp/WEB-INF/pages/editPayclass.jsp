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
                        <h5>编辑支付类型</h5>
                    </div>
					
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
								
									<form class="form-horizontal" id="editPayclassForm" method="POST"
										role="form">
				
										<!-- <div style="margin-top: 10px; margin-botton: 10px;">
											<strong><span>行业信息</span></strong>
										</div> -->
										<input type="hidden" id="id" name="id" value="${payclass.id }">
										<input type="hidden" id="systemId" name="systemId" value="${payclass.systemId }">
										<input type="hidden" id="status" name="status" value="${payclass.status }">
										<input type="hidden" id="creatorId" name="creatorId" value="${payclass.creatorId }">
										<input type="hidden" id="createDate" name="createDate" value="${payclass.createDate }">
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>支&nbsp;付&nbsp;类&nbsp;型&nbsp;ID:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="code" name="code"
													required="required" placeholder="请输入支付类型ID"
													value="${payclass.code }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>支付类型名称:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="name" name="name" required="required"
													placeholder="请输入支付类型名称" value="${payclass.name }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label">类型英文名称:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="nameEn" name="nameEn"
													placeholder="请输入支付类型英文名称" value="${payclass.nameEn }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>接&nbsp;&nbsp;入&nbsp;&nbsp;方&nbsp;&nbsp;式:</label>
											<div class="col-sm-8">
												<select name="accessType" id="accessType" class="form-control">
													<option value="">-----请选择-----</option>
													<option value="1" <c:if test="${payclass.accessType == '1'}">selected</c:if>>WEB</option>
													<option value="2" <c:if test="${payclass.accessType == '2'}">selected</c:if>>WAP</option>
													<option value="3" <c:if test="${payclass.accessType == '3'}">selected</c:if>>手机</option>
													<option value="4" <c:if test="${payclass.accessType == '4'}">selected</c:if>>短信</option>
												</select>
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
			$("#editPayclassForm").validate({
				invalidHandler : function(form, validator) { //不通过回调
					return false;
				},
				rules : {
					code : {
						required : true,
						maxlength : 10,
						code : true,
						remote : {
							url : "payclass/checkCode",
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
					name : {
						required : true,
						maxlength : 30,
						remote : {
							url : "payclass/checkName",
							type : "post",
							dataType : "json",
							data : {
								name : function() {
									return $("#name").val();
								},
								id : function() {
									return $("#id").val();
								}
							}
						}
					},
					nameEn : {
						required : false,
						maxlength : 30,
						remote : {
							url : "payclass/checkNameEn",
							type : "post",
							dataType : "json",
							data : {
								nameEn : function() {
									return $("#nameEn").val();
								},
								id : function() {
									return $("#id").val();
								}
							}
						}
					},
					accessType : {
						required : true
					}
				},
				messages : {
					code : {
						required : "请输入支付类型ID！",
						maxlength : "支付类型ID最大长度为10！",
						remote : "该支付类型ID已存在！"
					},
					name : {
						required : "请输入支付类型名称！",
						maxlength : "支付类型名称最大长度为30！",
						remote : "该支付类型名称已存在！"
					},
					nameEn : {
						maxlength : "支付类型英文名称长度最大长度为30！",
						remote : "该支付类型英文名称已存在！"
					},
					accessType : {
						required : "请选择接入方式！"
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
						url : "${pageContext.request.contextPath }/editPayclass",
						data : $('#editPayclassForm').serialize(),// 你的formid
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
														window.location.href = "${pageContext.request.contextPath }/listPayclass";
													}
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							} else if ("fail" == data.status) {
								layer
										.alert(
												'新增失败！',
												{
													skin : 'layui-layer-molv',
													icon : 5,
													closeBtn : 0,
													btnAlign : 'c', //按钮居中
													anim : 0, //动画类型
													time : 2000,
													end : function() {
														window.location.href = "${pageContext.request.contextPath }/listPayclass";
													}
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							} else if ("isSystem" == data.isSystem) {
		                layer
	                    .alert(
	                        '默认支付类型不允许编辑！',
	                        {
	                          skin : 'layui-layer-molv',
	                          icon : 5,
	                          closeBtn : 0,
	                          btnAlign : 'c', //按钮居中
	                          anim : 0, //动画类型
	                          time : 2000,
	                          end : function() {
	                            window.location.href = "${pageContext.request.contextPath }/listPayclass";
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
						window.location.href = "${pageContext.request.contextPath}/toEditPayclassPage?id=" + $("#id").val()
					});
	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/listPayclass";
					});
</script>

<script type="text/javascript">
	$(function() {
		$("#code").change(function() {
			var code = $("#code").val().replace(/<\/?[^>]*>/g,'');
			code = code.replace(/\s+/g, "");
			code = code.replace(/\<+/g, "");
			code = code.replace(/\>+/g, "");
			$("#code").val(code);
		});
		
		$("#name").change(function() {
			var name = $("#name").val().replace(/<\/?[^>]*>/g,'');
			name = name.replace(/\s+/g, "");
			name = name.replace(/\<+/g, "");
			name = name.replace(/\>+/g, "");
			$("#name").val(name);
		});
		
		$("#nameEn").change(function() {
			var nameEn = $("#nameEn").val().replace(/<\/?[^>]*>/g,'');
			nameEn = nameEn.replace(/\s+/g, "");
			nameEn = nameEn.replace(/\<+/g, "");
			nameEn = nameEn.replace(/\>+/g, "");
			$("#nameEn").val(nameEn);
		});
		
	});
</script>

</html>
