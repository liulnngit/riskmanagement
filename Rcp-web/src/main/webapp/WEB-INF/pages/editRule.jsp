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
                        <h5>编辑规则</h5>
                    </div>
					<div class="ibox-content">
					<div class="panel admin-panel">
						<div class="body-content">
							
								<form class="form-horizontal" id="editRuleForm" method="POST" role="form">
								
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则编码:</label>
											<div class="col-sm-8">
												<input id="ruleCode" name="ruleCode" readonly="readonly"
											type="text" class="form-control"  value="${rule.ruleCode }"/>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
					    					    				   				
				    					<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则名称:</label>
											<div class="col-sm-8">
												<input id="ruleName" name="ruleName" type="text" class="form-control" value="${rule.ruleName }" placeholder="请输入规则名称"/>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
					    				<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则类别:</label>
											<div class="col-sm-8">
												<input type="text"
				                  class="form-control" readonly="readonly" id="ruleTypeTitle" name="ruleTypeTitle"
				                  required="required" value="${rule.ruleType}">
				                  <input type="hidden" id="ruleTypeHidden" id="ruleType" name="ruleType" value="${rule.ruleType }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
					    			
				    				<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则属性:</label>
											<div class="col-sm-8">
												<select id="ruleFeature" required="required" class="form-control" name="ruleFeature">
													<option value="">-----请选择-----</option>
													<option value="1" 
													<c:if test="${rule.ruleFeature=='1'}">selected</c:if>>常规</option>
													<option value="2" 
													<c:if test="${rule.ruleFeature=='2'}">selected</c:if>>统计</option>
													<option value="3" 
													<c:if test="${rule.ruleFeature=='3'}">selected</c:if>>高频</option>
													<option value="4" 
													<c:if test="${rule.ruleFeature=='4'}">selected</c:if>>全局</option>
											</select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				    				
				    				
				    		
				            
				    				<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则算法:</label>
											<div class="col-sm-8">
												<select id="ruleArithmetic" required="required" class="form-control" name="ruleArithmetic">
													<option value="">-----请选择-----</option>
											</select>
											<input type="hidden" id="ruleArithmeticHidden" value="${rule.ruleArithmetic }">  
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				    				
				    				
				    					<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>支持配置:</label>
											<div class="col-sm-8">
												<select id="isConf" class="form-control"
												required title="请选择" name="isConf">
												<option value="">-----请选择-----</option>
												<option value="0"
												<c:if test="${rule.isConf=='0'}">selected</c:if>>不可配置</option>
												<option value="1"
												<c:if test="${rule.isConf=='1'}">selected</c:if>>可配置</option>
											</select>	
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				    					<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则级别:</label>
											<div class="col-sm-8">
												<select id="riskLevel" required="required" class="form-control" name="riskLevel">
									                  <option value="">-----请选择-----</option>
									              </select>
									              <input type="hidden" id="riskLevelHidden" value="${rule.riskLevel }">	
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				    					<div class="form-group">
											<label class="col-sm-2 control-label">配置文件:</label>
											<div class="col-sm-8">
												<div id="file_css" class="form-control">
												<input type="text" value="未选择文件" id="showText"/><input type="button" value="浏览"/><input type="file"  name="ruleFile" id="ruleFile"/>
												</div>	
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				    				
				    				
				    					<div class="form-group">
											<label class="col-sm-2 control-label">配置参数:</label>
											<div class="col-sm-8">
												<table
												class="table table-bordered float-item-left margin-items-top" id="myTable">
												<thead>
													<tr>
														<th>参数名称</th>
														<th>参数值</th>
													</tr>
												</thead>
												<tbody align="center">
													<c:forEach items="${paramList }" var="p">
														<tr>
															<td><input type="text" id="paramName" name="paramName"
																value="${p.name}" placeholder="请输入参数名称"></td>
															<td>
															<input type="text" id="paramValue" name="paramValue"
																value='${p.matches}' style="width: 300px;" placeholder="请输入参数值"></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>		
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				    					<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则描述:</label>
											<div class="col-sm-8">
												<textarea id="remark" name="remark" rows="5" class="form-control" placeholder="请输入规则描述">${rule.remark }</textarea>	
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
										                 <button id="resetBtn" type="button" class="btn btn-primary margin-items-top">重置</button>
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

<!-- 商家私有配置选择 -->
<script type="text/javascript">
	$(function() {
		$('#returnBtn').click(function() {
			window.location.href="${pageContext.request.contextPath }/listRule";
		})
		
		//选择文件之后触发事件
		$('#ruleFile')
				.change(
						function() {
							var file = $('#ruleFile').val();
							var formData = new FormData($("#ruleFile")[0]);
							if (file.length == 0) {
								alert("用户取消了选择！！！");
							} else {
								$
										.ajaxFileUpload({
											type : "POST",
											url : "${pageContext.request.contextPath}/showParam",
											contentType : "application/json",
											dataType : 'json',
											secureuri : false,
											fileElementId : 'ruleFile',
											success : function(data) {
												var tbody = window.document
														.getElementById("tbody-result");
												var tableHtml = "";
												for (var position = 0; position < data.length; position++) {
													tableHtml += '<tr>'
															+ '<td>'
															+ data[position].name
															+ '</td>'
															+ '<td>'
															+ data[position].matches
															+ '</td>' + '</tr>';
													tbody.innerHTML = tableHtml;
												}
											}
										});
							}
						});
	})
</script>

<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/queryAllAlgorithmTypeList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for ( var i = 0; i < data.length; i++) {
						$("#ruleArithmetic").append(
								'<option id="ruleOption" value="' + data[i].type +'">'
										+ data[i].title + '</option>')
					}
					
					//获取input隐藏域中的值
					var selectOption = $("#ruleArithmeticHidden").val();
					//判断从数据库查出的规则算法是不是和数组中的规则类型一样，如果是一样则设置为选中状态
					//判断从数据库查出的规则算法是不是和数组中的规则类型一样，如果是一样则设置为选中状态
					$("#ruleArithmetic option[value='" + selectOption + "']")
							.attr("selected", "selected");
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
					var selectOption = $("#ruleTypeHidden").val();
					for (var i = 0; i < data.length; i++) {
						if(data[i].id == selectOption){
							$("#ruleTypeTitle").val(data[i].title);
							return;
						}
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
		         //获取input隐藏域中的值
		         var selectOption = $("#riskLevelHidden").val();
		         //判断从数据库查出的规则算法是不是和数组中的规则类型一样，如果是一样则设置为选中状态
		         $("#riskLevel option[value='" + selectOption + "']").attr(
		             "selected", "selected");
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
		$("#editRuleForm").validate({
			invalidHandler : function(form, validator) { //不通过回调
				return false;
			},
			rules : {
				ruleCode : {
					required : true,
					digits : true,				//必须是整数
					maxlength : 30
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
					        },
					        ruleCode: function() {
					        	return $("#ruleCode").val();
					        }
					    }
					}
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
				riskLevel : {
					required : true
				},
				remark : {
					required : true
				}
			},
			messages : {
				ruleCode : {
					required : "请输入规则编码！",
					digits : "请输入整数！",
					maxlength : "规则编码最大长度是30!"
				},
				ruleName : {
					required : "请输入规则名称！",
					remote : "该规则名称已存在！"
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
				riskLevel : {
					required : "请选择风险级别！"
				},
				remark : {
					required : "请输入规则描述信息！"
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
					url : "${pageContext.request.contextPath }/editRule",
					data : $('#editRuleForm').serialize(),// 你的formid
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
											'编辑成功！',
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
											'编辑失败！',
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
	
$("#resetBtn").click(function() {
	window.location.href = "${pageContext.request.contextPath}/showRule?ruleCode=" + $("#ruleCode").val();
});
$("#returnBtn").click(
    function() {
      window.location.href = "${pageContext.request.contextPath}/listRule";
    }
);
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
		
		$("#paramName").change(function() {
			var paramName = $("#paramName").val().replace(/<\/?[^>]*>/g,'');
			$("#paramName").val($.trim(paramName));
		});
		
		$("#paramValue").change(function() {
			//var paramValue = $("#paramValue").val().replace(/<\/?[^>]*>/g,'');
			$("#paramValue").val($.trim($("#paramValue").val()));
		});
	});
</script>
<script>

window.onload=function(){
var file=document.querySelector("#file_css input[type='file']");
var text=document.querySelector("#file_css input[type='text']");
file.addEventListener("change",assign,false);
function assign(){
text.value=file.value;
}
}
</script>
</html>