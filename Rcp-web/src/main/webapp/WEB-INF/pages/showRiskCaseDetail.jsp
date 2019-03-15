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
<script type="text/javascript" charset="utf-8"
	src="${pageContext.request.contextPath}/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${pageContext.request.contextPath}/js/ueditor/ueditor.all.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${pageContext.request.contextPath}/js/ueditor/lang/zh-cn/zh-cn.js"></script>
<style>
table>tbody>tr>td {
	border: 1px solid #ccc;
	height: 14px;
	line-height: 14px;
	text-align: center;
	padding: 10px;
}
</style>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5></h5>
					</div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">

								<table class="table table-bordered">
									<tbody align="left">
										<tr>
											<td style="width: 20%">系统名称</td>
											<td style="width: 80%">${riskCase.systemName}</td>
										</tr>
										<tr>
											<td style="width: 20%">案件标题</td>
											<td style="width: 80%">${riskCase.title}</td>
										</tr>
										<tr>
											<td style="width: 20%">案件级别</td>
											<td style="width: 80%">${riskCase.priority}</td>
										</tr>
										<tr>
											<td style="width: 20%">状态</td>
											<td style="width: 80%">${riskCase.status}</td>
										</tr>
										<tr>
											<td style="width: 20%">创建人</td>
											<td style="width: 80%">${riskCase.creator}</td>
										</tr>
										<tr>
											<td style="width: 20%">创建时间</td>
											<td style="width: 80%">${riskCase.createDate}</td>
										</tr>
								</table>
								<ul id="myTab" class="nav nav-tabs">
									<li class="active"><a href="#caseDetailTab"
										data-toggle="tab"> 案件详情 </a></li>
									<li><a href="#analyzeDetailTab" data-toggle="tab">案件分析</a></li>
									<li><a href="#resolutionTab" data-toggle="tab">解决方案</a></li>
								</ul>

								<form class="form-inline" id="editRiskCaseForm" method="POST"
									role="form"
									style="border: 1px solid #ccc; border-top: none; padding: 10px;">
									<input type="hidden" id="uuid" name="uuid"
										value="${riskCase.uuid }"> <input type="hidden"
										class="form-control" id="title" name="title"
										value="${riskCase.title}"> <input type="hidden"
										id="priorityTitle" name="priorityTitle"
										value="${riskCase.priority }">
									<div id="myTabContent" class="tab-content">
										<div class="tab-pane fade in active" id="caseDetailTab">
											<c:forEach items="${riskCase.caseDetails}" var="detail">
												<div style="margin-top: 5px;">
													<span style="color: green">操作人:</span> <span>${detail.name}</span>
													<span style="margin-left: 20px; color: red;">时间:</span> <span>${detail.key}</span>
												</div>
												<div style="margin-top: 5px;">
													<div style="color: blue">案件内容:</div>
													<div style="padding: 10px;">${detail.value}</div>
												</div>
												<hr>
											</c:forEach>
											<c:if test="${riskCase.status != '已关闭'}">
												<button id="detailBtn" type="button"
													class="btn btn-primary btn-sm" style="margin-bottom: 10px;">
													<span class="glyphicon glyphicon-plus"></span>追加详情
												</button>
											</c:if>
											<div style="width: 60%;">
												<script id="caseDetail" name="caseDetail" type="text/plain"></script>
											</div>
										</div>
										<div class="tab-pane fade" id="analyzeDetailTab">
											<c:forEach items="${riskCase.analyzeDetails}" var="pkv">
												<div style="margin-top: 5px;">
													<span style="color: green">操作人:</span> <span>${pkv.name}</span>
													<span style="margin-left: 20px; color: red">时间:</span> <span>${pkv.key}</span>
												</div>
												<div style="margin-top: 5px;">
													<div style="color: blue">分析内容:</div>
													<div style="padding: 10px;">${pkv.value}</div>
												</div>
												<hr>
											</c:forEach>
											<c:if test="${riskCase.status != '已关闭'}">
												<button id="analyzeBtn" type="button"
													class="btn btn-primary btn-sm" style="margin-bottom: 10px;">
													<span class="glyphicon glyphicon-plus"></span>追加分析
												</button>
											</c:if>
											<div style="width: 60%;">
												<script id="analyzeDetail" name="analyzeDetail"
													type="text/plain"></script>
											</div>
										</div>
										<div class="tab-pane fade" id="resolutionTab">
											<c:forEach items="${riskCase.resolution}" var="pkv">
												<div style="margin-top: 5px;">
													<span style="color: green">操作人:</span> <span>${pkv.name}</span>
													<span style="margin-left: 20px; color: red">时间:</span> <span>${pkv.key}</span>
												</div>
												<div style="margin-top: 5px;">
													<div style="color: blue">解决方案:</div>
													<div style="padding: 10px;">${pkv.value}</div>
												</div>
												<hr>
											</c:forEach>
											<c:if test="${riskCase.status != '已关闭'}">
												<button id="resolutionBtn" type="button"
													class="btn btn-primary btn-sm" style="margin-bottom: 10px;">
													<span class="glyphicon glyphicon-plus"></span>追加方案
												</button>
											</c:if>
											<div style="width: 60%;">
												<script id="resolution" name="resolution" type="text/plain"></script>
											</div>
										</div>

									</div>
									<hr>
									<table>
										<tr>
											<td style="width: 20%">历史记录</td>
											<td><c:forEach items="${riskCase.history}" var="pkv"
													varStatus="status">
				                					${pkv.value};</br>
												</c:forEach></td>
										</tr>
										</tbody>
									</table>
									<div style="margin-top: 20px; margin-botton: 20px;"></div>
									<div class="btn-toolbar" role="toolbar">
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
					<br> <br> <br>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		$("#detailBtn").click(function() {
			var ue = UE.getEditor('caseDetail');
		});
	});
</script>

<script type="text/javascript">
	$(function() {
		$("#analyzeBtn").click(function() {
			var ue = UE.getEditor('analyzeDetail');
		});
	});
</script>

<script type="text/javascript">
	$(function() {
		$("#resolutionBtn").click(function() {
			var ue = UE.getEditor('resolution');
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
					},
					analyzeDetail : {
						maxlength : 2000
					},
					resolution : {
						maxlength : 2000
					}
				},
				messages : {
					caseDetail : {
						maxlength : "案件详情最大长度为2000！"
					},
					analyzeDetail : {
						maxlength : "分析详情最大长度为2000！"
					},
					resolution : {
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
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							} else if ("isClosed" == data.isClosed) {
								layer
										.alert(
												'编辑失败，案件已关闭！',
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
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
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
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							}
						}
					});
		}
	})

	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/listRiskCase";
					});
</script>

</html>