<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>无权访问</title>
  </head>
  
  <body> 
   
    <div class="container-fluid">
        
        <div class="row-fluid">
	    <div class="http-error">
	        <h1>403</h1>
	        <p class="info">无权访问该页面</p>
	    </div>
	</div>
 </body>
</html>


