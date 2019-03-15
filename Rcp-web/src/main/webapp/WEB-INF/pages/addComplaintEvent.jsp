<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
	<%@ include file="../commons/sourceFile.jsp"%>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/additional-methods.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/formatDateUtil.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>新增投诉事件</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
									<form class="form-horizontal" id="addComplaintEventForm" method="post" role="form">
										<div class="form-group">
											<label class="col-sm-2 control-label">【联系人信息】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>投诉人:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="name" name="name" required="required" placeholder="请输入投诉人">
											</div>
										</div>
										<div class="hr-line-dashed"></div>					
										
					    				<div class="form-group">
											<label class="col-sm-2 control-label">电&nbsp;&nbsp;&nbsp;话:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="请输入电话">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
					    				<div class="form-group">
											<label class="col-sm-2 control-label">邮&nbsp;&nbsp;&nbsp;箱:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="emailAddress" name="emailAddress" placeholder="请输入邮箱">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label">【商家信息】</label>
										</div>
					    				<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>订&nbsp;&nbsp;单&nbsp;&nbsp;号:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="merchantOrderId" name="merchantOrderId" required="required" placeholder="请输入商家订单号">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
					    				
					    				<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;"></span>商&nbsp;&nbsp;家&nbsp;&nbsp;号:</label>
											<div class="col-sm-8">
												<!-- <input type="text" class="form-control" id="merchantId" name="merchantId" required="required" placeholder="请输入商家号"> -->
												<span id="merchantId" class="form-control"></span>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
					    				
					    				<div class="form-group">
												<label class="col-sm-2 control-label">投诉金额:</label>
												<div class="col-sm-8">	
												<span id="complaintMoney" class="form-control"></span>	
												</div>							
					    				</div>
					    				
					    				<div class="hr-line-dashed"></div>
					    				<div class="form-group">
											<label class="col-sm-2 control-label">投诉内容:</label>
											<div class="col-sm-8">
												<textarea placeholder="请输入投诉内容" class="form-control" id="remark" name="remark" rows="5"></textarea>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
					    				<div class="form-group">
											
											<div class="col-sm-4 col-sm-offset-2">
												<div class="btn-toolbar" role="toolbar">
												<div class="btn-group">
													<input id="submitBtn" type="submit" class="btn btn-primary margin-items-top" value="保 存">
												</div>
												<div class="btn-group">
													<button id="resetBtn" type="reset" class="btn btn-primary margin-items-top">重置</button>
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
					
					<!-- 模态框示例（Modal） -->
						<div class="modal fade" id="complaintModal" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
							data-backdrop="static" data-keyboard="false">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h4 class="modal-title" id="myModalLabel">投诉结果检测</h4>
									</div>
									<div class="modal-body" style="padding: 0px 30px 0px;">
											
												 <table class="table table-bordered float-item-left margin-items-top" style="margin-top: 20px;word-wrap: break-word; word-break: break-all;">
													<thead>
														<tr>
															<th style="width:20%">投诉人</th>
															<th style="width:40%">电话</th>
															<th style="width:40%">邮箱</th>
														</tr>
													</thead>
													<tbody align="center">
														<tr id="complaintResult">
															<!-- <td></td>
															<td></td>
									                        <td></td> -->
														</tr>
													</tbody>
												</table>
					    				
												 <table	class="table table-bordered float-item-left margin-items-top" style="word-wrap: break-word; word-break: break-all;">
													<thead>
														<tr>
															<!-- <th>消费者</th> -->
															<th style="width:25%">设备指纹</th>
															<th style="width:25%">IP</th>
															<th style="width:25%">卡号</th>
															<th style="width:25%">电话号码</th>
															<!-- <th>检测结果</th> -->
														</tr>
													</thead>
													<tbody align="center">
														<tr id="consumerResult">
															<!-- <td></td>
															<td></td>
									                        <td></td>
									                        <td></td>
									                        <td></td> -->
														</tr>
													</tbody>
												</table>
												 <table	class="table table-bordered float-item-left margin-items-top" style="word-wrap: break-word; word-break: break-all;">
													<thead>
														<tr>
															<th style="width:30%">商家ID</th>
															<th style="width:30%">商家域名</th>
															<!-- <th>检测结果</th> -->
														</tr>
													</thead>
													<tbody align="center">
														<tr id="merchantResult">
															<!-- <td></td>
															<td></td> -->
														</tr>
													</tbody>
												</table>
					    				
									</div>
									<div class="modal-footer">
										<button id="closeBtn" type="button" class="btn btn-primary">关闭</button>
										<span id="tip"> </span>
									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal -->
						</div>
					
					<br>
					<br>
					<br>
				</div>
			</div>
		</div>
</body>

<script type="text/javascript">
$("#returnBtn").click(
    function() {
      window.location.href = "${pageContext.request.contextPath}/listComplaint";
    }
);
</script>

<script type="text/javascript">
$(function() {
	$.validator.setDefaults({
		submitHandler : function(form) {
			ajaxSubmitForm();
		}
	});
	// 在键盘按下并释放及提交后验证提交表单
	$("#addComplaintEventForm").validate({
		invalidHandler : function(form, validator) { //不通过回调
			return false;
		},

		rules : {
			name : {
				required : true,
				maxlength : 40
			},
			phoneNumber : {
				isPhone : true
			},
			merchantOrderId : {
				required : true,
				maxlength : 20,
				remote : {
					url : "order/checkOrderId",
					type : "post",
					dataType : "json",
					data : {
						merchantOrderId : function() {
							return $("#merchantOrderId").val();
						}
					}
				}
			},
			/* merchantId : {
				required : true,
				maxlength : 20,
				remote : {
					url : "checkMerchantId",
					type : "post",
					dataType : "json",
					data : {
						merchantOrderId : function() {
							return $("#merchantOrderId").val();
						},
						merchantId : function() {
							return $("#merchantId").val();
						}
					}
				}
			}, */
			emailAddress : {
				email : true,
				maxlength : 100
			},
			remark : {
				maxlength : 500
			}
		},
		messages : {
			name : {
				required : "请输入投诉人！",
				maxlength : "投诉人最大长度是40！"
			},
			merchantOrderId : {
				required : "请输入订单号！",
				maxlength : "商家订单号最大长度是20！",
				remote : "订单号不存在！"
			//regex : "密码只能是数字、字母与下划线"
			},
			/* merchantId : {
				required : "请输入商家号！",
				maxlength : "商家号长度为20！",
				remote : "商家订单号与商家号不匹配！"
			}, */
			emailAddress : {
				email : "请输入正确的电子邮箱地址！",
				maxlength : "邮箱最大长度是100！"
			},
			remark : {
				maxlength : "投诉内容最大长度是500！"
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
	
	function ajaxSubmitForm() {
		$
				.ajax({
					url : "${pageContext.request.contextPath}/addComplaintEvent",
					type : "POST",
					cache : false,
					async : false,
					data : $("#addComplaintEventForm").serialize(),
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
					/* complete : function() {
						//后端响应后放开按钮
						$("#submitBtn").removeAttr("disabled");
					}, */
					success : function(data) {
						if ("success" == data.status) {
							/* layer
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
													window.location.href = "${pageContext.request.contextPath }/listComplaint";
												} 
											}); */
							
							$('#complaintModal').modal('show');
							var complaintMap = data.complaintMap;
							$("#complaintResult").append("<td>" + complaintMap.name 
									+ "</td>" + "<td>" + complaintMap.phoneNumber + "</td>"
									 + "<td>" + complaintMap.email + "</td>");
							
							var consumerMap = data.consumerMap;
							
							$("#consumerResult").append("<td>" + consumerMap.fingerId + "</td>"
								 		+ "<td>" + consumerMap.IPAddress + "</td>"
									 	+ "<td>" + consumerMap.blankCardNo + "</td>"
									 	+ "<td>" + consumerMap.payerTelphone + "</td>");
							
							var merchantMap = data.merchantMap;
							$("#merchantResult").append("<td>" + merchantMap.merchantId 
									+ "</td>" + "<td>" + merchantMap.merchantUrl
									+ "</td>");
							
							//后端响应后放开按钮
							$("#submitBtn").removeAttr("disabled");
							return;
						} else if ("fail" == data.status) {
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
													window.location.href = "${pageContext.request.contextPath }/listComplaint";
												}
											});
							//后端响应后放开按钮
							$("#submitBtn").removeAttr("disabled");
							return;
						} else if ("reComplaint" == data.reComplaint) {
							layer
							.alert(
									'该订单已被投诉！',
									{
										skin : 'layui-layer-molv',
										icon : 5,
										closeBtn : 0,
										btnAlign : 'c', //按钮居中
										anim : 0, //动画类型
										time : 2000/* ,
										end : function() {
											window.location.href = "${pageContext.request.contextPath }/listComplaint";
										} */
									});
					//后端响应后放开按钮
					$("#submitBtn").removeAttr("disabled");
					return;
						} else if ("orderEmpty" == data.status) {
							layer
							.alert(
									'订单不存在！',
									{
										skin : 'layui-layer-molv',
										icon : 5,
										closeBtn : 0,
										btnAlign : 'c', //按钮居中
										anim : 0, //动画类型
										time : 2000/* ,
										end : function() {
											window.location.href = "${pageContext.request.contextPath }/listComplaint";
										} */
									});
					//后端响应后放开按钮
					$("#submitBtn").removeAttr("disabled");
					return;
						}
					}
				});
	}
});
</script>

<script type="text/javascript">
	$(function() {
		$("#name").blur(function() {
			var name = $("#name").val().replace(/<\/?[^>]*>/g,'');
			$("#name").val($.trim(name));
		});
		
		$("#phoneNumber").blur(function() {
			$("#phoneNumber").val($.trim($("#phoneNumber").val()));
		});
		
		$("#merchantId").blur(function() {
			$("#merchantId").val($.trim($("#merchantId").val()));
		});
		
		$("#merchantOrderId").blur(function() {
			$("#merchantOrderId").val($.trim($("#merchantOrderId").val()));
		});
		
		$("#emailAddress").blur(function() {
			$("#emailAddress").val($.trim($("#emailAddress").val()));
		});
		
		$("#remark").blur(function() {
			var remark = $("#remark").val().replace(/<\/?[^>]*>/g,'');
			$("#remark").val($.trim(remark));
		});
	});
</script>

<script type="text/javascript">
	$(function() {
		$("#merchantOrderId").change(function() {
			var merchantOrderId = $("#merchantOrderId").val();
			//var merchantId = $("#merchantId").val();
			$.ajax({
				url : "${pageContext.request.contextPath }/getOrderDataByOrderId",
				type : "post",
				data : {merchantOrderId:merchantOrderId},
				dataType : "json",
				erro : function(request) {
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
                        $("#complaintMoney").text("￥" + formatCurrency(data.tx_money));
                        $("#merchantId").text(data.merchant_id);
                    }
				}
			});
		})
	});
</script>

<script type="text/javascript">
	$(function() {
		$("#closeBtn").click(function() {
			window.location.href = "${pageContext.request.contextPath }/listComplaint";
		});
	});
</script>

</html>