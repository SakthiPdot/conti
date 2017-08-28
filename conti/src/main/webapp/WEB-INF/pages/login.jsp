<!DOCTYPE html>

<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<%@ page isELIgnored="false" %> 
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    
  <%-- <meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/> --%>
	<link rel="icon" type="image/gif/png" href="resources/Image/conti_logo.png">
   <title>Conti - Login</title>
  
	<link rel="stylesheet" href="resources/custom/css/login.css"> 
</head>

<body onload='document.loginForm.username.focus();' >



	<div class="login-page">
	  <div class="form">
	  
	  	<c:if test="${not empty error}">
			<div class="error" style="color: red;" align="center">${error}</div>
		</c:if>
		
		<c:if test="${not empty msg}">
			<div class="msg" style="color: green;" align="center">${msg}</div>
		</c:if>
	    
	    <form class="login-form" role="form" name='loginForm' id="logon" action="<c:url value='/login' />" method='POST'>
	    
	      	      <input class="form-control" placeholder="Username" id="username" name="username" type="text" autofocus />
	      		  <input class="form-control" placeholder="Password" id="password" name="password" type="password" value="">
	     	      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	     	      <button>LOGIN</button>
	     	      <!-- <a href="forgot_password"><button class="forgot-button" style="width: 45%;">Forgot Password</button></a>  
	     	      <a href="forgot_username"><button class="forgot-button1" style="width: 45%;">Forgot Username</button></a> -->
	     		   <p class="message">Forgot <a href="forgot_password">Password</a> / <a href="forgot_username">User name</a></p>
	     		  
	    </form>
	    
	  </div>
	</div>


 	<script src="resources/built-in/js/jquery-1.11.1.min.js"></script>
    
</body>

</html>
