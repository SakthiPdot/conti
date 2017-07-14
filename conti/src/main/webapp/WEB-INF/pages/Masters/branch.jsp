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
	 <link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
	 <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">
	 
	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
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
			                    <input type="text" id="pincode" class="form-control disabled locations" tabindex="-1"  maxlength="6" onKeyPress="return CheckIsNumeric(event)" value="{{location_name.originalObject.pincode}}">
			           
			             </div> 	                                
		                </div> 
		                
		                
		                
		                <div class="col-lg-12">
			                <div class="col-lg-6 content-body">
			                	<span>Contact  Person</span>			                	
			                	
			                	<input type="text" class="form-control" maxlength = "30" onKeyPress="return CheckIsCharacterWithspace(event,this.value)" data-ng-model="ctrl.branch.branch_contactperson" 
			                  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Branch contact person"  />
			                	
			              
			               </div>	
			               
			               <div class="col-lg-6 content-body">
			                	<span>Contact Number</span>			                	
			                	<input type="text" class="form-control" maxlength = "12" onKeyPress="return CheckIsNumeric(event)" data-ng-model="ctrl.branch.branch_mobileno" 
			                  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Branch contact Number"  />
			              
			               </div>		                                
		                </div>
		                
		                
		                <div class="col-lg-12">
			                <div class="col-lg-12 content-body">
			                	 <span>Contact Mail</span>			                	
			                	<input type="text" class="form-control" maxlength = "30"  data-ng-model="ctrl.branch.branch_email" 
			                  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Branch Email id"  />
			               </div>		                                
		                </div>
		                
		                
		                <div class="col-lg-12">
			                <div class="col-lg-6 content-body">
			                	<span>LR Invoice No Prefix</span>			                	
			                	<input type="text" class="form-control" maxlength = "30" onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" data-ng-model="ctrl.branch.lrno_prefix" 
			                  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Branch Invoice no prefix"  />
			                	
			                	
			              
			               </div>	
			               
			               <div class="col-lg-6 content-body">
			                	<span>Receipt Invoice No Prefix</span>			                	
			                	<input type="text" class="form-control" maxlength = "30" onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" data-ng-model="ctrl.branch.receiptno_prefix" 
			                  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Branch Receipt number"  />
			               </div>		                                
		                </div>  
		                               
	                </div> 
	                
	           
	                
	                
	                            
	             </div>
                 
                 <div class="modal-footer footerHeight" >
				
				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-4 footerLeft">
							<button type="button" class=" btn btn-danger  pull-left" data-ng-click="ctrl.close()" ><i class="fa fa-times" area-hidden="true"></i> Cancle</button>
						</div>
						
						<div class="col-lg-4" style="text-align:center; !important;">
							<a id="" class="btnPadding btn btn-warning"	data-ng-click="ctrl.deleteBranch()" data-ng-show="ctrl.branch.branch_id!=null"><i class="fa fa-trash"  aria-hidden="true"></i> &nbsp;Delete</a> 
							<a id="" class="btnPadding btn btn-primary" data-ng-click="ctrl.clear()" data-ng-show="!branchForm.$pristine&&(ctrl.branch.branch_id!=null)">Clear</a>							
						</div>
						
						<div class="col-lg-4 footerRight" data-ng-show="!(ctrl.branch.branch_id==null)">

						 <button type="submit" class="btn btn-success" id="saveclose" data-id="0" data-ng-click="save($event)"><i class="fa fa-floppy-o "></i> Update</button>					
						
						</div>
						
						<div class="col-lg-4 footerRight" data-ng-show="ctrl.branch.branch_id==null">
							<div class="btn-group dropup" id="savebutton">
							<button type="submit" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false">
									<i class="fa fa-floppy-o "></i> Save
							</button>
							
							<div class="dropdown-menu pull-right" style="padding-right: 5px;">
								<button class="farmsave mybutton" id="saveclose" data-id="0"
										data-ng-click="save($event)" type="submit">Save and
										Close</button>
									<br>
									<button class="farmsave mybutton" id="savenew" data-id="1"
										data-ng-click="save($event)" type="submit">Save and
										New</button>
								<br>
							</div>	
							</div>
						</div>
					</div>
				</div>
            </div>
 			
 			</form>
 			
 </div>
 
	
	<jsp:include page="../Dashboard/nav.jsp"/>
	
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
                            <div class="table-responsive">
                             <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox"></th>
                                            <th>S.No</th>
                                            <th>Branch Name</th>
                                            <th>Branch Code</th>
                                            <th>Address 1</th>
                                            <th>Address 2</th>
                                            <th>Contact Person</th>
                                            <th>Contact Number</th>
                                            <th>Contact Mail</th>
                                            <th>LR No Prefix</th>
                                            <th>Receipt No Prefix</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat="bat in ctrl.branches|order:'branch_name'"
                                        data-ng-dblclick="ctrl.updateBranch(bat)">
                                            <td><input type="checkbox"></td>
                                            <td>{{$index+1}}</td>
                                            <td>{{bat.branch_name}}</td>
                                            <td>{{bat.branch_code}}</td>
                                            <td>{{bat.branch_addressline1}}</td>
                                            <td>{{bat.branch_addressline2}}</td>
                                            <td>{{bat.branch_mobileno}}</td>
                                            <td>{{bat.branch_email}}</td>
                                            <td>{{bat.lrno_prefix}}</td>
                                            <td>{{bat.receiptno_prefix</td>
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