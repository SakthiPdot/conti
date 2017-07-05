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
    <meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>

    
    <title>${title}</title>
    <!-- Bootstrap Styles-->
    <link href="resources/built-in/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="resources/built-in/assets/css/font-awesome.css" rel="stylesheet" />
	
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	 
    <!-- Morris Chart Styles-->
    <link href="resources/built-in/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="resources/built-in/assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css"> 
	
	 <link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	  <link href="resources/built-in/assets/Drawer/animate.css" rel="stylesheet" />
	 <link href="resources/custom/css/custom.css" rel="stylesheet">
	
	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/custom/js/app.js"></script>

	

</head>


<body style="overflow-x:hidden;"
data-ng-app="contiApp" data-ng-controller="locationController as locctrl">
 
 		<div class="overlay hideme"></div>
 		
 		<form data-ng-submit="locctrl.submit()">
 		<div class="drawer ">
 			<div class="row">
 			<div class="col-lg-12 trowserHeader">
 				 
                   <div class="col-lg-6 headerLeft">
                   		 <b class="model-title">Location Master</b>
                   </div>
                   
                   <div class="col-lg-6 headerRight">
                   		<i class="fa fa-times fa-2x drawerClose  pull-right iconLeft"></i>
                   </div>
            
             </div>
 			</div>
               
                 
                 
                 <div class="model-body">
                 
	                  <div class="row">
			                <div class="col-lg-12 title_area">	
					          	<div class="col-lg-12 new-masters" >
					          		 <b> New Location</b>	
					          	</div> 				            
				            </div>                
		             </div> 
                 
	                <div class="row">
		                <div class="col-lg-12">			                
			               <div class="col-lg-12 content-body">
		                 	 
		                 	  <span>Location Name</span>
			                  <input type="text"
			                  data-ng-model="locctrl.Location.location_name" 
			                  class="form-control">
			                  
			                  <span>Location Code</span>
			                  <input type="text"
			                  data-ng-model="locctrl.Location.location_code"
			                   class="form-control">
			                  
			                   <span>Abbreviation</span>
			                  <input type="text"
			                  data-ng-model="locctrl.Location.abbreviation"
			                   class="form-control">    
			                
		            	 </div>  
			           </div> 
			             
			             
			             <div class="col-lg-12">
	                		<div class="col-lg-6 content-body">
	                	     <span>City</span>
	                	     
	                	     
	                	     <select 
	                	    	 data-ng-model="locctrl.location.selectedAddress"
	                	    	 data-ng-options="x.city  for x in locctrl.addresses|orderBy:'city' track by x.id"
	                	    	 class="form-control"
	                	    	 data-ng-change="updateAddressDetail()"
	                	    	 id="city">
	                	    		<option value="">--Select City --</option> 
	                	     </select>
	                	     
	                	     
								<input type="text"
								data-ng-hide="true"
								data-ng-model="locctrl.Location.address.id"
								id="city" 
			                  	class="form-control"/>
			                  	
								 <span>State</span>
			                     <input type="text"
			                     data-ng-model="locctrl.Location.address.state" class="form-control">
	                		</div>
	                			
	                		
	                		<div class="col-lg-6 content-body">
	                	           
			                  <span>Country</span>
			                  <input type="text" class="form-control"
			                  data-ng-model="locctrl.Location.address.country">
			                  
			                  <span>Pincode</span>
			                  <input type="text" class="form-control"
			                  data-ng-model="locctrl.Location.pincode">
			                  
	                		</div>
	                	</div>
	                	
	                	
	                	               
	                </div> 
	                
	                                
	                
	                </div>
                 
                 <div class="modal-footer footerHeight" >
				
				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-4 footerLeft">
							<button type="button" class=" btn btn-danger drawerClose pull-left" ><i class="fa fa-trash-o"></i> Clear</button>
						</div>
						
						<div class="col-lg-4" style="text-align:center; !important;">
							<a id="" class="btnPadding btn btn-warning"	style="display: none; "><i class="fa fa-trash"  aria-hidden="true"></i> &nbsp;Delete</a> 
							
							<a id="" class="btnPadding btn btn-primary" style="display:none;">Clear</a>							
						</div>
						
						<div class="col-lg-4 footerRight">

						 <button type="submit" class="btn btn-success"><i class="fa fa-floppy-o "></i> Save</button>					
						
						</div>
					</div>
				</div>
            </div>
 			
 			
 			
 		</div>
 		</form>
	
	<jsp:include page="../Dashboard/nav.jsp"/>
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      
      		<div class="header "> 
             <div class="page-header header-size">
                 	  <b>${title}</b>
                 	  
                 	  <button class="btn btn-info drawerOpen pull-right" >Add New Location</button>
             </div>             										
		   </div>
      		
      		<div id="page-inner">  
		 <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                             Location Register
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                            <div class="row">
                              <div class="col-lg-12">
                               <div class="col-lg-6">
                                     <div class="dataTables_length" id="dataTables-example_length">
							<div class="dropdown">
								<button class="btn btn-info dropdown-toggle"
									type="button" data-toggle="dropdown">
									Batch Action <span class="caret"></span>
								</button>
								<ul class="dropdown-menu">
									<li><a href="#">Email</a></li>
									<li><a id="deletearchieve">Archive</a></li>

								</ul>
								<!--<button type="button" class="btn btn-primary">Filter</button>-->
							</div>
							<!-- dropdown -->

						</div> 
                                </div>
                                
                              <div class="col-lg-6 icons-button">
                                   <div class="pull-right">
                                     <button type="button" class="btn btn-info"><i class="fa fa-cog fa-lg"></i></button>
                                      <button type="button" class="btn btn-info"><i class="fa fa-file-excel-o fa-lg"></i></button>
                                      <button type="button" class="btn btn-info"><i class="fa fa-print fa-lg"></i></button>
                                	</div>
                                </div>
                              </div>
                            </div>
                          
                            
                            
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>S.No</th>
                                            <th>Location Name</th>
                                            <th>Location Code</th>
                                            <th>Abbreviation</th>
                                            <th>City</th>
                                            <th>State</th>
                                            <th>Country</th>
                                            <th>Pincode</th>
                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>Peelamedu</td>
                                            <td>cbe002</td>
                                            <td>Landmark</td>
                                            <td>Coimbatore</td>
                                            <td>Tamilnadu</td>
                                            <td>India</td>
                                            <td>632541</td>
                                          
                                        </tr>
                                          <tr>
                                            <td>2</td>
                                            <td>RS Puram</td>
                                            <td>cbe003</td>
                                            <td>Landmark</td>
                                            <td>Coimbatore</td>
                                            <td>Tamilnadu</td>
                                            <td>India</td>
                                            <td>632541</td>
                                          
                                        </tr>
                                       <tr>
                                            <td>3</td>
                                            <td>RS Puram</td>
                                            <td>cbe003</td>
                                            <td>Landmark</td>
                                            <td>Coimbatore</td>
                                            <td>Tamilnadu</td>
                                            <td>India</td>
                                            <td>632541</td>
                                          
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
    <!-- JS Scripts-->
    <!--====================================================== SCRIPTS START=========================================-->

       <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
        </script>
        
        
	<script type="text/javascript" src="resources/custom/js/validation.js"></script>
	<script type="text/javascript" src="resources/custom/js/Location/location_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/Address/address_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/Location/location_control.js"></script>
	
   <!--====================================================== SCRIPTS END =========================================-->

</body>

</html>