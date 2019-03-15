<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit|ie-comp|ie-stand" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit" />
<title>风控系统管理平台</title>
<link rel="icon" href="${pageContext.request.contextPath }/images/logo-dark_new.png" type="image/x-icon" />
<link rel="stylesheet" href="${pageContext.request.contextPath  }/css/pintuer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath  }/css/admin.css">

<script src="${pageContext.request.contextPath  }/js/jquery.js"></script>
<script src="${pageContext.request.contextPath  }/js/pintuer.js"></script>
<script src="${pageContext.request.contextPath }/js/zDrag.js"></script>
<script src="${pageContext.request.contextPath }/js/zDialog.js"></script>
<script src="${pageContext.request.contextPath }/js/reconnecting-websocket.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath }/js/layer.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min14ed.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/font-awesome.min93e3.css">

<link href="${pageContext.request.contextPath }/css/style.min862f.css" rel="stylesheet">
<!--IE8只能支持jQuery1.9-->
<!--[if lte IE 8]>
<script src="${pageContext.request.contextPath  }/js/jquery.1.9.0.js"></script>
<![endif]-->
<script src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath  }/js/pintuer.js"></script>
<script src="${pageContext.request.contextPath }/js/zDrag.js"></script>
<script src="${pageContext.request.contextPath }/js/zDialog.js"></script>

<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath }/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="${pageContext.request.contextPath }/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath }/js/plugins/layer/layer.min.js"></script>
<script src="${pageContext.request.contextPath }/js/hplus.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/contabs.min.js"></script>
<script src="${pageContext.request.contextPath }/js/plugins/pace/pace.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath }/js/layui/css/layui.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/comet4j-0.1.7.js"></script>
<script src="${pageContext.request.contextPath }/js/ajaxfileupload.js"></script>
<script src="${pageContext.request.contextPath }/js/jquery.validate.js"></script>
<style>
.bottom-label {
	position: fixed;
	bottom: 10px;
	right: 30px;
}

.systemTitle {
	font-size: 18px;
	font-weight: bold;
	margin-top: 5px;
}
</style>

<script type="text/javascript">
	$(function() {

		var websocket = null;

		//判断当前浏览器是否支持WebSocket  
		if ('WebSocket' in window) {
			websocket = new WebSocket("wss://rcp.zhiduntech.com/websocket"); //url 需要改成对应系统的
		} else {
			layer.msg('浏览器不支持 webSocket', {
				time : 2000, //2s后自动关闭
			});
			return false;
		}

		var heartCheck = {
			timeout : 6000,//60ms
			timeoutObj : null,
			reset : function() {
				clearTimeout(this.timeoutObj);
				this.start();
			},
			start : function() {
				this.timeoutObj = setTimeout(function() {
					websocket.send("Heartbeat");
				}, this.timeout)
			}
		}

		//连接发生错误的回调方法  
		websocket.onerror = function() {

		};

		//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
		window.onbeforeunload = function() {
			closeWebSocket();
		}

		//连接成功建立的回调方法  
		websocket.onopen = function(event) {
			heartCheck.start();
			layer.msg('消息服务已打开', {
				time : 2000, //2s后自动关闭
			});
			$(".layui-icon").css({
				color : "#FFFFFF"
			});
		}

		//接收消息
		websocket.onmessage = function(event) {

			if (event.data == 'Server HeartBeat') {
				heartCheck.reset();
				return;
			}
			var event = JSON.parse(event.data);
			if (event.channel == 'monitorcenter') {
				layer.msg('监控中心收到预警信息', {
					time : 2000, //2s后自动关闭
				});
				flashMsg();
				var monitorcount = parseInt($("#txtmonitorMsg").val()) + 1;
				$("#txtmonitorMsg").val(monitorcount);
				getMessage();
			} else if (event.channel == 'riskevent') {
				/* var notice = parseInt($("#txtriskEventMsg").val());
				alert(notice);
				if ('' != data && data > 0 && data != notice) {
					layer.msg('您有未处理的流程消息', {
						time : 2000, //2s后自动关闭
					});
					flashMsg();
					var noticecount = data;
					alert(noticecount);
					$("#txtTotalMsg").val(noticecount);
				} else if (null == data || '' == data) {
					layer.msg('您有新的风控事件消息', {
						time : 2000, //2s后自动关闭
					});
					flashMsg();
					var noticecount = parseInt($("#txtriskEventMsg").val()) + 1;
					alert(noticecount);
					$("#txtriskEventMsg").val(noticecount);
				} */
				layer.msg('您有新的风控事件消息', {
					time : 2000, //2s后自动关闭
				});
				flashMsg();
				var riskEventCount = parseInt($("#txtriskEventMsg").val()) + 1;
				$("#txtriskEventMsg").val(riskEventCount);
				getMessage();
			} else if (event.channel == 'news') {
				layer.msg('您有新的公告消息', {
					time : 2000, //2s后自动关闭
				});
				flashMsg();
				var noticecount = parseInt($("#txtnoticeMsg").val()) + 1;
				$("#txtnoticeMsg").val(noticecount);
				getMessage();
			}
		}

		//连接关闭的回调方法  
		websocket.onclose = function() {
			heartCheck.reset();
			layer.msg('消息服务关闭', {
				time : 2000, //2s后自动关闭
			});
			$(".layui-icon").css({
				color : "#FFFFFF"
			});
		}

		//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。  
		window.onbeforeunload = function() {
			websocket.close();
		}
	});
</script>

<script>
	var tag = 0;
	function shake(ele, cls, times) {
		var i = 0, t = false, o = ele.attr("class") + " ", c = "", times = times || 2;
		if (t)
			return;
		t = setInterval(function() {
			i++;
			c = i % 2 ? o + cls : o;
			if (tag == 0) {
				$(".layui-icon").css({
					color : "yellow"
				});
			} else {
				$(".layui-icon").css({
					color : "red"
				});
			}
			if (i == 2 * times) {
				clearInterval(t);
				$(".layui-icon").css({
					color : "#FFFFFF"
				});
			}
			tag = tag == 0 ? 1 : 0;
		}, 1000);
	};
	// http://www.jb51.net Then use the above function as:

	function flashMsg() {
		//$( '.layui-icon' ).flash( '255,0,0', 1000 );
		tag = 0;
		shake($('.layui-icon'), 'red', 5);
	};
</script>

</head>

<body class="fixed-sidebar full-height-layout gray-bg">
	<input type="hidden" name="systemAccount" id="systemAccount" value="${systemAccount}" />
	<input type="hidden" name="adminAccount" id="adminAccount" value="${adminAccount}" />
	<nav class="navbar-default navbar-static-side" role="navigation">

		<div class="sidebar-collapse" style="width: auto; height: 100%;">
			<ul class="nav" id="side-menu-cc">
				<li class="nav-header" style="text-align: center;">
					<div class="dropdown profile-element ">
						<span id="logo_img"></span>
						 <a class="dropdown-toggle toggle_nav_a"
							href="javascript:;"> <span class="clear"> <span class="block m-t-xs"><strong class="font-bold">${account.loginName }</strong></span> <span class="text-muted text-xs block">${account.systemName}<b
									class="caret"></b></span>
						</span>
						</a>
						<ul class="dropdown-menu animated fadeInRight m-t-xs toggle_nav_b" style="display: none; top: 93%;">

							<li><a class="J_menuItem" href="${pageContext.request.contextPath }/toAccountCenterPage?id=${account.id}">用户中心</a></li>
							<li><a class="J_menuItem" href="${pageContext.request.contextPath }/listNotice">公告管理</a></li>
							<li class="divider"></li>
							<li><a href="${pageContext.request.contextPath }/logout">安全退出</a></li>
						</ul>
					</div>
					<div class="logo-element" id="min_logo"></div>
				</li>
				<li class="nav-toggle-a"><a class="J_menuItem" href="${pageContext.request.contextPath }/main"><i class="fa"></i> <span class="nav-label">首页</span></a></li>
				<c:forEach items="${menuList}" var="menu" varStatus="status">
					<c:if test="${menu.parentId == 0}">
						<li class="nav-toggle-a"><a href="javascript:;"><i class="fa"></i> <span class="nav-label">${menu.menuName}</span><span class="fa arrow"></span></a>
							<ul class="nav nav-second-level nav-toggle-b" style="display: none;">
								<c:set var="exitCode" value="0" />
								<c:forEach items="${menuList}" var="subMenu" begin="${status.index+1}">
									<c:if test="${subMenu.parentId == 0}">
										<c:set var="exitCode" value="1" />
									</c:if>
									<c:if test="${exitCode != 1}">
										<li><a class="J_menuItem" href="${pageContext.request.contextPath }${subMenu.linkUrl}" target="right">${subMenu.menuName}</a></li>
									</c:if>
								</c:forEach>
							</ul></li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</nav>
	<script type="text/javascript">
		$(function() {
			var systemAccount = $("#systemAccount").val();
			var adminAccount = $("#adminAccount").val();
			var logo_img = $("#logo_img").val();
			if(systemAccount == "1"){
				$("#logo_img").append('<img alt="请上传LOGO" class="img-circle" src="${pageContext.request.contextPath }/images/logo-dark_new.png" style="width: 70px; height: 70px;" data-toggle="modal" data-target="#uploadModal" />');
				$("#min_logo").append('<img alt="请上传LOGO" class="img-circle" src="${pageContext.request.contextPath }/images/logo-dark_new.png" style="width:28px;height:32px;"  />');
			}else if(adminAccount == "1"){
				$("#logo_img").append('<img alt="请上传LOGO" class="img-circle" src="${pageContext.request.contextPath }/getLogoimg" onerror="this.src=\'${pageContext.request.contextPath }/images/getLogoimg.png\'" style="width: 70px; height: 70px;" data-toggle="modal" data-target="#uploadModal" />');
				$("#min_logo").append('<img alt="请上传LOGO" class="img-circle" src="${pageContext.request.contextPath }/getLogoimg" onerror="this.src=\'${pageContext.request.contextPath }/images/getLogoimg.png\'" style="width:28px;height:32px;"  />');
			}else{
				$("#logo_img").append('<img alt="请上传LOGO" class="img-circle" src="${pageContext.request.contextPath }/getLogoimg" onerror="this.src=\'${pageContext.request.contextPath }/images/getLogoimg.png\'" style="width: 70px; height: 70px;"  />')
				$("#min_logo").append('<img alt="请上传LOGO" class="img-circle" src="${pageContext.request.contextPath }/getLogoimg"  onerror="this.src=\'${pageContext.request.contextPath }/images/getLogoimg.png\'" style="width:28px;height:32px;"  />');
			}
			
			$("#side-menu-cc li span").each(function(index, el) {
				var name = el.innerHTML;

				if (name == '首页') {
					$(this).siblings('i').addClass('fa-home');
				} else if (name == '我的流程') {
					$(this).siblings('i').addClass('fa-columns');
				} else if (name == '设备指纹') {
					$(this).siblings('i').addClass('fa-flask');
				} else if (name == '规则引擎') {
					$(this).siblings('i').addClass('fa-magic');
				} else if (name == '黑名单库') {
					$(this).siblings('i').addClass('fa-file');
				} else if (name == '白名单库') {
					$(this).siblings('i').addClass('fa-file-o');
				} else if (name == '操作日志') {
					$(this).siblings('i').addClass('fa-paste');
				} else if (name == '报表中心') {
					$(this).siblings('i').addClass('fa-bar-chart-o');
				} else if (name == '风险管理') {
					$(this).siblings('i').addClass('fa-bell');
				} else if (name == '关注名单') {
					$(this).siblings('i').addClass('fa-file-text');
				} else if (name == '预警中心') {
					$(this).siblings('i').addClass('fa-warning');
				} else if (name == '基础管理') {
					$(this).siblings('i').addClass('fa-gear');
				} else if (name == '案件管理') {
					$(this).siblings('i').addClass('fa-bars');
				} else if (name == '平台管理') {
					$(this).siblings('i').addClass('fa-bookmark');
				}
			})
		});
	</script>
	<script type="text/javascript">
		$(function() {

			$(".toggle_nav_a").click(function() {
				$(".toggle_nav_b").slideToggle();
			});
			$(".nav-toggle-a").click(
					function() {
						//alert($(this).hasClass('active'));
						$(".toggle_nav_b").slideUp();
						if ($(this).hasClass('active')) {
							$(this).removeClass('active');
						} else {
							$(this).addClass('active').siblings().removeClass(
									'active');
						}

						$(this).siblings().children('ul').slideUp();
						$(this).children('ul').slideToggle();
					});

			$(".nav-toggle-a a").click(function() {
				$('body').removeClass('mini-navbar');
			});
			$(".logo-element").click(function() {
				$('body').removeClass('mini-navbar');
			});

		});
	</script>





	<div id="page-wrapper" class="gray-bg dashbard-1">
		<div class="row border-bottom" style="_position: absolute; _top: expression(offsetParent.scrollTop); _left: expression(offsetParent.scrollLeft);">
			<nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
				<div class="navbar-header">
					<a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="javascript:;"><i class="fa fa-bars"></i> </a>

				</div>
				<ul class="nav navbar-top-links navbar-right">
					<li class="dropdown dropdown1" style="padding-left:50px;"><a id="open" class="dropdown-toggle count-info" data-toggle="dropdown" href="javascript:;"> <i class="fa fa-bell"></i> <span class="label label-primary"
							id="totalNew">0</span>
					</a>
						<ul class="dropdown-menu dropdown-alerts" style="display: none; padding: 10px 0px 3px 0px;">
							<li><a class="J_menuItem SeeList" href="${pageContext.request.contextPath }/listNotice" target="right">
									<div>
										<i class="fa fa-bullhorn fa-fw"></i> 您有<span id="news">0</span>条新公告
										<!-- <span class="pull-right text-muted small">4分钟前</span> -->
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a class="J_menuItem SeeRiskevent" href="${pageContext.request.contextPath }/listToDoTask" target="right">
									<div>
										<i class="fa fa-exclamation-circle fa-fw"></i> <span id="riskeventNew">0</span>条流程信息
										<!-- <span class="pull-right text-muted small">12分钟钱</span> -->
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a class="J_menuItem SeeAlert" href="${pageContext.request.contextPath }/alertCenter" target="right">
									<div>
										<i class="fa fa-exclamation-triangle fa-fw"></i> <span id="monitorNew">0</span>预警中心新信息
										<!-- <span class="pull-right text-muted small">4分钟前</span> -->
									</div>
							</a></li>

						</ul></li>
					<li class="dropdown">
                            <a class=" dropdown-toggle count-info"  href="${pageContext.request.contextPath }/echarts" title="风控系统监控中心">
                                <i class="fa fa-industry"></i>
                            </a>
                     </li>
					<li class="hidden-xs"></li>
					<li class="dropdown hidden-xs dro-right"><a class="right-sidebar-toggle" aria-expanded="false" href="javascript:;"> <i class="fa fa-tasks"></i> 主题
					</a></li>
				</ul>
			</nav>
		</div>
		<script type="text/javascript">
			$(function() {
				$("#open").hover(function() {
					getMessage();
				});
				
				$(".s-skin-1").click(function(){
					
					$('#right-sidebar').removeClass('sidebar-open');
				})
				$(".s-skin-0").click(function(){
					
					$('#right-sidebar').removeClass('sidebar-open');
				})
				$(".s-skin-3").click(function(){
					
					$('#right-sidebar').removeClass('sidebar-open');
				})
				
				$('.SeeList').click(function(){
					$("#txtnoticeMsg").val(0);
					$('#news').text(0);
					getMessage();
				})
				
				$('.SeeRiskevent').click(function(){
					$("#txtriskEventMsg").val(0);
					$('#riskeventNew').text(0);
					getMessage();
				})
				
				$('.SeeAlert').click(function(){
					$("#txtmonitorMsg").val(0);
					$('#monitorNew').text(0);
					getMessage();
				})
			});
			function getMessage() {
				var notice = parseInt($("#txtnoticeMsg").val());
				$('#news').text(notice);
				var riskEvent = parseInt($("#txtriskEventMsg").val());
				$('#riskeventNew').text(riskEvent);
				var monitor = parseInt($("#txtmonitorMsg").val());
				$('#monitorNew').text(monitor);
				var total = notice + riskEvent + monitor;
				$('#totalNew').text(total);
				$(".dropdown1").hover(function() {
					$(this).siblings().children('ul').hide();
					$(this).children('ul').show();
				}, function() {
					$(this).children('ul').hide();
				});
			}
		</script>
		<div class="row content-tabs" style="_position: absolute; _top: expression(offsetParent.scrollTop); _left: expression(offsetParent.scrollLeft);">
			<button class="roll-nav roll-left J_tabLeft">
				<i class="fa fa-backward"></i>
			</button>
			<nav class="page-tabs J_menuTabs">
				<div class="page-tabs-content">
					<a href="javascript:;" class="active J_menuTab" data-id="${pageContext.request.contextPath }/main">首页</a>
				</div>
			</nav>
			<button class="roll-nav roll-right J_tabRight">
				<i class="fa fa-forward"></i>
			</button>
			<div class="btn-group roll-nav roll-right">
				<button class="dropdown J_tabClose close_nav" data-toggle="dropdown">
					关闭操作<span class="caret"></span>

				</button>
				<ul role="menu" class="dropdown-menu dropdown-menu-right">
					<li class="J_tabShowActive"><a>定位当前选项卡</a></li>
					<li class="divider"></li>
					<li class="J_tabCloseAll"><a>关闭全部选项卡</a></li>
					<li class="J_tabCloseOther"><a>关闭其他选项卡</a></li>
				</ul>
			</div>
			<a href="${pageContext.request.contextPath }/logout" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
		</div>
		<div class="row J_mainContent" id="content-main">
			<iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="${pageContext.request.contextPath }/main" frameborder="0" data-id="${pageContext.request.contextPath }/main" seamless></iframe>
		</div>

		<div style="text-align: center;"></div>

		<script type="text/javascript">
			$(function() {
				$('.J_menuItem').click(function(){
					
					$('.J_menuTabs .J_menuTab').each(function (i){
						var o = $(this).data("id");
						var a = '/RiskControlPlatform-web/listNotice';
						var b ='/RiskControlPlatform-web/listToDoTask';
						var c ='/RiskControlPlatform-web/alertCenter';
						//console.log($(this).html());
						if(a == o){
							$(this).html('公告管理 '+'<i class="fa fa-times-circle"></i>');
							
						}
						if(b == o){
							$(this).html('我的待办件 '+'<i class="fa fa-times-circle"></i>');
						}
						if(c == o){
							$(this).html('预警中心 '+'<i class="fa fa-times-circle"></i>');
						}
						

					});
				})
				
			});
		</script>
		<div id="right-sidebar">
			<div class="sidebar-container">

				<ul class="nav nav-tabs navs-3">

					<li class="active"><a data-toggle="tab" href="#tab-1"> <i class="fa fa-gear"></i> 主题
					</a></li>

				</ul>

				<div class="tab-content">
					<div id="tab-1" class="tab-pane active">

						<div class="skin-setttings">

							<div class="title">皮肤选择</div>
							<div class="setings-item default-skin nb">
								<span class="skin-name "> <a href="#" class="s-skin-0"> 默认皮肤 </a>
								</span>
							</div>
							<div class="setings-item blue-skin nb">
								<span class="skin-name "> <a href="#" class="s-skin-1"> 蓝色主题 </a>
								</span>
							</div>
							<div class="setings-item yellow-skin nb">
								<span class="skin-name "> <a href="#" class="s-skin-3"> 黄色/紫色主题 </a>
								</span>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<input type="hidden" id="txtnoticeMsg" name="txtnoticeMsg" value="0" />
	<input type="hidden" id="txtriskEventMsg" name="txtriskEventMsg" value="0" />
	<!-- <input type="hidden" id="txtcomplaintMsg" name="txtcomplaintMsg" value="0"/> -->
	<input type="hidden" id="txtmonitorMsg" name="txtmonitorMsg" value="0" />
	<input type="hidden" id="txtAttentionDelMsg" name="txtAttentionDelMsg" value="0" />
	<input type="hidden" id="txtTotalMsg" name="txtTotalMsg" value="0" />
	<!-- 模态框示例（Modal） -->
					<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title" id="myModalLabel">上传文件</h4>
								</div>
								<form id="uploadFileForm" method="post" enctype="multipart/form-data">
									<div class="modal-body">
										<div id="file_css" style="width:86%;">
											<input type="text" value="未选择文件" id="showText" style="width: 90%;"/><input type="button" value="浏览" style="width: 9%;"/>
											<input id="logoImg" type="file" name="logoImg" 
												onchange="fileChange(this);">
										</div>
										<div style="margin-top: 20px;">
											<input type="reset" class="btn btn-primary" />
										</div>
									</div>
									<div class="modal-footer">
										<span>备注：<font color="red">支持.jpg,.png的上传(最大不能超过100k)</font></span>
										<button id="submitBtn" type="submit" class="btn btn-primary">上传</button>
										<button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
										<span id="tip"> </span>
									</div>
								</form>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal -->
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
			$("#uploadFileForm").validate({
				invalidHandler : function(form, validator) { //不通过回调
					return false;
				},
				rules : {
					logoImg : {
						required : true
					}
				},
				messages : {
					logoImg : {
						required : "请选择要上传的文件！"
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
			var form = new FormData($("#uploadFileForm")[0]);
			$
					.ajax({
						url : "${pageContext.request.contextPath }/uploadSystemTypeLogimg",
						cache : false,
						type : "POST",
						data : form,// 你的formid
						async : false,
						processData : false, // 不处理数据
						contentType : false, // 不设置内容类型
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
												'上传成功！',
												{
													skin : 'layui-layer-molv',
													icon : 1,
													closeBtn : 0,
													btnAlign : 'c', //按钮居中
													anim : 0, //动画类型
													time : 2000,
													end : function() {
														window.location.href = "${pageContext.request.contextPath }/index";
													}
												});
							} else if ("fail" == data.status) {
								layer
										.alert(
												'上传失败！',
												{
													skin : 'layui-layer-molv',
													icon : 5,
													closeBtn : 0,
													btnAlign : 'c', //按钮居中
													anim : 0, //动画类型
													time : 2000,
													end : function() {
														window.location.href = "${pageContext.request.contextPath }/index";
													}
												});
							} else if ("sizeError" == data.fileSize) {
								layer.alert('图片大小不能超过100KB！', {
									skin : 'layui-layer-molv',
									icon : 5,
									closeBtn : 0,
									btnAlign : 'c', //按钮居中
									anim : 0, //动画类型
									time : 2000
								});
							} else if ("typeError" == data.fileType) {
								layer.alert('文件类型错误(类型为JPG或PNG)！', {
									skin : 'layui-layer-molv',
									icon : 5,
									closeBtn : 0,
									btnAlign : 'c', //按钮居中
									anim : 0, //动画类型
									time : 2000
								});
							} else if ("errorWH" == data.errorWH) {
								layer.alert('图片宽度不能超过56，高度不能超过64！', {
									skin : 'layui-layer-molv',
									icon : 5,
									closeBtn : 0,
									btnAlign : 'c', //按钮居中
									anim : 0, //动画类型
									time : 2000
								});
							} 
						}
					});
		}
	})
</script>

<script type="text/javascript">
	var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
	function fileChange(target, id) {
		var fileSize = 0;
		var filetypes = [ ".jpg",".png" ];
		var filepath = target.value;
		var filemaxsize = 100;//5M 
		if (filepath) {
			var isnext = false;
			var fileend = filepath.substring(filepath.lastIndexOf("."));
			if (filetypes && filetypes.length > 0) {
				for (var i = 0; i < filetypes.length; i++) {
					if (filetypes[i] == fileend) {
						isnext = true;
						break;
					}
				}
			}
			if (!isnext) {
				layer.alert('不接受此文件类型！', {
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
			var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
			if (!fileSystem.FileExists(filePath)) {
				layer.alert('附件不存在，请重新输入！', {
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
			layer.alert("附件大小不能大于" + filemaxsize + "kb！", {
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
			layer.alert("附件大小不能为0M！", {
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
	}
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
