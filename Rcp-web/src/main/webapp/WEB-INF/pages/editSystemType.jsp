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
	src="${pageContext.request.contextPath}/js/additional-methods.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
					<div class="ibox-title">
                        <h5>修改接入系统信息</h5>
                    </div>
				
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
								<div style="margin-left: 50px; margin-top: 20px">
									<form class="form-horizontal" id="editSystemTypeForm"
										action="editSystemType" method="POST" role="form">
				
										<div class="form-group">
											<label class="col-sm-2 control-label">【系统信息】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>系统名称:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="systemName" name="systemName"
													required="required" value="${systemType.systemName}" placeholder="请输入系统名称">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>系统代码:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="systemCode" name="systemCode" readonly="readonly"
													required="required" value="${systemType.systemCode}" placeholder="请输入系统代码">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label">【公司信息】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>IP&nbsp;&nbsp;地&nbsp;&nbsp;址:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="ipAddress" name="ipAddress"
													required="required" value="${systemType.ipAddress}" placeholder="请输入IP地址">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>公司地址:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="companyAddress" name="companyAddress"
													required="required" value="${systemType.companyAddress}" placeholder="请输入联系地址">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>公司域名:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="companyDomain" name="companyDomain"
													required="required" value="${systemType.companyDomain}" 
													placeholder="请输入公司域名(格式：http://...或https://...)">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label">【联系信息】</label>
										</div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>联&nbsp;系&nbsp;人 :</label>
											<div class="col-sm-8">
												<input
													type="text" class="form-control" id="contacts" name="contacts"
													required="required" value="${systemType.contacts}" placeholder="请输入联系人">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>联系电话:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="phoneNumber" name="phoneNumber"
													required="required" value="${systemType.phoneNumber}" placeholder="请输入联系电话">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>邮箱地址:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="email" name="email" placeholder="请输入邮箱地址"
													required="required" value="${systemType.email}">
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
										<div class="clear" style="margin-left: 100px;"></div>
										<input type="hidden" id="id" name="id" value="${systemType.id}" />
										<input type="hidden" name="token" value="${systemType.token}" />
										<input type="hidden" name="creatorId"
											value="${systemType.creatorId}" /> <input type="hidden"
											name="createDate" value="${systemType.createDate}" />
										
											</div>
										</div>
										
									</form>
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

		$.validator.setDefaults({
			submitHandler : function(form) {
				ajaxSubmitForm();
			}
		});

		$(function() {
			// 在键盘按下并释放及提交后验证提交表单
			$("#editSystemTypeForm").validate({
				invalidHandler : function(form, validator) { //不通过回调
					return false;
				},
				rules : {
					systemName : {
						required : true,
						maxlength : 32,
						remote : {
							url : "systemType/checkSystemNameValid", //后台处理程序
							type : "post", //数据发送方式
							dataType : "json", //接受数据格式   
							data : { //要传递的数据
								systemName : function() {
									return $("#systemName").val();
								},
								id : function() {
									return $("#id").val();
								}
							}
						}
					},
					systemCode : {
						required : true,
						maxlength : 10,
						remote : {
							url : "systemType/checkSystemCodeValid",
							type : "post",
							dataType : "json",
							data : {
								systemCode : function() {
									return $("#systemCode").val();
								},
								id : function() {
									return $("#id").val();
								}
							}
						}
					},
					companyAddress : {
						required : true,
						maxlength : 100
					},
					ipAddress : {
						required : true,
						ip : true,
						maxlength : 20
					},
					companyDomain : {
						required : true,
						maxlength : 100,
						url : true,
						remote : {
							url : "systemType/checkCompanyDomainValid",
							type : "post",
							dataType : "json",
							data : {
								companyDomain : function() {
									return $("#companyDomain").val();
								},
								id : function() {
									return $("#id").val();
								}
							}
						}
					},
					contacts : {
						required : true,
						maxlength : 30
					},
					phoneNumber : {
						required : true,
						maxlength : 20,
						isPhone : true
					/* remote : {
						url : "systemType/checkPhoneNumberValid",
						type : "post",
						dataType : "json",
						data : {
							phoneNumber : function() {
								return $("#phoneNumber").val();
							},
							id : function() {
								return $("#id").val();
							}
						}
					} */
					},
					email : {
						required : true,
						email : true,
						maxlength : 30,
						remote : {
						url : "systemType/checkEmailValid",
						type : "post",
						dataType : "json",
						data : {
							email : function() {
								return $("#email").val();
							},
							id : function() {
								return $("#id").val();
							}
						}
					}
					}
				},
				messages : {
					systemName : {
						required : "请输入接入系统名称！",
						maxlength : "系统名称最大长度是32！",
						remote : "该系统名称已存在！"
					},
					systemCode : {
						required : "请输入接入系统编码！",
						maxlength : "系统编码最大长度为10！",
						remote : "系统编码已存在！"
					},
					ipAddress : {
						required : "请输入IP地址！",
						maxlength : "IP地址最大长度是20！"
					},
					companyAddress : {
						required : "请输入接入公司地址！",
						maxlength : "公司地址最大长度是100！"
					},
					companyDomain : {
						required : "请输入接入平台域名！",
						maxlength : "域名最大长度是100！",
						url : "请输入正确的域名！",
						remote : "该域名已存在！"
					},
					contacts : {
						required : "请输入联系人姓名！",
						maxlength : "联系人姓名最大长度是30！"
					},
					phoneNumber : {
						required : "请输入联系电话!",
						maxlength : "联系电话最大长度是20！"
					//remote : "该电话号码已存在！"
					},
					email : {
						required : "请输入联系邮箱！",
						email : "请输入正确的电子邮箱地址！",
						maxlength : "邮箱最大长度是30！",
						remote : "该邮箱已存在！"
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
						url : "${pageContext.request.contextPath }/editSystemType",
						data : $('#editSystemTypeForm').serialize(),// 你的formid
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
														window.location.href = "${pageContext.request.contextPath }/listSystemType";
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
														window.location.href = "${pageContext.request.contextPath }/listSystemType";
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
						window.location.href = "${pageContext.request.contextPath }/toEditSystemTypePage?id="
								+ $("#id").val();
					});
	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/listSystemType";
					});
</script>

<script type="text/javascript">
	$(function() {
		$("#systemName").change(function() {
			var systemName = $("#systemName").val().replace(/<\/?[^>]*>/g,'');
			$("#systemName").val($.trim(systemName));
		});

		$("#systemCode").change(function() {
			var systemCode = $("#systemCode").val().replace(/<\/?[^>]*>/g,'');
			$("#systemCode").val($.trim(systemCode));
		});

		$("#companyAddress").change(function() {
			var companyAddress = $("#companyAddress").val().replace(/<\/?[^>]*>/g,'');
			$("#companyAddress").val($.trim(companyAddress));
		});

		$("#companyDomain").change(function() {
			var companyDomain = $("#companyDomain").val().replace(/<\/?[^>]*>/g,'');
			$("#companyDomain").val($.trim(companyDomain));
		});

		$("#contacts").change(function() {
			var contacts = $("#contacts").val().replace(/<\/?[^>]*>/g,'');
			$("#contacts").val($.trim(contacts));
		});

		$("#phoneNumber").change(function() {
			var phoneNumber = $("#phoneNumber").val().replace(/<\/?[^>]*>/g,'');
			$("#phoneNumber").val($.trim(phoneNumber));
		});

		$("#email").change(function() {
			var email = $("#email").val().replace(/<\/?[^>]*>/g,'');
			$("#email").val($.trim(email));
		});
		
		$("#ipAddress").change(function() {
			var ipAddress = $("#ipAddress").val().replace(/<\/?[^>]*>/g,'');
			$("#ipAddress").val($.trim(ipAddress));
		});
	});
</script>

</html>