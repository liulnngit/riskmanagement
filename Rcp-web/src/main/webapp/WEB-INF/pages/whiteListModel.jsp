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
<script type="text/javascript" src="${pageContext.request.contextPath }/js/additional-methods.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>白名单模型</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
									<form class="form-horizontal" role="form" id="editWhiteListModelForm">
										
										<div class="form-group">
											<label class="col-sm-2 control-label">白名单对象:</label>
											<div class="col-sm-8">
												<label class="checkbox-inline"> <input type="radio"
													name="target" id="optionsRadios3" value="1"
													<c:if test="${whiteModelParam.target=='1'}">checked</c:if>>消费者
												</label> <label class="checkbox-inline"> <input type="radio"
													name="target" id="optionsRadios4" value="2"
													<c:if test="${whiteModelParam.target=='2'}">checked</c:if>>商家
												</label> <label class="checkbox-inline"> <input type="radio"
													name="target" id="optionsRadios5" value="3"
													<c:if test="${whiteModelParam.target=='3'}">checked</c:if>>设备
												</label>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label">【交易指标】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>周期单位:</label>
											<div class="col-sm-8">
												<select
													class="form-control" id="periodUnit" name="periodUnit">
													<option value="D"
														<c:if test="${whiteModelParam.periodUnit=='D'}">selected</c:if>>天</option>
													<option value="H"
														<c:if test="${whiteModelParam.periodUnit=='H'}">selected</c:if>>小时</option>
												</select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>交易周期:</label>
											<div class="col-sm-8">
												<input type="text" id="transacPeriod"
													name="transacPeriod" class="form-control" placeholder="请输入整数"
													value="${whiteModelParam.transacPeriod}">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>交易笔数:</label>
											<div class="col-sm-8">
												<input type="text" id="transacCount"
													name="transacCount" class="form-control" placeholder="请输入整数"
													value="${whiteModelParam.transacCount}">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label">【风险事件】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>中级风险以上次数:</label>
											<div class="col-sm-8">
												<input id="riskCount"
													type="text" name="riskCount" class="form-control"
													placeholder="请输入整数" value="${whiteModelParam.riskCount}">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>低级以下风险比率:</label>
											<div class="col-sm-8">
												<input
													type="text" name="riskRate" class="form-control" id="riskRate"
													placeholder="请输入百分数" value="${whiteModelParam.riskRate}">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											
											<div class="col-sm-4 col-sm-offset-2">
												<div class="btn-toolbar" role="toolbar">
											<div class="btn-group">
												<input id="submitBtn" type="submit"
													class="btn btn-primary margin-items-top" value="保 存" />
											</div>
											<div class="btn-group">
												<button id="resetBtn" type="button" class="btn btn-primary margin-items-top">重
													置</button>
											</div>
											<div class="btn-group">
												<button id="returnBtn" type="button"
													class="btn btn-primary margin-items-top">返 回</button>
											</div>
										</div>
										<input type="hidden" name="id" class="form-control" value="${analyzeModelParameter.id}">
				            <input type="hidden" id="analyzeModelId" name="analyzeModelId" class="form-control" value="${analyzeModel.id}">
				            <input type="hidden" name="systemId" class="form-control" value="${analyzeModelParameter.systemId}">
				            <input type="hidden" name="status" class="form-control" value="${analyzeModelParameter.status}">
				            <input type="hidden" name="creatorId" class="form-control" value="${analyzeModelParameter.creatorId}">
				            <input type="hidden" name="createDate" class="form-control" value="${analyzeModelParameter.createDate}">
				            <input type="hidden" name="menuId" id="menuId" class="form-control" value="${menuId}">
											</div>
										</div>
				
										
										
									</form>
									<div>
										<div style="margin-top: 10px; margin-botton: 10px;">
											<strong><span>说明：</span></strong>
										</div>
										<div style="margin-top: 10px; margin-botton: 10px;">
											<strong><span>${analyzeModel.remark}</span></strong>
										</div>
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
		$("#periodUnit").change(function() {
			$("#transacPeriod").val('');
		});
		$("#transacPeriod").change(function() {
			var periodUnit = $("#periodUnit").val();
			var textInput = $("#transacPeriod").val();
			var tag = true;
			if ('D' == periodUnit) {
				if (textInput > 365) {
					$("#transacPeriod").val('365');
					tag = false;
				} else if (textInput < 1) {
					$("#transacPeriod").val('1');
					tag = false;
				}
				tag = false;
			} else if ('H' == periodUnit) {
				if (textInput > 24) {
					$("#transacPeriod").val('24');
					tag = false;
				} else if (textInput < 1) {
					$("#transacPeriod").val('1');
					tag = false;
				}
				tag = false;
			}
			return tag;
		});
		
		$("#riskRate").change(function() {
			var rate = $("#riskRate").val();
			rate = parseInt(rate);
			if (rate > 100) {
				$("#riskRate").val("100%");
			} else if (rate < 1) {
				$("#riskRate").val("1%");
			}
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
		$("#editWhiteListModelForm").validate({
			invalidHandler : function(form, validator) { //不通过回调
				return false;
			},
			rules : {
				target : {
					required : true
				},
				periodUnit : {
					required : true,
					digits : true
				},
				transacPeriod : {
					required : true,
					digits : true
				},
				transacCount : {
					required : true,
					digits : true
				},
				riskCount : {
					required : true,
					digits : true
				},
				riskRate : {
					required : true,
					validatePercent : true
				}
			},
			messages : {
				target : {
					required : "请选择白名单对象！"
				},
				periodUnit : {
					required : "请选择周期单位！",
					digits : "请输入正整数！"
				},
				transacPeriod : {
					required : "请输入交易周期！",
					digits : "请输入正整数！"
				},
				transacCount : {
					required : "请输入交易笔数！",
					digits : "请输入正整数！"
				},
				riskCount : {
					required : "请输入最高风险次数！",
					digits : "请输入正整数！"
				},
				riskRate : {
					required : "请输入最高风险比率！"
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
					url : "${pageContext.request.contextPath }/updateWhiteListParam",
					data : $('#editWhiteListModelForm').serialize(),// 你的formid
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
													window.location.href = "${pageContext.request.contextPath }/listAnalyzeModel";
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
													window.location.href = "${pageContext.request.contextPath }/listAnalyzeModel";
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
		$("#returnBtn").click(function() {
			var menuId = $("#menuId").val();
      if("191" == menuId){
        window.location.href = "${pageContext.request.contextPath}/listModels"
      } else {
        window.location.href = "${pageContext.request.contextPath }/listAnalyzeModel";
      }
		});
		$("#resetBtn").click(function() {
			window.location.href = "${pageContext.request.contextPath }/showAnalyzeModelParam?id=" + $("#analyzeModelId").val();
		})
	})
</script>

</html>