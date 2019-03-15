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
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/additional-methods.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>新增分析模型</h5>
                    </div>
					
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
								
									<form class="form-horizontal" id="addAnalyzeModelForm" action="addAnalyzeModel" method="POST" role="form">
					    				<div class="form-group">
											<label class="col-sm-2 control-label">【分析模型】</label>
											
										</div>
					    				<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>模型名称:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="modelName"  name="modelName" required="required" placeholder="请输入模型名称">   
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>模型编码:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="modelCode"  name="modelCode" required="required" placeholder="请输入模型编码">   
											</div>
										</div>
										<div class="hr-line-dashed"></div>
					    				<div class="form-group">
											<label class="col-sm-2 control-label">【配置信息】</label>
											
										</div>
					    				<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>实现类名:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="classFullPath"  name="classFullPath" required="required" placeholder="请输入实现类名">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
					    				
					    				<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>模型说明:</label>
											<div class="col-sm-8">
												<textarea class="form-control" id="remark"  name="remark" required="required" placeholder="请输入模型说明" rows="8" cols="10"></textarea>
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
					                 <button type="reset" class="btn btn-primary margin-items-top">重置</button>
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
	$(function() {
		$.validator.setDefaults({
			submitHandler : function(form) {
				ajaxSubmitForm();
			}
		});

		$(function() {
			// 在键盘按下并释放及提交后验证提交表单
			$("#addAnalyzeModelForm").validate({
				invalidHandler : function(form, validator) { //不通过回调
					return false;
				},
				rules : {
					modelName : {
						required : true,
						maxlength : 20,
						remote : {
							url : "${pageContext.request.contextPath}/checkModelName",
							type : "post",
							dataType : "json",
							data : {
								modelName : function() {
									return $("#modelName").val();
								}
							}
						}
					},
					modelCode : {
		            	required : true,
		            	maxlength : 20,
		            	codeEnglish : true,
		            	remote : {
		            		url : "${pageContext.request.contextPath}/checkModelCode",
		            		type : "post",
		            		dataType : "json",
		            		data : {
		            			modelCode : function() {
		            				return $("#modelCode").val();
		            			}
		            		}
		            	}
		          	},
		          	remark : {
		            	required : true,
		            	maxlength : 500
		          	},
		          	classFullPath : {
		            	required : true,
		            	maxlength : 100
		          	}
				},
				messages : {
					modelName : {
						required : "请输入分析模型名称！",
						maxlength : "分析模型名称最大长度是20！",
						remote : "该分析模型名称已存在！"
					},
					modelCode : {
			            required : "请输入分析模型编码！",
			            maxlength : "分析模型编码最大长度是20！",
			            codeEnglish : "分析模型编码只能是英文字母！",
			            remote : "该分析模型编码已存在！"
			        },
			        remark : {
			            required : "请输入分析模型说明！",
			            maxlength : "分析模型说明最大长度是500！"
			        },
			        classFullPath : {
				        required : "请输入Controller类名！",
				        maxlength : "最大长度是100！"
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
						url : "${pageContext.request.contextPath }/addAnalyzeModel",
						data : $('#addAnalyzeModelForm').serialize(),// 你的formid
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
												'新增成功！',
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
												'新增失败！',
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
	})
	
	$("#returnBtn").click(
	    function() {
	      window.location.href = "${pageContext.request.contextPath}/listAnalyzeModel";
	    }
	);
</script>

<script type="text/javascript">
	$(function() {
		$("#modelName").change(function() {
			var modelName = $("#modelName").val().replace(/<\/?[^>]*>/g,'');
			$("#modelName").val($.trim(modelName));
		});
		
		$("#modelCode").change(function() {
			var modelCode = $("#modelCode").val().replace(/<\/?[^>]*>/g,'');
			$("#modelCode").val($.trim(modelCode));
		});
		
		$("#remark").change(function() {
			var remark = $("#remark").val().replace(/<\/?[^>]*>/g,'');
			$("#remark").val($.trim(remark));
		});
		
		$("#classFullPath").change(function() {
			var classFullPath = $("classFullPath").val().replace(/<\/?[^>]*>/g,'');
			$("#classFullPath").val($.trim(classFullPath));
		});
	});
</script>

</html>