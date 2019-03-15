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
<!--IE8只能支持jQuery1.9-->
<!--[if lte IE 8]>
<script src="${pageContext.request.contextPath  }/js/jquery.1.9.0.js"></script>
<![endif]-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/bootstrap.css">
	<link href="${pageContext.request.contextPath }/css/style.min862f.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/js/jquery.js"></script>
<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/js/jquery.validate.js"></script>
<script src="${pageContext.request.contextPath }/js/messages_zh.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/layer.js"></script>
<script src="${pageContext.request.contextPath }/js/zDrag.js"></script>
<script src="${pageContext.request.contextPath }/js/zDialog.js"></script>
</head>

<body>

	<div style="margin-left: 50px;">
		<div class="panel admin-panel">
			<div class="body-content">
				<div style="margin-top: 20px">
					<form class="form-inline" id="addAttentionForm" method="post">

						<div style="margin-top: 10px; margin-botton: 10px;">
							<strong><span>商户信息</span></strong>
						</div>

						<div style="margin-right:50px; margin-top: 10px; margin-botton: 10px;">
							<div class="input-group">
								<span class="input-group-addon"><span style="color:red;font-size:18px;">* </span>商&nbsp;&nbsp;家&nbsp;&nbsp;号:</span> <input type="text"
									class="form-control" id="merchantId" name="merchantId"
									required="required" value="${merchantId }" readonly="readonly">
							</div>
						</div>
						<div style="margin-right:50px; margin-top: 10px; margin-botton: 10px;">
							<div class="input-group">
								<span class="input-group-addon">商家地址:</span> <input type="text"
									class="form-control" id="address" name="address"
									placeholder="请输入商家地址">
							</div>
						</div>
						
						<div style="margin-right:50px; margin-top: 10px; margin-botton: 10px;">
							<div class="input-group">
								<span class="input-group-addon">商家域名:</span> 
								<input type="text"
									class="form-control" id="merchantUrl" name="merchantUrl" placeholder="请输入域名">
							</div>
						</div>

						<!-- <div style="margin-top: 10px; margin-botton: 10px;">
							<strong><span>关注周期</span></strong>
						</div>
						<div style="width: 60%; margin-top: 10px; margin-botton: 10px;">
							<div class="input-group">
								<span class="input-group-addon">关注开始时间:</span>
								<input type="text" id="startDate" name="startDate"
									readonly class="form_datetime form-control">
							</div>
						</div>

						<div style="width: 60%; margin-top: 10px; margin-botton: 10px;">
							<div class="input-group">
								<span class="input-group-addon">关注结束时间:</span> 
								<input type="text" id="endDate" name="endDate" readonly
									class="form_datetime form-control">
							</div>
						</div> -->

						<div style="margin-top: 10px; margin-botton: 10px;">
							<strong><span>其它信息</span></strong>
						</div>
						<div style="margin-right:50px; margin-top: 10px; margin-botton: 10px;">
							<div class="input-group">
								<span class="input-group-addon"><span style="color:red;font-size:18px;">* </span>关注级别:</span> <select
									id="attentionLevel" name="attentionLevel" class="form-control"
									required="required">
									<option value="">-----请选择-----</option>
									<option value="0">高</option>
									<option value="1">中</option>
									<option value="2">低</option>
								</select>
							</div>
						</div>
						<div style="margin-right:50px; margin-top: 10px; margin-botton: 10px;">
							<div class="input-group">
								<span class="input-group-addon"><span style="color:red;font-size:18px;">* </span>状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态:</span> <select id="status"
									name="status" class="form-control" required="required">
									<option value="">-----请选择-----</option>
									<option value="0">未审批</option>
									<option value="1">已审批</option>
								</select>
							</div>
						</div>

						<div style="margin-right:50px; margin-top: 10px; margin-botton: 10px;">
							<div class="input-group">
								<span class="input-group-addon"><span style="color:red;font-size:18px;">* </span>是否报警:</span> <select id="alarm"
									name="alarm" class="form-control" required="required">
									<option value="">-----请选择-----</option>
									<option value="0">否</option>
									<option value="1">是</option>
								</select>
							</div>
						</div>

						<div style="margin-right:50px; margin-top: 10px; margin-botton: 10px;">
							<div class="input-group">
								<span class="input-group-addon"><span style="color:red;font-size:18px;">* </span>关注原因:</span>
								<textarea id="attentionMsg" required="required" class="form-control"
									name="attentionMsg" style="margin-left: 10px;" rows="5">${remark }</textarea>	
							</div>
						</div>

						<div style="margin-top: 20px; margin-botton: 20px;"></div>
						<div class="btn-toolbar" role="toolbar" style="float:right;margin-right:50px;">
							<div class="btn-group">
								<button id="submitBtn" type="submit" class="btn btn-primary">保存</button>
							</div>
							<!-- <div class="btn-group">
								<button id="resetBtn" type="button"
									class="btn btn-primary margin-items-top">重置</button>
							</div> -->
							<div class="btn-group">
								<button id="returnBtn" type="button" class="btn btn-primary">返回</button>
							</div>
						</div>
					</form>

				</div>


			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	$.validator.setDefaults({
		submitHandler : function(form) {
			ajaxSubmitForm();
		}
	});

	$(function() {
		// 在键盘按下并释放及提交后验证提交表单
		$("#addAttentionForm").validate({
			invalidHandler : function(form, validator) { //不通过回调
				return false;
			},
			rules : {
				merchantId : {
					required : true
				},
				/* address : {
					required : false
				}, */
				/* startDate : {
					required : true
				},
				endDate : {
					required : true
				}, */
				merchantUrl : {
					required : false,
					maxlength : 255
					/* url : true */
				},
				attentionLevel : {
					required : true
				},
				status : {
					required : true
				},
				alarm : {
					required : true
				}/* ,
				attentionMsg : {
					required : true
				} */
			},
			messages : {
				merchantId : {
					required : "请输入商家号！"
				},
				/* address : {
					required : "请输入商家地址！"
				}, */
				/* startDate : {
					required : "请选择关注开始日期！"
				},
				endDate : {
					required : "请选择关注结束日期！"
				}, */
				merchantUrl : {
					required : false,
					maxlength : "域名最大长度为255！"
					/* url : "请输入正确的域名！(格式:http://...或https://...)" */
				}, 
				attentionLevel : {
					required : "请选择关注级别！"
				},
				status : {
					required : "请选择关注状态！"
				},
				alarm : {
					required : "请选择是否报警！"
				}/* ,
				attentionMsg : {
					required : "请输入关注原因！"
				} */
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
					url : "${pageContext.request.contextPath }/insertAttention",
					data : $('#addAttentionForm').serialize(),// 你的formid
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
						if (data) {
							if (data.status == 'success') {
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
												Dialog.close();
											}
										});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							} else if ('fail' == data.status) {
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
												Dialog.close();
											}
										});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							} else if ('repeat' == data.status) {
								layer
								.alert(
										'该商家已被关注！',
										{
											skin : 'layui-layer-molv',
											icon : 5,
											closeBtn : 0,
											btnAlign : 'c', //按钮居中
											anim : 0, //动画类型
											time : 2000,
											end : function() {
												Dialog.close();
											}
										});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							}
						}
					}
				});
	}
</script>

<script>
	$("#resetBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/addAttention";
					});
	$("#returnBtn")
			.click(
					function() {
						Dialog.close();
					});
</script>

<script type="text/javascript">
	$(function() {
		$("#merchantId").change(function() {
			$("#merchantId").val($.trim($("#merchantId").val()));
		});
		
		$("#address").change(function() {
			$("#address").val($.trim($("#address").val()));
		});
		
		$("#attentionMsg").change(function() {
			$("#attentionMsg").val($.trim($("#attentionMsg").val()));
		});
	});
</script>

</html>