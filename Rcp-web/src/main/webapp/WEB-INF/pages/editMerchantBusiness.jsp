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
                        <h5>新增商家行业关联</h5>
                    </div>
				
					<div class="ibox-content">	
						<div class="panel admin-panel">
							<div class="body-content">
								
									<form class="form-horizontal" id="editMerchantBusinessForm" method="POST"
										role="form">
										<input id="id" name="id" value="${merchantBusiness.id}" type="hidden">
										<input id="creatorId" name="creatorId" value="${merchantBusiness.creatorId}" type="hidden">
										<input id="createDate" name="createDate" value="${merchantBusiness.createDate}" type="hidden">
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>商家号：</label>
											<div class="col-sm-8">
												<input class="form-control" id="merchantId" name="merchantId" type="text" 
													readonly="readonly" value="${merchantBusiness.merchantId}" style="border:none">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>商家名：</label>
											<div class="col-sm-8">
												<input class="form-control" id="merchantName" name="merchantName" type="text" 
													readonly="readonly" value="${merchantName}"  style="border:none">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>行&nbsp;&nbsp;&nbsp;&nbsp;业：</label>
											<div class="col-sm-8">
												<select id="businessId" name="businessId" class="form-control">
													<option value="">-----请选择-----</option>
												</select>
												<input id="businessIdHidden" value="${merchantBusiness.businessId}" type="hidden">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
				
										<%-- <div style="width: 60%; margin-top: 10px; margin-botton: 10px;">
											<div class="input-group">
												<span class="input-group-addon">状&nbsp;&nbsp;&nbsp;&nbsp;态:</span> <select name="status" id="status"
													class="form-control" required="required">
													<option value="">-----请选择-----</option>
													<option value="A" <c:if test="${'A' eq merchantBusiness.status}">selected</c:if>>启用</option>
													<option value="I" <c:if test="${'I' eq merchantBusiness.status}">selected</c:if>>禁用</option>
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
										<input id="status" name="status" value="${merchantBusiness.status}" type="hidden">
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

		// 在键盘按下并释放及提交后验证提交表单
		$("#editMerchantBusinessForm").validate({
			invalidHandler : function(form, validator) { //不通过回调
				return false;
			},

			rules : {
				businessId : {
					required : true
				},
				status : {
					required : true
				}
			},
			messages : {
				content : {
					required : "请选择行业！"
				},
				status : {
					required : "请选择状态！"
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

		function ajaxSubmitForm() {
			$
					.ajax({
						cache : false,
						type : "POST",
						url : "${pageContext.request.contextPath }/editMerchantBusiness",
						data : $('#editMerchantBusinessForm').serialize(),// 你的formid
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
														window.location.href = "${pageContext.request.contextPath }/listMerchantBusiness";
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
														window.location.href = "${pageContext.request.contextPath }/listMerchantBusiness";
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

	$("#returnBtn").click(function() {
		window.location.href = "${pageContext.request.contextPath}/listMerchantBusiness";
	});
</script>

<script type="text/javascript">
	$(function() {
		/*$.ajax({
			url : "${pageContext.request.contextPath}/queryMerchantNotSetBusiness",
			type : "get",
			dataType : "json",
			error : function(request) {
				layer.alert('网络异常！', {
					skin : 'layui-layer-molv',
					icon : 5,
					closeBtn : 0,
					btnAlign : 'c', //按钮居中
					anim : 0, //动画类型
					time : 2000
				});
			},
			success : function(data) {
				if (data) {
					for (var i = 0; i < data.length; i++) {
						var id = data[i].id;
						var name = data[i].merchantName;
						$("#merchantId").append('<option value="' + id + '">' + name + '</option>');
					}
				}
			}
		}); */
		
		$.ajax({
			url : "${pageContext.request.contextPath}/queryBusinessTypes",
			type : "get",
			dataType : "json",
			error : function(request) {
				layer.alert('网络异常！', {
					skin : 'layui-layer-molv',
					icon : 5,
					closeBtn : 0,
					btnAlign : 'c', //按钮居中
					anim : 0, //动画类型
					time : 2000
				});
			},
			success : function(data) {
				if (data.length > 0) {
					var selectOption = $("#businessIdHidden").val();
					for (var i = 0; i < data.length; i++) {
						var id = data[i].id;
						var title = data[i].title;
						if (selectOption == id) {
							$("#businessId").append('<option value="' + id + '" selected>' + title + '</option>');
						} else {
							$("#businessId").append('<option value="' + id + '">' + title + '</option>');
						}
					}
				}
			}
		});
	});
</script>

<script type="text/javascript">
	$(function() {
		$("#resetBtn").click(function() {
			var id = $("#id").val();
			var merchantName = $("#merchantName").val();
			window.location.href = "${pageContext.request.contextPath }/showMerchantBusiness?id=" + id;
		});
	});
</script>

</html>