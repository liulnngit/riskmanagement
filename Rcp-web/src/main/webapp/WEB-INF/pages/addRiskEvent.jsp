<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%@ include file="../commons/sourceFile.jsp"%>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>新增风险事件</h5>
                    </div>
				
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
									<form class="form-horizontal" id="addRcEventForm" method="POST" role="form">
				
										<!-- <div style="margin-top: 10px; margin-botton: 10px;">
											<strong><span>类别信息</span></strong>
										</div> -->
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>商&nbsp;&nbsp;家&nbsp;&nbsp;号:</label>
											<div class="col-sm-8">
												<input id="merchantId" name="merchantId" class="form-control" type="text" placeholder="请输入商家号"/>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>订&nbsp;&nbsp;单&nbsp;&nbsp;号:</label>
											<div class="col-sm-8">
												<input id="orderId"
													name="orderId" type="text" class="form-control" placeholder="请输入订单号" />
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label">设备标识:</label>
											<div class="col-sm-8">
												<input id="fingerId"
													name="fingerId" type="text" class="form-control" placeholder="请输入设备标识" />
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>支付类别:</label>
											<div class="col-sm-8">
												<select
													id="payclassId" required="required" class="form-control"
													name="payclassId">
													<option value="">-----请选择-----</option>
												</select>
											</div>
											<input id="payclassName" name="payclassName" type="hidden" />
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则名称:</label>
											<div class="col-sm-8">
												<select
													id="ruleCode" required="required" class="form-control"
													name="ruleCode">
													<option value="">-----请选择-----</option>
												</select>
											</div>
											<input id="payclassName" name="payclassName" type="hidden" />
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>风险级别:</label>
											<div class="col-sm-8">
												<select
													id="riskLevel" class="form-control" required name="riskLevel">
													<option value="">-----请选择-----</option>
												</select>
											</div>
											<input id="payclassName" name="payclassName" type="hidden" />
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label">事件描述:</label>
											<div class="col-sm-8">
												<textarea id="remark" name="remark" style="margin-left: 10px;"
													rows="5" class="form-control" placeholder="请输入风险事件描述"></textarea>
											</div>
											<input id="payclassName" name="payclassName" type="hidden" />
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
												<input type="reset" class="btn btn-primary margin-items-top" value="重置"/>
											</div>
											<div class="btn-group">
												<button id="returnBtn" type="button"
													class="btn btn-primary margin-items-top">返回</button>
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
		$.ajax({
			url : "${pageContext.request.contextPath}/queryListRule",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#ruleCode").append(
								'<option value="' + data[i].ruleCode +'">'
										+ data[i].ruleName + '</option>')
					}
				}
			}
		});

		$.ajax({
			url : "${pageContext.request.contextPath}/queryPayclassList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#payclassId").append(
								'<option value="' + data[i].id +'">' + data[i].name
										+ '</option>')
					}
					
					$("#payclassId").change(function() {
						var selecteText = $('#payclassId').find('option:selected').text();
						$("#payclassName").val(selecteText);
					});
				}
			}
		});

		$.ajax({
			url : "${pageContext.request.contextPath}/queryRiskLevelList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#riskLevel").append(
								'<option value="' + data[i].id +'">'
										+ data[i].title + '</option>')
					}
				}
			}
		});
		
		$("#returnBtn").click(function() {
			window.location.href = "${pageContext.request.contextPath}/listRiskEvent";
		});
	});
</script>

<script type="text/javascript">
	$.validator.setDefaults({
		submitHandler : function(form) {
			ajaxSubmitForm();
		}
	});

	$(function() {
		// 在键盘按下并释放及提交后验证提交表单
		$("#addRcEventForm").validate({
			invalidHandler : function(form, validator) { //不通过回调
				return false;
			},
			rules : {
				merchantId : {
					required : true,
					maxlength : 20,
					remote : {
						url : "checkMerchantId",
						type : "post",
						dataType : "json",
						data : {
							merchantId : function() {
								return $("#merchantId").val();
							}
						}
					}
				},
				orderId : {
					required : true,
					maxlength : 64,
					remote : {
						url : "checkMerchantIdAndOrderId",
						type : "post",
						dataType : "json",
						data : {
							orderId : function() {
								return $("#orderId").val();
							},
							merchantId : function() {
								return $("#merchantId").val();
							}
						}
					}
				},
				payclassId : {
					required : true
				},
				ruleCode : {
					required : true
				},
				riskLevel : {
					required : true
				}/* ,
				remark : {
					required : true
				} */
			},
			messages : {
				merchantId : {
					required : "请输入商家号！",
					maxlength : "商家号最大长度为20！",
					remote : "商家号不存在！"
				},
				orderId : {
					required : "请输入商家订单号！",
					maxlength : "商家订单号最大长度为64！",
					remote : "商家订单号与商家号不匹配！"
				},
				payclassId : {
					required : "请选择支付类型！"
				},
				ruleCode : {
					required : "请选择规则名称！"
				},
				riskLevel : {
					required : "请选择风险级别！"
				}/* ,
				remark : {
					required : "请输入风险事件描述！"
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
					url : "${pageContext.request.contextPath }/addRiskEvent",
					data : $('#addRcEventForm').serialize(),// 你的formid
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
													window.location.href = "${pageContext.request.contextPath }/listRiskEvent";
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
													window.location.href = "${pageContext.request.contextPath }/listRiskEvent";
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

<script type="text/javascript">
	$(function() {
		$("#merchantId").change(function() {
			$("#merchantId").val($.trim($("#merchantId").val()));
		});
		
		$("#orderId").change(function() {
			$("#orderId").val($.trim($("#orderId").val()));
		});
		
		$("#fingerId").change(function() {
			var fingerId = $("#fingerId").val().replace(/<\/?[^>]*>/g,'');
			$("#fingerId").val($.trim(fingerId));
		});
		
		$("#remark").change(function() {
			var remark = $("#remark").val().replace(/<\/?[^>]*>/g,'');
			$("#remark").val($.trim(remark));
		});
	});
</script>

</html>