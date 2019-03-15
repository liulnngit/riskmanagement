<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/base64.js"></script>--%>
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
                        <h5>用户中心</h5>
                    </div>
                    <div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
									<form class="form-horizontal" id="editAccountForm" method="POST"
										role="form">
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>登录名称:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="loginName" name="loginName"
													value="${user.loginName }" required="required"
													readonly="readonly" placeholder="请输入登录名称">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label">原始密码:</label>
											<div class="col-sm-8">
												<input
													type="password" class="form-control" id="originalPwd"
													onpaste="return false" onselectstart="return false"
													name="originalPwd" placeholder="请输入原始密码">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label">登录密码:</label>
											<div class="col-sm-8">
												<input
													type="password" class="form-control" id="loginPwd"
													onpaste="return false" onselectstart="return false"
													name="loginPwd" placeholder="请输入登录密码">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label">确认密码:</label>
											<div class="col-sm-8">
												<input
													type="password" class="form-control" id="reLoginPwd"
													onpaste="return false" onselectstart="return false"
													name="reLoginPwd" placeholder="请输入确认密码">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>邮箱地址:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="emailAddress"
													value="${user.emailAddress }" name="emailAddress"
													required="required" placeholder="请输入邮箱地址">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										
				
										<%-- <div style="margin-top: 10px; margin-botton: 10px;">
											<strong><span>角色信息</span></strong>
										</div>
										<div style="width: 60%; margin-top: 10px; margin-botton: 10px;">
											<div>
												<span>选择角色:</span>
											</div>
											<div>
												<select id="roleSelector" required="required" title="至少选择一个角色"
													name="roleIds" multiple="multiple" size="10">
													<option value="">-----请选择-----</option>
													<c:forEach items="${roleList}" var="role" varStatus="status">
														<c:set var="selected" value="0" />
														<c:forEach items="${selectedRoleList}" var="selectedRole"
															varStatus="status">
															<c:if test="${selectedRole.id == role.id}">
																<c:set var="selected" value="1" />
															</c:if>
														</c:forEach>
														<c:choose>
															<c:when test="${selected != 1}">
																<option value="${role.id}">${role.roleName}</option>
															</c:when>
															<c:otherwise>
																<option value="${role.id}" selected="selected">${role.roleName}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>
											</div>
										</div> --%>
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
												<input id="id" name="id" type="hidden" value="${account.id}"> <input
													name="accountType" type="hidden" value="${account.accountType}">
												<input name="creatorId" type="hidden" value="${account.creatorId}">
												<input name="createDate" type="hidden"
													value="${account.createDate}">
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
			$("#editAccountForm").validate({
				invalidHandler : function(form, validator) { //不通过回调
					return false;
				},

				rules : {
					loginName : {
						required : true,
						maxlength : 40,
						remote : {
							url : "account/checkLoginNameValid",
							type : "post",
							dataType : "json",
							data : {
								loginName : function() {
									return $("#loginName").val();
								},
								id : function() {
									return $("#id").val()
								}
							}
						}
					},
					originalPwd : {
						remote : {
							url : "account/checkOriginalPwd",
							type : "post",
							dataType : "json",
							data : {
								originalPwd : function() {
									return getData($("#originalPwd").val());
								},
								id : function() {
									return $("#id").val()
								}
							}
						}
					},
					loginPwd : {
						//required : true,
						rangelength : [ 5, 15 ],
						remote : {
							url : "account/checkOldPwd",
							type : "post",
							dataType : "json",
							data : {
								loginPwd : function() {
									return getData($("#loginPwd").val());
								},
								id : function() {
									return $("#id").val()
								}
							}
						}
					},
					reLoginPwd : { //密码2的描述多于1项使用对象类型 
						//required : true, //必填，这里可以是一个匿名方法 
						equalTo : "#loginPwd", //必须与密码1相等 
						rangelength : [ 5, 15 ]
					//长度5-10之间 
					//regex : "^\\w+$" //使用自定义的验证规则 
					},
					emailAddress : {
						required : true,
						email : true,
						maxlength : 30,
						remote : {
							url : "account/checkEmailAddressValid",
							type : "post",
							dataType : "json",
							data : {
								emailAddress : function() {
									return $("#emailAddress").val();
								},
								id : function() {
									return $("#id").val()
								}
							}
						}
					}
				},
				messages : {
					loginName : {
						required : "用户名不能为空！",
						maxlength : "用户名最大长度是40！",
						remote : "该用户已存在！"
					},
					loginPwd : {
						//required : "密码不能为空！",
						rangelength : "密码长度为5~15位！",
						remote : "新密码不能与旧密码相同！"
					},
					reLoginPwd : {
						//required : "确认密码不能为空！",
						equalTo : "两次密码输入不一致！",
						rangelength : "密码长度为5~15位！"
					//regex : "密码只能是数字、字母与下划线"
					},
					emailAddress : {
						required : "邮箱不能为空！",
						email : "请输入正确的电子邮箱地址！",
						maxlength : "邮箱最大长度是30！",
						remote : "邮箱已存在！"
					},
					originalPwd : {
						remote : "请输入正确的密码！"
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
		
		function getData(str) {
		    return btoa(encodeURIComponent(str).replace(/%([0-9A-F]{2})/g, function(match, p1) {
		        return String.fromCharCode('0x' + p1);
		    }));
		}

		function ajaxSubmitForm() {
			$("#loginPwd").val(getData($("#loginPwd").val()));
			$
					.ajax({
						url : "${pageContext.request.contextPath}/editAccountCenter",
						type : "POST",
						cache : false,
						async : false,
						data : $("#editAccountForm").serialize(),
						erro : function(request) {
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
														window.location.href = "${pageContext.request.contextPath }/main";
													}
												},
												function() {
													window.location.href = "${pageContext.request.contextPath }/main";
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
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
														window.location.href = "${pageContext.request.contextPath }/main";
													}
												},
												function() {
													window.location.href = "${pageContext.request.contextPath }/main";
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
							}
						}
					});
		}
	});

	$("#resetBtn").click(function(){
		window.location.href = "${pageContext.request.contextPath }/toAccountCenterPage?id=" + $("#id").val();
	});
	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/main";
					});
</script>

<script type="text/javascript">
	$(function() {
		$("#inputLoginName").change(function() {
			$("#inputLoginName").val($.trim($("#inputLoginName").val()));
		});
		
		$("#loginPwd").change(function() {
			$("#loginPwd").val($.trim($("#loginPwd").val()));
		});
		
		$("#emailAddress").change(function() {
			$("#emailAddress").val($.trim($("#emailAddress").val()));
		});
	});
</script>

</html>