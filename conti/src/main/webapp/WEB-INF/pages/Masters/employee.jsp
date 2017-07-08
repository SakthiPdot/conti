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
	 <link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
	 <link href="resources/custom/css/custom.css" rel="stylesheet">
	 <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">
	 

	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script> 
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script>    

   <script src="resources/custom/js/app.js"></script>
</head>


<body style="overflow-x:hidden;" data-ng-app = "contiApp" data-ng-controller = "EmployeeController as ctrl">
 
 <!-- ------------------------- Overlay for message begin ------------------ -----  -->
	<div class="overlay hideme"></div>
<!-- ------------------------- Overlay for message end ------------------ -----  -->	
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
 		  <form data-ng-submit="ctrl.submit()" name="myForm" class="form-horizontal">
 			<div class="row">
 			<div class="col-lg-12 trowserHeader">
 				 
                   <div class="col-lg-6 headerLeft">
                   		 <b class="model-title">Employee Master </b> 
                   </div>
                   
                   <div class="col-lg-6 headerRight">
                   		<i class="fa fa-times fa-2x drawerClose pull-right iconLeft" onClick="drawerClose('.drawer')"></i>
                   </div>
            
             </div>
 			</div>
                
  
                 <input type="hidden" data-ng-model="ctrl.employee.emp_id" />
                 <div class="model-body">
                 
                    <div class="row">
			                <div class="col-lg-12 title_area">	                
			              
				          	<div class="col-lg-12 new-masters" >
				          		 <!-- <b> New Employee</b> -->	
				          	</div> 
				            
				            </div>                
		             </div> 

	                <div class="row">
		                <div class="col-lg-12">
		                <div class="col-lg-12 content-body">
		                 	   <span>Employee Name </span>	         
			                   <input type="text" class="form-control" maxlength="50" onKeyPress="return CheckIsCharacterWithspace(event,this.value)" data-ng-model="ctrl.employee.emp_name" data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee Name"
			                    required />
			                   
			                   <span>Employee Code</span>
			                   <input type="text" class="form-control" maxlength="5" onKeyPress="return CheckIsAlphaNumeric(event)" data-ng-model="ctrl.employee.emp_code" data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee code" required />
			                
			           
			             </div>         	
			             </div> 
			             
			             
			             <div class="col-lg-12">
		                <div class="col-lg-6 content-body">
		                 	   <span>Employee Category </span>	         
			                   <!-- <select class="form-control" data-ng-model="ctrl.employee.empcategory" required>
			                   		<option>Driver</option>
			                   		<option>Courier Staff</option>
			                   		<option>System User</option>
			                   </select> -->
			               
			               		<angucomplete-alt id="empcategory" data-ng-model="ctrl.employee.empcategory"
									              placeholder="Ex : Driver"
									              pause="100"
									              selected-object="employeecategory"
									              local-data="ctrl.employeecategory"
									              search-fields="empcategory"
									              title-field="empcategory"
									              minlength="0"
									              field-required="true"
												  data-trigger="focus" data-toggle="popover" 
												  data-placement="top" data-content="Please Enter Employee category"
												  initial-value="{{ctrl.employee.empcategory}}"
												  onKeyPress="return CheckIsCharacter(event)"
									              input-class="form-control form-control-small">
              						</angucomplete-alt>
			              </div> 

			               <div class="col-lg-6 content-body" >    
			                   <span>Branch Name</span>
			                  <!--  <select class="form-control" data-ng-model="ctrl.employee.branch_id" required>			                   
			                   		<option value ="" selected>--Select--</option>
			                   		<option>Coimbatore</option>
			                   		<option>Chennai</option>
			                   		<option>Bangalore</option>
			                   </select> -->
			                
			                <angucomplete-alt id="branch_name" data-ng-model="ctrl.employee.branch_name"
						              placeholder="Ex : Coimbatore"
						              pause="100"
						              selected-object="branch_name"
						              local-data="ctrl.branches"
						              search-fields="branch_name"
						              title-field="branch_name"
									  match-class="highlight"
									  initial-value=""
						              minlength="1"
						              field-required="true"
						              data-trigger="focus" data-toggle="popover" 
						              data-placement="top" data-content="Please Enter Employee branch name"
						              onKeyPress="return CheckIsCharacter(event)"
						              input-class="form-control form-control-small">
              				</angucomplete-alt>

			           		<input type="text" id = "branch_id" name ="branch_id" value = "{{branch_name.originalObject.branch_id}}" />
			             </div>         	
			             </div>  
			             
			             <div class="col-lg-12">
		                <div class="col-lg-12 content-body">
		                 	   <span>Address Line 1 </span>	         
			                   <input type="text" class="form-control" data-ng-model="ctrl.employee.emp_address1"
			                   data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee address" required>
			                   
			                   <span>Address Line 2</span>
			                   <input type="text" class="form-control" data-ng-model="ctrl.employee.emp_address2" 
			                   data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee address"
			                    required>
			                   
			                   <span>Location</span>
			                  <!--  <select class="form-control"  data-ng-model="ctrl.employee.location_id" required>
			                   		<option value="" selected>-- Select --</option>
			                   		<option>Peelamedu</option>
			                   		<option>RS Puram</option>
			                   		<option>TownHall</option>
			                   </select> -->
			                	
			           
			           			 <angucomplete-alt id="location_name" data-ng-model="ctrl.employee.location_name"
									              placeholder="Ex : Coimbatore"
									              pause="0"
									              selected-object="location_name"
									              local-data="ctrl.locations"
									              search-fields="location_name,pincode"
									              title-field="location_name,pincode"
												  match-class="highlight"
												  initial-value="{{ctrl.employee.location.location_name}}"
									              minlength="1"
	   											 data-trigger="focus" data-toggle="popover" 
	   											 data-placement="top" data-content="Please Enter Employee location"
	   											 onKeyPress="return CheckIsCharacter(event)"
									              input-class="form-control form-control-small">
              						</angucomplete-alt>
              						<input type="text" id = "location_id" name ="location_id" value = "{{location_name.originalObject}}" />

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
		                 	   <span>Phone No </span>	         
			                  <input type="text" class="form-control" minlength = "10" maxlength="10" onKeyPress="return CheckIsNumeric(event)" data-ng-model="ctrl.employee.emp_phoneno" 
			                  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee mobile number" required />
			               
			              </div> 
			               <div class="col-lg-6 content-body">    
			                   <span>Email</span>
			                   <input type="email" class="form-control" data-ng-model="ctrl.employee.emp_email" 
			                   data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee email id" required />
			                 
			                
			           
			             </div>         	
			             </div>  
			             
			             
			             <div class="col-lg-12">
			                <div class="col-lg-6 content-body">
			                 	   <span>Date of Birth </span>	 
								      `
								<!--  <div class="form-group input-group">
                                            <input type="text" class="form-control">
                                            <span class="input-group-btn">
                                                <button class="btn btn-default" type="button"><i class="fa fa-search"></i>
                                                </button>
                                            </span>
                                        </div> -->
								                 
				                   <div class="form-group input-group">
				                  
				                  
				                               <input type="text" class="form-control datepicker" data-ng-model="ctrl.employee.dob"
				                               data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of birth" required/>
	                                            <span class="input-group-addon"><i class="fa fa-calendar"></i>
	                                            </span>
	                                          
	                               </div> 
				               
				              </div> 
				              
				               <div class="col-lg-6 content-body">    
				                   <span>Date of Joining</span>
				                  <div class="form-group input-group">
				                               <input type="text" class="form-control" data-ng-model="ctrl.employee.doj" 
				                               data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of joining"
				                               required>
	                                            <span class="input-group-addon"><i class="fa fa-calendar"></i>
	                                            </span>
	                                            
	                               </div>
				           	         
				             </div>         	
			             </div>  
			             
			            
			             
			       </div>
	                
	                                
                 </div>
                 
                 <div class="modal-footer footerHeight">
				
				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-4 footerLeft">
							<button type="button" class="btn btn-danger drawerClose pull-left" data-ng-click = "ctrl.reset()"><i class="fa fa-trash-o"></i> Clear</button>
						</div>
						
						<div class="col-lg-4" style="text-align:center; !important;">
							<a id="" class="btnPadding btn btn-warning"	style="display: none; "><i class="fa fa-trash"  aria-hidden="true"></i> &nbsp;Delete</a> 
							
							<a id="" class="btnPadding btn btn-primary" style="display:none;">Clear</a>							
						</div>
						
						<div class="col-lg-4 footerRight" data-ng-show = "ctrl.employee.emp_id==null">

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
                 	  
                 	  <button class="btn btn-info drawerOpen pull-right" onClick="drawerOpen('.drawer')" >Add New Employee</button>
             </div>	   
             </div>
      		
      		<div id="page-inner">  
		 <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                             Employees Register
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
                                            <th>Employee Name</th>
                                            <th>Employee Code</th>
                                            <th>Employee Category</th>
                                            <th>Branch</th>
                                            <th>Address</th>
                                            <th>Mobile</th>
                                            <th>Email</th>
                                            <th>Date of Birth</th>
                                            <th>Date of Joining</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr
                                        	data-ng-repeat = "emp in ctrl.employees | orderBy : 'emp_name'"
                                        	data-ng-dblclick="ctrl.updateEmployee(emp)">
                                            <td>{{$index+1}}</td>
                                            <td>{{emp.emp_name}}</td>
                                            <td>{{emp.emp_code}}</td>
                                            <td>{{emp.empcategory}}</td>
                                            <td>{{emp.branch_id}}</td>
                                            <td>{{emp.emp_address}}</td>
                                            <td>{{emp.emp_phoneno}}</td>
                                            <td>{{emp.emp_email}}</td>
                                            <td>{{emp.dob}}</td>
                                            <td>{{emp.doj}}</td>
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


  <script src="resources/custom/js/custom.js"></script>
  <script src="resources/custom/js/employee_master/employee_controller.js"></script>
  <script src="resources/custom/js/employee_master/employee_service.js"></script>
  <script src="resources/custom/js/branch_master/branch_service.js"></script>
  <script src="resources/custom/js/Location/location_service.js"></script>  
  <script type="text/javascript" src="resources/custom/js/validation.js"></script>
  <!-- Custom Js -->

<script>$('[data-toggle="popover"]').popover();</script>
</body>

</html>