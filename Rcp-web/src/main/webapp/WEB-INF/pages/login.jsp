<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>登录</title>
<link rel="icon"
	href="${pageContext.request.contextPath }/images/logo-dark_new.png"
	type="image/x-icon" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath  }/css/pintuer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath  }/css/admin.css">
<script src="${pageContext.request.contextPath  }/js/jquery.js"></script>
<script src="${pageContext.request.contextPath  }/js/pintuer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/base64.js"></script>

<style type="text/css">  
#capital{  
  color:#F90;  
  padding:2px;   
  position:absolute;  
} 
.xm4-move{
margin-left: 33.33333333%;
}
.form-group{
	margin-bottom:15px;
	padding-bottom:0px;
} 
.input-big, .form-big .input, .form-big .button{
	font-size:14px;
	line-height: 14px;
} 
.button.border-main,.button.bg-main{
	    border-color: #298898;
    color: #fff;
    background-color: #298898;
}
.button.border-main:hover, .button.border-main:focus, .button.bg-main:hover, .button.bg-main:focus{
	    border-color: #298898;
    color: #fff;
    background-color: #298898;
}
html,body{
	 height:100%;
	background:#fff; 
} 
</style>
<script type="text/javascript"> 
	if (window != top){
		top.location.href = location.href; 
	}
	
	/* 检测输入框的大小写是否开启 */  
	window.onload=function(){  
	  function isIE(){   
	    if(!!window.ActiveXObject || "ActiveXObject" in window){   
	      return true;   
	    }     
	    else{   
	     return false;   
	    }   
	  }   
	  (function(){   
	    var inputPWD=document.getElementById('password');   
	    var capital=false;   
	    var capitalTip={   
	      elem:document.getElementById('capital'),   
	      toggle:function(s){   
	        var sy=this.elem.style;   
	        var d=sy.display;   
	        if(s){   
	          sy.display = s;   
	        }  
	        else{   
	          sy.display=d=='none'?'':'none';   
	        }   
	      }   
	    }   
	    var detectCapsLock=function(event){   
	      if(capital){return};   
	      var e = event||window.event;   
	      var keyCode = e.keyCode||e.which;  
	      var isShift = e.shiftKey ||(keyCode == 16 ) || false ;  
	      if(((keyCode>=65&&keyCode<=90 )&&!isShift)||((keyCode>=97&&keyCode<=122 )&&isShift)){  
	        capitalTip.toggle('block');  
	        capital=true  
	      }   
	      else{  
	        capitalTip.toggle('none');  
	      }   
	    }   
	    if(!isIE()){  
	      inputPWD.onkeypress=detectCapsLock;   
	      inputPWD.onkeyup=function(event){   
	        var e = event||window.event;   
	        if(e.keyCode == 20 && capital){   
	          capitalTip.toggle();   
	          return false;   
	        }   
	      }   
	   }  
	  })()  
	}
</script>
<!--IE8只能支持jQuery1.9-->
<!--[if lte IE 8]>
<script src="${pageContext.request.contextPath  }/js/jquery.1.9.0.js"></script>
<![endif]-->
</head>
<body>
	<div class="bg" style="border-bottom:1px solid #ccc;border-top:1px solid #ccc;box-shadow: 1px 1px 1px #ccc inset;"></div>
	<div class="container">
		<div class="line">
			<div class="logo margin-big-left" style="z-index: 2;">
				<h1 class="systemTitle" style="color:#000;">
					<img src="images/logo.png"
						class="radius-circle rotate-hover" height="55" alt="" />
				</h1>
			</div>
			<div class="login-right" style="z-index: 2;">
				<a href="/">风控系统管理平台</a>
				<span>|</span>
				<a href="http://www.tech.com/about.html?id=lxwm" target="_blank">联系我们</a>
				<span>|</span>
				<a href="#">登录</a>
				<span>|</span>
				<a href="#">注册</a>
			</div>
			<div class="xs6 xm4 xs3-move xm4-move" style="z-index: 2;">
				<div style="height: 153px;height:240px\0;"></div>
				<div class="media media-y margin-big-bottom"></div>
				<form id="loginForm" action="login" method="post">
					<div class="panel loginbox" style="background: rgba(255, 255, 255, 0.9);">
						<div class="text-center margin-big padding-big-top">
							<h1>风控系统管理平台</h1>
							<br /> <font color="red"><h4>${message}</h4></font>
						</div>
						<div class="panel-body"
							style="padding: 30px; padding-bottom: 10px; padding-top: 10px;">
							<div class="form-group">
								<div class="field field-icon-right">
									<input type="text" class="input input-big" id="username" name="username" value="${rUserName}" onpaste="return false" 
										onselectstart="return false"
										placeholder="账号" data-validate="required:请填写账号" style="padding-left: 41px;border: 1px solid #ddd;" oninput="showBtn()" onpropertychange="showBtn()" />  <span
										class="icon icon-user margin-small"></span> <span class="clear-btn" id="clearBtn" onClick="clearText();" style="display:none;">X</span>
								</div>
							</div>
							<div class="form-group">
								<div class="field field-icon-right">
									<input type="password" class="input input-big" id="password" 
										name="password" value="${rPassword}"  onpaste="return false" 
										onselectstart="return false"
										placeholder="密码" data-validate="required:请填写密码" style="padding-left: 41px;    border: 1px solid #ddd;" oninput="showBtn2()" onpropertychange="showBtn2()"/> <span
										class="icon icon-key margin-small"></span> <span class="clear-btn" id="clearBtn2" onClick="clearText2();" style="display:none;">X</span>
										<div id="capital" style="display:none;">大写锁定已开启</div>
								</div>
							</div>
							<div class="form-group">
								<div class="field">
									<input type="text" class="input input-big" id="code" name="code"
										placeholder="验证码" data-validate="required:请填写右侧的验证码" style="padding-left: 15px;border: 1px solid #ddd;" onKeyUp="showBtn1()"/><span class="clear-btn" id="clearBtn1" onClick="clearText1();" style="right:102px;display:none;">X</span>
									<img id="img" src="${pageContext.request.contextPath}/code" alt="验证码" width="100" height="33"
										class="passcode" style="height: 32px; cursor: pointer;"
										>

								</div>
							</div>
						</div>
						<div style="padding: 30px;padding-top: 0;">
							<button id="submitBtn" type="button"
								class="button button-block bg-main text-big input-big"
								>登录</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div id="footer">		
		 <div class="center">
				<div class="line">
					<div class="footer-left">
						<div class="phone" ><a href="tel:4009319899"></a></div>
						<h4>咨询热线</h4>
						<a class="tel" href="tel:4009319899">400-9319-899</a>
						<div class="">
							<i></i>
							<span>智盾APP</span>
						</div>
						<div class="">
							<i></i>
							<span>微信公众号</span>
						</div>
					</div>
					<ul class="footer-right none_mob">
						<li >
							<a href="http://www.zhiduntech.com/product.html?id=zfxt3" target="_blank">支付3.0系统</a>
						</li>
						<li >
							<a href="http://www.zhiduntech.com/product.html?id=jhzf" target="_blank">聚合支付系统</a>
						</li>
						<li>
							<a href="http://www.zhiduntech.com/about.html?id=qyjj" target="_blank">关于我们</a>
						</li>
						<li>
							<a href="http://www.zhiduntech.com/about.html?id=lxwm" target="_blank">联系我们</a>
						</li>
						<li>
							<a href="http://www.zhiduntech.com/product.html" target="_blank">更多产品 >></a>
						</li>
					</ul>
					<div class="cl"></div>
				</div>

				<div class="cl"></div>			
			</div>
			<p class="center">
			©  深圳智盾信息技术有限公司  粤ICP备17054332-1
			</p>
		</div>

</body>

<script type="text/javascript">
	$(function() {
		$("#img").click(function(){
            $(this).attr("src","${pageContext.request.contextPath}/code?a="+new Date().getMilliseconds());    
        });
	});
</script>
 
<script>
   function showBtn1(){
		if(document.getElementById('code').value.length > 0){
			$('#clearBtn1').show();
			//document.getElementById('clearBtn').style.display = 'block';
		}else{
			$('#clearBtn1').hide();
			//document.getElementById('clearBtn').style.display = 'none';
		}
	}
	function showBtn(){
		if(document.getElementById('username').value.length > 0){
			$('#clearBtn').show();
			//document.getElementById('clearBtn').style.display = 'block';
		}else{
			$('#clearBtn').hide();
			//document.getElementById('clearBtn').style.display = 'none';
		}
	}
	function showBtn2(){
		if(document.getElementById('password').value.length > 0){
			$('#clearBtn2').show();
			//document.getElementById('clearBtn').style.display = 'block';
		}else{
			$('#clearBtn2').hide();
			//document.getElementById('clearBtn').style.display = 'none';
		}
	}
	function clearText(){
		document.getElementById('username').value = '';
		$('#clearBtn').hide();
	}
	function clearText1(){
		document.getElementById('code').value = '';
		$('#clearBtn1').hide();
	}
	function clearText2(){
		document.getElementById('password').value = '';
		$('#clearBtn2').hide();
	}
</script>
<script type="text/javascript">
	$(function() {
		$("#username").blur(function() {
			$("#username").val($.trim($("#username").val()));
		});
		
		$("#password").blur(function() {
			var pwd = $.trim($("#password").val());
			$("#password").val(pwd);
		});
		
		$("#code").blur(function() {
			$("#code").val($.trim($("#code").val()));
		});
		
		function getData(str) {
		    return btoa(encodeURIComponent(str).replace(/%([0-9A-F]{2})/g, function(match, p1) {
		        return String.fromCharCode('0x' + p1);
		    }));
		}
		
		$("#submitBtn").click(function() {
			var pwd = $("#password").val();
			$("#password").val(getData(pwd));
			$("#loginForm").submit();
			
		});
		
		document.onkeydown = function(e){ 
		    var ev = document.all ? window.event : e;
		    if(ev.keyCode==13) {
		    	var pwd = $("#password").val();
				$("#password").val(getData(pwd));
				$("#loginForm").submit();

		     }
		}
	})
</script>

</html>