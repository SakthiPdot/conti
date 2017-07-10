<!DOCTYPE html>
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
    <title>  ${title}</title>
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
	
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	 <link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	 
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	 <link href="resources/custom/css/custom.css" rel="stylesheet">
</head>


<body style="overflow-x:hidden;">
 
 		<div class="overlay hideme"></div>
 		
 		<div class="drawer hideme">
 			<div class="row">
 			<div class="col-lg-12 trowserHeader" >
 				 
                   <div class="col-lg-6 headerLeft">
                   		 <b class="model-title">Customer Master</b>
                   </div>
                   
                   <div class="col-lg-6 headerRight">
                   		<i class="fa fa-times fa-2x drawerClose pull-right iconLeft"></i>
                   </div>
            
             </div>
 			</div>
                
                 
                 
                 <div class="model-body">
                 
                    <div class="row">
			                <div class="col-lg-12 title_area">	                
			              
				          	<div class="col-lg-12 new-masters" >
				          		 <b> New Customer</b>	
				          	</div> 
				            
				            </div>                
		             </div> 
                 
	                <div class="row">
		                <div class="col-lg-12">
		                <div class="col-lg-12 content-body">
		                 	   <span>Customer Name </span>	         
			                   <input type="text" class="form-control">
			                   
			                   <span>Customer Code</span>
			                   <input type="text" class="form-control">
			                   
			                    <span>Phone Number</span>
			                   <input type="text" class="form-control">
			                
			           
			             </div>         	
			             </div> 
			             
			             
			             <div class="col-lg-12">
		                <div class="col-lg-6 content-body">
		                 	   <span>Customer Type </span>	         
			                   <select class="form-control">
			                   		<option>Credit</option>
			                   		
			                   </select>
			               
			              </div> 
			               <div class="col-lg-6 content-body">    
			                   <span>Branch Name</span>
			                   <select class="form-control">
			                   		<option>Coimbatore</option>
			                   		<option>Chennai</option>
			                   		<option>Bangalore</option>
			                   </select>
			                
			           
			             </div>         	
			             </div>  
			             
			             <div class="col-lg-12">
		                <div class="col-lg-12 content-body">
		                
		                       <span>Company Name </span>	         
			                   <input type="text" class="form-control">
			                   
		                 	   <span>Address Line 1 </span>	         
			                   <input type="text" class="form-control">
			                   
			                   <span>Address Line 2</span>
			                   <input type="text" class="form-control">
			                   
			                   
			                
			           
			             </div>         	
			             </div>
			             
			             <div class="col-lg-12">
		                <div class="col-lg-6 content-body">
		                     <span>Location</span>
			                   <select class="form-control">
			                   		<option>Peelamedu</option>
			                   		<option>RS Puram</option>
			                   		<option>TownHall
			                   </select>
		                
		                 	   <span>City </span>	         
			                    <input type="text" class="form-control">
			                    
			                     <span>State </span>	         
			                    <input type="text" class="form-control">
			               
			              </div> 
			               <div class="col-lg-6 content-body">    
			                     <span>Country </span>	         
			                    <input type="text" class="form-control">
			                    
			                     <span>Pincode </span>	         
			                    <input type="text" class="form-control">
			                     <span>Email</span>
			                   <input type="text" class="form-control">
			           
			             </div>         	
			             </div> 
			             
			   
			       </div>
	              
	          </div>
                 
                 <div class="modal-footer footerHeight">
				
				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-4 footerLeft">
							<button type="button" class="btn btn-danger drawerClose pull-left"><i class="fa fa-trash-o"></i> Clear</button>
						</div>
						
						<div class="col-lg-4" style="text-align:center; !important;">
							<a id="" class="btnPadding btn btn-warning"	style="display: none; "><i class="fa fa-trash"  aria-hidden="true"></i> &nbsp;Delete</a> 
							
							<a id="" class="btnPadding btn btn-primary" style="display:none;">Clear</a>							
						</div>
						
						<div class="col-lg-4 footerRight">

						 	 <button type="button" class="btn btn-success"><i class="fa fa-floppy-o "></i> Save</button>					
						
						</div>
					</div>
				</div>
            </div>
 			
 			
 			
 		</div>
 
	
	<jsp:include page="../Dashboard/settings_nav.jsp"/>
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      
      		<div class="header "> 
             <div class="page-header header-size">
                 	  <b>${title}</b>
                 	  
                 	  <button class="btn btn-primary drawerOpen pull-right" onClick="drawerOpen('.drawer')">Add New Customer</button>
             </div>	   
             </div>
      		
      		<div id="page-inner">  
		 <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                             Customer Register
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                            <div class="row">
                              <div class="col-lg-12">
                               <div class="col-xs-6">
                                     <div class="dataTables_length" id="dataTables-example_length">
							<div class="dropdown">
								<button class="btn btn-primary dropdown-toggle"
									type="button" data-toggle="dropdown">
									Batch Action <span class="caret"></span>
								</button>
								<ul class="dropdown-menu">
									<li><a href="#">Active</a></li>
									<li><a href="#">InActive</a></li>
									<li><a href="#">Archive</a></li>

								</ul>
								
							</div>
						

						</div> 
                                </div>
                                
                               <div class="col-xs-6 icons-button">
                                   <div class="pull-right">
                                     <button type="button" class="btn btn-primary"><i class="fa fa-cog fa-lg"></i></button>
                                      <button type="button" class="btn btn-primary"><i class="fa fa-file-excel-o fa-lg"></i></button>
                                      <button type="button" class="btn btn-primary"><i class="fa fa-print fa-lg"></i></button>
                                	</div>
                                </div>
                              </div>
                            </div>
                          
                            
                            
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox"></th>
                                            <th>S.No</th>
                                            <th>Customer Name</th>
                                            <th>Customer Code</th>
                                            <th>Customer Type</th>
                                            <th>Branch Name</th>
                                            <th>Company Name</th>
                                            <th>Address</th>
                                            <th>Email</th>
                                   
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><input type="checkbox"></td>
                                            <td>1</td>
                                            <td>Kumar</td>
                                            <td>k001</td>
                                            <td>Credit</td>
                                            <td>Coimbatore</td>
                                            <td>kumar pvt ltd Street</td>
                                            <td>Singanallur</td>
                                            <td>kumar@gmail.com</td>
                                        
                                       </tr>
                                       <tr>
                                            <td><input type="checkbox"></td>
                                            <td>2</td>
                                            <td>Kesavan</td>
                                            <td>k7001</td>
                                            <td>Credit</td>
                                            <td>Coimbatore</td>
                                            <td>k7 stores</td>
                                            <td>RS Puram</td>
                                            <td>k7@gmail.com</td>
                                        
                                       </tr>
                                       <tr>
                                            <td><input type="checkbox"></td>
                                            <td>3</td>
                                            <td>Chandru</td>
                                            <td>Ch001</td>
                                            <td>Credit</td>
                                            <td>Coimbatore</td>
                                            <td>chandru pvt ltd Street</td>
                                            <td>Ganapathy</td>
                                            <td>chandru@gmail.com</td>
                                        
                                       </tr>
                          
                                                               
                                
                                 
                                    </tbody>
                                </table>
                            </div>
                            
                        </div>
                    </div>
                    <!--End Advanced Tables -->
                </div>
            </div>
      </div>
      
            
        </div>
        <!-- /. PAGE WRAPPER  -->
		
    </div>
    <!-- /. WRAPPER  -->
    <script src="resources/built-in/assets/js/jquery-1.10.2.js"></script>
      <!-- Bootstrap Js -->
    <script src="resources/built-in/assets/js/bootstrap.min.js"></script>
    <!-- Metis Menu Js -->
    <script src="resources/built-in/assets/js/jquery.metisMenu.js"></script>
     <!-- DATA TABLE SCRIPTS -->
    <script src="resources/built-in/assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="resources/built-in/assets/js/dataTables/dataTables.bootstrap.js"></script>
     <script src="resources/custom/js/custom.js"></script>
  	<script src="resources/custom/js/session.js"></script>
        <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
    </script>
         <!-- Custom Js -->


     

</body>

</html>