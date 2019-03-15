<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp" %>

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
                        <h5>指纹查询</h5>
                    </div>
					<div class="ibox-content">
					<div class="panel admin-panel">
						<div class="body-content">
							
								<form id="fingerParameterForm" method="post">
								
									<div style="margin-top:10px;margin-botton:10px;"><strong><span>设备标识查询与识别</span></strong></div>
									<div style="margin-top:10px;margin-botton:10px;"></div>
									<div style="width:60%;margin-top:10px;margin-botton:10px;">
										<div class="input-group">
											<span class="input-group-addon">设备标识:</span>
											<input type="text" class="form-control" id="fingerId"  name="fingerId" required="required" placeholder="请输入设备标识">			
					    				</div>		    				
				    				</div>
				    				
				    				<div style="margin-top:20px;margin-botton:20px;"></div>
									<div class="btn-toolbar" role="toolbar">
										<div class="btn-group">
										    <button id="submitBtn" type="button" class="btn btn-primary margin-items-top">搜索参数</button>
										</div>
										<div class="btn-group">
										    <button type="button" class="btn disabled">相似度分析</button>
										</div>
									</div>
								</form>
					
									
									<hr />
							<table class="table table-bordered">
								<thead>
									<tr>
										<th>设备ID</th>
										<th>操作IP</th>
										<th>订单号</th>
										<th>订单时间</th>
										<th>商家号</th>
										<th>商家订单号</th>
									</tr>
								</thead>
								<tbody align="center">
									<c:forEach items="${list }" var="order">
									<tr>
										<td>${order.fingerId }</td>
										<td>${order.orderIP }</td>
										<td><a href="#" class="showOrderData" id="${order.orderId }">
											<strong><u>${order.orderId }</u></strong></a></td>
										<td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td>${order.merchantId }</td>
										<td>${order.merchantOrderId }</td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						
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
	$("#submitBtn").click(function() {
		var fingerId = $("#fingerId").val();
		if ('' == fingerId) {
			//tips层
			layer.tips('请输入设备标识！', '#fingerId');
		} else {
			$("#fingerParameterForm").submit();
		}
	})
	
	$(function(){
   $(".showOrderData").click(function() {
      var orderId = this.id;
      var pageUrl = "${pageContext.request.contextPath }/showOrderInfo?orderId=" + orderId;
      var diag = new Dialog();
      diag.Width = 600;
      diag.Height = 650;
      diag.Title = "订单详情";
      diag.URL = pageUrl;
      diag.Drag = false;
      diag.show();
    });
  });
</script>

</html>