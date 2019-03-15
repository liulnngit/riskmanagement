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
                        <h5>更新角色</h5>
                    </div>
				
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
								
									<form class="form-horizontal" id="editRoleForm" method="POST"
										role="form">
				
										<div class="form-group">
											<label class="col-sm-2 control-label">【角色信息】</label>
										</div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>角色名称:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="roleName" value="${role.roleName}"
													name="roleName" required="required" placeholder="请输入角色名称" <c:if test="${'S' eq role.status}">readonly</c:if> />
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label">【权限信息】</label>
										</div>
				
										<div class="form-group">
											<label class="col-sm-2 control-label">功能菜单:</label>
											<div class="col-sm-8">
												<button id="checkAll" class="btn-primary" type="button">全选</button>
												<ul style="margin-left: 60px;" id="functionTree" class="ztree"></ul>
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											
											<div class="col-sm-4 col-sm-offset-2">
												<div class="btn-toolbar" role="toolbar">
											<div class="btn-group">
												<button id="submitBtn" type="submit"
													class="btn btn-primary margin-items-top">保 存</button>
											</div>
											<div class="btn-group">
												<button id="resetBtn" type="button"
													class="btn btn-primary margin-items-top">重置</button>
											</div>
											<div class="btn-group">
												<button id="returnBtn" type="button" class="btn btn-primary">返回</button>
											</div>
										</div>
										<input type="hidden" name="ids">
										<input type="hidden" id="id" name="id" value="${role.id}">
										<input type="hidden" name="status" value="${role.status}">
										<input type="hidden" name="creatorId" value="${role.creatorId}">
										<input type="hidden" name="createDate" value="${role.createDate}">
											</div>
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

<script type="text/javascript">
$(function() {
	$.ajax({
		url : "${pageContext.request.contextPath}/querySystemTypeList",
		type : "GET",
		contentType : "application/json",
		dataType : "json",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				$("#systemId").append(
						'<option value="' + data[i].id +'">'
								+ data[i].systemName + '</option>')
			}
			var selectOption = $("#selectSystemId").val();
			$("#systemId option[value='" + selectOption + "']").attr(
					"selected", "selected");
		}
	});
		// 授权树初始化
		var setting = {
			data : {
				key : {
					title : "t"
				},
				simpleData : { //使用简单json数据构造节点数据
					enable : true
				}
			},
			check : { //使用ztree勾选效果
				enable : true,
			}

		};
		$.ajax({
			//url : '${pageContext.request.contextPath}/json/menu.json',
			url : 'queryMenuList',
			type : 'POST',
			dataType : 'json',
			success : function(data) {
				zTreeObj = $.fn.zTree.init($("#functionTree"), setting, data);
				var treeObj = $.fn.zTree.getZTreeObj("functionTree");
				zTreeObj.expandAll(true);
				var nodes = zTreeObj.getNodes();
				var array = zTreeObj.transformToArray(nodes);

				var roleId = $("input[name='id']:eq(0)").val();

				//勾选回显
				$
						.ajax({
							type : 'POST',
							url : 'checkedMenuList',
							dataType : 'json',
							data : {
								"roleId" : roleId
							},
							success : function(treeJson) {
								for ( var i in array) {
									for ( var j in treeJson) {
										if (!array[i].isParent) {
											if (array[i].id == treeJson[j].id) {
												zTreeObj.checkNode(array[i],
														true, true);
											}
										}
									}
								}
							}
						});

			},
			error : function(msg) {
				alert('树加载异常!');
			}
		});

	});
</script>

<script type="text/javascript">
	$(function() {

		$.validator.setDefaults({
			submitHandler : function(form) {
				checkValue();
				ajaxSubmitForm();
			}
		});

		$(function() {
			// 在键盘按下并释放及提交后验证提交表单
			$("#editRoleForm").validate({
				invalidHandler : function(form, validator) { //不通过回调
					return false;
				},
				rules : {
					roleName : {
						required : true,
						maxlength : 30,
						remote : {
							url : "role/checkRoleNameValid",
							type : "post",
							dataType : "json",
							data : {
								roleName : function() {
									return $("#roleName").val();
								},
								id : function() {
									return $("#id").val();
								}
							}
						}
					},
					ids : {
						required : true
					},
					systemId : {
						required : true
					}
				},
				messages : {
					roleName : {
						required : "请输入角色名称！",
						maxlength : "角色名称最大长度为30！",
						remote : "该角色名称已存在！"
					},
					ids : {
						required : "请为角色选择相应的权限！"
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
				//提交表单后，未通过验证的表单（第一个或提交之前获得焦点的未通过验证的表单）会获得焦点。
				focusInvalid : function(element) {
					$(element).valid();
				}
			});
		});

		function checkValue() {
			var treeObj = $.fn.zTree.getZTreeObj("functionTree");//获得页面中的ztree对象
			var nodes = treeObj.getCheckedNodes(true);//在提交表单之前将选中的checkbox收集
			var array = new Array();
			for (var i = 0; i < nodes.length; i++) {
				var id = nodes[i].id;//权限id
				array.push(id);
			}
			var ids = array.join(",");//1,2,3,4,5
			$("input[name=ids]").val(ids);
		}
		
		function ajaxSubmitForm() {
			/* $("#addNoticeForm").submit(); */
			$
					.ajax({
						cache : false,
						type : "POST",
						url : "${pageContext.request.contextPath }/editRole",
						data : $('#editRoleForm').serialize(),// 你的formid
						async : false,
						error : function(request) {
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
												'编辑成功！',
												{
													skin : 'layui-layer-molv',
													icon : 1,
													closeBtn : 0,
													btnAlign : 'c', //按钮居中
													anim : 0, //动画类型
													time : 2000,
													end : function() {
														window.location.href = "${pageContext.request.contextPath }/listRole";
													}
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							} else if ('fail' == data.status) {
								layer
										.alert(
												'编辑失败！',
												{
													skin : 'layui-layer-molv',
													icon : 5,
													closeBtn : 0,
													btnAlign : 'c', //按钮居中
													anim : 0, //动画类型
													time : 2000,
													end : function() {
														window.location.href = "${pageContext.request.contextPath }/listRole";
													}
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							} else if ('isSystemRole' == data.isSystemRole) {
								layer
								.alert(
										'系统角色，不允许修改角色名称！',
										{
											skin : 'layui-layer-molv',
											icon : 5,
											closeBtn : 0,
											btnAlign : 'c', //按钮居中
											anim : 0, //动画类型
											time : 2000,
											end : function() {
												window.location.href = "${pageContext.request.contextPath }/listRole";
											}
										});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							}
						}
					});
		}
	})
	
$("#resetBtn").click(function() {
	window.location.href = "${pageContext.request.contextPath }/toEditRolePage?roleId=" + $("#id").val();
});
$("#returnBtn").click(function() {
      window.location.href = "${pageContext.request.contextPath}/listRole";
    }
);
</script>

<script type="text/javascript">
	$(function() {
		$("#roleName").change(function() {
			var roleName = $("#roleName").val().replace(/<\/?[^>]*>/g,'');
			$("#roleName").val($.trim(roleName));
		});
	});
</script>

<script type="text/javascript">
	$(function() {
		//全选
		$("#checkAll").click(function() {
			var treeObj = $.fn.zTree.getZTreeObj("functionTree");
			  //将现有节点全部选中（不包括还没有展开的节点）
			 treeObj.checkAllNodes(true);
		});
		
		//反选
		$("#inverse").click(function() {
			var treeObj = $.fn.zTree.getZTreeObj("functionTree");
			treeObj.checkAllNodes(false);
		});
	});
</script>

</html>