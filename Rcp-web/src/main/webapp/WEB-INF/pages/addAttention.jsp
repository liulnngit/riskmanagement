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
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.css">
<link href="${pageContext.request.contextPath }/css/font-awesome.min93e3.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/style.min862f.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/js/jquery.js"></script>
<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/js/jquery.validate.js"></script>
<script src="${pageContext.request.contextPath }/js/messages_zh.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/lang/zh-cn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/calendar.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>新增关注名单</h5>
                    </div>
					
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
								
									<form class="form-horizontal" id="addAttentionForm" method="post">
										<div class="form-group">
											<label class="col-sm-2 control-label">【商户信息】</label>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>商&nbsp;&nbsp;家&nbsp;&nbsp;号:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="merchantId" name="merchantId" required="required" placeholder="请输入商家号">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label">商家地址:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="address" name="address" required="required" placeholder="请输入商家地址">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label">商家域名:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="merchantUrl" name="merchantUrl" placeholder="请输入域名">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
				
										<!-- <div style="margin-top: 10px; margin-botton: 10px;">
											<strong><span>关注周期</span></strong>
										</div>
										<div style="width: 30%; margin-top: 10px; margin-botton: 10px;">
											<div class="input-group">
												<span class="input-group-addon">关注开始时间:</span> 
												<input onFocus="var endDate=$dp.$('endDate');WdatePicker({onpicked:function(){endDate.focus();},dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endDate\')||\'%y-%M-%d-%H:%m:%s\'}',minDate:'#F{$dp.$D(\'endDate\',{M:-6})}'})"
													type="text" id="startDate" name="startDate" style="height: 34px;border: 1px solid #cccccc;"
													class="Wdate form-control">
											</div>
										</div>
				
										<div style="width: 30%; margin-top: 10px; margin-botton: 10px;">
											<div class="input-group">
												<span class="input-group-addon">关注结束时间:</span> 
												<input onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'#F{$dp.$D(\'startTime\',{M:6})}'})"
													type="text" id="endDate" name="endDate"
													class="form_datetime form-control"  style="height: 34px;border: 1px solid #cccccc;">
											</div>
										</div> -->
										<div class="form-group">
											<label class="col-sm-2 control-label">【其它信息】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>关注级别:</label>
											<div class="col-sm-8">
												<select id="attentionLevel" name="attentionLevel" class="form-control" required="required">
													<option value="">-----请选择-----</option>
													<option value="0">高</option>
													<option value="1">中</option>
													<option value="2">低</option>
												</select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态:</label>
											<div class="col-sm-8">
												<select id="status" name="status" class="form-control" required="required">
													<option value="">-----请选择-----</option>
													<option value="0">未审批</option>
													<option value="1">已审批</option>
												</select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>是否报警:</label>
											<div class="col-sm-8">
												<select id="alarm" name="alarm" class="form-control" required="required">
													<option value="">-----请选择-----</option>
													<option value="0">否</option>
													<option value="1">是</option>
												</select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>关注原因:</label>
											<div class="col-sm-8">
												<textarea id="attentionMsg" required="required" name="attentionMsg" rows="10" class="form-control" placeholder="请输入关注原因"></textarea>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											
											<div class="col-sm-4 col-sm-offset-2">
												<div class="btn-toolbar" role="toolbar">
													<div class="btn-group">
														<input id="submitBtn" type="submit" class="btn btn-primary" value="保存" />
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
		$("#addAttentionForm").validate({
			invalidHandler : function(form, validator) { //不通过回调
				return false;
			},
			rules : {
				merchantId : {
					required : true,
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
				address : {
					required : false
				},
				/*startDate : {
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
				},
				attentionMsg : {
					required : true
				}
			},
			messages : {
				merchantId : {
					required : "请输入商家号！",
					remote : "商家号不存在！"
				},
				address : {
					required : "请输入商家地址！"
				},
				/* startDate : {
					required : "请选择关注开始日期！"
				},
				endDate : {
					required : "请选择关注结束日期！"
				}, */
				merchantUrl : {
					maxlength : "域名最大长度为255！"
					/* url : "请输入正确的域名！(格式:http://...或https://...)" */
				},
				attentionLevel : {
					required : "请选择关注级别！"
				},
				status : {
					required : "请选择商家状态！"
				},
				alarm : {
					required : "请选择是否报警！"
				},
				attentionMsg : {
					required : "请输入关注原因！"
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
														window.location.href = "${pageContext.request.contextPath }/listAttention";
													}
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
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
														window.location.href = "${pageContext.request.contextPath }/listAttention";
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
														window.location.href = "${pageContext.request.contextPath }/listAttention";
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
	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/listAttention";
					});
</script>

<!-- <script>
	laydate.skin('molv');
	var start = {
		elem : '#startDate',
		format : 'YYYY-MM-DD hh:mm:ss',
		min : laydate.now(), //设定最小日期为当前日期
		max : '2099-06-16 23:59:59', //最大日期
		istime : true,
		istoday : true,
		choose : function(datas) {
			end.min = datas; //开始日选好后，重置结束日的最小日期
			end.start = datas //将结束日的初始值设定为开始日
		}
	};
	var end = {
		elem : '#endDate',
		format : 'YYYY-MM-DD hh:mm:ss',
		min : laydate.now(),
		max : '2099-06-16 23:59:59',
		istime : true,
		istoday : true,
		choose : function(datas) {
			start.max = datas; //结束日选好后，重置开始日的最大日期
		}
	};
	laydate(start);
	laydate(end);
</script> -->

<script type="text/javascript">
	$(function() {
		$("#merchantId").change(function() {
			var merchantId = $("#merchantId").val().replace(/<\/?[^>]*>/g,'');
			$("#merchantId").val($.trim(merchantId));
		});

		$("#address").change(function() {
			var address = $("#address").val().replace(/<\/?[^>]*>/g,'');
			$("#address").val($.trim(address));
		});

		$("#attentionMsg").change(function() {
			var attentionMsg = $("#attentionMsg").val().replace(/<\/?[^>]*>/g,'');
			$("#attentionMsg").val($.trim(attentionMsg));
		});
	});
</script>

</html>