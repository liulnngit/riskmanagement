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
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>编辑案件</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
								
									<form class="form-horizontal" id="editRiskCaseForm" method="POST" role="form">
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>案件标题:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" readonly="readonly" id="title" name="title" required="required" value="${riskCase.title}">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>案件级别:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" readonly="readonly" id="priorityTitle" name="priorityTitle" required="required">
												<input type="hidden" id="priorityHidden" value="${riskCase.priority }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label">案件详情:</label>
											<div class="col-sm-8">
												<textarea class="form-control" id="caseDetail" name="caseDetail" placeholder="请输入案件详情" rows="5"></textarea>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label">分析详情:</label>
											<div class="col-sm-8">
												<textarea class="form-control" id="analyzeDetail" name="analyzeDetail" placeholder="请输入分析详情" rows="5"></textarea>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label">解决方案:</label>
											<div class="col-sm-8">
												<textarea class="form-control" id="resolution" name="resolution" placeholder="请输入解决方案" rows="5"></textarea>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				            			<div class="form-group">
											<label class="col-sm-2 control-label">历史记录:</label>
											<div class="col-sm-8">
												<c:forEach items="${riskCase.history}" var="pkv" varStatus="status">
									              ${pkv.value};</br>
									          	</c:forEach>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				            
				            			<div class="form-group">
											
											<div class="col-sm-4 col-sm-offset-2">
												<div class="btn-toolbar" role="toolbar">
													<div class="btn-group">
														<button id="submitBtn" type="submit" class="btn btn-primary margin-items-top">保存</button>
													</div>
													<div class="btn-group">
														<button id="resetBtn" type="button" class="btn btn-primary margin-items-top">重置</button>
													</div>
													<div class="btn-group">
														<button id="returnBtn" type="button" class="btn btn-primary">返回</button>
													</div>
												</div>
												<input type="hidden" id="uuid" name="uuid" value="${riskCase.uuid }">
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
      url : "${pageContext.request.contextPath}/queryRiskLevelList",
      type : "GET",
      contentType : "application/json",
      dataType : "json",
      success : function(data) {
        if (data.length > 0) {
          var selectOption = $("#priorityHidden").val();
          for (var i = 0; i < data.length; i++) {
        	  if(selectOption == data[i].id){
        		  $("#priorityTitle").val(data[i].title);
        		  return;
        	  }
          }
        }
      }
    });
  });
</script>

<script type="text/javascript">
	$(function() {
		$.validator.setDefaults({
			submitHandler : function(form) {
				ajaxSubmitForm();
			}
		});

		$(function() {
			// 在键盘按下并释放及提交后验证提交表单
			$("#editRiskCaseForm").validate({
				invalidHandler : function(form, validator) { //不通过回调
					return false;
				},
				rules : {
					caseDetail : {
						maxlength : 2000
					}, analyzeDetail : {
              maxlength : 2000
          }, resolution : {
              maxlength : 2000
          }
				},
				messages : {
					 caseDetail : {
             maxlength : "案件详情最大长度为2000！"
           }, analyzeDetail : {
             maxlength : "分析详情最大长度为2000！"
           }, resolution : {
             maxlength : "解决方案最大长度为2000！"
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
		});

		function ajaxSubmitForm() {
			debugger;
			$
					.ajax({
						cache : false,
						type : "POST",
						url : "${pageContext.request.contextPath }/editRiskCase",
						data : $('#editRiskCaseForm').serialize(),// 你的formid
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
						complete : function() {
							//后端响应后放开按钮
							$("#submitBtn").removeAttr("disabled");
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
														window.location.href = "${pageContext.request.contextPath }/listRiskCase";
													}
												});
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
														window.location.href = "${pageContext.request.contextPath }/listRiskCase";
													}
												});
								return;
							}
						}
					});
		}
	})

	$("#resetBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/showRiskCase?id="
								+ $("#id").val();
					});
	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/listRiskCase";
					});
</script>
</html>