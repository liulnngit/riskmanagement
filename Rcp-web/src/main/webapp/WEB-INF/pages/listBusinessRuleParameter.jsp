<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>设置支付类型</title>
<%@ include file="../commons/sourceFile.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery.serializejson.js"></script>
<script src="${pageContext.request.contextPath }/js/chosen.jquery.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/chosen.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/formatDateUtil.js"></script>

<!-- <script type="text/javascript">
function formIsDirty(form) {
	  for (var i = 0; i < form.elements.length; i++) {
	    var element = form.elements[i];
	    var type = element.type;
	    if (type == "checkbox" || type == "radio") {
	      if (element.checked != element.defaultChecked) {
	        return true;
	      }
	    }
	    else if (type == "hidden" || type == "password" || type == "text" || type == "textarea") {
	      if (element.value != element.defaultValue) {
	        return true;
	      }
	    }
	    else if (type == "select-one" || type == "select-multiple") {
	      for (var j = 0; j < element.options.length; j++) {
	        if (element.options[j].selected != element.options[j].defaultSelected) {
	          return true;
	        }
	      }
	    }
	  }
	  return false;
	}
	window.onbeforeunload = function (e) {
	  e = e || window.event;
	  if (formIsDirty(document.forms["payClassForm"])) {
	    // IE 和 Firefox
	    if (e) {
	      e.returnValue = "对不起，页面数据已做修改，尚未保存，确定要刷新或离开本页面？";
	    }
	    // Safari浏览器
	    return "对不起，页面数据已做修改，尚未保存，确定要刷新或离开本页面？";
	  }
	};
</script> -->	

<script type="text/javascript">
function getRuleType() {
	$.ajax({
		url : "${pageContext.request.contextPath}/queryRuleTypeList",
		type : "get",
		dataType : "json",
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
		},
		success : function(data) {
			if (data.length > 0) {
				for (var i = 0; i < data.length; i++) {
					if ('4' == data[i].id) {
						$("#ruleType").append(
								'<option selected = "selected" value="' + data[i].id +'">'
										+ data[i].title + '</option>');
					} else {
						$("#ruleType").append(
								'<option value="' + data[i].id +'">'
										+ data[i].title + '</option>');
					}
				}
			}
		}
	});
}

function getBusinessType() {
	$.ajax({
		url : "${pageContext.request.contextPath}/queryAllBusinessTypes",
		type : "get",
		dataType : "json",
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
		},
		success : function(data) {
			if (data.length > 0) {
				for (var i = 0; i < data.length; i++) {
					if (data[i].code == 'default') {
						$("#businessId").append(
								'<option selected = "selected" value="' + data[i].id +'" id="' + data[i].code + '">'
										+ data[i].title + '</option>');
					} else {
						$("#businessId").append(
								'<option value="' + data[i].id +'" id="' + data[i].code + '">'
										+ data[i].title + '</option>');
					}
				}
			}
		}
	});
}

function getPayclass() {
	$.ajax({
		url : '${pageContext.request.contextPath}/queryPayclassList',
		type : 'get',
		dataType : "json",
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
		},
		success : function(data) {
			if (data.length > 0) {
				for (var i = 0; i < data.length; i++) {
					if (data[i].code == 'default') {
						$("#payclassId").append(
								'<option selected = "selected" value="' + data[i].id +'" id="' + data[i].code + '">' + data[i].name
										+ '</option>');
					} else {
						$("#payclassId").append(
								'<option value="' + data[i].id +'" id="' + data[i].code + '">' + data[i].name
										+ '</option>');
					}
					
				}
				/*$('#payclassId').chosen();*/
				
			}
		}
	});
}

function getPayclassNotDefault() {
	$.ajax({
		url : '${pageContext.request.contextPath}/queryPayclassList',
		type : 'get',
		dataType : "json",
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
		},
		success : function(data) {
			if (data.length > 0) {
				for (var i = 0; i < data.length; i++) {
					if (data[i].code != 'default') {
						$("#payclassId").append(
								'<option value="' + data[i].id +'">' + data[i].name
										+ '</option>');
					}
				}
			}
		}
	});
}
</script>
<style>
	.onoffswitch-inner:before{text-align: left;}
</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>设置业务风险参数</h5>
                    </div>
					<div class="ibox-content">
					 
					<form class="form-horizontal" id="payClassForm" method="post" role="form">
						<div class="panel admin-panel">
							<div class="body-content" style="overflow: inherit;">
								
									<div class="form-inline">
										<div class="input-group">
											<span class="input-group-addon">规则类型:</span> <select
												id="ruleType" name="ruleType" class="form-control"
												>
											</select>
										</div>
										<div class="input-group">
											 <span class="input-group-addon">行业名称:</span> <select
												id="businessId" name="businessId" class="form-control"
												>
											</select>
										</div>
										<div class="input-group"> 
											<span class="input-group-addon" style="margin-left: 10%;">支付类型:</span>
											<select id="payclassId" name="payclassId" class="form-control"
												></select>
										</div>
				
									</div>
									
								
							</div>
							<hr />
							
								<div>
									<!-- <h3 class="col-sm-2">风险规则阈值设置</h3> -->
									<ul class="nav nav-tabs">
				                        <li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true" id="tab-1">统计</a>
				                        </li>
				                        <li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false" id="tab-2">常规</a>
				                        </li>
				                        <li class=""><a data-toggle="tab" href="#tab-3" aria-expanded="false" id="tab-3">高频</a>
				                        </li>
				                        <li class=""><a data-toggle="tab" href="#tab-4" aria-expanded="false" id="tab-4">全局</a>
				                        </li>
				                    </ul>
								</div>
								<div id="tbody-result" >
									
								</div>
								<input type="hidden" id="length" name="length">
							
						</div>
						
						<div class="form-group">
											
							<div class="col-sm-4 col-sm-offset-5">
								<div class="btn-group">
								<button id="submitBtn" type="button" class="btn btn-primary">确定</button>
							</div>
							<div class="btn-group" style="margin-left: 20px;">
								<button id="resetBtn" type="button" class="btn btn-primary">重置</button>
							</div>
							<!-- <div class="btn-group" style="margin-left: 20px;">
								<button type="button" id="returnBtn" class="btn btn-primary">返回</button>
							</div> -->
							</div>
						</div>
						
						
					</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	$(function() {
		$("#returnBtn")
				.click(
						function() {
							window.location.href = "${pageContext.request.contextPath}/listBusinessRuleParameter";
						});
		
		$("#resetBtn").click(function() {
			//alert("");
			var tbody = window.document.getElementById("tbody-result");
			var thead ="<table class='table table-bordered' id=''><thead><tr><th>规则名称</th><th>规则参数</th><th>风险级别</th><th><input type='checkbox' name='checkCall' value='全选/全不选'>是否报警</th><th><input type='checkbox' name='checkItems'  value='全选/全不选'>状态</th></tr></thead><tbody align='center'>";
			var tcenter = "";
			var tfooter ="</tbody></table>";
			tbody.innerHTML = thead + tcenter +tfooter;
			var ruleType = $("#ruleType").val();
			var businessId = $("#businessId").val();
			var payclassId = $("#payclassId").val();
			var businessCode = $("#businessId").find("option:checked").attr("id");
			var payclassCode = $("#payclassId").find("option:checked").attr("id");
			var url = '';
			if ('default' == businessCode && 'default' == payclassCode) {
				url = '${pageContext.request.contextPath}/queryAllRules';
			} else if ('default' == payclassCode) {
				url = '${pageContext.request.contextPath}/queryParseRule';
			} else {
				url = '${pageContext.request.contextPath}/queryCommonRule';
			}
			getBusinessData(ruleType, businessId, payclassId, businessCode, url);
			checkAll();
			tabSwitch();
		});
		
	});
</script>

<script type="text/javascript">
	$(function() {
		$("#ruleType").change(function() {
			var tbody = window.document.getElementById("tbody-result");
			var thead ="<table class='table table-bordered' id=''><thead><tr><th>规则名称</th><th>规则参数</th><th>风险级别</th><th><input type='checkbox' name='checkCall' value='全选/全不选'>是否报警</th><th><input type='checkbox' name='checkItems' value='全选/全不选'>状态</th></tr></thead><tbody align='center'>";
			var tcenter = "";
			var tfooter ="</tbody></table>";
			tbody.innerHTML = thead + tcenter +tfooter;
			var ruleType = $("#ruleType").val();
			var businessId = $("#businessId").val();
			var payclassId = $("#payclassId").val();
			var businessCode = $("#businessId").find("option:checked").attr("id");
			var payclassCode = $("#payclassId").find("option:checked").attr("id");
			var url = '';
			if ('default' == businessCode && 'default' == payclassCode) {
				url = '${pageContext.request.contextPath}/queryAllRules';
			} else if ('default' == payclassCode) {
				url = '${pageContext.request.contextPath}/queryParseRule';
			} else {
				url = '${pageContext.request.contextPath}/queryCommonRule';
			}
			getBusinessData(ruleType, businessId, payclassId, businessCode, url);
			checkAll();
			tabSwitch();
		});
		
		$("#businessId").change(function() {
			var tbody = window.document.getElementById("tbody-result");
			var thead ="<table class='table table-bordered' id=''><thead><tr><th>规则名称</th><th>规则参数</th><th>风险级别</th><th><input type='checkbox' name='checkCall' value='全选/全不选'>是否报警</th><th><input type='checkbox' name='checkItems' value='全选/全不选'>状态</th></tr></thead><tbody align='center'>";
			var tcenter = "";
			var tfooter ="</tbody></table>";
			tbody.innerHTML = thead + tcenter +tfooter;
			var ruleType = $("#ruleType").val();
			var businessId = $("#businessId").val();
			var businessCode = $("#businessId").find("option:checked").attr("id");
			/* if ('default' != businessCode) {
				$("#payclassId option[id='default']").remove(); //删除Select中Value='3'的Optiona
			} else {
				$("#payclassId").empty();
				getPayclass();
			} */
			var payclassId = $("#payclassId").val();
			var payclassCode = $("#payclassId").find("option:checked").attr("id");
			var url = '';
			if ('default' == businessCode && 'default' == payclassCode) {
				url = '${pageContext.request.contextPath}/queryAllRules';
			} else if ('default' == payclassCode) {
				url = '${pageContext.request.contextPath}/queryParseRule';
			} else {
				url = '${pageContext.request.contextPath}/queryCommonRule';
			}
			getBusinessData(ruleType, businessId, payclassId, businessCode, url);
			checkAll();
			tabSwitch();
		});
		
		$("#payclassId").change(function() {
			var tbody = window.document.getElementById("tbody-result");
			var thead ="<table class='table table-bordered' id=''><thead><tr><th>规则名称</th><th>规则参数</th><th>风险级别</th><th><input type='checkbox' name='checkCall' value='全选/全不选'>是否报警</th><th><input type='checkbox' name='checkItems'  value='全选/全不选'>状态</th></tr></thead><tbody align='center'>";
			var tcenter = "";
			var tfooter ="</tbody></table>";
			tbody.innerHTML = thead + tcenter +tfooter;
			var ruleType = $("#ruleType").val();
			var businessId = $("#businessId").val();
			var payclassId = $("#payclassId").val();
			var businessCode = $("#businessId").find("option:checked").attr("id");
			var payclassCode = $("#payclassId").find("option:checked").attr("id");
			var url = '';
			if ('default' == businessCode && 'default' == payclassCode) {
				url = '${pageContext.request.contextPath}/queryAllRules';
			} else if ('default' == payclassCode) {
				url = '${pageContext.request.contextPath}/queryParseRule';
			} else {
				url = '${pageContext.request.contextPath}/queryCommonRule';
			}
			getBusinessData(ruleType, businessId, payclassId, businessCode, url);
			checkAll();
			tabSwitch();
		});
	});
</script>

<script type="text/javascript">
	getRuleType();
	getBusinessType();
	getPayclass();
	
	$(function() {
		initData();
	});
	
	function initData() {
		var ruleType = $("#ruleType").val();
		var businessId = $("#businessId").val();
		var payclassId = $("#payclassId").val();
		var businessCode = $("#businessId").find("option:checked").attr("id");
		var payclassCode = $("#payclassId").find("option:checked").attr("id");
		var url = '';
		if ('default' == businessCode && 'default' == payclassCode) {
			url = '${pageContext.request.contextPath}/queryAllRules';
		} else if ('default' == payclassCode) {
			url = '${pageContext.request.contextPath}/queryParseRule';
		} else {
			url = '${pageContext.request.contextPath}/queryCommonRule';
		}
		getBusinessData(ruleType, businessId, payclassId, businessCode, url);
		checkAll();
		tabSwitch();
	}
	
	function getBusinessData(ruleType, businessId, payclassId, businessCode, url) {
		var levelId = [];
		var levelName = [];
		$.ajax({
			url : '${pageContext.request.contextPath}/queryRiskLevelList',
			type : 'get',
			dataType : "json",
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
			},
			success : function(result) {
				if (result.length > 0) {
					for (var i = 0; i < result.length; i++) {
						levelId.push(result[i].id);
						levelName.push(result[i].title);
					}
				}
			}
		});

		var length;
		//var businessId = $("#businessId").val();
		//var ruleType = $("#ruleType").val();
		$
				.ajax({
					/* url : '${pageContext.request.contextPath}/queryParseRule?ruleType='
							+ ruleType + '&businessId=' + businessId + '&payclassId=' + payclassId, */
					url : url,
					type : 'post',
					data : {"ruleType":ruleType,"businessId":businessId,"payclassId":payclassId,"businessCode":businessCode},
					dataType : "json",
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
					},
					success : function(data) {
						if (data.length > 0) {
							var tbody = window.document
									.getElementById("tbody-result");
							var tableHtml = "";
							var thead ="<table class='table table-bordered' id=''><thead><tr><th>规则名称</th><th>规则参数</th><th>风险级别</th><th><input type='checkbox' name='checkCall' value='全选/全不选'>是否报警</th><th><input type='checkbox' name='checkItems'  value='全选/全不选'>状态</th><th>规则属性</th></tr></thead><tbody align='center'>";
							var tcenter = "";
							var tfooter ="</tbody></table>";
							length = data.length;
							var getNum = "value=value.replace(/[^\d]/g,'')";
							$("#length").val(length);
							for (var i = 0; i < data.length; i++) {
								//debugger;
								var ruleCode = data[i].ruleCode;
								var ruleName = data[i].ruleName;
								if ('I' == data[i].status) {
									tableHtml = "<tr class='danger danger_" + data[i].ruleFeature + "'>";
								} else {
									tableHtml = "<tr class='success danger_" + data[i].ruleFeature + "'>";
								}
								tableHtml += "<input id='ruleCode_" + i + "' name='ruleCode' type='hidden' value='"+ ruleCode + "'><td>"
										+ ruleName + "</td><td>";
								
								if (data[i].isConfig == '1') {
									for (var k = 0; k < data[i].params.length; k++) {
										tableHtml += "<div class='row' style='margin-bottom: 5px;'><div class='col-xs-5' style='text-align: right;'><input type='hidden' class='keyClass_" + i + "' name='key' id='key_" + i + "'"
			                      + " value='" + data[i].params[k].key + "'/>"
												+ "<input type='hidden' class='paramNameClass_" + i + "' name='paramName' id='paramName_" + i + "'"
				                      + " value='" + data[i].params[k].name + "'/>"
												+ data[i].params[k].name + ':</div>'
												+ "<div class='col-xs-5' style='text-align: left;'><input  style='border:1px solid #ccc;' class='valueClass_" + i + "' id='value_" + i 
												+ "' name='value' type='text' value=" + formatNumber(data[i].params[k].value) + "></div></div>";
									}
								}
								
								tableHtml += "</td><td><select style='padding: 3px;border: 1px solid #ccc;' id='riskLevel_" + i + "' name='riskLevel'>";
								for (var j = 0; j < levelId.length; j++) {
									if (data[i].riskLevel == levelId[j]) {
										tableHtml += "<option selected value='" + levelId[j] + "'>"
										+ levelName[j] + "</option>";
									} else {
										tableHtml += "<option value='" + levelId[j] +"'>"
												+ levelName[j] + "</option>";
									}
								}
								tableHtml += "</select></td>";
								tableHtml += "<td>";
								if ('1' == data[i].alarmFlag) {
									tableHtml += "<input type='checkbox' checked class='chk_3' id='alarmFlag_" + i + "' name='alarmFlag'>"
									/* tableHtml += "<option value='0'>否</option>";
									tableHtml += "<option value='1' selected='selected'>是</option>"; */
								} else if ('0' == data[i].alarmFlag) {
									/* tableHtml += "<option value='0' selected='selected'>否</option>";
									tableHtml += "<option value='1'>是</option>"; */
									tableHtml += "<input type='checkbox'  class='chk_3' id='alarmFlag_" + i + "' name='alarmFlag'>"
								} else {
									tableHtml += "<input type='checkbox'  class='chk_3' id='alarmFlag_" + i + "' name='alarmFlag'>"
								}
								tableHtml += "<label for='alarmFlag_" + i + "'></label></td>";
								//状态回显
								tableHtml += "<td>";
								if ('A' == data[i].status) {
									tableHtml += "<input type='checkbox' checked class='chk_4' name='status' id='status_" + i + "'>"
									/* tableHtml += "<option value='A' selected='selected'>启用</option>";
									tableHtml += "<option value='I'>禁用</option>"; */
								} else {
									/* tableHtml += "<option value='A'>启用</option>";
									tableHtml += "<option value='I' selected='selected'>禁用</option>"; */
									tableHtml += "<input type='checkbox' class='chk_4' name='status' id='status_" + i + "'>"
								}
								tableHtml += "<label for='status_" + i + "'></label></td>";
								if ('1' == data[i].ruleFeature) {
									tableHtml += "<td><div><span>常规<input id='ruleFeature_" + i + "' name='ruleFeature' type='hidden' value='" + data[i].ruleFeature + "'/></span></div>";	
								} else if ('2' == data[i].ruleFeature) {
									tableHtml += "<td><div><span>统计<input id='ruleFeature_" + i + "' name='ruleFeature' type='hidden' value='" + data[i].ruleFeature + "'/></span></div>";		
								} else if ('3' == data[i].ruleFeature) {
									tableHtml += "<td><div><span>高频<input id='ruleFeature_" + i + "' name='ruleFeature' type='hidden' value='" + data[i].ruleFeature + "'/></span></div>";		
								} else if ('4' == data[i].ruleFeature){
									tableHtml += "<td><div><span>全局<input id='ruleFeature_" + i + "' name='ruleFeature' type='hidden' value='" + data[i].ruleFeature + "'/></span></div>";
								}else {
									tableHtml += "<td><div><span></span></div>";
								}
								
								tableHtml += "</td></tr>";
								tcenter += tableHtml;
								
							}
							tbody.innerHTML = thead + tcenter +tfooter;
                            //只能输入数字
                            $(document).find("input[type='text']").on("keyup",function(){
                                $(this).val(formatNumber($(this).val().replace(/[^\d]/g,'').replace(/\b(0+)/gi,"")));
                            });

                            /*$(document).find("input[type='text']").on("blur",function(){
                                $(this).val(formatNumber($(this).val()));
                            });*/
						}
					}
				});
	}
</script>

<!-- <script type="text/javascript">
	$(function() {
		//只能输入数字
		 $(document).find(":input").on("keyup",function(){
	         var data = $(this).val($(this).val().replace(/[^\d]/g,'').replace(/\b(0+)/gi,""));
	     });
	});
</script> -->

<script type="text/javascript">

    

	function getData() {

		var length = $("#length").val();
		var businessId = $("#businessId").val();
		var payclassId = $("#payclassId").val();
		var ruleType = $("#ruleType").val();
		var businessCode = $("#businessId").find("option:checked").attr("id");
		var payclassCode = $("#payclassId").find("option:checked").attr("id");

		var arr = [];
		for (var i = 0; i < length; i++) {
			var ruleCode = $("#ruleCode_" + i).val();
			var riskLevel = $("#riskLevel_" + i).val();
			//var alarmFlag = $("#alarmFlag_" + i).val();
			var alarmFlag = $("#alarmFlag_" + i).is(':checked')==true?1:0;
			//var status = $("#status_" + i).val();
			var status = $("#status_" + i).is(':checked')==true?'A':'I';
			var ruleFeature = $("#ruleFeature_" + i).val();

			var obj = new Object();
			obj.businessId = businessId;
			obj.payclassId = payclassId;
			obj.ruleCode = ruleCode;
			obj.riskLevel = riskLevel;
			obj.alarmFlag = alarmFlag;
			obj.status = status;
			obj.ruleType = ruleType;
			obj.businessCode = businessCode;
			obj.payclassCode = payclassCode;
			obj.ruleFeature = ruleFeature;

			var keysArr = new Array();
			var paramNameArr = new Array();
			var valuesArr = new Array();
			$(".keyClass_" + i).each(function() {
				keysArr.push($(this).val());
			});

			$(".paramNameClass_" + i).each(function() {
				paramNameArr.push($(this).val());
			});
			$(".valueClass_" + i).each(function() {
                valuesArr.push($(this).val().replace(",",""));
			});
			var paramsArr = [];
			for (var j = 0; j < valuesArr.length; j++) {
				var paramObj = new Object();
				paramObj.key = keysArr[j];
				paramObj.name = paramNameArr[j];
				paramObj.value = valuesArr[j];
				paramsArr.push(paramObj);
			}
			obj.params = paramsArr;
			arr.push(obj);
		}

		return arr;
	}
</script>

<script type="text/javascript">
	$("#submitBtn").click(function() {
		/* var flag = formIsDirty(document.forms["payClassForm"]);
		if (flag) {
			ajaxSubmitForm();
		} else {
			layer
			.alert(
					'保存失败！您没有修改内容！',
					{
						skin : 'layui-layer-molv',
						icon : 5,
						closeBtn : 0,
						btnAlign : 'c', //按钮居中
						anim : 0, //动画类型
						time : 2000,
						end : function() {
							initData();
						}
					});
			return;
		}*/
	ajaxSubmitForm();
	});
	function ajaxSubmitForm() {
		var jsonData = JSON.stringify(getData());
		$
				.ajax({
					url : "${pageContext.request.contextPath }/addPayclassRule",
					type : "post",
					data : jsonData,// 你的formid
					dataType : "json",
					contentType : "application/json;charset=UTF-8",
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
											'保存成功！',
											{
												skin : 'layui-layer-molv',
												icon : 1,
												closeBtn : 0,
												btnAlign : 'c', //按钮居中
												anim : 0, //动画类型
												time : 2000,
												end : function() {
													initData();
												}
											});
							return;
						} else if ("fail" == data.status) {
							layer
									.alert(
											'保存失败！',
											{
												skin : 'layui-layer-molv',
												icon : 5,
												closeBtn : 0,
												btnAlign : 'c', //按钮居中
												anim : 0, //动画类型
												time : 2000,
												end : function() {
													initData();
												}
											});
							return;
						} else if ("empty" == data.status) {
							layer
							.alert(
									'保存失败！请输入参数',
									{
										skin : 'layui-layer-molv',
										icon : 5,
										closeBtn : 0,
										btnAlign : 'c', //按钮居中
										anim : 0, //动画类型
										time : 2000,
										end : function() {
											initData();
										}
									});
							return;
						}
					}
				});
	};
</script>
<script type="text/javascript">
		function checkAll(){
			$("input[name='checkItems']").click(function(){
				 if(this.checked){
				    $("input[name='statusAll']").prop("checked",true);
				 }else{
					 $("input[name='statusAll']").prop("checked",false);
				} 
			});
			
			$("input[name='checkCall']").click(function(){
				 if(this.checked){
				    $("input[name='alarmFlagAll']").prop("checked",true);
				 }else{
					 $("input[name='alarmFlagAll']").prop("checked",false);
				} 
			});
		}
		function tabNo(){
			$(".danger > td input[name='statusAll']").prop("name","status");
			$(".success > td input[name='statusAll']").prop("name","status");
			$(".danger > td input[name='alarmFlagAll']").prop("name","alarmFlag");
			$(".success > td input[name='alarmFlagAll']").prop("name","alarmFlag");
			$("input[name='checkItems']").prop("checked",false);
			$("input[name='checkCall']").prop("checked",false);
		}
		function tabSwitch(){
			$(".nav li").each(function(index,e){
				if($(this).hasClass("active")){
					var num =  index +1;
					tabNo();
					if(num == "1"){
						$(".danger_2").show();
						$(".danger_2 > td input[name='status']").prop("name","statusAll");
						$(".danger_2 > td input[name='alarmFlag']").prop("name","alarmFlagAll");
						$(".danger_1").hide();
						$(".danger_3").hide();
						$(".danger_4").hide();
					}else if(num == "2"){
						$(".danger_2").hide();
						$(".danger_1").show();
						$(".danger_1 > td input[name='status']").prop("name","statusAll");
						$(".danger_1 > td input[name='alarmFlag']").prop("name","alarmFlagAll");
						$(".danger_3").hide();
						$(".danger_4").hide();
					}else if(num == "3"){
						$(".danger_2").hide();
						$(".danger_1").hide();
						$(".danger_3").show();
						$(".danger_3 > td input[name='status']").prop("name","statusAll");
						$(".danger_3 > td input[name='alarmFlag']").prop("name","alarmFlagAll");
						$(".danger_4").hide();
					}else if(num == "4"){
						$(".danger_2").hide();
						$(".danger_1").hide();
						$(".danger_3").hide();
						$(".danger_4").show();
						$(".danger_4 > td input[name='status']").prop("name","statusAll");
						$(".danger_4 > td input[name='alarmFlag']").prop("name","alarmFlagAll");
					}
					
				}
			});
			$("#tab-1").click(function(){
				tabNo();
				$(".danger_2").show();
				$(".danger_2 > td input[name='status']").prop("name","statusAll");
				$(".danger_2 > td input[name='alarmFlag']").prop("name","alarmFlagAll");
				$(".danger_1").hide();
				$(".danger_3").hide();
				$(".danger_4").hide();
				
			});
		 	$("#tab-2").click(function(){
		 		tabNo();
				$(".danger_1").show();
				$(".danger_1 > td input[name='status']").prop("name","statusAll");
				$(".danger_1 > td input[name='alarmFlag']").prop("name","alarmFlagAll");
                $(".danger_2").hide();
				$(".danger_3").hide();
				$(".danger_4").hide();
				
			});
		 	$("#tab-3").click(function(){
		 		tabNo();
				$(".danger_3").show();
				$(".danger_3 > td input[name='status']").prop("name","statusAll");
				$(".danger_3 > td input[name='alarmFlag']").prop("name","alarmFlagAll");
                $(".danger_2").hide();
                $(".danger_1").hide();
				$(".danger_4").hide();
				
			});
		 	$("#tab-4").click(function(){
		 		tabNo();
				$(".danger_4").show();
				$(".danger_4 > td input[name='status']").prop("name","statusAll");
				$(".danger_4 > td input[name='alarmFlag']").prop("name","alarmFlagAll");
                $(".danger_2").hide();
                $(".danger_1").hide();
                $(".danger_3").hide();
				
			});
		}
</script>
</html>