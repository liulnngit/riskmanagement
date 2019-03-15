<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>新增黑名单</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
									<form id="blackForm" class="form-horizontal" role="form" method="post" >
												
										<c:forEach items="${configUtils}" var="configs">
											<div class="form-group" id="group">
												<label class="col-sm-2 control-label">${configs.name }</label>
												<div class="col-sm-8">
													<input id="${configs.id }" name="${configs.id }" type="text" class="form-control" placeholder="${configs.tipName }">
												</div>
											</div>
											<div class="hr-line-dashed"></div>
										</c:forEach>
										<div class="form-group">
											<label class="col-sm-2 control-label">拉黑原因:</label>
											<div class="col-sm-8">
												<textarea id="remark" name="remark" class="form-control"
													rows="3" placeholder="请输入拉黑原因"></textarea>
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
	$.validator.setDefaults({
		submitHandler : function(form) {
			ajaxSubmitForm();
		}
	});

	$(function() {
		// 在键盘按下并释放及提交后验证提交表单
		$("#blackForm").validate({
			invalidHandler : function(form, validator) { //不通过回调
				return false;
			},
			rules : {
		/*		merchantId : {
					required : true,
					remote : {
						url : "blackLibrary/checkMerchantId",
						type : "post",
						dataType : "json",
						data : {
							merchantId : function() {
								return $("#merchantId").val();
							}
						}
					}
				},
		 */
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
		
        $(":input").each(function(){
        	var value = $.trim($(this).val());//文本框的值
        	if(value != null && value != '') {
        		var name = $(this).attr("id");
        		if (name != 'remark') {
	        		json +='\"' + name + '\":\"' + value+'\",';
        		}
        	}
        });
        
        if(json.length > 1) {
        	var value = $.trim($("#remark").val());
     		json += '\"remark\":\"' + value + '\"';
        }
        json += '\}';
        return json;
    }
	
	function ajaxSubmitForm() {
		var data = getFormData();
		$
				.ajax({
					url : "${pageContext.request.contextPath }/addBlackUser",
					cache : false,
					type : "post",
					data : {blackUser : data},// 你的formid
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
														window.location.href = "${pageContext.request.contextPath }/searchBlackList";
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
														window.location.href = "${pageContext.request.contextPath }/searchBlackList";
													}
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							} else if ('empty' == data.status) {
								layer
								.alert(
										'请输入相关信息！',
										{
											skin : 'layui-layer-molv',
											icon : 5,
											closeBtn : 0,
											btnAlign : 'c', //按钮居中
											anim : 0, //动画类型
											time : 2000,
											end : function() {
												window.location.href = "${pageContext.request.contextPath }/searchBlackList";
											}
										});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							}else if ('repeat' == data.status) {
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
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
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
						window.location.href = "${pageContext.request.contextPath}/searchBlackList";
					});
</script>

</html>