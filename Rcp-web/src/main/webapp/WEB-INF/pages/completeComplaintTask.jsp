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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/formatDateUtil.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>投诉流程处理</h5>
                    </div>
                    <div class="ibox-content">
					<div class="panel admin-panel">
						<div class="body-content">

							<h4>投诉详情</h4>
									<table class="table table-bordered">
										<tbody align="center">
				
											<tr>
												<td><label>投诉人：</label></td>
												<td>${complaint.name }</td>
												<td><label>电话：</label></td>
												<td>${complaint.phoneNumber }</td>
											</tr>
				
											<tr>
												<td><label>邮箱：</label></td>
												<td>${complaint.emailAddress }</td>
												<td><label>投诉时间：</label></td>
												<td>${complaint.createTime }</td>
											</tr>
											<tr>
												<td><label>商家号：</label></td>
												<td>${complaint.merchantId }</td>
												<td><label>投诉金额：</label></td>
												<td><span id="txMoneyTD"></span></td>
											</tr>
				
											<tr>
												<td><label>订单号：</label></td>
												<td>${complaint.merchantOrderId }</td>
												<td><label>投诉内容：</label></td>
												<td>${complaint.remark }</td></tr>
				
											<%-- <tr>
												<td>${rcEvent.remark }</td>
												<td><fmt:formatDate value="${rcEvent.createDate }"
														pattern="yyyy-MM-dd hh:mm:ss" /></td>
												<td>${rcEvent.processorName }</td>
												<td>商品促销和活动推广</td>
											</tr> --%>
										</tbody>
									</table>
									<input id="txMoneyHidden" type="hidden" value="${complaint.txMoney}">
									<hr />

							<h4>投诉人信息检测结果</h4>
							<table class="table table-bordered float-item-left margin-items-top" style="word-wrap: break-word; word-break: break-all;">
								<thead>
								<tr>
									<th style="width:20%">投诉人</th>
									<th style="width:40%">电话</th>
									<th style="width:40%">邮箱</th>
								</tr>
								</thead>
								<tbody align="center">
								<tr id="complaintResult">
									<!-- <td></td>
                                    <td></td>
                                    <td></td> -->
								</tr>
								</tbody>
							</table>
							<hr />

							<h4>订单消费者信息检查结果</h4>
							<table	class="table table-bordered float-item-left margin-items-top"  style="word-wrap: break-word; word-break: break-all;">
								<thead>
								<tr>
									<!-- <th>消费者</th> -->
									<th style="width:25%">设备指纹</th>
									<th style="width:25%">IP</th>
									<th style="width:25%">卡号</th>
									<th style="width:25%">电话号码</th>
									<!-- <th>检测结果</th> -->
								</tr>
								</thead>
								<tbody align="center">
								<tr id="consumerResult">
									<!-- <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td> -->
								</tr>
								</tbody>
							</table>
							<hr />

							<h4>投诉商家信息检查结果</h4>
							<table	class="table table-bordered float-item-left margin-items-top" style="word-wrap: break-word; word-break: break-all;">
								<thead>
								<tr>
									<th style="width:30%">商家ID</th>
									<th style="width:30%">商家域名</th>
									<th style="width:30%">订单号</th>
									<!-- <th>检测结果</th> -->
								</tr>
								</thead>
								<tbody align="center">
								<tr id="merchantResult">
									<!-- <td></td>
                                    <td></td> -->
								</tr>
								</tbody>
							</table>

							<hr />
									<div class="margin-big-top">
										<label>处理详情：</label>
									</div>

									<hr />
									<form action="" id="eventForm">
										<input id="taskId" name="taskId" type="hidden" value="${taskId }">
										<input id="id"
											name="id" type="hidden" value="${complaint.id }">
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
											<button id="complaintBlackBtn" class="btn btn-primary" type="button"  data-toggle="modal"  data-target="#myModal">黑名单</button>
										</div>
										<div class="btn-group" >
											<button id="returnBtn" class="btn btn-primary" type="button">返回</button>
										</div>
									</div>
									<div class="modal fade" id="myModal" tabindex="-1"
										 role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<h4 class="modal-title" id="myModalLabel">设置黑名单</h4>
												</div>
												<div class="modal-body">
													<form class="form-horizontal" id="setBlackList" method="POST" role="form">
														<div class="form-group">
															<label class="col-sm-2 control-label"><input type="checkbox" name="checkbox" id="checkBoxId" value="checkbox" />投诉人</label>
														</div>
														<div class="hr-line-dashed"></div>

														<div id="complan" style="display:none;">
															<div class="form-group">
																<label class="col-sm-2 control-label" id="sp_complaintName">投诉人:</label>
																<div class="col-sm-8">
																	<input type="text" class="form-control"   name="complaintName"  value="" id="complaintName">
																</div>
																<div class="col-sm-2" id="checkboxdiv">
																	<input type="checkbox" tag="complaintName" onchange="javascript:return DoSelect(this);"/>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" id="sp_complaint_telphone">电话号码:</label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" placeholder="请输入电话号码"  name="complaint_telphone"  value="" id="complaint_telphone" >

																</div>
																<div class="col-sm-2" id="checkboxdiv">
																	<input type="checkbox" tag="complaint_telphone" onchange="javascript:return DoSelect(this);"/>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" id="sp_email">邮箱地址:</label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" placeholder="请输入邮箱地址"  name="email"  value="" id="email" >

																</div>
																<div class="col-sm-2" id="checkboxdiv">
																	<input type="checkbox" tag="email" onchange="javascript:return DoSelect(this);"/>
																</div>
															</div>
															<div class="hr-line-dashed"></div>
														</div>

														<div class="form-group">
															<label class="col-sm-2 control-label"><input type="checkbox" name="checkbox" id="checkBoxId_1" value="checkbox" />消费者</label>
														</div>
														<div class="hr-line-dashed"></div>

														<div id="complan_1" style="display:none;">
															<div class="form-group">
																<label class="col-sm-2 control-label" id="sp_fingerId">设备指纹:</label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" placeholder="请输入设备指纹"  name="fingerId"  value="" id="fingerId" >

																</div>
																<div class="col-sm-2" id="checkboxdiv_1">
																	<input type="checkbox" tag="fingerId" onchange="javascript:return DoSelect(this);"/>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" id="sp_IPAddress">IP地址:</label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" placeholder="请输入IP地址"  name="IPAddress"  value="" id="IPAddress" >

																</div>
																<div class="col-sm-2" id="checkboxdiv_1">
																	<input type="checkbox" tag="IPAddress" onchange="javascript:return DoSelect(this);"/>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" id="sp_blankCardNo">银行卡号:</label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" placeholder="请输入银行卡号"  name="blankCardNo"  value="" id="blankCardNo" >

																</div>
																<div class="col-sm-2" id="checkboxdiv_1">
																	<input type="checkbox" tag="blankCardNo" onchange="javascript:return DoSelect(this);"/>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" id="sp_telphoneX">电话号码:</label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" placeholder="请输入电话号码"  name="telphoneX"  value="" id="telphoneX" >

																</div>
																<div class="col-sm-2" id="checkboxdiv_1">
																	<input type="checkbox" tag="telphoneX" onchange="javascript:return DoSelect(this);"/>
																</div>
															</div>
															<div class="hr-line-dashed"></div>
														</div>

														<div class="form-group">
															<label class="col-sm-2 control-label"><input type="checkbox" name="checkbox" id="checkBoxId_2" value="checkbox" />商家</label>
														</div>
														<div class="hr-line-dashed"></div>

														<div id="complan_2" style="display:none;">
															<div class="form-group">
																<label class="col-sm-2 control-label" id="sp_merchantId">商家号:</label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" placeholder="请输入商家号"  name="merchantId"  value="" id="merchantId" >

																</div>
																<div class="col-sm-2" id="checkboxdiv_2">
																	<input type="checkbox" tag="merchantId" onchange="javascript:return DoSelect(this);"/>
																</div>
															</div>
															<div class="form-group">
																<label class="col-sm-2 control-label" id="sp_url">商家域名:</label>
																<div class="col-sm-8">
																	<input type="text" class="form-control" placeholder="请输入商家域名"  name="url"  value="" id="url" >

																</div>
																<div class="col-sm-2" id="checkboxdiv_2">
																	<input type="checkbox" tag="url" onchange="javascript:return DoSelect(this);"/>
																</div>
															</div>
															<div class="hr-line-dashed"></div>
														</div>

														<div class="form-group">

														</div>


													</form>
												</div>
												<div class="modal-footer">
													<div class="btn-toolbar" role="toolbar" style="float:right;">
														<div class="btn-group">
															<button id="submit" type="submit" class="btn btn-primary margin-items-top">保 存</button>
														</div>
														<div class="btn-group">
															<button id="resetBtn" type="reset" class="btn btn-primary margin-items-top">重置</button>
														</div>
														<div class="btn-group">
															<button type="button" class="btn btn-primary"
																	data-dismiss="modal">关闭</button>
														</div>
													</div>
												</div>
											</div>
											<!-- /.modal-content -->
										</div>

										<!-- /.modal -->
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
						url : "${pageContext.request.contextPath }/completeComplaintTask",
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
			window.location.href = "${pageContext.request.contextPath}/listToDoTask";
		});
	});
</script>

<script type="text/javascript">
	$(function() {
		$("#remark").change(function() {
			var remark = $("#remark").val().replace(/<\/?[^>]*>/g,'');
			$("#remark").val($.trim(remark));
		});
		
		var txMoney = $("#txMoneyHidden").val();
		if (txMoney != '' && txMoney != 'undefined') {
			$("#txMoneyTD").text("￥" + formatCurrency(txMoney));
		}

		showAbnormalDetail($("#id").val());
		$("#complaintBlackBtn").click(function() {
            var complaint_phone = $("#complaint_phone").text();
            if (complaint_phone.indexOf("(") > 0) {
                complaint_phone = complaint_phone.substring(0,complaint_phone.lastIndexOf("("))
			}

			var complaint_email = $("#complaint_email").text();
            if (complaint_email.indexOf("(") > 0) {
                complaint_email = complaint_email.substring(0,complaint_email.lastIndexOf("("))
            }


		    $("#complaintName").val($("#complaint_name").text());
            $("#complaint_telphone").val(complaint_phone);
            $("#email").val(complaint_email);

            var consumer_fingerId = $("#consumer_fingerId").text();
            if (consumer_fingerId.indexOf("(") > 0) {
                consumer_fingerId = consumer_fingerId.substring(0,consumer_fingerId.lastIndexOf("("))
            }

            var consumer_ip = $("#consumer_ip").text();
            if (consumer_ip.indexOf("(") > 0) {
                consumer_ip = consumer_ip.substring(0,consumer_ip.lastIndexOf("("))
            }

            var consumer_cardNo = $("#consumer_cardNo").text();
            if (consumer_cardNo.indexOf("(") > 0) {
                consumer_cardNo = consumer_cardNo.substring(0,consumer_cardNo.lastIndexOf("("))
            }

            var consumer_phone = $("#consumer_phone").text();
            if (consumer_phone.indexOf("(") > 0) {
                consumer_phone = consumer_phone.substring(0,consumer_phone.lastIndexOf("("))
            }


            $("#fingerId").val(consumer_fingerId);
            $("#IPAddress").val(consumer_ip);
            $("#blankCardNo").val(consumer_cardNo);
            $("#telphoneX").val(consumer_phone);

            var merchant_id = $("#merchant_id").text();
            if (merchant_id.indexOf("(") > 0) {
                merchant_id = merchant_id.substring(0,merchant_id.lastIndexOf("("))
            }

            var merchant_url = $("#merchant_url").text();
            if (merchant_url.indexOf("(") > 0) {
                merchant_url = merchant_url.substring(0,merchant_url.lastIndexOf("("))
            }

            $("#merchantId").val(merchant_id);
            $("#url").val(merchant_url);
		});
	});
</script>

<script type="text/javascript">
    //查看投诉异常详情
    function showAbnormalDetail(complaintId) {
        $.ajax({
            url : "${pageContext.request.contextPath}/showAbnormalDetail?complaintId=" + complaintId,
            type : "GET",
            cache : false,
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
            },
            success : function (data) {
                $('#complaintCheckModal').modal('show');
                var complaintMap = data.complaintMap;
                $("#complaintResult").empty();
                $("#consumerResult").empty();
                $("#merchantResult").empty();
                $("#complaintResult").append("<td><span id='complaint_name'>" + complaintMap.name
                    + "</span></td>" + "<td><span id='complaint_phone'>" + complaintMap.phoneNumber + "</span></td>"
                    + "<td><span id='complaint_email'>" + complaintMap.email + "</span></td>");

                var consumerMap = data.consumerMap;
                $("#consumerResult").append("<td><span id='consumer_fingerId'>" + consumerMap.fingerId + "</span></td>"
                    + "<td><span id='consumer_ip'>" + consumerMap.IPAddress + "</span></td>"
                    + "<td><span id='consumer_cardNo'>" + consumerMap.blankCardNo + "</span></td>"
                    + "<td><span id='consumer_phone'>" + consumerMap.payerTelphone + "</span></td>");

                var merchantMap = data.merchantMap;
                $("#merchantResult").append("<td><span id='merchant_id'>" + merchantMap.merchantId
                    + "</span></td>" + "<td><span id='merchant_url'>" + merchantMap.merchantUrl
                    + "</span></td>" + "<td>" + merchantMap.orderId
                    + "</td>");
            }
        });
    }
</script>
<script type="text/javascript">

    $("#checkBoxId").click(function() {
        if(this.checked){
            $("#complan").show();
        }else{
            $("#complan").hide();
        }
    })
    $("#checkBoxId_1").click(function() {
        if(this.checked){
            $("#complan_1").show();
        }else{
            $("#complan_1").hide();
        }
    })
    $("#checkBoxId_2").click(function() {
        if(this.checked){
            $("#complan_2").show();
        }else{
            $("#complan_2").hide();
        }
    })
</script>
<script type="text/javascript">
    $.validator.setDefaults({
        submitHandler : function(form) {
            ajaxSubmitFormBlack();
        }
    });
    $("#submit").click(function() {
        //alert("点击");
        //$("#eventForm").submit();
        ajaxSubmitFormBlack();

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
        $("#getBlackList").validate({
            invalidHandler : function(form, validator) { //不通过回调
                return false;
            },
            rules : {


            },
            messages : {

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
        json += 'complaintMap:{';
        var complaintData = new Object();
        $("#checkboxdiv > input").each(function(index, val){
            if($(val).attr("checked")=="checked")
            {
                var name = $(val).attr("tag");
                var value = $.trim($("#" + name).val());
                json +='\"' + name + '\":\"' + value+'\",';
            }
        });
        json = json.substring(0, json.length - 1);
        json += '},';
        json += 'consumerMap:{';
        $("#checkboxdiv_1 > input").each(function(index, val){

            if($(val).attr("checked")=="checked")
            {
                var name_1 = $(val).attr("tag");
                var value_1 = $.trim($("#" + name_1).val());
                json +='\"' + name_1 + '\":\"' + value_1+'\",';
            }
        });
        json = json.substring(0, json.length - 1);
        json += '},';

        json += 'merchantMap:{';
        $("#checkboxdiv_2 > input").each(function(index, val){

            if($(val).attr("checked")=="checked")
            {
                var name_2 = $(val).attr("tag");
                var value_2 = $.trim($("#" + name_2).val());
                json +='\"' + name_2 + '\":\"' + value_2+'\",';
            }
        });
        json = json.substring(0, json.length - 1);
        json += '}';

		json += '}';
        return json;
    }

    function ajaxSubmitFormBlack() {
        var data = getFormData();

        $.ajax({
            url : "${pageContext.request.contextPath }/addBlackFromComplaint",
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
                $("#submit").removeAttr("disabled");
            },
            beforeSend : function() {
                //在表单提交后后端未作出响应时，禁用提交按钮，提高用户体验。
                $("#submit").attr({
                    disabled : "disabled"
                });
            },
            complete : function() {
                //后端响应后放开按钮
                $("#submit").removeAttr("disabled");
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
</html>