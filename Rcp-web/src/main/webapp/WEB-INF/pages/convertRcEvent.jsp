<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
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
                	<div class="ibox-title" id="add">
                        <h5>设为风控事件</h5>
                    </div>
					
					
					<div class="ibox-content">
				    <div class="panel admin-panel">
				      <div class="body-content">
									<form class="form-horizontal" id="convertRcEventForm" method="POST" role="form">
				           <input type="hidden" name="complaintId" value="${complaint.id}">
				           
				           				<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>规则名称:</label>
											<div class="col-sm-8">
												<select name="ruleCode" id="ruleCode" class="form-control">
								                 <option value="">-----请选择-----</option>
								               </select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>支付类型:</label>
											<div class="col-sm-8">
												<select name="payclassId" id="payclassId" class="form-control">
								                 <option value="">-----请选择-----</option>
								               </select>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
								   		<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>商家商户号:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="merchantId" name="merchantId" 
												required="required" placeholder="请输入商家商户号" value="${complaint.merchantId}" readonly="readonly">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				            
				            			<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>商家订单号:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="orderId" name="orderId" 
												required="required" placeholder="请输入商家订单号" value="${complaint.merchantOrderId}" readonly="readonly">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
									
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>风险级别:</label>
											<div class="col-sm-8">
												<input type="text" class="form-control" id="riskLevelTitle" name="riskLevelTitle" readonly="readonly">
											</div>
											<input type="hidden" name="riskLevel" id="riskLevel" /> 
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>描述:</label>
											<div class="col-sm-8">
												<textarea id="remark" name="remark" class="form-control" rows="5" placeholder="请输入描述信息"></textarea>
											</div>
											
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											
											<div class="col-sm-4 col-sm-offset-2">
												<div class="btn-toolbar" role="toolbar">
											<div class="btn-group">
												<button id="submitBtn" type="submit" class="btn btn-primary margin-items-top">确定</button>
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
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/queryListRuleParameterVo",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#ruleCode").append(
								'<option value="' + data[i].ruleCode +'">' + data[i].ruleName
										+ '</option>')
					}
				}
			}
		});
		
		$.ajax({
			url : "${pageContext.request.contextPath}/queryPayclassList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for ( var i = 0; i < data.length; i++) {
						$("#payclassId").append(
								'<option value="' + data[i].id +'">' + data[i].name
										+ '</option>')
					}
				}
			}
		});
		
		$("#ruleCode").change(function() {
      var ruleCode = $("#ruleCode").val();
      $("#riskLevel").val("");
      $("#riskLevelTitle").val("");
      if(null != ruleCode && "" != ruleCode){
          $.ajax({
            url : "${pageContext.request.contextPath}/queryRuleParameterByRuleCode?ruleCode="
                + ruleCode,
            type : "GET",
            contentType : "application/json",
            dataType : "json",
            success : function(data) {
            	if (null != data) {
            		  $("#riskLevel").val(data.riskLevel);
            		  $("#riskLevelTitle").val(data.riskLevelPo.title);
                }
              }
          });
      }
    });
		
		$.validator.setDefaults({
      submitHandler : function(form) {
        ajaxSubmitForm();
      }
    });
		
		$(function() {
     // 在键盘按下并释放及提交后验证提交表单
     $("#convertRcEventForm").validate({
       invalidHandler : function(form, validator) { //不通过回调
         return false;
       },
       rules : {
    	   ruleCode : {
 	          required : true
 	        },
	       payclassId : {
	            required : true
	          },
	       merchantId : {
             required : true
           },
         orderId : {
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
           required : "请选择规则名称！"
         },
         payclassId : {
           required : "请选择支付类型！"
         },
         merchantId : {
           maxlength : "请输入商家号！"
         },
         orderId : {
           required : "请输入商家订单号！"
         },
         riskLevel : {
           required : "请选择风险级别！"
         },
         remark : {
             required : "请输入描述信息！"
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
      $
        .ajax({
          cache : false,
          type : "POST",
          url : "${pageContext.request.contextPath }/convertRcEvent",
          data : $('#convertRcEventForm').serialize(),// 你的formid
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
                          window.location.href = "${pageContext.request.contextPath }/listComplaint";
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
                          window.location.href = "${pageContext.request.contextPath }/listComplaint";
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
		$("#returnBtn").click(function() {
			window.location.href = "${pageContext.request.contextPath }/listComplaint";
		})
	});
</script>

<script type="text/javascript">
	$(function() {
		$("#remark").change(function() {
			var remark = $("#remark").val().replace(/<\/?[^>]*>/g,'');
			$("#remark").val($.trim(remark));
		});
	})
</script>

</html>