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
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.serializejson.js"></script>	
</head>

<body>
	<div style="margin-left: 50px;">
		<div class="panel admin-panel">
			<div class="body-content">
				<div style="margin-top: 20px">
					<form id="blackForm" class="form-inline" role="form" method="post" >
						<div style="margin-top: 10px; margin-botton: 10px;">
							<strong><span>请填写表单信息</span></strong>
						</div>

						<c:forEach items="${configUtils}" var="configs">
							<div class="input-group" style="width:80%;margin-top:10px;margin-botton:10px;margin-right:20px;">							
							    <span id="sp_${configs.id }" class="input-group-addon">${configs.name }</span>
									<c:choose>
										<c:when test="${configs.id eq 'merchantId'}">
											<input id="${configs.id }" name="${configs.id }" type="text" readonly="readonly"
												class="form-control" placeholder="${configs.tipName }" value="${merchantId }">
										</c:when>
										<c:when test="${configs.id eq 'fingerId'}">
											<input id="${configs.id }" name="${configs.id }" value="${fingerId }" 
												type="text" class="form-control" placeholder="${configs.tipName }" readonly="readonly">
										</c:when>
										<c:when test="${configs.id eq 'remark'}">
											<input id="${configs.id }" name="${configs.id }" value="${remark }" type="text" class="form-control" placeholder="${configs.tipName }">
										</c:when>
										<c:otherwise>
											<input id="${configs.id }" name="${configs.id }" type="text" class="form-control" placeholder="${configs.tipName }">
										</c:otherwise>
									</c:choose>
			    				
			    			</div>
			    						    				
		    				<div id="checkboxdiv" class="form-group">
		    					<input type="checkbox" tag="${configs.id }" onchange="javascript:return DoSelect(this);"/>
		    				</div>
						</c:forEach>
							<div class="input-group" style="width:80%;margin-right:20px; margin-top: 10px; margin-botton: 10px;">
								<span class="input-group-addon">拉黑原因:</span>
								<textarea id="remark" name="remark" class="form-control"
									rows="5" placeholder="请输入拉黑原因">${remark }</textarea>
							</div>

						<div style="margin-top: 20px; margin-botton: 20px;"></div>
						<div class="btn-toolbar" role="toolbar" style="float:right;margin-right:115px;">
							<div class="btn-group">
								<button id="submitBtn" type="submit"
									class="btn btn-primary margin-items-top">保 存</button>
							</div>
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
	
	function DoSelect(obj)
	{
		var control = $("#"+$(obj).attr("tag"));
		if($(control).val()=="")
		{
			var text = $("#sp_"+$(obj).attr("tag")).text() + " 不允许为空";
			layer.alert(text, {
					skin : 'layui-layer-molv',
					icon : 5,
					closeBtn : 0,
					btnAlign : 'c', //按钮居中
					anim : 0, //动画类型
					time : 2000
			});
			$(obj).prop("checked",false);
		}
		//验证。。。
		else
		{
			if($(obj).attr("checked")=="checked")
			{
				$(obj).removeAttr("checked");
			}else
			{
				$(obj).attr("checked","checked");
			}
		}
	}

	$(function() {
		// 在键盘按下并释放及提交后验证提交表单				
		$("#blackForm").validate({
			invalidHandler : function(form, validator) { //不通过回调
				return false;
			},
			rules : {
				
				telphone : {
					isPhone : true
				},
				idCardNo : {
					isIdCardNo : true
				},
				blankCardNo : {
					bankCardNum : true
				},
				IPAddress : {
					ip : true
				}, 
				email : {
					email : true
				}
			},
			messages : {
				merchantId : {
					required : "请输入商家号！",
					remote : "商家号已存在黑名单！"
				},
				telphone : {
					isPhone : "请正确输入电话号码！"
				},
				idCardNo : {
					isIdCardNo : "请正确输入证件号码！"
				},
				blankCardNo : {
					bankCardNum : "请正确输入银行卡号码！"
				},
				email : {
					email : "请正确输入电子邮箱！"
				} ,
				IPAddress : {
					IP : "请正确输入IP地址！"
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
	
	function getFormData(){		
 		var json = '{';
		$("#checkboxdiv > input").each(function(index, val){
			
			if($(val).attr("checked")=="checked")
			{
				var name = $(val).attr("tag");
				var value = $.trim($("#" + name).val());
				json +='\"' + name + '\":\"' + value+'\",';
			}
		});
		if(json.length > 0) {		
			var value = $.trim($("#remark").val());
			json += '\"remark\":\"' + value + '\"}';
		}
	
		return json;
	}

	function ajaxSubmitForm() {
		var data = getFormData();
		
		$.ajax({
			url : "${pageContext.request.contextPath }/addBlackUser",
			cache : false,
			type : "post",
			data : {blackUser:data},// 你的formid
			async : false,
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
				//后端响应后放开按钮
				$("#submitBtn").removeAttr("disabled");
			},
			beforeSend : function() {
				//在表单提交后后端未作出响应时，禁用提交按钮，提高用户体验。
				$("#submitBtn").attr({
					disabled : "disabled"
				});
			},
			complete : function() {
				//后端响应后放开按钮
				$("#submitBtn").removeAttr("disabled");
			},
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
						return;
					} else if (data.status == 'fail') {
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
						return;
					} else if (data.status == 'empty') {
						layer
						.alert(
								'没有选择要保存的数据！',
								{
									skin : 'layui-layer-molv',
									icon : 5,
									closeBtn : 0,
									btnAlign : 'c', //按钮居中
									anim : 0, //动画类型
									time : 2000
								});
						return;
					}  else if ('repeat' == data.status) {
						layer
						.alert(
								'已经存在黑名单！',
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
						return;
					}
				}
			}
		});
		
	}
</script>

<script type="text/javascript">
	/* $("#submitBtn").click(function() {
	 $("#blackForm").submit();
	 }); */

	$("#resetBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/blackListManagement";
					});
	$("#returnBtn")
			.click(
					function() {
						Dialog.close();
					});
</script>

</html>