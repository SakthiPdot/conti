<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib
    prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
<%@ page isELIgnored="false" %> 
<%@page session="true"%>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${title}</title>
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
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css"> 
	
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	  <link href="resources/custom/css/custom.css" rel="stylesheet">
</head>


<body style="overflow-x:hidden;">
 
	
	<jsp:include page="../Dashboard/nav.jsp"/>
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      
      	    		
      		  <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default panelMarginBottom">                            
						<div class="panel-heading">
							
						</div>
						<div class="panel-body customer-font">
						<b>${title}</b>
						</div>
                        </div>
                    </div>
              </div>
                
             
             <div class="row">
             	<div class="col-lg-12 col-md-12">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Employee Details 
                        </div>
                        <div class="panel-body">
                            	<div class="col-md-12 col-lg-12">
                            		<div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth">Employee Name </span> <span class="spanclass">:  </span>
                            		     <span class="viewprofile_color">${user.employeeMaster.emp_name}</span>                      		    
                            		</div>
                            		
                            	                        		
                            	</div>
                            	
                            	<div class="col-md-12">
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Employee Code</span> <span class="spanclass">:  </span>                            		   
                            		     <span class="viewprofile_color">${user.employeeMaster.emp_code}</span>                         		    
                            		    
                            		</div>
                            	</div>
                            	
                            	<div class="col-md-12">
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Employee Category</span> <span class="spanclass">:  </span>                            		                                		    
                            		    <span class="viewprofile_color">${user.employeeMaster.empcategory}</span>
                            		</div>
                            	</div>
                            	
                            	<div class="col-md-12">
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Branch Name</span> <span class="spanclass">:  </span>                            		                               		    
                            		    <span class="viewprofile_color">${user.branchModel.branch_name}</span>
                            		</div>
                            	</div>
                            	
                            	<div class="col-md-12">
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Address</span> <span class="spanclass">:  </span>                            		                               		    
                            		     <span class="viewprofile_color">${user.employeeMaster.emp_address1},${user.employeeMaster.emp_address2}</span>
                            		</div>
                            	</div>
                            	
                            	<div class="col-md-12">
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Mobile No</span> <span class="spanclass">:  </span>                            		                                		    
                            		     <span class="viewprofile_color">${user.employeeMaster.emp_phoneno}</span>
                            		</div>
                            	</div>
                            	
                            	<div class="col-md-12">
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Email</span> <span class="spanclass">:  </span>                            		                           		    
                            		    <span class="viewprofile_color">${user.employeeMaster.emp_email}</span>
                            		</div>
                            	</div>
                            	
                            	<div class="col-md-12">
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Date of Birth</span> <span class="spanclass">:  </span>                            		                              		    
                            		    <span class="viewprofile_color">${user.employeeMaster.dob}</span>
                            		</div>
                            	</div>
                            	
                            	<div class="col-md-12">
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Date of Joining</span> <span class="spanclass">:  </span>
                            		   <span class="viewprofile_color">${user.employeeMaster.doj}</span>                           		    
                            		   
                            		</div>
                            	</div>
                        </div>
                     
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           User Settings
                        </div>
                        <div class="panel-body">
                          	<div class="col-md-12">
                          		<div class="col-md-12 branchclass">
                          			<span class="text-paddingwidth">User Name</span> <span class="spanclass">:  </span>
                          			<span class="viewprofile_color">${user.username}</span>
                            		                        		    
                            	</div>
                          	</div>
                          	
                          	<div class="col-md-12">
                          		<div class="col-md-12 branchclass">
                          			<span class="text-paddingwidth">Role Name</span> <span class="spanclass">:  </span>
                          			 <span class="viewprofile_color">${role_name}</span> 
                            		<!--  <input type="text" class="form-control" disabled>  -->                           		    
                            	</div>
                          	</div>
                          	
                        </div>
                      
                    </div>
                </div>
                
                
            </div>
            </div>   
                
                
                   
                
                              
            
        </div>
        <!-- /. PAGE WRAPPER  -->
		
		
    </div>
    <!-- /. WRAPPER  -->
    

</body>

</html>