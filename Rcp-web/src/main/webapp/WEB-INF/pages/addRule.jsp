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
                        <h5>新增风险规则</h5>
                    </div>
				
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
								
									<form class="form-horizontal" id="addRuleForm" method="POST"
										role="form">
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则编码:</label>
											<div class="col-sm-8">
												<input
													id="ruleCode" name="ruleCode" type="text" class="form-control" placeholder="请输入规则编码" />
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则名称:</label>
											<div class="col-sm-8">
												<input
													id="ruleName" name="ruleName" type="text" class="form-control" placeholder="请输入规则名称" />
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则类别:</label>
											<div class="col-sm-8">
												<select
													id="ruleType" required="required" class="form-control"
													name="ruleType">
													<option value="">-----请选择-----</option>
												</select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则属性:</label>
											<div class="col-sm-8">
												<select
													id="ruleFeature" required="required" class="form-control"
													name="ruleFeature">
													<option value="">-----请选择-----</option>
													<option value="1">常规</option>
													<option value="2">统计</option>
													<option value="3">高频</option>
													<option value="4">全局</option>
												</select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则算法:</label>
											<div class="col-sm-8">
												<select
													id="ruleArithmetic" required="required" class="form-control"
													name="ruleArithmetic">
													<option value="">-----请选择-----</option>
												</select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>支持配置:</label>
											<div class="col-sm-8">
												<select id="isConf"
													class="form-control" required title="请选择" name="isConf">
													<option value="">-----请选择-----</option>
													<option value="0">不可配置</option>
													<option value="1">可配置</option>
												</select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则级别:</label>
											<div class="col-sm-8">
												<select
													id="riskLevel" required="required" class="form-control"
													name="riskLevel">
													<option value="">-----请选择-----</option>
												</select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label">配置文件:</label>
											<div class="col-sm-8">
												<div id="file_css" class="form-control">
													<input type="text" value="未选择文件" id="showText"/><input type="button" value="浏览"/><input type="file"  onchange="fileChange(this);" name="ruleFile" id="ruleFile"/>
												</div>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label">配置参数:</label>
											<div class="col-sm-8">
												<div id="tbody-result">
													<table
														class="table table-bordered float-item-left margin-items-top" id="myTable">
														<thead>
															<tr>
																<th>参数名称</th>
																<th>参数值</th>
															</tr>
														</thead>
														<tbody align="center" >
														</tbody>
													</table>
												</div>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则描述:</label>
											<div class="col-sm-8">
												<textarea id="remark" name="remark" class="form-control"
													rows="5" placeholder="请输入规则描述"></textarea>
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
												<button type="reset" class="btn btn-primary margin-items-top">重置</button>
											</div>
											<div class="btn-group">
												<button id="returnBtn" type="button"
													class="btn btn-primary margin-items-top">返回</button>
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

<!-- 商家私有配置选择 -->
<script type="text/javascript">
	$(function() {
		$('#returnBtn').click(function() {
			window.location.href="${pageContext.request.contextPath }/listRule";
		})
	})
</script>

<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/queryAlgorithmTypeList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#ruleArithmetic").append(
								'<option value="' + data[i].type +'">'
										+ data[i].title + '</option>')
					}
				}
			}
		});

		$.ajax({
			url : "${pageContext.request.contextPath}/queryRuleTypeList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#ruleType").append(
								'<option value="' + data[i].id +'">'
										+ data[i].title + '</option>')
					}
				}
			}
		});
		
		$.ajax({
	      url : "${pageContext.request.contextPath}/queryRiskLevelList",
	      type : "GET",
	      contentType : "application/json",
	      dataType : "json",
	      success : function(data) {
	    	  if (data.length > 0) {
	    		  for (var i = 0; i < data.length; i++) {
			          $("#riskLevel").append(
			              '<option value="' + data[i].id +'">'
			                  + data[i].title + '</option>')
			        }
	    	  }
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
		$("#addRuleForm").validate({
			invalidHandler : function(form, validator) { //不通过回调
				return false;
			},
			rules : {
				ruleCode : {
					required : true,
					digits : true,				//必须是整数
					maxlength : 30,
					remote : {
						url: "checkRuleCode",     //后台处理程序
					    type: "post",               //数据发送方式
					    dataType: "json",           //接受数据格式   
					    data: {                     //要传递的数据
					    	ruleCode: function() {
					            return $("#ruleCode").val();
					        }
					    }
					}
				},
				ruleName : {
					required : true,
					remote : {
						url: "checkRuleName",     //后台处理程序
					    type: "post",               //数据发送方式
					    dataType: "json",           //接受数据格式   
					    data: {                     //要传递的数据
					        ruleName: function() {
					            return $("#ruleName").val();
					        }
					    }
					}
				},
				ruleFeature : {
					required : true
				},
				ruleType : {
					required : true
				},
				ruleArithmetic : {
					required : true
				},
				isConf : {
					required : true
				},
				systemId : {
					required : true
				},
				riskLevel : {
					required : true
				},
				remark : {
					required : true,
					maxlength : 140
				}
			},
			messages : {
				ruleCode : {
					required : "请输入规则编码！",
					digits : "请输入整数！",
					maxlength : "规则编码最大长度是30!",
					remote : "该规则编码已存在！"
				},
				ruleName : {
					required : "请输入规则名称！",
					remote : "该规则名称已存在！"
				},
				ruleFeature : {
					required : "请选择大的规则类型！"
				},
				ruleType : {
					required : "请选择规则类型！"
				},
				ruleArithmetic : {
					required : "请选择规则算法！"
				},
				isConf : {
					required : "请选择是否可配置！"
				},
				systemId : {
					required : "请选择所属系统！"
				},
				riskLevel : {
					required : "请选择风险级别！"
				},
				remark : {
					required : "请输入规则描述信息！",
					maxlength : "规则描述信息长度为140！"
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
			onfocusout: function(element) { 
				$(element).valid(); 
			},
			//提交表单后，未通过验证的表单（第一个或提交之前获得焦点的未通过验证的表单）会获得焦点。
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
					url : "${pageContext.request.contextPath }/addRule",
					data : $('#addRuleForm').serialize(),// 你的formid
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
													window.location.href = "${pageContext.request.contextPath }/listRule";
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
													window.location.href = "${pageContext.request.contextPath }/listRule";
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
	var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
	function fileChange(target, id) {
		var fileSize = 0;
		var filetypes = [".drl"];
		var filepath = target.value;
		var filemaxsize = 1024;//1M 
		if (filepath) {
			var isnext = false;
			var fileend = filepath.substring(filepath.indexOf("."));
			if (filetypes && filetypes.length > 0) {
				for (var i = 0; i < filetypes.length; i++) {
					if (filetypes[i] == fileend) {
						isnext = true;
						break;
					}
				}
			}
			if (!isnext) {
				layer.alert('不接受此文件类型！',
						{
							skin : 'layui-layer-molv',
							icon : 5,
							btnAlign : 'c', //按钮居中
							closeBtn : 0,
							anim : 0, //动画类型
							time : 2000
						});
				target.value = "";
				return false;
			}
		} else {
			return false;
		}
		if (isIE && !target.files) {
			var filePath = target.value;
			//console.log(filePath);
			var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
			//console.log(fileSystem.FileExists(filePath));
			if (!fileSystem.FileExists(filePath)) {
				layer.alert('规则文件不存在，请重新输入！',
						{
							skin : 'layui-layer-molv',
							icon : 5,
							btnAlign : 'c', //按钮居中
							closeBtn : 0,
							anim : 0, //动画类型
							time : 2000
						});
				return false;
			}
			
			var file = fileSystem.GetFile(filePath);
			fileSize = file.Size;
		} else {
			fileSize = target.files[0].size;
		}
		var size = fileSize / 1024;
		if (size > filemaxsize) {
			layer.alert("规则文件大小不能大于" + filemaxsize / 1024 + "M！",
					{
						skin : 'layui-layer-molv',
						icon : 5,
						btnAlign : 'c', //按钮居中
						closeBtn : 0,
						anim : 0, //动画类型
						time : 2000
					});
			target.value = "";
			return false;
		}
		if (size <= 0) {
			layer.alert("规则文件大小不能为0M！",
					{
						skin : 'layui-layer-molv',
						icon : 5,
						btnAlign : 'c', //按钮居中
						closeBtn : 0,
						anim : 0, //动画类型
						time : 2000
					});
			target.value = "";
			return false;
		}
		var fileName = filepath.substring(filepath.lastIndexOf("\\") + 1);
		$("#showText").val(fileName);
		ruleFileUpload(fileName);
		$("#ruleFile").val(fileName);
	}
	
	function ruleFileUpload(fileName) {
			$.ajaxFileUpload({
						type : "POST",
						url : "${pageContext.request.contextPath }/showParam",
						contentType : "application/json",
						dataType : 'json',
						secureuri : false,
						fileElementId : 'ruleFile',
						success : function(data) {
							var tbody = window.document
									.getElementById("tbody-result");
							var tableHead ='<table class="table table-bordered float-item-left margin-items-top" id="myTable"><thead><tr><th>参数名称</th><th>参数值</th></tr></thead><tbody align="center" >';
							var tableHtml = "";
							if (data.length > 0) {
								for (var position = 0; position < data.length; position++) {
									tableHtml += '<tr>'
											+ '<td>'
											+ data[position].name
											+ '</td>'
											+ '<td>'
											+ data[position].matches
											+ '</td>' + '</tr>';
									tbody.innerHTML =tableHead + tableHtml +'</tbody></table>';
								}
								
							} else {
								tbody.innerHTML =tableHead + '</tbody></table>';
							}
						}
					});
			return false;
		}
	
</script>

<script type="text/javascript">
	$(function() {
		$("#ruleCode").change(function() {
			var ruleCode = $("#ruleCode").val().replace(/<\/?[^>]*>/g,'');
			$("#ruleCode").val($.trim(ruleCode));
		});
		
		$("#ruleName").change(function() {
			var ruleName = $("#ruleName").val().replace(/<\/?[^>]*>/g,'');
			$("#ruleName").val($.trim(ruleName));
		});
		
		$("#remark").change(function() {
			var remark = $("#remark").val().replace(/<\/?[^>]*>/g,'');
			$("#remark").val($.trim(remark));
		});
	});
</script>

</html>