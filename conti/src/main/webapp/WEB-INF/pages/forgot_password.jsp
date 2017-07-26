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
    
   <meta name="_csrf" content="${_csrf.token}"/>
   <meta name="_csrf_header" content="${_csrf.headerName}"/>

   <title>${title}</title>
  <!-- Bootstrap Styles-->
    <link href="resources/built-in/assets/css/bootstrap.css" rel="stylesheet" />
  	<link rel="stylesheet" href="resources/custom/css/login.css">
  	<link rel="stylesheet" href="resources/custom/css/success_failure_msg.css">
  	<link href="resources/built-in/assets/Drawer/animate.css" rel="stylesheet" />
  	
<!--   	<link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" /> -->
  	 <!-- FontAwesome Styles-->
    <link href="resources/built-in/assets/css/font-awesome.css" rel="stylesheet" />
  
</head>

<body data-ng-app = "contiApp" data-ng-controller = "UserController as ctrl">
<!-- ------------------------- Overlay for message begin ------------------ -----  -->
	<div class="overlay hideme"></div>
<!-- ------------------------- Overlay for message end ------------------ -----  -->	
<!-- ------------------------- Success message begin ------------------ -----  -->
	<div class="success-forgot hideme">
		<i class="fa fa-check-circle" aria-hidden="true"></i> {{ctrl.message}}
		<span class="close" data-ng-click = "ctrl.forgot_animateClose()"><i class="fa fa-times" aria-hidden="true"></i></span>
	</div>
<!-- ------------------------- Success message end ------------------ -----  -->
<!-- ------------------------- Failure message begin ------------------ -----  -->	
	<div class="failure hideme">
		<i class="fa fa-times-circle" aria-hidden="true"></i> {{ctrl.message}}
		<!-- <span class="close" data-ng-click = "ctrl.forgot_animateClose()"><i class="fa fa-times" aria-hidden="true"></i></span> -->
	</div>
	<div class="failure-forgot hideme">
		<i class="fa fa-times-circle" aria-hidden="true"></i> {{ctrl.message}}
		<span class="close" data-ng-click = "ctrl.forgot_animateClose()"><i class="fa fa-times" aria-hidden="true"></i></span>
	</div>
<!-- ------------------------- Failure message end ------------------ -----  -->
	<div class="login-page"  >
	  <div class="form">
	    
	    <form name="login-form" class="login-form" role="form" data-ng-submit = "ctrl.findUsername()" >
      	      <input class="form-control" data-ng-model = "ctrl.user.username" placeholder="Username" id="username" name="username" type="text" autofocus required />      		  
     	      <button type="submit">Get password</button>
     		  <p class="message"> << <a href="login">Go back</a></p>
     		  <input type="text" name="${_csrf.parameterName}" value="${_csrf.token}" />
	    </form>
	    
	  </div>
	</div>


 	<script type="text/javascript" src="resources/built-in/js/jquery-1.11.1.min.js"></script>
 	
 	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
 	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script type="text/javascript" src="resources/built-in/js/lodash.js"></script> 
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
	<script type="text/javascript" src="resources/custom/js/app.js"></script>
 	<script type="text/javascript" src="resources/custom/js/user_master/user_control.js"></script>
 	<script type="text/javascript" src="resources/custom/js/user_master/user_service.js"></script>
 	<script type="text/javascript" src="resources/custom/js/validation.js"></script>
 	<script src="resources/custom/js/branch_master/branch_service.js"></script>  
	<script src="resources/custom/js/employee_master/employee_service.js"></script>
	<script src="resources/custom/js/confirmDialog.js"></script>   
    
</body>

</html>
