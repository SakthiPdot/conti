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
    <link href="http://localhost:8080/Conti/resources/built-in/assets/css/bootstrap.css" rel="stylesheet" />
  	<link rel="stylesheet" href="http://localhost:8080/Conti/resources/custom/css/login.css">
  	  	<link rel="stylesheet" href="http://localhost:8080/Conti/resources/custom/css/success_failure_msg.css">
  	<link href="http://localhost:8080/Conti/resources/built-in/assets/Drawer/animate.css" rel="stylesheet" />
  	
  	<link href="http://localhost:8080/Conti/resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
  	 <!-- FontAwesome Styles-->
    <link href="http://localhost:8080/Conti/resources/built-in/assets/css/font-awesome.css" rel="stylesheet" />

</head>

<body class = "scrollHidden" data-ng-app = "contiApp" data-ng-controller = "UserController as ctrl">

	<div class="success hideme"><i class="fa fa-check-circle" aria-hidden="true"></i> {{ctrl.message}}</div>
	<div class="failure hideme"><i class="fa fa-times-circle" aria-hidden="true"></i> {{ctrl.message}}</div>


	<c:choose>
		<c:when test="${valid}">
			
			<c:choose>
				<c:when test="${!link_used}">
					<c:choose>
						<c:when test="${!link_expired}">
							
								<div class = "row">
									<div class= "col-lg-12">
									
										<div class="login-page"  >
										  <div class="form">
										    <form name="login-form" class="login-form" role="form" data-ng-submit = "ctrl.resetPassword()" >
										    		<input class="form-control" type="hidden" name = "id" id = "id" value = "${user_id}" />
										    		<input class="form-control" type="hidden" name = "link" id = "link" value = "${hascode}" />
									      	      <input class="form-control" data-ng-model = "ctrl.user.userpassword" placeholder="New password" id="userpassword" name="userpassword" type="password" data-ng-keyup = "ctrl.getPassword(ctrl.user.userpassword)" autofocus required />
									      	      <input class="form-control" data-ng-model = "ctrl.user.confpassword" placeholder="Confirm Password" id="confpassword" name="confpassword" type="password" data-ng-keyup = "ctrl.checkPassword(ctrl.user.userpassword, ctrl.user.confpassword)" autofocus required />      		  
											      <span data-ng-show = "!ctrl.checkPWD">Password doesn't match</span>
									     	      <button type="submit" data-ng-disabled = "((ctrl.resetBtn) && (ctrl.checkPWD))? false : true">Reset</button>
									     		  <!-- <p class="message"> << <a href="login">Go back</a></p> -->
									     		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										    </form>
										   </div>
										   
										   
										</div>
										
										
										<div class="passward_validate hidden">
											<ul>
												<li>
													<i class="fa fa-check-circle caps red" aria-hidden="true"></i> at least one capital letter
												</li>
												<li>
													<i class="fa fa-check-circle num red" aria-hidden="true"></i> at least one numeric
												</li>
												<li>
													<i class="fa fa-check-circle specialchar red" aria-hidden="true"></i> at least one special character
												</li>
												<li>
													<i class="fa fa-check-circle minchar red" aria-hidden="true"></i> minimum 8 characters
												</li>
											</ul>
										</div>
									</div>
								</div>
						
						</c:when>
						
						<c:when test="${link_expired}">
							<div class="login-page"  >
								  <div class="form">
								    <form class="login-form" >
								    <i class="fa fa-meh-o fa-5x" style="color: #90bccc" aria-hidden="true"></i>
								    </form>
								    <form class="login-form" style = "color: #90bccc; font-size: x-large;">
								   		 oops..! Your link already expired..!
								    </form>
								  </div>
							</div>
						</c:when>
					</c:choose>
						
				</c:when>
				<c:when test="${link_used}"> 
						<div class="login-page"  >
							  <div class="form">
							    <form class="login-form" >
							    <i class="fa fa-meh-o fa-5x" style="color: #90bccc" aria-hidden="true"></i>
							    </form>
							    <form class="login-form" style = "color: #90bccc; font-size: x-large;">
							   		 oops..! You have been used this already..!
							    </form>
							  </div>
						</div>
				</c:when>
			</c:choose>
			
			
				
					
					
					
		</c:when>
		
		<c:when test="${!valid}">
			<div class="login-page"  >
				  <div class="form">
				    <form class="login-form" >
				    <i class="fa fa-meh-o fa-5x" style="color: #90bccc" aria-hidden="true"></i>
				    </form>
				    <form class="login-form" style = "color: #90bccc; font-size: x-large;">
				   		 oops..! file not found..!
				    </form>
				  </div>
			</div>
		</c:when>
	</c:choose>
	


 	<script type="text/javascript" src="http://localhost:8080/Conti/resources/built-in/js/jquery-1.11.1.min.js"></script>
 	<script type="text/javascript" src="http://localhost:8080/Conti/resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="http://localhost:8080/Conti/resources/custom/js/session.js"></script>
 	<script type="text/javascript" src="http://localhost:8080/Conti/resources/custom/js/app.js"></script>
 	<script type="text/javascript" src="http://localhost:8080/Conti/resources/custom/js/user_master/user_control.js"></script>
 	<script type="text/javascript" src="http://localhost:8080/Conti/resources/custom/js/user_master/user_service.js"></script>
    
</body>

</html>
