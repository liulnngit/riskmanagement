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
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery.serializejson.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>规则参数</h5>
                    </div>
                    <div class="ibox-content">	
					<div class="panel admin-panel">
							<div class="btn-group" id="toolbar" >								
											<div class="btn-group">
													<button id="addBtn" type="button" class="btn btn-primary">新增</button>
											</div>
											<div class="btn-group">
													<button id="editRuleParameter" type="button" class="btn btn-primary">修改</button>
											</div>
											<div class="btn-group">
													<button id="deleteBtn" type="button" class="btn btn-primary">删除</button>
											</div>
											<div class="btn-group">
													<button id="searchBtn" type="button" class="btn btn-primary"
														data-toggle="modal" data-target="#searchModal">查询</button>
											</div>
							       
							    <div class="btn-group">
									<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">禁用/启用
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
										<li><a href="#" id="stopRuleParameter">禁用</a></li>
							           <li><a href="#" id="startRuleParameter">启用</a></li>
									</ul>
				  				</div>
							       
								<!-- 			<div class="btn-group">
				                  <button id="settingBtn" type="button" class="btn btn-primary">设置</button>
				              </div> -->
				              <div class="btn-group">
				                  <button id="showBtn" type="button" class="btn btn-primary">查看</button>
				              </div>
									 <div class="btn-group" id="ruleTypeDiv">
									<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">类别
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
										<li><a href="#" id="startRule">交易前-互联网</a></li>
									</ul>
				  				</div>				
							</div>
							<div class="body-content">
								<table id="tb_listRuleParameter"></table>		
								<input type="hidden" id="jsonParam" name="jsonParam" value=""/>
							</div>
							
							<!-- 查询模态框（Modal） -->
		<div class="modal fade" id="searchModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">查询行业参数</h4>
					</div>
					<div class="modal-body">
						<form id="searchForm">
							<div style="margin-top: 10px; margin-botton: 10px;">
							<strong><span>类别信息</span></strong>
						</div>

						<div style="margin-right: 50px;  margin-top: 10px; margin-botton: 10px;">
							<div class="input-group">
								<span class="input-group-addon">规则类别:</span> <select
									id="ruleType" required="required" class="form-control"
									name="ruleType">
									<option value="">-----请选择-----</option>
								</select>
							</div>
						</div>

						<div style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
							<div class="input-group">
								<span class="input-group-addon">规则名称:</span> <select
									id="ruleCode" required="required" class="form-control"
									name="ruleCode">
									<option value="">-----请选择-----</option>
								</select>
							</div>
						</div>

						<div style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
							<div class="input-group">
								<span class="input-group-addon">规则级别:</span> <select
									id="riskLevel" required="required" class="form-control"
									name="riskLevel">
									<option value="">-----请选择-----</option>
								</select>
							</div>
						</div>

						<div style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
							<div class="input-group">
								<span class="input-group-addon">是否报警:</span> <select
									id="alarmFlag" required class="form-control" name="alarmFlag">
									<option value="">-----请选择-----</option>
									<option value="1">是</option>
									<option value="0">否</option>
								</select>
							</div>
						</div>

						<div style="margin-right: 50px; margin-top: 10px; margin-botton: 10px;">
							<div class="input-group">
								<span class="input-group-addon">是否启用:</span> <select id="status"
									required class="form-control" name="status">
									<option value="">-----请选择-----</option>
									<option value="A">启用</option>
									<option value="I">禁用</option>
								</select>
							</div>
						</div>
						</form>
					</div>
					<div class="modal-footer">
						<button id="submitBtn" type="button" class="btn btn-primary">查询</button>
						<button id="clearBtn" type="button" class="btn btn-primary">清空</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
						<span id="tip"> </span>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
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

		//1.初始化Table
		var oTable = new TableInit();
		oTable.Init();

		$('#tb_listRuleParameter').bootstrapTable('hideColumn', 'id');//隐藏某一列
		$('#tb_listRuleParameter').bootstrapTable('hideColumn', 'isConf');//隐藏某一列

		//2.初始化Button的点击事件
		var oButtonInit = new ButtonInit();
		oButtonInit.Init();

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		oTableInit.Init = function() {
			$('#tb_listRuleParameter').bootstrapTable({
				url : '${pageContext.request.contextPath }/getListRuleParameter', //请求后台的URL（*）
				method : 'post', //请求方式（*）
				//toolbar : '#toolbar', //工具按钮用哪个容器
				contentType : 'application/x-www-form-urlencoded',
				striped : true, //是否显示行间隔色
				cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				pagination : true, //是否显示分页（*）
				sortable : false, //是否启用排序
				//sortOrder : "asc", //排序方式
				sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, //初始化加载第一页，默认第一页
				pageSize : 10, //每页的记录行数（*）
				pageList : [ 10, 25, 50, 100 ], //可供选择的每页的行数（*）
				//search : true, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
				//strictSearch : true,
				//showColumns : true, //是否显示所有的列
				//showRefresh : true, //是否显示刷新按钮
				minimumCountColumns : 2, //最少允许的列数
				clickToSelect : true, //是否启用点击选中行
				smartDisplay: false,//智能显示分页按钮
				escape : true,
			    paginationPreText: "上一页",
			    paginationNextText: "下一页",
				//height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
				uniqueId : "id", //每一行的唯一标识，一般为主键列
				//showToggle : true, //是否显示详细视图和列表视图的切换按钮
				//cardView : false, //是否显示详细视图
				//detailView : false, //是否显示父子表
				singleSelect : true, //禁止多选
				undefinedText : "",
				columns : [ {
					checkbox : true,
					align : 'center'
				}, {
					field : 'id',
					title : '规则参数ID',
					align : 'center'
				}, {
					field : 'isConf',
          title : '是否可配置',
          align : 'center'
				}, {
					field : 'ruleName',
	        title : '规则名称',
	        align : 'center'
        }, {
          field : 'type',
          title : '规则类别',
          align : 'center'
        },/*  {
	        field : 'configParameterValues',
	        title : '规则参数',
	        align : 'center',
	        //visible : false,
			formatter : function(value, row,
					index) {
				var e = '<div style="width:150px;height:20px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;">'
					+ value + '</div>';
			return e;
			}
       }, */ {
          field : 'rlRiskLevel',
          title : '风险级别',
          align : 'center'
        }, {
        	field : 'alarmFlag',
          title : '是否报警',
          align : 'center'
        }, {
        	field : 'status',
          title : '状态',
          align : 'center'
        }, {
					field : 'creator',
					title : '创建人',
					align : 'center'
				},  {
					field : 'createTime',
					title : '创建时间',
					align : 'center'
				}],
				queryParams : oTableInit.queryParams
			//传递参数（*）
			});
		};

		//得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
				jsonParam:$("#jsonParam").val()
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
	
	$("#submitBtn").click(function() {
		var obj = $('#searchForm').serializeJSON();
		var jsonString = JSON.stringify(obj);
		$("#jsonParam").val(jsonString);
		$('#tb_listBusinessRule').bootstrapTable('destroy');
		var oTable = new TableInit();
		oTable.Init();
		$('#tb_listBusinessRule').bootstrapTable('hideColumn', 'id');
		$('#tb_listBusinessRule').bootstrapTable('hideColumn', 'isConf');//隐藏某一列
		$('#searchModal').modal('hide');
	});

	//回车键事件
	document.onkeydown = function(e) {
		var ev = document.all ? window.event : e;
		if (ev.keyCode == 13) {
			var obj = $('#searchForm').serializeJSON();
			var jsonString = JSON.stringify(obj);
			$("#jsonParam").val(jsonString);
			$('#tb_listRuleParameter').bootstrapTable('destroy');
			var oTable = new TableInit();
			oTable.Init();
			$('#tb_listRuleParameter').bootstrapTable('hideColumn', 'id');
			$('#tb_listRuleParameter').bootstrapTable('hideColumn', 'isConf');//隐藏某一列
			$('#searchModal').modal('hide');
		}
	}
	
</script>

<script type="text/javascript">
function clickEvent(obj){
	var jsonParam;
	var ruleType = obj.value;
	if('000' == ruleType){
		jsonParam = null;
	} else if('999' == ruleType){
		var jsonParam = "";
    jsonParam = jsonParam.replace(/"/g, "'");
    var pageUrl = "${pageContext.request.contextPath }/toSearchRuleParameterPage?jsonParam=" + jsonParam;
    var diag = new Dialog();
    diag.Width = 900;
    diag.Height = 400;
    diag.Title = "请输入查询条件";
    diag.URL = pageUrl;
    diag.Drag = false;
    diag.show();
    return;
	} else {
		jsonParam = '{"ruleType":"' + ruleType +'"}';
	}
}
	$(function() {
		
		$.ajax({
      url : "${pageContext.request.contextPath}/queryRuleTypeList",
      type : "GET",
      contentType : "application/json",
      dataType : "json",
      success : function(data) {
    	  $("#ruleTypeDiv").empty();
        var u = $("#ruleTypeDiv")
        .append("<button type='button' class='btn btn-primary dropdown-toggle' data-toggle='dropdown'>类别<span class='caret'></span></button>");
        var tmpStr = "<ul class='dropdown-menu' id='ruleTypeUl' role='menu'><li id='ruleTypeLi' value='000' onclick='return clickEvent(this);'><a href='#' id=''>全部</a><li>";
        for (var i = 0; i < data.length; i++) {
               var tmp = "<li id='ruleTypeLi' value='" + +data[i].id + "' onclick='return clickEvent(this);'><a href='#' id=''>"+data[i].title+"</a></li>";
               tmpStr += tmp;
         }
        tmpStr += "<li id='ruleTypeLi' value='999' onclick='return clickEvent(this);'><a href='#' id=''>更多...</a><li>";
    	  tmpStr += "</ul>";
    	  u.append(tmpStr);
      }
    });
		
		
		$("#addBtn")
				.click(
						function() {
							window.location.href = "${pageContext.request.contextPath }/addRuleParameter";
						});
		$("#editRuleParameter")
      .click(
          function() {
            var selectRow = $("#tb_listRuleParameter").bootstrapTable(
                'getSelections');
            if (selectRow.length != 1) {
              layer.alert('请选择一条数据进行操作！', {
                skin: 'layui-layer-molv',
                icon: 5,
                closeBtn: 0,
                btnAlign: 'c', //按钮居中
                anim: 0, //动画类型
                time: 2000
              });
              return false;
            } else {
            	var paramStatus = selectRow[0].status;
            	if("禁用" == paramStatus){
            		layer.alert('规则参数未启用！', {
                    skin: 'layui-layer-molv',
                    icon: 5,
                    closeBtn: 0,
                    btnAlign: 'c', //按钮居中
                    anim: 0, //动画类型
                    time: 2000
                  });
            		return false;
            	}
              window.location.href = "${pageContext.request.contextPath}/showRuleParameter?id="
                  + selectRow[0].id;
            }
          });
		
		$("#settingBtn")
      .click(
         function() {
           var selectRow = $("#tb_listRuleParameter").bootstrapTable(
               'getSelections');
           if (selectRow.length != 1) {
             layer.alert('请选择一条数据进行操作！', {
               skin: 'layui-layer-molv',
               icon: 5,
               closeBtn: 0,
               btnAlign: 'c', //按钮居中
               anim: 0, //动画类型
               time: 2000
             });
             return false;
           } else {
        	   var isConf = selectRow[0].isConf;
        	   var ruleParamStatus = selectRow[0].status;
        	   if("1" != isConf){
        		   layer.alert('该规则不可配置！', {
                 skin: 'layui-layer-molv',
                 icon: 5,
                 closeBtn: 0,
                 btnAlign: 'c', //按钮居中
                 anim: 0, //动画类型
                 time: 2000
               });
               return false;
        	   } else if("禁用" == ruleParamStatus){
        		   layer.alert('该参数未启用！', {
                 skin: 'layui-layer-molv',
                 icon: 5,
                 closeBtn: 0,
                 btnAlign: 'c', //按钮居中
                 anim: 0, //动画类型
                 time: 2000
               });
               return false;
        	   }
             window.location.href = "${pageContext.request.contextPath}/toSetBusinessRuleParameterPage?id="
                 + selectRow[0].id;
           }
         });
		
		//禁用规则参数状态
	    $("#stopRuleParameter")
	        .click(
	            function() {
	              var selectRow = $("#tb_listRuleParameter").bootstrapTable(
	                  'getSelections');
	              if (selectRow.length != 1) {
	            	  layer.alert("请选择一条数据操作！", {
                          skin: 'layui-layer-molv',
                          icon: 5,
                          btnAlign: 'c', //按钮居中
                          closeBtn: 0,
                          anim: 0, //动画类型
                          time: 2000
                        });
	                return false;
	              } else {
	                if ('禁用' != selectRow[0].status) {
	                	$
	                    .ajax({
	                      url : "${pageContext.request.contextPath}/changeRuleParameterStatus?id="
	                          + selectRow[0].id
	                          + "&status=I",
	                      type : "get",
	                      async : true,
	                      cache : false,
	                      success : function(data) {
	                        if ("success" == data.status) {
	                          layer.alert("禁用规则参数成功！", {
	                            skin: 'layui-layer-molv',
	                            icon: 1,
	                            btnAlign: 'c', //按钮居中
	                            closeBtn: 0,
	                            anim: 0, //动画类型
	                            time: 2000,
	                            end : function() {
	                              $("#tb_listRuleParameter").bootstrapTable('refresh', {index:selectRow[0].id});
	                            }
	                          });
	                        } else {
	                          layer.alert("禁用规则参数失败！", {
	                            skin: 'layui-layer-molv',
	                            icon: 5,
	                            btnAlign: 'c', //按钮居中
	                            closeBtn: 0,
	                            anim: 0, //动画类型
	                            time: 2000
	                          });
	                        }
	                      }
	                    });
	                } else {
	                	layer.alert("该规则参数已经是启用禁用！", {
                            skin: 'layui-layer-molv',
                            icon: 5,
                            btnAlign: 'c', //按钮居中
                            closeBtn: 0,
                            anim: 0, //动画类型
                            time: 2000
                          });
	                }
	              }
	            });
	    //启用规则参数状态
	    $("#startRuleParameter")
	        .click(
	            function() {
	              var selectRow = $("#tb_listRuleParameter").bootstrapTable(
	                  'getSelections');
	              if (selectRow.length != 1) {
	                layer.alert('请选择一条数据进行操作！', {
	                  skin : 'layui-layer-molv',
	                  icon : 5,
	                  closeBtn : 0,
	                  btnAlign : 'c', //按钮居中
	                  anim : 0, //动画类型
	                  time : 2000
	                });
	                return false;
	              } else {
	            	var ruleStatus = selectRow[0].rule.status;
	            	if ('I' == ruleStatus) {
	            		layer.alert('该规则参数所对应的规则为禁用状态，启用规则参数失败！', {
	  	                  skin : 'layui-layer-molv',
	  	                  icon : 5,
	  	                  closeBtn : 0,
	  	                  btnAlign : 'c', //按钮居中
	  	                  anim : 0, //动画类型
	  	                  time : 2000
	  	                });
	  	                return false;
	            	} else {
	            		if ('启用' != selectRow[0].status) {
	            			 $
			                    .ajax({
			                      url : "${pageContext.request.contextPath}/changeRuleParameterStatus?id="
			                          + selectRow[0].id
			                          + "&status=A",
			                      type : "get",
			                      async : true,
			                      cache : false,
			                      success : function(data) {
			                    	if ("fail" == data.msg) {
			                    		layer.alert("该规则参数所对应的规则为禁用状态，启用规则参数失败！", {
				                              skin: 'layui-layer-molv',
				                              icon: 5,
				                              btnAlign: 'c', //按钮居中
				                              closeBtn: 0,
				                              anim: 0, //动画类型
				                              time: 2000
				                            });
			                    	} else if ("success" == data.status) {
			                          layer.alert("启用规则参数成功！", {
			                              skin: 'layui-layer-molv',
			                              icon: 1,
			                              btnAlign: 'c', //按钮居中
			                              closeBtn: 0,
			                              anim: 0, //动画类型
			                              time: 2000,
			                              end : function() {
			                                $("#tb_listRuleParameter").bootstrapTable('refresh', {index:selectRow[0].id});
			                              }
			                            });
			                        } else if ("fail" == data.status) {
			                          layer.alert("启用规则参数失败！", {
			                            skin: 'layui-layer-molv',
			                            icon: 5,
			                            btnAlign: 'c', //按钮居中
			                            closeBtn: 0,
			                            anim: 0, //动画类型
			                            time: 2000
			                          });
			                        } else if ("fail" == data.statusMsg) {
			                        	layer.alert("该规则参数已经是启用状态！", {
				                            skin: 'layui-layer-molv',
				                            icon: 5,
				                            btnAlign: 'c', //按钮居中
				                            closeBtn: 0,
				                            anim: 0, //动画类型
				                            time: 2000
				                          });
			                        }
			                      }
			                    });
	            		} else {
	            			layer.alert("该规则参数已经是启用状态！", {
	                            skin: 'layui-layer-molv',
	                            icon: 5,
	                            btnAlign: 'c', //按钮居中
	                            closeBtn: 0,
	                            anim: 0, //动画类型
	                            time: 2000
	                          });
	            		}
		              }
		            }
	            	});
	               
		
		$("#showBtn")
     .click(
         function() {
           var selectRow = $("#tb_listRuleParameter").bootstrapTable(
               'getSelections');
           if (selectRow.length != 1) {
             layer.alert('请选择一条数据进行操作！', {
               skin: 'layui-layer-molv',
               icon: 5,
               closeBtn: 0,
               btnAlign: 'c', //按钮居中
               anim: 0, //动画类型
               time: 2000
             });
             return false;
           } else {
             window.location.href = "${pageContext.request.contextPath}/showRuleParameterDetail?id="
                 + selectRow[0].id;
           }
         });
		
	})

	$("#deleteBtn")
		.click(
				function() {
					//获取选中的行
					var selectRow = $("#tb_listRuleParameter").bootstrapTable(
							'getSelections');
					if (selectRow.length != 1) {
						layer.alert('请选择一条数据进行操作！', {
							skin : 'layui-layer-molv',
							icon : 5,
							closeBtn : 0,
							btnAlign : 'c', //按钮居中
							anim : 0, //动画类型
							time : 2000
						});
						return false;
					} else {
						layer
								.confirm(
										"您确定要删除这" + selectRow.length
												+ "条数据吗？",
										{
											icon : 3,
											closeBtn : 0,
											btnAlign : 'c', //按钮居中
											title : '提示'
										},
										function() {
											$
													.ajax({
														url : "${pageContext.request.contextPath}/deleteRuleParameter?id="
																+ selectRow[0].id,
														type : "get",
														async : true,
														cache : false,
														success : function(
																data) {
															if ("success" == data.status) {
																layer.alert("删除成功！", {
																	skin: 'layui-layer-molv',
																	icon: 1,
																	btnAlign: 'c', //按钮居中
																	closeBtn: 0,
																	anim: 0, //动画类型
																	time: 2000
																});
																$("#tb_listRuleParameter").bootstrapTable('hideRow', {uniqueId:selectRow[0].id});
																$("#tb_listRuleParameter").bootstrapTable('refresh');
															} else {
																layer.alert("删除失败！", {
																	skin: 'layui-layer-molv',
																	icon: 5,
																	btnAlign: 'c', //按钮居中
																	closeBtn: 0,
																	anim: 0, //动画类型
																	time: 2000
																});
															}
															
														}
													});
										});

					}
				});
</script>

<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/queryRiskLevelList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#riskLevel").append(
								'<option value="' + data[i].id +'">'
										+ data[i].title + '</option>')
					}
				}
			}
		});

		$("#ruleType")
				.change(
						function() {
							var selecteText = $('#ruleType').find(
									'option:selected').text();
							var selecteVal = $('#ruleType').find(
									'option:selected').val();
							$("#ruleCode").empty();
							$("#ruleCode").append(
									"<option value=''>-----请选择-----</option>");
							$
									.ajax({
										url : "${pageContext.request.contextPath}/queryRuleListForRuleParameter?ruleType="
												+ selecteVal,
										type : "GET",
										contentType : "application/json",
										dataType : "json",
										cache : false,
										success : function(data) {
											if (data.length > 0) {
												for (var i = 0; i < data.length; i++) {
													$("#ruleCode")
															.append(
																	'<option value="' + data[i].ruleCode +'">'
																			+ data[i].ruleName
																			+ '</option>')
												}
											}
										}
									});
						});

		$.ajax({
			url : "${pageContext.request.contextPath}/queryRuleTypeList",
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#ruleType").append(
								'<option value="' + data[i].id +'">'
										+ data[i].title + '</option>')
					}

				}
			}
		});

		$.ajax({
			url : "${pageContext.request.contextPath}/queryListRule",
			type : "get",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#ruleCode").append(
								'<option value="' + data[i].ruleCode + '">'
										+ data[i].ruleName + '</option>');
					}
				}
			}

		});

	});
</script>

<script type="text/javascript">
	$(function() {
		$("#clearBtn").click(function() {
			$("#ruleType").val('');
			$("#ruleCode").val('');
			$("#riskLevel").val('');
			$("#alarmFlag").val('');
			$("#status").val('');
		});
	});
</script>

</html>