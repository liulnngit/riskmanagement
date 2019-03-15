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
	src="${pageContext.request.contextPath}/js/base64.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap-multiselect.js"></script>
<style>
.col-sm-8>.btn-group {
	width: 100%;
}

.btn-group>.multiselect {
	display: none;
}

.dropdown-menu {
	display: block;
	position: inherit;
	width: 100%;
	height: 323px;
	overflow: auto;
}

input[type=checkbox], input[type=radio] {
	display: none;
}

.dropdown-menu>li>a {
	padding: 0;
}

.form-horizontal .checkbox {
	padding-top: 3px;
}
/* .dropdown-menu > .active > a, .dropdown-menu > .active > a:focus, .dropdown-menu > .active > a:hover{background-color:#666;} */
</style>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>编辑系统参数</h5>
					</div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
								<form class="form-horizontal" id="editSysParameterForm"
									method="POST" role="form">
									<div class="form-group">
										<label class="col-sm-2 control-label">参数名称:</label>
										<div class="col-sm-8">
											<input type="text" class="form-control" id="parameterName"
												name="parameterName" value="${sysParameter.parameterName }"
												readonly="readonly">
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><span
											style="color: red; font-size: 18px;">* </span>参&nbsp;&nbsp;数&nbsp;&nbsp;值:</label>
										<div class="col-sm-8" id="parameterDiv">
											<%-- <input type="text"
													class="form-control" id="parameterValue" name="parameterValue" required="required"
													placeholder="请输入参数值" value="${sysParameter.parameterValue }"> --%>
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label">参数描述:</label>
										<div class="col-sm-8">
											<textarea rows="3" cols="" disabled="disabled"
												class="form-control">${sysParameter.description}</textarea>
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div class="form-group">

										<div class="col-sm-4 col-sm-offset-2">
											<div class="btn-toolbar" role="toolbar">
												<div class="btn-group">
													<button id="submitBtn" type="button"
														class="btn btn-primary margin-items-top">保 存</button>
												</div>
												<div class="btn-group">
													<button id="resetBtn" type="button"
														class="btn btn-primary margin-items-top">重置</button>
												</div>
												<div class="btn-group">
													<button id="returnBtn" type="button"
														class="btn btn-primary">返回</button>
												</div>
											</div>
											<input type="hidden" id="id" name="id"
												value="${sysParameter.id }"> <input type="hidden"
												id="systemId" name="systemId"
												value="${sysParameter.systemId }"> <input
												type="hidden" id="parameterCode" name="parameterCode"
												value="${sysParameter.parameterCode }"> <input
												type="hidden" id="parameterType" name="parameterType"
												value="${sysParameter.parameterType }"> <input
												type="hidden" id="parameterDefaultValue"
												name="parameterDefaultValue"
												value="${sysParameter.parameterDefaultValue }"> <input
												type="hidden" id="description" name="description"
												value="${sysParameter.description }"> <input
												type="hidden" name="status" value="${sysParameter.status }">
											<input type="hidden" name="creatorId"
												value="${sysParameter.creatorId }"> <input
												type="hidden" name="createDate"
												value="${sysParameter.createDate }">
										</div>
									</div>


								</form>
								<input type="hidden" id="valueHidden"
									value="${sysParameter.parameterValue}">
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
				//ajaxSubmitForm();
			}
		});

		$(function() {
			// 在键盘按下并释放及提交后验证提交表单
			$("#editSysParameterForm").validate({
				invalidHandler : function(form, validator) { //不通过回调
					return false;
				},
				rules : {
					parameterValue : {
						required : true,
						maxlength : 2000,
					}
				},
				messages : {
					parameterValue : {
						required : "请输入参数值！",
						maxlength : "参数值最大长度为2000！"
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

	})

	$("#resetBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/toEditSysParameterPage?id="
								+ $("#id").val();
					});
	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/listSysParameter";
					});
</script>

<script type="text/javascript">
	$(function() {
		$("#parameterName").change(
				function() {
					var parameterName = $("#parameterName").val().replace(
							/<\/?[^>]*>/g, '');
					$("#parameterName").val($.trim(parameterName));
				});

		$("#parameterValue").change(
				function() {
					var parameterValue = $("#parameterValue").val().replace(
							/<\/?[^>]*>/g, '');
					$("#parameterValue").val($.trim(parameterValue));
				});
	});
</script>

<script type="text/javascript">
	$(function() {
		var parameterCode = $("#parameterCode").val();
		if (parameterCode == 'rcp.risk.event.workflow.level') {
			$
					.ajax({
						url : "queryRiskLevelList",
						type : "GET",
						contentType : "application/json",
						dataType : "json",
						success : function(data) {
							if (data.length > 0) {
								var select = '<select id="riskLiveValue" class="form-control"  name="parameterValue" required="required">'
								for (var i = 0; i < data.length; i++) {
									if ($("#valueHidden").val() == data[i].title) {
										select += '<option value="' + data[i].title +'" selected="selected">'
										+ data[i].title + '</option>';
									} else {
										select += '<option value="' + data[i].title +'">'
											+ data[i].title + '</option>';
									}
								}
								select += '</select>';
								$("#parameterDiv").append(select);
								$("#submitBtn").click(function() {
									ajaxSubmitForm();
								});
							}

						}
					});
		} else if (parameterCode == 'rcp.risk.event.payclass.name') {
			$
					.ajax({
						url : "${pageContext.request.contextPath}/queryPayclassList",
						type : "GET",
						contentType : "application/json",
						dataType : "json",
						success : function(data) {
							if (data.length > 0) {
								var value = $("#valueHidden").val();
								var arr = value.split(",");
								var payclassSelect = '<select	id="parameterValue1" class="form-control" title="请至少选择一个支付类型！" required name="parameterValue" multiple="multiple" size="10">';
								for (var i = 0; i < data.length; i++) {
									if ('default' != data[i].code) {
										var flag = false;
										if (arr.length > 0) {
											for (var j = 0; j < arr.length; j++) {
												if (arr[j] == data[i].name) {
													payclassSelect += '<option value="' + data[i].name +'" selected="selected">'
														+ data[i].name + '</option>';
														flag = true;
														break;
												}
											}
										}
										if(!flag){
											payclassSelect += '<option value="' + data[i].name +'">'
													+ data[i].name + '</option>';
										}
									}
								}
								payclassSelect += '</select>';
								$("#parameterDiv").append(payclassSelect);
								$('#parameterValue1').multiselect();
								$("#submitBtn").click(function() {
									ajaxSubmitForm();
								});
							}

						}
					});
		} else if (parameterCode == 'rcp.risk.event.email.receiver') {
			var input = '<input type="text" class="form-control" id="emailValue" name="parameterValue" required="required" placeholder="请输入参数值" value="'
					+ $("#valueHidden").val() + '">';
			$("#parameterDiv").append(input);
			$("#submitBtn").click(function() {
				var emailValue = $("#emailValue").val();
				$("#emailValue").val(removeAllSpace(emailValue));
				if (checkEmail(emailValue)) {
					ajaxSubmitForm();
				}
			});
		} else {
			var input = '<input type="text" class="form-control" id="parameterValue" name="parameterValue" required="required" placeholder="请输入参数值" value="'
					+ $("#valueHidden").val() + '">';
			$("#parameterDiv").append(input);
			$("#submitBtn").click(function() {
				ajaxSubmitForm();
			});
		}
	});
</script>

<script type="text/javascript">
	function isEmail(str) {
		var reg = /^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/g;
		return reg.test(str);
	}

	function checkEmail(email) {
		//验正邮箱格式要正确 20080602_heyitang
		//如果，用户入了邮箱才需要进行判断
		if (email.endsWith(";")) {
			email = email.substring(0, email.lastIndexOf(";"));
		}
		console.log(email);
		if (email != null) {
			if (email.indexOf(";") == -1) {
				if (!isEmail(email)) {
					layer.tips('请输入正确的邮箱！', '#emailValue');
					$("#emailValue").focus();
					return false;
				}
			} else {
				var emailArray = email.split(";");
				for (var i = 0; i < emailArray.length; i++) {
					//这里防止出现heyitang@qq.com;heyitang@163.com;;多加了;这时候，数组中可能有元素没有内容
					console.log(isEmail(emailArray[i]));
					debugger;
						if (!isEmail(emailArray[i])) {
							layer.tips('请输入正确的邮箱！', '#emailValue');
							$("#emailValue").focus();
							return false;
						}
				}
			}
			return true;
		}
	}
	
	//去掉字符串中所有空格
	function removeAllSpace(str) {
		return str.replace(/\s+/g, "");
	}

	function ajaxSubmitForm() {
		$
				.ajax({
					cache : false,
					type : "POST",
					url : "${pageContext.request.contextPath }/editSysParameter",
					data : $('#editSysParameterForm').serialize(),// 你的formid
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
													window.location.href = "${pageContext.request.contextPath }/listSysParameter";
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
													window.location.href = "${pageContext.request.contextPath }/listSysParameter";
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

</html>