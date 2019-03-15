<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>风控系统管理平台</title>
<link rel="icon"
	href="${pageContext.request.contextPath }/images/logo-dark_new.png"
	type="image/x-icon" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath  }/css/bootstrap.css"></link>
<link rel="stylesheet"
	href="${pageContext.request.contextPath  }/css/bootstrap-theme.css"></link>
<link rel="stylesheet"
	href="${pageContext.request.contextPath  }/css/main.css"></link>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/bootstrap.min14ed.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/font-awesome.min93e3.css">

<link href="${pageContext.request.contextPath }/css/style.min862f.css"
	rel="stylesheet">
<script type="text/javascript"
	src="${pageContext.request.contextPath  }/js/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath  }/js/bootstrap.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath  }/js/gallery/vendors/echarts/echarts-all-3.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath  }/js/gallery/vendors/echarts-stat/ecStat.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath  }/js/gallery/vendors/echarts/extension/dataTool.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath  }/js/gallery/vendors/echarts/map/js/china.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath  }/js/gallery/vendors/echarts/map/js/world.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath  }/js/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script
	src="${pageContext.request.contextPath  }/echarts_map/build/dist/echarts.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath  }/js/jqueryNumber.min.js"></script>


</head>
<body class="wrap">
	<!--四个角-->
	<div id="tl" class="kuang">
		<img src="images/tl.png" />
	</div>
	<div id="tr" class="kuang">
		<img src="images/tr.png" />
	</div>
	<div id="bl" class="kuang">
		<img src="images/bl.png" />
	</div>
	<div id="br" class="kuang">
		<img src="images/br.png" />
	</div>



	<!--柱形图-->
	<div id="columnBox">
		<div id="column" style="width: 90%; height: 100%;" data-attr="交易趋势图">
		</div>

		<div id="column2" style="width: 90%; height: 100%;">
			<div class="m4">
				<h4>订单总数</h4>
				<p>
					<span class="t_num"></span>笔
				</p>
				<s></s>
			</div>
			<div class="m4">
				<h4>风险事件</h4>
				<p>
					<span class="t_num1"></span>笔
				</p>
				<s></s>
			</div>
			<div class="m4">
				<h4>投诉事件</h4>
				<p>
					<span class="t_num2"></span><span>笔<span>
				</p>
				<s></s>
			</div>
			<script type="text/javascript"
				src="${pageContext.request.contextPath  }/js/animateBackground-plugin.js"></script>
		</div>

	</div>

	<div class="content_left_3">
		<table class="table" style="margin-bottom: 0px;">
			<tr></tr>
			<tr>
				<td style="width: 40%;text-align: center;">商家号</td>
				<td style="width: 40%;text-align: center;">订单号</td>
				<td style="text-align: center;">交易金额</td>
			</tr>
		</table>
		<div id="cdemo">
			<div id="cdemo1">
				<table class="table" id="highData" style="margin-bottom:0;">

				</table>
			</div>
			<div id="cdemo2"></div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			getHighData();
			function getHighData() {
				$.ajax({
					url : '${pageContext.request.contextPath }/getHighData',
					type : 'get',
					dataType : 'json',
					success : function(result) {
						if (result.length > 0) {
							var tbody = window.document
									.getElementById("highData");
							var tableHtml = "";
							tbody.innerHTML = "";
							for (var i = 0; i < result.length; i++) {

								tableHtml += '<tr>' + '<td style="width:40%;text-align: center;">'
										+ result[i].merchantId + '</td>'
										+ '<td style="width:40%;text-align: center;">'
										+ result[i].orderId + '</td>' + '<td style="text-align: center;">￥'
										+ result[i].txMoney + '</tr>';
								tbody.innerHTML = tableHtml;
							}
							if(result.length >5){
								cdemo2.innerHTML = cdemo1.innerHTML;
							}
						}
					}
				});
			}
			setInterval(getHighData, 1000 * 60 * 1);
		});
	</script>
	<!--饼图-->
	<div id="pieBox">
		<div id="pie" style="width: 100%; height: 90%;"></div>

	</div>
	<div class="content_right_2">
		<div id="main6" style="width: 50%; height: 90%;"></div>
		<div id="main3" style="width: 50%; height: 90%;"></div>
		<script type="text/javascript"
			src="${pageContext.request.contextPath  }/js/echarts.main.js"></script>
	</div>
	<!--地图-->
	<div id="map_content">
		<div id="map" style="height: 70%;"></div>
	</div>




	<!--时间-->
	<div class="mapContent">
		<p style="font-size: 24px; color: #fff;">${account.systemName}监控中心</p>
		<p class="time" id="Date"></p>

		<div id="container">
			<div class="flip">
				<div class="price-icon">￥</div>
				<div class="price-div">
					<div class="t-l number"></div>
					<div class="l number"></div>
					<div class="comma sign">,</div>
					<div class="h-k number"></div>
					<div class="t-k number"></div>
					<div class="k number"></div>
					<div class="comma sign">,</div>
					<div class="h number"></div>
					<div class="t number"></div>
					<div class="single number"></div>
					<div class="sign dot">.</div>
					<div class="t-d number"></div>
					<div class="h-d number"></div>
				</div>
				<div class="price-icon"
					style="width: 65px; font-size: 30px; height: 60px; line-height: 60px;">万元</div>
				<script type="text/javascript"
					src="${pageContext.request.contextPath  }/js/number.js"></script>
			</div>
		</div>

	</div>

	<!--点状图-->
	<div id="spotBox">

		<ul>
			<li><span style="background: #4169e1"></span>低I</li>
			<li><span style="background: #0000ff"></span>低II</li>
			<li><span style="background: #00fa9a"></span>低III</li>
			<li><span style="background: #00bc00"></span>中I</li>
			<li><span style="background: #f75000"></span>中II</li>
			<li><span style="background: #ffd00a"></span>中III</li>
			<li><span style="background: #e505e1"></span>高I</li>
			<li><span style="background: #ff0082"></span>高II</li>
			<li><span style="background: #ee0000"></span>高III</li>
		</ul>

	</div>

	<!--客户数据-->
	<div class="dataBox">
		<table class="table" style="margin-bottom: 0px;">
			<tr></tr>
			<tr>
				<td style="width: 25%;text-align: center;">商家号</td>
				<td style="width: 25%;text-align: center;">订单号</td>
				<td style="width: 15%;text-align: center;">风险级别</td>
				<td style="width: 10%;text-align: left;">区域</td>
				<td style="width: 10%;text-align: center;">时间</td>
			</tr>
		</table>
		<div id="rdemo">
			<div id="rdemo1">
				<table class="table" id="riskData" style="margin-bottom:0;">

				</table>
			</div>
			<div id="rdemo2"></div>
		</div>
		<script type="text/javascript">
			$(function() {
				getRiskData();
				function getRiskData() {
					$
							.ajax({
								url : '${pageContext.request.contextPath }/getDynamicRiskData',
								type : 'get',
								dataType : 'json',
								success : function(result) {
									var tbody1 = window.document
											.getElementById("riskData");
									var tableHtml1 = "";
									tbody1.innerHTM = "";
									if (result.length > 0) {
										for (var i = 0; i < result.length; i++) {
											tableHtml1 += '<tr>'
													+ '<td style="width:25%;text-align: center;">'
													+ result[i].merchantId
													+ '</td>'
													+ '<td style="width:25%;text-align: center;">'
													+ result[i].orderId
													+ '</td>'
													+ '<td style="width:15%;text-align: center;">'
													+ result[i].riskLevel
													+ '</td>' + '<td style="width:10%;text-align: center;">'
													+ result[i].zone + '</td>'
													+ '<td style="width:10%;text-align: center;">' + result[i].date
													+ '</td>' + '</tr>';
											tbody1.innerHTML = tableHtml1;
										}
									} else {
										tbody1.innerHTML = "";
									}
									if(result.length >5){
										rdemo2.innerHTML = rdemo1.innerHTML;
									}
								}
							});
				}
				setInterval(getRiskData, 1000 * 60 * 1);
			});
		</script>
	</div>
	<div class="gohome">
		<a class="animated bounceInUp"
			href="${pageContext.request.contextPath }/index" title="返回首页"> <i
			class="fa fa-home"></i>
		</a>
	</div>
	<script type="text/javascript">
		//alert('1');
		//var b = $('.counter').html();
		//alert(b)
		setInterval(function() {
			$('.counter').html(
					parseFloat(Math.random() * 1000000).toLocaleString());
		}, 1000)
	</script>
	<script type="text/javascript">
		window.onload = function() {
			setInterval(function() {
				var date = new Date();
				var year = date.getFullYear(); //获取当前年份
				var mon = date.getMonth() + 1; //获取当前月份
				var da = date.getDate(); //获取当前日
				var h = date.getHours(); //获取小时
				var m = date.getMinutes(); //获取分钟
				var s = date.getSeconds(); //获取秒
				var d = document.getElementById('Date');
				d.innerHTML = year + '-' + mon + '-' + da + ' ' + h + ':' + m
						+ ':' + s;
			}, 1000)
		}
	</script>
	<script type="text/javascript">
		var speed = 100;
		function Marquee() {
			if (rdemo2.offsetTop-rdemo.scrollTop<=0) {
				rdemo.scrollTop -= rdemo1.offsetHeight;
			} else {
				rdemo.scrollTop++;
			}
		}
	
		var MyMar = setInterval(Marquee, speed);
		rdemo.onmouseover = function() {
			clearInterval(MyMar);
		}
		rdemo.onmouseout = function() {
			MyMar = setInterval(Marquee, speed);
		} 
	</script>
	
	<script type="text/javascript">
		var speed = 100;
		
		function Marquee1() {
			if (cdemo2.offsetTop-cdemo.scrollTop<=0) {
				cdemo.scrollTop -= cdemo1.offsetHeight;
			} else {
				cdemo.scrollTop++;
			}
		}
		var MyMar1 = setInterval(Marquee1, speed);
		cdemo.onmouseover = function() {
			clearInterval(MyMar1);
		}
		cdemo.onmouseout = function() {
			MyMar1 = setInterval(Marquee1, speed);
		}
	</script>
</body>
</html>