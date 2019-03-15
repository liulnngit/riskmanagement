<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
		<meta name="renderer" content="webkit">
		<title></title>
		<%@ include file="../commons/sourceFile.jsp" %>
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/additional-methods.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/formatDateUtil.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>修改投诉事件</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
									<form class="form-horizontal" id="editComplaintEventForm" method="post" role="form">
										<div class="form-group">
											<label class="col-sm-2 control-label">【联系人信息】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>投诉人:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="name" name="name" required="required" placeholder="请输入投诉人" value="${complaint.name}">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
					    				
										<div class="form-group">
											<label class="col-sm-2 control-label">电&nbsp;&nbsp;&nbsp;话:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="phoneNumber" name="phoneNumber"  placeholder="请输入电话" value="${complaint.phoneNumber}">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
					    				<div class="form-group">
											<label class="col-sm-2 control-label">邮&nbsp;&nbsp;&nbsp;箱:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="emailAddress" name="emailAddress"  placeholder="请输入邮箱" value="${complaint.emailAddress}">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
					    				<div class="form-group">
											<label class="col-sm-2 control-label">【商家信息】</label>
										</div>
					    				<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>订&nbsp;&nbsp;单&nbsp;&nbsp;号:</label>
											<div class="col-sm-8">
												<%-- <input type="text" class="form-control" id="merchantOrderId" name="merchantOrderId" required="required" 
													placeholder="请输入订单号" value="${complaint.merchantOrderId}" readonly="readonly"> --%>
												<span class="form-control">${complaint.merchantOrderId}</span>	
											</div>
										</div>
										<div class="hr-line-dashed"></div>
					    				
					    				<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">*</span>商&nbsp;&nbsp;家&nbsp;&nbsp;号:</label>
											<div class="col-sm-8">
												<%-- <input type="text" class="form-control" id="merchantId" name="merchantId" required="required" 
													placeholder="请输入商家号" value="${complaint.merchantId}" readonly="readonly"> --%>
												<span class="form-control">${complaint.merchantId}</span>	
											</div>
										</div>
										<div class="hr-line-dashed"></div>
					    				
					    				<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;"></span>投诉金额:</label>
											<div class="col-sm-8">
												<%-- <input type="text" class="form-control" placeholder="请输入投诉金额" readonly="readonly" value="￥${complaint.txMoney }"> --%>
													<input id="txMoneyHidden" type="hidden" value="${complaint.txMoney}">
													<span id="txMoneyText" class="form-control"></span>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
					    				
					    				<div class="form-group">
											<label class="col-sm-2 control-label">投诉内容:</label>
											<div class="col-sm-8">
												<textarea placeholder="请输入投诉内容" class="form-control" id="remark" name="remark" rows="8" cols="10">${complaint.remark}</textarea>	
											</div>
										</div>
										<div class="hr-line-dashed"></div>
					    				
					    				
					    				<div class="form-group">
											
											<div class="col-sm-4 col-sm-offset-2">
												<div class="btn-toolbar" role="toolbar">
												<div class="btn-group">
													<button id="submitBtn" type="submit" class="btn btn-primary margin-items-top">保 存</button>
												</div>
												<div class="btn-group">
													<button id="resetBtn" type="button" class="btn btn-primary margin-items-top">重置</button>
												</div>
												<div class="btn-group">
													<button id="returnBtn" type="button" class="btn btn-primary">返回</button>
												</div>
										</div>
										
										<input type="hidden" name="id" id="id" value="${complaint.id}"/>
				          				<input type="hidden" name="creatorId" value="${complaint.creatorId}"/>
				          				<input type="hidden" name="createDate" value="${complaint.createDate}"/>
				          				<input type="hidden" name="systemId" value="${complaint.systemId}"/>
				          				<input type="hidden" name="txMoney" value="${complaint.txMoney }">
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
	$("#editComplaintEventForm").validate({
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
			/* merchantId : {
				required : true,
				maxlength : 20,
				remote : {
					url : "checkMerchantId",
					type : "post",
					dataType : "json",
					data : {
						merchantId : function() {
							return $("#merchantId").val();
						},
						merchantOrderId : function() {
							return $("#merchantOrderId").val();
						}
					}
				}
			}, */
			/* merchantOrderId : {
				required : true,
				maxlength : 20,
				remote : {
					url : "checkMerchantOrderId",
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
			merchantId : {
				required : "请输入商家号！",
				maxlength : "商家号长度为20！",
				remote : "商家号不存在！"
			},
			merchantOrderId : {
				required : "请输入商家订单号！",
				maxlength : "商家订单号最大长度是20！",
				remote : "商家订单号不存在！"
			//regex : "密码只能是数字、字母与下划线"
			},
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
					url : "${pageContext.request.contextPath}/editComplaintEvent",
					type : "POST",
					cache : false,
					async : false,
					data : $("#editComplaintEventForm").serialize(),
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
													window.location.href = "${pageContext.request.contextPath }/listComplaint";
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
													window.location.href = "${pageContext.request.contextPath }/listComplaint";
												}
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

$("#resetBtn").click(
	    function() {
	      window.location.href = "${pageContext.request.contextPath}/toEditComplaintPage?id=" + $("#id").val();
	    }
	);
$("#returnBtn").click(
    function() {
      window.location.href = "${pageContext.request.contextPath}/listComplaint";
    }
);
</script>

<script type="text/javascript">
	$(function() {
        var txMoney = $("#txMoneyHidden").val();
        if (txMoney != '' && txMoney != 'null' && txMoney != 'undefined') {
            $("#txMoneyText").text('￥' + formatCurrency(txMoney))
        }

		$("#name").change(function() {
			var name = $("#name").val().replace(/<\/?[^>]*>/g,'');
			$("#name").val($.trim(name));
		});
		
		$("#phoneNumber").change(function() {
			$("#phoneNumber").val($.trim($("#phoneNumber").val()));
		});
		
		$("#merchantId").change(function() {
			$("#merchantId").val($.trim($("#merchantId").val()));
		});
		
		$("#merchantOrderId").change(function() {
			$("#merchantOrderId").val($.trim($("#merchantOrderId").val()));
		});
		
		$("#emailAddress").change(function() {
			$("#emailAddress").val($.trim($("#emailAddress").val()));
		});
		
		$("#remark").change(function() {
			var remark = $("#remark").val().replace(/<\/?[^>]*>/g,'');
			$("#remark").val($.trim(remark));
		});
	});
</script>

</html>