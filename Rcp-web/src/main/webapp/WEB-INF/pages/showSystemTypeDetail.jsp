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
</head>

<body>
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <h4 class="modal-title" id="myModalLabel">查看公告</h4>
        </div>
        <div class="modal-body">
            <table class="table table-bordered" style="word-wrap: break-word; word-break: break-all;">
                <tbody align="left">
                <tr>
                    <td style="width:20%;">系统名称</td>
                    <td style="width:80%;">${systemType.systemName}</td>
                </tr>
                <tr>
                    <td>启用/禁用</td>
                    <td>${systemType.status}</td>
                </tr>
                <tr>
                    <td>公司地址</td>
                    <td>${systemType.companyAddress}</td>
                </tr>
                <tr>
                    <td>公司域名</td>
                    <td>${systemType.companyDomain}</td>
                </tr>
                <tr>
                    <td>联系人</td>
                    <td>${systemType.contacts}</td>
                </tr>
                <tr>
                    <td>联系人电话</td>
                    <td>${systemType.phoneNumber}</td>
                </tr>
                <tr>
                    <td>联系人邮箱</td>
                    <td>${systemType.email}</td>
                </tr>
                <tr>
                    <td>接入时间</td>
                    <td>${systemType.createTime}</td>
                </tr>
                <tr>
                    <td>系统ID</td>
                    <td><input readonly="readonly" class="form-control" value="${systemType.id}"></input></td>
                </tr>
                <tr>
                    <td style="align:left;">系统Token</td>
                    <td><textarea readonly="readonly" class="form-control" rows="2">${systemType.token}</textarea></td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary"
                    data-dismiss="modal">关闭</button>
            <span id="tip"> </span>
        </div>
    </div>
    <!-- /.modal-content -->
</div>

	
</body>
<script type="text/javascript">

</script>
</html>