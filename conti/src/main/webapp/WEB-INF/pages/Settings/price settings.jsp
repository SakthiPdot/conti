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
    <title>${title}</title>
    <!-- Bootstrap Styles-->
    <link href="resources/built-in/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="resources/built-in/assets/css/font-awesome.min.css" rel="stylesheet" />
	
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- Custom Styles-->
    <link href="resources/built-in/assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css"> 
    
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	 <link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
	  <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet"> 
	  
		 <link href="resources/custom/css/custom.css" rel="stylesheet">
	 	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <script src="resources/custom/js/app.js"></script>
	 </head>


<body style="overflow-x:hidden;">
 
	
	<jsp:include page="../Dashboard/settings_nav.jsp"/>
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      
      	    		
      		  <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">                            
						<div class="panel-body customer-font">
						<b>${title}</b>
						</div>
                        </div>
                    </div>
                </div>
                
                <div class="row customer-field">
                <div class="col-lg-12">
               
                   <div class="col-lg-2">
                		
                	</div>  
               
                <div class="col-lg-8">
               
                <div class="panel panel-default">
                <div class="panel-body">
                 <div class="col-lg-6 col-xs-12">
                	
                		<span>From Branch</span>
                		<select class="form-control">
                			<option>Coimbatore Branch</option>
                			<option>Chennai Branch</option>
                			<option>Bangalore Branch</option>
                		</select>
                		
                		<span>Service</span>
                		<select class="form-control">
                			<option>Counter</option>
                			<option>Door Delivery</option>                			
                		</select>
                		
                		<span>Product</span>
                		<select class="form-control">
                			<option> Small Box </option>
                			<option>Large Box</option>                			
                		</select>
                		
                		<span>Product Type</span>
                		<select class="form-control">
                			<option> Box </option>
                			<option> Cover</option>                			
                		</select>
                </div>  
                
                
                <div class="col-lg-6 col-xs-12 default-price">
                		<input type="checkbox" value=""> &nbsp;&nbsp; <span>Default Price</span>
                		 <input type="text" class="form-control">
                		 <input type="checkbox" value=""> &nbsp;&nbsp; <span>Default Handling Charges</span>
                		 <input type="text" class="form-control">
                </div>
                
                </div>
                </div>
                </div>
            
                <div class="col-lg-2"></div>
                 
                </div>
                </div>
                
                
                
                
                 
                        
                
                <div class="row">
                <div class="col-lg-12">
                
                
							
                	<div class="col-lg-2">
                		
                	</div>  
                	
                	        <div class="col-lg-8">                	
                               <div class="panel panel-default">                                
                                <div class="panel-body">
                                  <div class="table-responsive">
                                     <table class="table table-striped table-bordered table-hover">
	                                    <thead>
	                                        <tr>
	                                          
	                                            <th class="text-center">To Branch</th>
	                                            <th class="text-center" colspan="3">Weight Range</th>	                                         
	                                            <th class="text-center" >Price</th>
	                                            <th class="text-center" >Actions</th>
	                                        </tr>
	                                    </thead>
		                                    <tbody>
		                                        <tr>
		                                            <td>
		                                            	<select class="form-control">
								                			<option>Coimbatore Branch</option>
								                			<option>Chennai Branch</option>
								                			<option>Bangalore Branch</option>
								                		</select>
								                    </td>
		                                            <td class="col-sm-1"><input type="text" class="form-control"></td>
		                                            <td class="col-sm-1" style="text-align:center;">To</td>
		                                            <td class="col-sm-1"><input type="text" class="form-control"></td>
		                                            <td><input type="text" class="form-control"></td>
		                                            <td class="text-center"><button class="btn btn-primary"><i class="fa fa-pencil-square-o fa-lg"></i>  Edit</button> 
		                                            <button class="btn btn-danger"><i class="fa fa-trash fa-lg"></i>  Delete</button></td>
		                                           
		                                        </tr>
		                                        
		                                    </tbody>
                                   </table>
                                   
                                   <button class="btn btn-primary"><i class="fa fa-plus fa-lg"></i></button> 
                            </div>
                        </div>
                    </div>
                   </div>                	
                	
                	
                	<div class="col-lg-2">
                		
                	</div>  
			
                	
                </div>
                </div>
                
                               
               <br>
               <br>
                
                <div class="row">
                <div class="col-lg-12 col-md-12 col-xs-12">
                
                	<div class="col-lg-5 col-md-3">
                	</div>
                	
                
                	
                	<div class="col-lg-1 col-md-3 col-xs-8">
                		<button type="button" class="btn btn-danger"><i class="fa fa-times"></i>  Clear</button>
                	</div>
                	
                	<div class="col-lg-2 col-md-3 col-xs-4">
                		<button type="button" class="btn btn-success"><i class="fa fa-floppy-o" aria-hidden="true"></i>    Save</button>
                	</div>  
                	
                	<div class="col-lg-4 col-md-3">
                		
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
    <script src="resources/custom/js/session.js"></script>
</body>

</html>