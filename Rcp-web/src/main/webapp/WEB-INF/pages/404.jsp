<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>页面不存在</title>
  </head>

  <body> 
    <div class="container-fluid">
        
        <div class="row-fluid">
	    <div class="http-error">
	        <h1>404</h1>
	        <p class="info">页面不存在</p>
	    </div>
	</div>
  </body>
</html>


