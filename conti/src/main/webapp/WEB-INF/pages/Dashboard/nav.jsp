<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib
    prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page isELIgnored="false" %> 
<%@page session="true"%>

<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    
    <meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />
	
    <title>Conti</title>
    <!-- Bootstrap Styles-->
    <link href="resources/built-in/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="resources/built-in/assets/css/font-awesome.css" rel="stylesheet" />
	
	 <link href="resources/built-in/assets/Drawer/animate.css" rel="stylesheet" />
	 
    <!-- Morris Chart Styles-->
    <link href="resources/built-in/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="resources/built-in/assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <!--<link href='http://fonts.googleapis.com/css\?family=Open+Sans' rel='stylesheet' type='text/css' />-->
    <link rel="stylesheet" href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css"> 
	

	<link href="resources/built-in/css/bootstrap-dialog.min.css" rel="stylesheet" type="text/css">

	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	 <link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	 
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	 <link href="resources/custom/css/custom.css" rel="stylesheet">

</head>

<body>

		
		
		
    <div id="wrapper">
        <nav class="navbar navbar-default top-navbar" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/Conti/"><!-- <strong>Conti</strong> -->
                <img style ="width: 80% !important;
			    height: 140%;
			    padding-bottom: 7px;
			    padding-left: 20px;" src="resources/Image/conti.png"></a>
				
		<!-- <img alt="hi" src="resources/Image/dashboard.png"> -->
            </div>

           <ul class="nav navbar-top-links navbar-right">
              <!--  <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                        <i class="fa fa-envelope fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-messages">
                        <li>
                            <a href="#">
                                <div>
                                    <strong>John Doe</strong>
                                    <span class="pull-right text-muted">
                                        <em>Today</em>
                                    </span>
                                </div>
                                <div>Lorem Ipsum has been the industry's standard dummy text ever since the 1500s...</div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <strong>John Smith</strong>
                                    <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
                                </div>
                                <div>Lorem Ipsum has been the industry's standard dummy text ever since an kwilnw...</div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <strong>John Smith</strong>
                                    <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
                                </div>
                                <div>Lorem Ipsum has been the industry's standard dummy text ever since the...</div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a class="text-center" href="#">
                                <strong>Read All Messages</strong>
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </li>
                    </ul>
                   
                </li>-->
             
              <!--   <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                        <i class="fa fa-tasks fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-tasks">
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Task 1</strong>
                                        <span class="pull-right text-muted">60% Complete</span>
                                    </p>
                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                                            <span class="sr-only">60% Complete (success)</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Task 2</strong>
                                        <span class="pull-right text-muted">28% Complete</span>
                                    </p>
                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="28" aria-valuemin="0" aria-valuemax="100" style="width: 28%">
                                            <span class="sr-only">28% Complete</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Task 3</strong>
                                        <span class="pull-right text-muted">60% Complete</span>
                                    </p>
                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                                            <span class="sr-only">60% Complete (warning)</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Task 4</strong>
                                        <span class="pull-right text-muted">85% Complete</span>
                                    </p>
                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" style="width: 85%">
                                            <span class="sr-only">85% Complete (danger)</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a class="text-center" href="#">
                                <strong>See All Tasks</strong>
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </li>
                    </ul>
                    
                </li>-->
              
                 <!-- <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                        <i class="fa fa-bell fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-alerts">
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-comment fa-fw"></i> New Comment
                                    <span class="pull-right text-muted small">4 min</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-twitter fa-fw"></i> 3 New Followers
                                    <span class="pull-right text-muted small">12 min</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-envelope fa-fw"></i> Message Sent
                                    <span class="pull-right text-muted small">4 min</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-tasks fa-fw"></i> New Task
                                    <span class="pull-right text-muted small">4 min</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="fa fa-upload fa-fw"></i> Server Rebooted
                                    <span class="pull-right text-muted small">4 min</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a class="text-center" href="#">
                                <strong>See All Alerts</strong>
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </li>
                    </ul>
                  
                </li>-->
              
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                       WELCOME <sec:authentication property="principal.username" /><i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="user_profile"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li><a href="password_change"><i class="fa fa-gear fa-fw"></i> Accounts Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="javascript:formSubmit()"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                   
                </li>
              <c:url value="/clogout" var="logoutUrl" />
	<form action="${logoutUrl}" method="get" id="logoutForm">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
	</form>
	
              <script>
					function formSubmit() {
						document.getElementById("logoutForm").submit();
					}
	          </script>
            </ul>
            
            
            
            
            
        </nav>
        <!--/. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">

                    <li>
                        <a id="dashboard" href="/Conti/"><i class="fa fa-dashboard"></i> Dashboard</a>
                    </li>
					
					 
					
                    <li>
                        <a href="customer" id="screen_customer"><i class="fa fa-user"></i> Customer</a>
                    </li>
					<li>
                        <a href="#"><i class="fa fa-truck"></i> Shipment Management<span class="fa arrow"></span></a>
						
						<ul class="nav nav-third-level">
                                    <li>
                                        <a href="add_shipment" id="screen_addshipment">Add Shipment</a>
                                    </li>
                                    <li>
                                        <a href="view_shipment" id="screen_viewshipment">View  Shipment</a>
                                    </li>
                                    

                        </ul>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-qrcode"></i> Manifest Management<span class="fa arrow"></span></a>
							<ul class="nav nav-third-level">
								<li>
									<a href="add_manifest" >Add Manifest</a>
								</li>
								<li>
									<a href="view_manifest">View Manifest</a>
								</li>
							
							</ul>
                    </li>
                    
                    <li>
                        <a href="#"><i class="fa fa-file-text-o"></i> Receipt <span class="fa arrow"></span></a>
						   <ul class="nav nav-third-level">
							<li>
								<a href="receipt_generate">Receipt Generation</a>
							</li>
							
							<li>
								<a href="view_receipt">View Receipt</a>
							</li>
							
							</ul>
                    </li>
                    <li>
                        <a href="report" id="screen_report"><i class="fa fa-flag"></i> Reports </a>
                    </li>
                    
                     <sec:authorize access="hasRole('SUPER_ADMIN') or hasRole('MANAGER')">
	                    <li>
	                        <a href="company_settings"><i class="fa fa-wrench"></i> Settings</a>
	                        
	                    </li>
                    </sec:authorize>
                </ul>

            </div>

        </nav>
        <!-- /. NAV SIDE  -->
      
	 
	  
	  
	  
		
        <!-- /. PAGE WRAPPER  -->
		
		
    </div>
    <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
    <!-- jQuery Js -->
    <script src="resources/built-in/assets/js/jquery-1.10.2.js"></script>
    
    <!-- Bootstrap Js -->
     <script src="resources/built-in/assets/js/bootstrap.min.js"></script> 
	<script src=" resources/custom/js/date-time-picker.min.js" ></script>
    <!-- Metis Menu Js -->
    <script src="resources/built-in/assets/js/jquery.metisMenu.js"></script>
    
    <!-- Morris Chart Js -->
    <script src="resources/built-in/assets/js/morris/raphael-2.1.0.min.js"></script>
    <script src="resources/built-in/assets/js/morris/morris.js"></script>
	
	
	<script src="resources/built-in/assets/js/easypiechart.js"></script>
	<script src="resources/built-in/assets/js/easypiechart-data.js"></script>
	
	 <script src="resources/built-in/assets/js/Lightweight-Chart/jquery.chart.js"></script>
	
    <!-- Custom Js -->
    <script src="resources/built-in/assets/js/custom-scripts.js"></script>
	<script src="resources/custom/js/session.js"></script>

	<script type="text/javascript" src="resources/built-in/js/bootstrap-dialog.min.js"></script>
</body>

</html>