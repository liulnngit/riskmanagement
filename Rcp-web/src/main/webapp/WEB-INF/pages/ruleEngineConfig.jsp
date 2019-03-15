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
	                        <h5>查看配置</h5>
	                    </div>
						<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="btn-group" id="toolbar">
											<button type="button" class="btn btn-primary margin-items-top"
												id="addBtn">下载</button>
											<button type="button" class="btn btn-primary margin-items-top"
												id="editRuleType">打印</button>
											<!-- <button type="button" class="btn btn-primary margin-items-top"
												id="deleteBtn">保存</button> -->
											<button type="button" class="btn btn-primary margin-items-top"
												id="returnBtn">返回</button>
							</div>
							<div class="body-content">
									<div style="margin-left: 0px;">
										<div style="margin-right: 0px; margin-top: 10px;">
										<form style="margin-left: 0px;" action="" method="post">
											<textarea rows="30" cols="150" disabled="disabled">${ruleFileContent }</textarea>
										</form>
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
$("#returnBtn").click(
    function() {
      window.location.href = "${pageContext.request.contextPath}/listRule";
    }
);
</script>
</html>