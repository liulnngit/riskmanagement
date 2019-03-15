<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
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
	                        <h5>指纹参数</h5>
	                    </div>
						<div class="ibox-content">
						<div class="panel admin-panel">
						<div class="body-content">
							
								<form id="fingerParameterForm" method="post">
								
									<div style="margin-top:10px;margin-botton:10px;"><strong><span>参数权重分配</span></strong></div>
									<div style="margin-top:10px;margin-botton:10px;"></div>
									<div>
										<table class="table table-bordered">
										<tbody>
											<tr>
												<td><input type="checkbox" value=""/>User Agent  --- 5%</td>
												<td><input type="checkbox" value=""/>语言 --- 8%</td>
												<td><input type="checkbox" value=""/>颜色深度</td>
												<td><input type="checkbox" value=""/>屏幕分辨率</td>
												<td><input type="checkbox" value=""/>是否具有会话存储</td>
												<td><input type="checkbox" value=""/>是否DoNotTrack</td>
												<td><input type="checkbox" value=""/>平台</td>
												<td><input type="checkbox" value=""/>CPU类</td>
												<td><input type="checkbox" value=""/>是否有打开的DB</td>
												<td><input type="checkbox" value=""/>CPU类</td>
												<td><input type="checkbox" value=""/>是否有打开的DB</td>
											</tr>
										</tbody>
									</table>
									</div>
									
									<div style="margin-top:20px;margin-botton:20px;"></div>
									<div class="btn-group">
										<input id="submitBtn" type="submit" class="btn disabled" value="确定">
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

</html>