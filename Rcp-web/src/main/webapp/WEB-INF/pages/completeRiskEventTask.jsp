<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp" %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<%@ include file="../commons/sourceFile.jsp" %>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
					<div class="ibox-title">
                        <h5>风险事件流程处理</h5>
                    </div>
					
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">	
										<div class="form-group">
											<label class="col-sm-2 control-label">风险事件</label>
										</div>
								<div class="hr-line-dashed"></div>
									<table class="table table-bordered">
										<tbody align="center">
										
											<tr>
												<td><label>商家号：</label></td>
												<td>${rcEvent.merchantId }</td>
												<td><label>订单号：</label></td>
												<td><a href="#" id="showOrderData">${rcEvent.orderId }</a></td>
											</tr>
											<tr>
												<td><label>违反风控规则：</label></td>
												<td>${rcEvent.ruleName }</td>
												<td><label>支付类型：</label></td>
												<td>${rcEvent.payclassName }</td>
											</tr>
											
											<tr>
												<td><label>风控发生时间：</label></td>
												<td>${rcEvent.showCreateTime}</td>
												<td><label>系统类型：</label></td>
												<td>${rcEvent.systemName }</td>
											</tr>
											
											<tr>
												<td><label>上一次处理人：</label></td>
												<td>${rcEvent.processor }</td>
												<td><label>事件原因：</label></td>
												<td>${rcEvent.remark }</td>
											</tr>
										</tbody>
									</table>
									<input id="orderId" type="hidden" value="${rcEvent.orderId }">
									
									
									
									<form action="" id="eventForm" class="form-horizontal">
										<input id="taskId" name="taskId" type="hidden" value="${taskId }">
										<input id="id" name="id" type="hidden" value="${rcEvent.id}">
										<div class="form-group">
										<label class="control-label" style="margin-left:10px;">【处理意见】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-1 control-label">处理意见：</label>
											<div class="col-sm-12">
												<textarea id="remark" rows="5" name="remark" class="form-control" placeholder="请输入处理意见"></textarea>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<%-- <div class="margin-big-top">
											<label>下一步：</label> <span style="margin-left: 15px;">
													<select name="selectOther" style="width: 200px; height: 35px;">
													<option value="">-----请选择-----</option>
													<c:forEach items="${userList }" var="user">
														<option value="${user.id }">${user.firstName }</option>
												</c:forEach>
													</select>
											</span>
										</div> --%>
									</form>
									
									<div class="form-group">
											
											<div class="col-sm-4 col-sm-offset-2">
												<div class="btn-toolbar" role="toolbar">
												<div class="btn-group">
													<button id="submitBtn" type="button" class="btn btn-primary margin-items-top">保 存</button>
												</div>
												<div class="btn-group">
													<button id="setBlackBtn" type="button" class="btn btn-primary margin-items-top">设置为黑名单</button>
												</div>
												<div class="btn-group">
													<button id="setAttentionBtn" type="button" class="btn btn-primary margin-items-top">设置为关注名单</button>
												</div>
												<div class="btn-group">
													<button id="returnBtn" type="button" class="btn btn-primary">返回</button>
												</div>
								   				</div>
											</div>
										</div>
											
									
									<hr/>
									<div class="margin-big-top">
										<label>处理日志：</label>
										<div id="tbody-result">
											<table class="table table-bordered">
											<thead>
												<tr>
													<th style="width:10%">处理人</th>
													<th style="width:15%">处理时间</th>
													<th style="width:75%">处理意见</th>
												</tr>
											</thead>
											<tbody  align="center">
												
											</tbody>
											</table>
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
		$('#returnBtn').click(function() {
			window.location.href="${pageContext.request.contextPath }/listToDoTask";
		})
	})
</script>
<script type="text/javascript">
	$(function() {
		$("#setBlackBtn").click(function() {
			var id = $("#id").val();
			var pageUrl = "${pageContext.request.contextPath }/toSetBlackPage?id=" + id;
			var diag = new Dialog();
			diag.Width = 600;
			diag.Height = 700;
			diag.Title = "设置为黑名单";
			diag.URL = pageUrl;
			diag.Drag = false;
			diag.show();
		});
		
		$("#setAttentionBtn").click(function() {
			var id = $("#id").val();
			var pageUrl = "${pageContext.request.contextPath }/toSetAttentionPage?id=" + id;
			var diag = new Dialog();
			diag.Width = 600;
			diag.Height = 700;
			diag.Title = "设置为关注名单";
			diag.URL = pageUrl;
			diag.Drag = false;
			diag.show();
		});
	});
</script>

<script type="text/javascript">
	$(function() {
		$("#submitBtn").click(function() {
			//alert("点击");
			//$("#eventForm").submit();
			ajaxSubmitForm();

		});

		function ajaxSubmitForm() {
			$
					.ajax({
						cache : false,
						type : "POST",
						url : "${pageContext.request.contextPath }/doRiskEventProcess",
						data : $('#eventForm').serialize(),// 你的formid
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
												'任务办理成功！',
												{
													skin : 'layui-layer-molv',
													icon : 1,
													closeBtn : 0,
													btnAlign : 'c', //按钮居中
													anim : 0, //动画类型
													time : 2000,
													end : function() {
														window.location.href = "${pageContext.request.contextPath }/listToDoTask";
													}
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							} else {
								layer
										.alert(
												'任务办理失败！',
												{
													skin : 'layui-layer-molv',
													icon : 5,
													closeBtn : 0,
													btnAlign : 'c', //按钮居中
													anim : 0, //动画类型
													time : 2000,
													end : function() {
														window.location.href = "${pageContext.request.contextPath }/listToDoTask";
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
	$(function() {
		var taskId = $("#taskId").val();
		$.ajax({
			url : "${pageContext.request.contextPath }/queryHistoryData?taskId=" + taskId,
			type : "get",
			dataType : "json",
			success : function (data) {
				var tbody = window.document
					.getElementById("tbody-result");
				var tableHead ='<table class="table table-bordered"><thead><tr><th style="width:10%">处理人</th><th style="width:15%">处理时间</th><th style="width:75%">处理意见</th></tr></thead><tbody  align="center">';
				var tableHtml = "";
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						tableHtml += '<tr>'
							+ '<td>'
							+ data[i].processor
							+ '</td>'
							+ '<td>'
							+ data[i].endTime
							+ '</td>'
							+ '<td>'
							+ data[i].processDes
							+ '</td>' 
							+ '</tr>';
					}
					tbody.innerHTML =tableHead + tableHtml +'</tbody></table>';
				}
			}
		});
	});
</script>

<script type="text/javascript">
	$(function(){
		$("#showOrderData").click(function() {
			var orderId = $("#orderId").val();
			var pageUrl = "${pageContext.request.contextPath }/showOrderInfo?orderId=" + orderId;
			var diag = new Dialog();
			diag.Width = 800;
			diag.Height = 500;
			diag.Title = "订单详情";
			diag.URL = pageUrl;
			diag.Drag = false;
			diag.show();
		});
	});
</script>

<script type="text/javascript">
	$(function() {
		$("#remark").change(function() {
			var remark = $("#remark").val().replace(/<\/?[^>]*>/g,'');
			$("#remark").val($.trim(remark));
		});
	});
</script>

</html>