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

<script type="text/javascript">
	
</script>

</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>重置密码</h5>
                    </div>
                    <div class="ibox-content">
					<div class="panel admin-panel">
						<div class="body-content">
							<c:if test="${'success' == status}">
								<form class="form-horizontal" id="resetPasswordForm" method="POST" role="form">
									<input type="hidden" id="id" name="id" value="${account.id }">
									<input type="hidden" id="sid" name="sid" value="${sid }">
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>登录密码:</label>
											<div class="col-sm-8">
												<input type="password" class="form-control" id="password" name="password" required="required" placeholder="请输入登录密码">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
									  	<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>确认密码:</label>
											<div class="col-sm-8">
												<input type="password" class="form-control" id="rePassword" name="rePassword" required="required" placeholder="请输入确认密码">
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
									                  <button id="clearBtn" type="button" class="btn btn-primary">清空</button>
									                </div>
									              </div>
											</div>
										</div>
				              
									</div>
								</form>
							</c:if>
							<c:if test="${'error' == status}">
				         <span>${msg}</span>
				      </c:if>
								<div>
									<input name="roles" type="hidden" id="roles" value="${roleId }">
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
	$.validator.setDefaults({
     submitHandler : function(form) {
       ajaxSubmitForm();
     }
   });
	
	$(function() {
	      // 在键盘按下并释放及提交后验证提交表单
	      $("#resetPasswordForm").validate({
	        invalidHandler : function(form, validator) { //不通过回调
	          return false;
	        },

	        rules : {
	        	password : {
	            required : true,
	            rangelength : [ 5, 15 ]
	          },
	          rePassword : { //密码2的描述多于1项使用对象类型 
	            required : true, //必填，这里可以是一个匿名方法 
	            equalTo : "#password", //必须与密码1相等 
	            rangelength : [ 5, 15 ]
	          //长度5-10之间 
	          //regex : "^\\w+$" //使用自定义的验证规则 
	          }
	        },
	        messages : {
	        	password : {
	            required : "密码不能为空！",
	            rangelength : "密码长度为5~15位！"
	          },
	          rePassword : {
	            required : "确认密码不能为空！",
	            equalTo : "两次密码输入不一致！",
	            rangelength : "密码长度为5~15位！"
	          //regex : "密码只能是数字、字母与下划线"
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
	            url : "${pageContext.request.contextPath}/resetPassword",
	            type : "POST",
	            cache : false,
	            async : false,
	            dataType : "json",
	            data : $("#resetPasswordForm").serialize(),
	            erro : function(request) {
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
	                        '重置成功！',
	                        {
	                          skin : 'layui-layer-molv',
	                          icon : 1,
	                          closeBtn : 0,
	                          btnAlign : 'c', //按钮居中
	                          anim : 0, //动画类型
	                          time : 2000,
	                          end : function() {
	                            window.location.href = "${pageContext.request.contextPath }/login";
	                          } 
	                        });
	              //后端响应后放开按钮
					$("#submitBtn").removeAttr("disabled");
	              return;
	              } else {
	                layer
	                    .alert(
	                        '重置失败！',
	                        {
	                          skin : 'layui-layer-molv',
	                          icon : 5,
	                          closeBtn : 0,
	                          btnAlign : 'c', //按钮居中
	                          anim : 0, //动画类型
	                          time : 2000
	                        });
	              //后端响应后放开按钮
					$("#submitBtn").removeAttr("disabled");
	              return;
	              }
	            }
	          });
	    }
    
		$("#clearBtn").click(
			function() {
			  $("#password").val("");
			  $("#rePassword").val("");
			}
		);
});
  
</script>

</html>