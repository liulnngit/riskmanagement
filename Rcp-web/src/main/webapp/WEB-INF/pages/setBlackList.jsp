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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/base64.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-multiselect.js"></script>

</head>

<body>
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <h4 class="modal-title" id="myModalLabel">设置黑名单</h4>
        </div>
        <div class="modal-body">
            <form class="form-horizontal" id="" method="POST" role="form">
                <div class="form-group">
                    <label class="col-sm-2 control-label"><input type="checkbox" name="checkbox" id="checkBoxId" value="checkbox" />投诉人</label>
                </div>
                <div class="hr-line-dashed"></div>

                <div id="complan">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">投诉人:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control"  name=""  value="">

                        </div>
                        <div class="col-sm-2">
                            <input type="checkbox" name="checkbox"  value="checkbox" style="margin-top:10px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">电话:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control"  name=""  value="">

                        </div>
                        <div class="col-sm-2">
                            <input type="checkbox" name="checkbox"  value="checkbox" style="margin-top:10px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control"  name=""  value="">

                        </div>
                        <div class="col-sm-2">
                            <input type="checkbox" name="checkbox"  value="checkbox" style="margin-top:10px;"/>
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label"><input type="checkbox" name="checkbox" id="checkBoxId_1" value="checkbox" />消费者</label>
                </div>
                <div class="hr-line-dashed"></div>

                <div id="complan_1">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">设备指纹:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control"  name=""  value="">

                        </div>
                        <div class="col-sm-2">
                            <input type="checkbox" name="checkbox"  value="checkbox" style="margin-top:10px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">IP地址:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control"  name=""  value="">

                        </div>
                        <div class="col-sm-2">
                            <input type="checkbox" name="checkbox"  value="checkbox" style="margin-top:10px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">银行卡号:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control"  name=""  value="">

                        </div>
                        <div class="col-sm-2">
                            <input type="checkbox" name="checkbox"  value="checkbox" style="margin-top:10px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">电话:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control"  name=""  value="">

                        </div>
                        <div class="col-sm-2">
                            <input type="checkbox" name="checkbox"  value="checkbox" style="margin-top:10px;"/>
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label"><input type="checkbox" name="checkbox" id="checkBoxId_2" value="checkbox" />商家</label>
                </div>
                <div class="hr-line-dashed"></div>

                <div id="complan_2">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">商家号:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control"  name=""  value="">

                        </div>
                        <div class="col-sm-2">
                            <input type="checkbox" name="checkbox"  value="checkbox" style="margin-top:10px;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">商家域名:</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control"  name=""  value="">

                        </div>
                        <div class="col-sm-2">
                            <input type="checkbox" name="checkbox"  value="checkbox" style="margin-top:10px;"/>
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                </div>

                <div class="form-group">

                </div>


            </form>
        </div>
        <div class="modal-footer">
            <div class="btn-toolbar" role="toolbar" style="float:right;">
                <div class="btn-group">
                    <button id="submitBtn" type="submit" class="btn btn-primary margin-items-top">保 存</button>
                </div>
                <div class="btn-group">
                    <button id="resetBtn" type="reset" class="btn btn-primary margin-items-top">重置</button>
                </div>
                <div class="btn-group">
                    <button type="button" class="btn btn-primary"
                            data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <!-- /.modal-content -->
</div>



</body>
<script type="text/javascript">

</script>

<script type="text/javascript">
    $("#complan").hide();
    $("#complan_1").hide();
    $("#complan_2").hide();
    $("#checkBoxId").click(function() {
        if(this.checked){
            $("#complan").show();
        }else{
            $("#complan").hide();
        }
    })
    $("#checkBoxId_1").click(function() {
        if(this.checked){
            $("#complan_1").show();
        }else{
            $("#complan_1").hide();
        }
    })
    $("#checkBoxId_2").click(function() {
        if(this.checked){
            $("#complan_2").show();
        }else{
            $("#complan_2").hide();
        }
    })
</script>


<script type="text/javascript">
    $(document).ready(function() {
        $('#roleSelector').multiselect();
    });
</script>
</html>