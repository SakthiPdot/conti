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
    <link href="resources/built-in/assets/css/font-awesome.css" rel="stylesheet" />
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
	  <link href="resources/built-in/assets/Drawer/animate.css" rel="stylesheet" />
	 <link href="resources/custom/css/custom.css" rel="stylesheet">
	 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/css/bootstrap-dialog.min.css">
	  <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">
	 
    <script src="resources/built-in/assets/js/jquery-1.10.2.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script> 
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script>    
    <script src="resources/custom/js/app.js"></script>
</head>


<body style="overflow-x:hidden;" data-ng-app="contiApp" data-ng-controller="BranchController as ctrl">
  <!-- ------------------------- Overlay for message begin ------------------ -----  -->
 		<div class="overlay hideme"></div>
 
  <!-- ------------------------- Success message begin ------------------ -----  -->
 		
 <!-- ------------------------- Success message begin ------------------ -----  -->
	<div class="success hideme">
		<i class="fa fa-check-circle" aria-hidden="true"></i> {{ctrl.message}}
		<span class="close" data-ng-click = "ctrl.forgot_animateClose()"><i class="fa fa-times" aria-hidden="true"></i></span>
	</div>
<!-- ------------------------- Success message end ------------------ -----  -->
<!-- ------------------------- Failure message begin ------------------ -----  -->	
	<div class="failure hideme">
		<i class="fa fa-times-circle" aria-hidden="true"></i> {{ctrl.message}}
		<!-- <span class="close" data-ng-click = "ctrl.forgot_animateClose()"><i class="fa fa-times" aria-hidden="true"></i></span> -->
	</div>
<!-- ------------------------- Failure message end ------------------ -----  -->
 
 		<div class="drawer hideme">
 		<form data-ng-submit="ctrl.submit()" name="branchForm" class="form-horizonral">
 			<div class="row">
 			<div class="col-lg-12 trowserHeader">
 				 
                   <div class="col-lg-6 headerLeft">
                   		 <b class="model-title">Branch {{ctrl.heading}}</b>
                   </div>
                   
                   <div class="col-lg-6 headerRight">
                   		<i class="fa fa-times fa-2x drawerClose pull-right iconLeft" data-ng-click="ctrl.close()"></i>
                   </div>
            
             </div>
 			</div>
               
                 
                 <input type="hidden" data-ng-model="ctrl.branch.branch_id" />
                 <div class="model-body">
                 
                   <div class="row">
			                <div class="col-lg-12 title_area">	                
			              
				          	<div class="col-lg-12 new-masters" >
				          		 <b> New Branch</b>	
				          	</div> 
				            
				            </div>                
		          </div> 
		             
		             
	                <div class="row">
		                <div class="col-lg-12">
			                <div class="col-lg-12 content-body">
			                	<span>Branch Name</span>			                	
			                	<input type="text" class="form-control" maxlength="50" onKeyPress="return CheckIsCharacterWithspace(event,this.value)" data-ng-model="ctrl.branch.branch_name" data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Branch Name">
			                	
			                	<span>Branch Code</span>			                	
			                	<input type="text" class="form-control" maxlength="10" onKeyPress="return CheckIsCharacterWithspace(event,this.value)" data-ng-model="ctrl.branch.branch_code" data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Branch code">
			                	
			                		                	
			                	<span>Address Line 1</span>			                	
			                	<input type="text" class="form-control" maxlength="100" onKeyPress="return CheckIsCharacterWithspace(event,this.value)" data-ng-model="ctrl.branch.branch_addressline1" data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Address line 1">
			                	
			                	<span>Address Line 2</span>			                	
			                	<input type="text" class="form-control" maxlength="50" onKeyPress="return CheckIsCharacterWithspace(event,this.value)" data-ng-model="ctrl.branch.branch_addressline2" data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Address line 2">
			                	
			                	<span>Location</span>			                	
			                	<angucomplete-alt id="location_name" data-ng-model="ctrl.branch.location_name"
									              placeholder="Ex : Coimbatore"
									              pause="0"
									              selected-object="location_name"
									              local-data="ctrl.locations"
									              search-fields="location_name,pincode"
									              title-field="location_name,pincode"
												  match-class="highlight"
												  initial-value="{{ctrl.branch.location.location_name}}"
									              minlength="1"
	   											 data-trigger="focus" data-toggle="popover" 
	   											 data-placement="top" data-content="Please Enter branch location"
	   											 onKeyPress="return CheckIsCharacter(event)"
									              input-class="form-control form-control-small">
              						</angucomplete-alt>
              						<input type="hidden" id = "location_id" name ="location_id" value = "{{location_name.originalObject}}" />
			               </div>		                                
		                </div> 
		                
		                
		                
		                <div class="col-lg-12">
			                <div class="col-lg-6 content-body">
		                 	   <span>City </span>	         
			                    <input type="text" id="city" class="form-control disabled locations" tabindex="-1" value="{{location_name.originalObject.address.city}}">
			                    
			                     <span>State </span>	         
			                    <input type="text" id="state" class="form-control disabled locations" tabindex="-1" value="{{location_name.originalObject.address.state}}">
			               
			              </div> 
			               <div class="col-lg-6 content-body">    
			                     <span>Country </span>	         
			                    <input type="text" id="country" class="form-control disabled locations" tabindex="-1" value="{{location_name.originalObject.address.country}}">
			                    
			                     <span>Pincode </span>	         
			                    <input type="text" id="pincode" class="form-control disabled locations" tabindex="-1" minlength = "6" maxlength="6" onKeyPress="return CheckIsNumeric(event)" value="{{location_name.originalObject.pincode}}">
			           
			             </div> 	                                
		                </div> 
		                
		                
		                
		                <div class="col-lg-12">
			                <div class="col-lg-6 content-body">
			                	<span>Contact  Person</span>			                	
			                	
			                	<input type="text" class="form-control" maxlength = "30" onKeyPress="return CheckIsNumeric(event)" data-ng-model="ctrl.branch.branch_contactperson" 
			                  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Branch contact person" required />
			                	
			              
			               </div>	
			               
			               <div class="col-lg-6 content-body">
			                	<span>Contact Number</span>			                	
			                	<input type="text" class="form-control" minlenth="10" maxlength = "12" onKeyPress="return CheckIsNumeric(event)" data-ng-model="ctrl.branch.branch_contactperson" 
			                  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Branch contact Number" required />
			              
			               </div>		                                
		                </div>
		                
		                
		                <div class="col-lg-12">
			                <div class="col-lg-12 content-body">
			                	 <span>Contact Mail</span>			                	
			                	<input type="text" class="form-control" maxlength = "30" onKeyPress="return CheckIsNumeric(event)" data-ng-model="ctrl.branch.branch_mailid" 
			                  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Branch Email id" required />
			               </div>		                                
		                </div>
		                
		                
		                <div class="col-lg-12">
			                <div class="col-lg-6 content-body">
			                	<span>LR Invoice No Prefix</span>			                	
			                	<input type="text" class="form-control" maxlength = "30" onKeyPress="return CheckIsNumeric(event)" data-ng-model="ctrl.branch.LRnumber_prefix" 
			                  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Branch Invoice no prefix" required />
			                	
			                	
			              
			               </div>	
			               
			               <div class="col-lg-6 content-body">
			                	<span>Receipt Invoice No Prefix</span>			                	
			                	<input type="text" class="form-control" maxlength = "30" onKeyPress="return CheckIsNumeric(event)" data-ng-model="ctrl.branch.receipt_prefix" 
			                  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Branch Receipt number" required />
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

						 <button type="button" class="btn btn-success"><i class="fa fa-floppy-o "></i> Save</button>					
						
						</div>
					</div>
				</div>
            </div>
 			
 			</form>
 			
 </div>
 
	
	<jsp:include page="../Dashboard/settings_nav.jsp"/>
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      
      		<div class="header "> 
             <div class="page-header header-size">
                 	  <b>${title}</b>
                 	  
                 	  <button class="btn btn-primary drawerOpen pull-right" onClick="drawerOpen('.drawer')" >Add New Branch</button>
             </div>           
             </div>
      		
      		<div id="page-inner">  
		 <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Branch Register
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
                                            <th>Branch Name</th>
                                            <th>Branch Code</th>
                                            <th>Address</th>
                                            <th>Contact Person</th>
                                            <th>Contact Number</th>
                                            <th>Contact Mail</th>
                                            <th>LR No Prefix</th>
                                            <th>Receipt No Prefix</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><input type="checkbox"></td>
                                            <td>1</td>
                                            <td>Coimbatore</td>
                                            <td>cbe002</td>
                                            <td>RS Puram</td>
                                            <td>Kumar</td>
                                            <td>9876543210</td>
                                            <td>Kumar@gmail.com</td>
                                            <td>LRC001</td>
                                            <td>RC008</td>
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
    

  <script src="resources/custom/js/custom.js"></script>
  <script src="resources/custom/js/branch_master/branch_controller.js"></script>
  <script src="resources/custom/js/branch_master/branch_service.js"></script>
  <script src="resources/custom/js/Location/location_service.js"></script>
  <script src="resources/custom/js/confirmDialog.js"></script>   
  <script type="text/javascript" src="resources/custom/js/validation.js"></script>
       
  

</body>

</html>