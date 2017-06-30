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
</head>


<body style="overflow-x:hidden;">
 
 		<div class="overlay hideme"></div>
 		
 		<div class="drawer hideme">
 			<div class="row">
 			<div class="col-lg-12 trowserHeader" style="height: 60px;padding-top: 10px;background-color: antiquewhite;">
 				 
                   <div class="col-lg-6 headerLeft">
                   		 <b class="model-title">Product Master</b>
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
			          		 <b> New Product</b>	
			          	</div>  
			          	
			      </div>                
	                </div> 
	                
	                <div class="row">
		                <div class="col-lg-12">
			                
			               <div class="col-lg-12 content-body">
		                 	 
		                 	  <span>Product Name</span>
			                  <input type="text" class="form-control">
			                  
			                  <span>Product Code</span>
			                  <input type="text" class="form-control">
			                  
			                   <span>Product Type</span>
			                  <select class="form-control">
			                  		<option>Box</option>
			                  		<option>Cover</option>
			                  </select>
			                  
			                  <span>Max.Weight in Kg</span>
			                  <input type="text" class="form-control">
			
			               
			             </div>  
			             </div>
			             
			             
			             <div class="col-lg-12">
			                
			               <div class="col-lg-12 content-body setup">
		                 	 
		                       <b><span>Dimension Setup 
                               <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>Yes
                               <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">No
                                </span>
                               </b>
			               
			             </div>  
			             </div>
			             
			             
			             <div class="col-lg-12">
			                
			               <div class="col-lg-12 content-body">
		                 	 
		                 	  <span>Maximum Height</span>
			                  <input type="text" class="form-control">
			                  
			                  <span>Maximum Width</span>
			                  <input type="text" class="form-control">
			                  
			                   <span>Maximum Length</span>
			                  <input type="text" class="form-control">
			                  
			                 	
			               
			             </div>  
			             </div>
			                             
	                </div>   
	                
	                
	              
	                             
                 </div>
                 
                 <div class="modal-footer footerHeight">
				
				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-4 footerLeft" >
						
							<button type="button"  class="btn btn-danger drawerClose pull-left "><i class="fa fa-trash-o"></i> Clear</button>
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
                 	  
                 	  <button class="btn btn-info drawerOpen pull-right" >Add New Product</button>
             </div>	        
             										
		 </div>
		 
		 
		 <div id="page-inner">  
		 <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                             Advanced Tables
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
                                            <th>Product Name</th>
                                            <th>Product Code</th>
                                            <th>Product Type</th>
                                            <th>Maximum Weight in Kg</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>Small Box</td>
                                            <td>PR001</td>
                                            <td>Box</td>
                                            <td>2</td>
                                       </tr>
                                       <tr>
                                            <td>2</td>
                                            <td>Large Box</td>
                                            <td>PR001</td>
                                            <td>Office Cover</td>
                                            <td>1</td>
                                       </tr>
                                         <tr>
                                            <td>3</td>
                                            <td>Large Box</td>
                                            <td>PR001</td>
                                            <td>Office Cover</td>
                                            <td>1</td>
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