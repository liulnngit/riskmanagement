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
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>解除关注名单流程处理</h5>
                    </div>
                    <div class="ibox-content">
					<div class="panel admin-panel">
						<div class="body-content">
							
								
									<table class="table table-bordered">
										<tbody align="center">
				
											<tr>
												<td><label>商家号：</label></td>
												<td>${attentionLibraryVO.merchantId }</td>
												<td><label>商家地址：</label></td>
												<td>${attentionLibraryVO.address }</td>
											</tr>
				
											<tr>
												<td><label>关注级别：</label></td>
												<td>${attentionLibraryVO.attentionLevel }</td>
												<td><label>解除人：</label></td>
												<td>${attentionLibraryVO.deleterName }</td>
											</tr>
				
											<tr>
												<td><label>状态：</label></td>
												<td>${attentionLibraryVO.status}</td>
												<td><label>是否报警：</label></td>
												<td>${attentionLibraryVO.alarm}</td>
											</tr>
				
											<tr>
												<td><label>处理人：</label></td>
												<td>${attentionLibraryVO.processorName}</td>
												<td><label>处理状态：</label></td>
												<td>${attentionLibraryVO.processStatus }</td>
											</tr>
				
											<tr>
												<td><label>关注开始时间：</label></td>
												<td>${attentionLibraryVO.startDate }</td>
												<td><label>关注结束时间：</label></td>
												<td>${attentionLibraryVO.endDate }</td>
											</tr>
											
											<tr><td><label>关注原因：</label></td>
												<td colspan="3" align="left">${attentionLibraryVO.attentionMsg }</td></tr>
				
											<%-- <tr>
												<td>${rcEvent.remark }</td>
												<td><fmt:formatDate value="${rcEvent.createDate }"
														pattern="yyyy-MM-dd hh:mm:ss" /></td>
												<td>${rcEvent.processorName }</td>
												<td>商品促销和活动推广</td>
											</tr> --%>
										</tbody>
									</table>
									<hr />
									<div class="margin-big-top">
										<label>处理详情：</label>
									</div>
				
									<hr />
									<form action="" id="eventForm">
										<input id="taskId" name="taskId" type="hidden" value="${taskId }"> <input
											name="id" type="hidden" value="${attentionLibraryVO.id }">
										<div class="margin-big-top" >
											<div class="input-group">
											<span class="input-group-addon">处理意见：</span>
											<textarea id="remark" rows="5" name="remark" class="form-control" placeholder="请输入处理意见"></textarea>
											</div>		
										</div>
				
										<%-- <div class="margin-big-top">
											<label>转给其他处理人：</label> <span style="margin-left: 15px;">
												<select name="selectOther" style="width: 200px; height: 35px;">
													<option value="">-----请选择-----</option>
													<c:forEach items="${userList }" var="user">
														<option value="${user.id }">${user.firstName }</option>
													</c:forEach>
											</select>
											</span>
										</div> --%>
									</form>
									<br>
									<div  class="margin-items-top" style="margin-left: 20%;">
										<div class="btn-group">
											<button id="submitBtn" type="button" class="btn btn-primary">确定</button>
										</div>
										<div class="btn-group" >
											<button id="returnBtn" type="button" class="btn btn-primary">返回</button>
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
						url : "${pageContext.request.contextPath }/completeAttentionDelTask",
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
					var tableHead = '<table class="table table-bordered"><thead><tr><th style="width:10%">处理人</th><th style="width:15%">处理时间</th><th style="width:75%">处理意见</th></tr></thead><tbody  align="center">';
					var tableHtml = '';
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
		$("#returnBtn").click(function() {
			window.locaction.href = "${pageContext.request.contextPath }/listToDoTask";
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