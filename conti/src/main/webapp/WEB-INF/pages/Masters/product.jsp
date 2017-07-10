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
	 <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet"> 	
 	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script>
	<script type="text/javascript" src="resources/custom/js/app.js"></script>
	 
</head>


<body style="overflow-x:hidden;">
 
 		<div class="overlay hideme"></div>
 		
 		
  <!-- Master Drawer Beginning  -->
  
  
 		<div class="drawer ">
 			<div class="row">
 			<div class="col-lg-12 trowserHeader">
 				 
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
		                  
		                  <span>Max.Weight</span>
		                  <div class="input-group">
		                  <input type="text" class="form-control">
							<span class="input-group-addon" id="basic-addon1"><label>kg</label></span>
						</div>
			               
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
		                  <div class="input-group">
			                  <input type="text" class="form-control">			                  
							<span class="input-group-addon" id="basic-addon1"><label>cm</label></span>
						</div>
			                  
			                  <span>Maximum Width</span>
		                  <div class="input-group">
			                  <input type="text" class="form-control">			                  
							<span class="input-group-addon" id="basic-addon1"><label>cm</label></span>
						</div>
			                  
			                   <span>Maximum Length</span>
		                  <div class="input-group">
			                  <input type="text" class="form-control">		                  
							<span class="input-group-addon" id="basic-addon1"><label>cm</label></span>
						</div>	                  
			                 	
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
 
	<!-- Master Drawer Completed -->
	
	
	<jsp:include page="../Dashboard/settings_nav.jsp"/>
<<<<<<< HEAD
=======
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
		
		
		 <div class="header "> 
             <div class="page-header header-size">
                 	  <b>${title}</b>
                 	  
                 	  <button class="btn btn-primary drawerOpen pull-right" onClick="drawerOpen('.drawer')" >Add New Product</button>
             </div>	        
             										
		 </div>
		 
		 
		 <div id="page-inner">  
		 <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                             Product Register
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
>>>>>>> branch 'master' of https://github.com/Pointdot2017/conti.git

	<div id="wrapper">
		<div id="page-wrapper">


			<div class="header ">
				<div class="page-header header-size">
					<b>${title}</b>

					<button class="btn btn-primary drawerOpen pull-right">Add
						New Product</button>
				</div>

			</div>


			<div id="page-inner">
				<div class="row">
					<div class="col-md-12">
						<!-- Advanced Tables -->
						<div class="panel panel-default">
							<div class="panel-heading">Product Register</div>
							<div class="panel-body">
								<div class="table-responsive">
									<div class="row">
										<div class="col-lg-12">
											<div class="col-xs-6">
												<div class="dataTables_length"
													id="dataTables-example_length">
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
													<button type="button" class="btn btn-primary">
														<i class="fa fa-cog fa-lg"></i>
													</button>
													<button type="button" class="btn btn-primary">
														<i class="fa fa-file-excel-o fa-lg"></i>
													</button>
													<button type="button" class="btn btn-primary">
														<i class="fa fa-print fa-lg"></i>
													</button>
												</div>
											</div>
										</div>
									</div>



									<table class="table table-striped table-bordered table-hover"
										id="dataTables-example">
										<thead>
											<tr>
												<th><input type="checkbox"></th>
												<th>S.No</th>
												<th>Product Name</th>
												<th>Product Code</th>
												<th>Product Type</th>
												<th>Maximum Weight in Kg</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><input type="checkbox"></td>
												<td>1</td>
												<td>Small Box</td>
												<td>PR001</td>
												<td>Box</td>
												<td>2</td>
											</tr>
											<tr>
												<td><input type="checkbox"></td>
												<td>2</td>
												<td>Large Box</td>
												<td>PR001</td>
												<td>Office Cover</td>
												<td>1</td>
											</tr>
											<tr>
												<td><input type="checkbox"></td>
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

	<!--====================================================== SCRIPTS START=========================================-->
	<script>$('[data-toggle="popover"]').popover();</script>
	<script type="text/javascript" src="resources/custom/js/validation.js"></script>
	<script type="text/javascript" src="resources/custom/js/Location/location_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/CompanySetting/company_setting_directive.js"></script>
	<script type="text/javascript" src="resources/custom/js/CompanySetting/company_setting_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/Address/address_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/CompanySetting/company_setting_control.js"></script>
<!--====================================================== SCRIPTS END =========================================-->


</body>

</html>