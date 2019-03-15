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
<%@ include file="../commons/sourceFile.jsp"%>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>流程列表</h5>
                    </div>
					<div class="ibox-content">
					<div class="panel admin-panel">
						<div class="btn-group" id="toolbar">
						  <shiro:hasRole name="Administrator">
								<button type="button" class="btn btn-primary margin-items-top"
									id="opendUploadBtn" data-toggle="modal" data-target="#uploadModal">上传文件</button>
						  </shiro:hasRole>
							<!-- <button type="button" class="btn btn-primary margin-items-top"
								id="selectRoleBtn" data-toggle="modal" data-target="#roleModal">候选启动</button>	 -->
						</div>
						<div class="body-content">
							
									<table id="tb_listWorkflow"></table>
								
						</div>
					</div>
				
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
										<div style="width: 60%; margin-top: 10px; margin-botton: 10px;">
											<div class="input-group">
												<span class="input-group-addon">流程名称:</span> <input id="processName"
													name="processName" class="form-control" type="text"
													style="width: 160%;" placeholder="请输入流程名称" />
											</div>
										</div>
										<div id="file_css" style="margin-top: 10px; margin-botton: 10px;width:86%;">
											<input type="text" value="未选择文件" id="showText" style="width: 90%;"/><input type="button" value="浏览" style="width: 9%;"/><input id="processFile" type="file" name="processFile" onchange="fileChange(this);">
										</div>
										
										<div style="margin-top: 20px;">
											<input type="reset" class="btn btn-primary"/>
										</div>
								</div>
								<div class="modal-footer">
									
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
					
					<!-- 模态框示例（Modal） -->
					<div class="modal fade" id="roleModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h1 class="modal-title" id="myModalLabel">设置候选角色</h1>
								</div>
								<div class="modal-body">
									<form id="uploadFileForm" action="deployWorkFlow" method="post"
										enctype="multipart/form-data">
										<div style="width: 60%; margin-top: 10px; margin-botton: 10px;">
											<div class="input-group">
												<span class="input-group-addon">候选角色</span> 
												<select id="groupArr" name="groupArr" class="form-control">
													<option value="">-----请选择角色-----</option>
												</select>
											</div>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button id="uploadBtn" type="submit" class="btn btn-primary">确定</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
									<span id="tip"> </span>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal -->
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

		//1.初始化Table
		var oTable = new TableInit();
		oTable.Init();

		//$('#tb_listWorkflow').bootstrapTable('hideColumn', 'id');//隐藏某一列

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_listWorkflow')
					.bootstrapTable(
							{
								url : '${pageContext.request.contextPath }/getListWorkflow', //请求后台的URL（*）
								method : 'get', //请求方式（*）
								toolbar : '#toolbar', //工具按钮用哪个容器
								striped : true, //是否显示行间隔色
								cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
								pagination : true, //是否显示分页（*）
								sortable : false, //是否启用排序
								//sortOrder : "asc", //排序方式
								sidePagination : "client", //分页方式：client客户端分页，server服务端分页（*）
								pageNumber : 1, //初始化加载第一页，默认第一页
								pageSize : 10, //每页的记录行数（*）
								pageList : [ 10, 25, 50, 100 ], //可供选择的每页的行数（*）
								//search : true, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
								//strictSearch : true,
								//showColumns : true, //是否显示所有的列
								//showRefresh : true, //是否显示刷新按钮
								minimumCountColumns : 2, //最少允许的列数
								clickToSelect : true, //是否启用点击选中行
								smartDisplay : false,//智能显示分页按钮
								escape : true,
								paginationPreText : "上一页",
								paginationNextText : "下一页",
								//height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
								uniqueId : "id", //每一行的唯一标识，一般为主键列
								//showToggle : true, //是否显示详细视图和列表视图的切换按钮
								//cardView : false, //是否显示详细视图
								//detailView : false, //是否显示父子表
								singleSelect : true, //禁止多选
								undefinedText : "",
								columns : [
										{
											checkbox : true,
											align : 'center'
										},
										{
											field : 'id',
											title : '流程ID',
											align : 'center'
										},
										{
											field : 'name',
											title : '流程名称',
											align : 'center'
										},
										{
											field : 'key',
											title : '流程定义的Key',
											align : 'center'
										},
										{
											field : 'version',
											title : '流程定义的版本',
											align : 'center'
										},
										{
											field : 'deploymentId',
											title : '部署ID',
											align : 'center'
										},
										{
											field : '',
											title : '操作',
											align : 'center',
											formatter : function(value, row,
													index) {
												/* var e = '<a class="btn btn-primary" href="${pageContext.request.contextPath }/deleteDeployment?deploymentId='
														+ row.deploymentId
														+ '">删除</a>'; */
												var e = '<button id="cliantBtn" onclick="deleteDeploymentFunction(\''
													+ row.deploymentId
													+ '\')" class="btn-primary">删除</button>'		
												return e;
											}
										} ],
								queryParams : oTableInit.queryParams
							//传递参数（*）
							});
		};

		//得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
			};
			return temp;
		};
		return oTableInit;
	};

	var ButtonInit = function() {
		var oInit = new Object();
		var postdata = {};

		oInit.Init = function() {
			//初始化页面上面的按钮事件
		};

		return oInit;
	};
</script>

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
				processFile : {
					required : true
				},
				remark : {
					processName : 40
				}
			},
			messages : {
				processFile : {
					required : "请选择要上传的文件！"
				},
				processName : {
					maxlength : "文件描述最大长度是40！"
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
		var form = new FormData($( "#uploadFileForm" )[0]);
		$
				.ajax({
					url : "${pageContext.request.contextPath }/deployWorkFlow",
					cache : false,
					type : "POST",
					data : form,// 你的formid
					async : false,
					processData: false,  // 不处理数据
					contentType: false,   // 不设置内容类型
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
													window.location.href = "${pageContext.request.contextPath }/listWorkflow";
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
													window.location.href = "${pageContext.request.contextPath }/listWorkflow";
												}
											});
						} else if ("sizeError" == data.fileSize) {
							layer
							.alert(
									'文件大小不能超过1M！',
									{
										skin : 'layui-layer-molv',
										icon : 5,
										closeBtn : 0,
										btnAlign : 'c', //按钮居中
										anim : 0, //动画类型
										time : 2000
									});
						} else if ("typeError" == data.fileType) {
							layer
							.alert(
									'文件类型错误(类型为zip)！',
									{
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
	$(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/queryRoleList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				for (var i = 0; i < data.length; i++) {
					$("#groupArr").append(
							'<option value="' + data[i].id +'">'
									+ data[i].roleName + '</option>')
				}
			}
		});
	});
</script>

<script type="text/javascript">
	var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
	function fileChange(target, id) {
		var fileSize = 0;
		var filetypes = [".zip"];
		var filepath = target.value;
		var filemaxsize = 1024;//1M 
		if (filepath) {
			var isnext = false;
			var fileend = filepath.substring(filepath.indexOf("."));
			if (filetypes && filetypes.length > 0) {
				for (var i = 0; i < filetypes.length; i++) {
					if (filetypes[i] == fileend) {
						isnext = true;
						break;
					}
				}
			}
			if (!isnext) {
				layer.alert('不接受此文件类型！',
						{
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
				layer.alert('附件不存在，请重新输入！',
						{
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
			layer.alert("附件大小不能大于" + filemaxsize / 1024 + "M！",
					{
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
			layer.alert("附件大小不能为0M！",
					{
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

<script type="text/javascript">
		function deleteDeploymentFunction(id) {
			layer.confirm("您确定要删除这一个流程吗？", {
				icon : 3,
                closeBtn : 0,
                btnAlign : 'c', //按钮居中
                title : '删除提示'
			}, function() {
				$
				.ajax({
					url : "${pageContext.request.contextPath }/deleteDeployment?deploymentId=" + id,
					type : "get",
					dataType : "json",
					success : function(data) {
						if ('success' == data.status) {
							layer.alert('删除流程成功！', {
								skin : 'layui-layer-molv',
								icon : 1,
								closeBtn : 0,
								btnAlign : 'c', //按钮居中
								anim : 0, //动画类型
								time : 2000,
								end : function() {
									$("#tb_listWorkflow").bootstrapTable(
											'refresh', {
												index : id
											});
								}
							});
							return false;
						} else if ('fail' == data.status) {
							layer.alert('删除流程失败！', {
								skin : 'layui-layer-molv',
								icon : 5,
								closeBtn : 0,
								btnAlign : 'c', //按钮居中
								anim : 0, //动画类型
								time : 2000,
								end : function() {
									$("#tb_listWorkflow").bootstrapTable(
											'refresh', {
												index : id
											});
								}
							});
						}
					}
				});
			})
		}
</script>

<script type="text/javascript">
	$(function() {
		$("#processName").change(function() {
			var processName = $("#processName").val().replace(/<\/?[^>]*>/g,'');
			$("#processName").val($.trim(processName));
		});
	});
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