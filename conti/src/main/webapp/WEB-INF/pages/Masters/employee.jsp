<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
    <link rel="icon" type="image/gif/png" href="resources/Image/conti_logo.png">
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
	
	
	 <link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	 
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	 <link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
	 <link href="resources/custom/css/custom.css" rel="stylesheet">
	 <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">
	 
	 <link href="resources/custom/css/demo.css" rel="stylesheet">

	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script type="text/javascript" src="resources/built-in/js/lodash.js"></script> 
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
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
 		  <form data-ng-submit="ctrl.submit()" 
 		  style="margin-bottom: 250px;" name="empForm" class="form-horizontal formBottom">
 			<div class="row">
 			<div class="col-lg-12 trowserHeader">
 				 
                   <div class="col-lg-10 headerLeft">
                   		 <b class="model-title">Employee {{ctrl.heading}} </b> 
                   </div>
                   
                   <div class="col-lg-2 headerRight">
                   		<!-- <i class="fa fa-times fa-2x drawerClose pull-right iconLeft" onClick="drawerClose('.drawer')" data-ng-click = "ctrl.reset()"></i> -->
                   		<i class="fa fa-times fa-2x drawerClose pull-right iconLeft" data-ng-click = "ctrl.close('Close')"></i>
                   </div>
            
             </div>
 			</div>
                
  
                 <input type="hidden" data-ng-model="ctrl.employee.emp_id" />
                 <div class="model-body">
                 
                    <div class="row">
			                <div class="col-lg-12 title_area">	
					          	<div class="col-lg-12 new-masters" >
					          		 <b  data-ng-show="ctrl.employee.emp_id == null" > New Employee</b>	
					          	</div> 				            
				            </div>                
		             </div> 
	                <div class="row">
		                <div class="col-lg-12">
		                <div class="col-lg-12 content-body">
		                 	   <span>Employee Name <span class="required">*</span></span>	         
			                   <input type="text" class="form-control" maxlength="50" onKeyPress="return CheckIsCharacterWithspace(event,this.value)" data-ng-model="ctrl.employee.emp_name" data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee Name"
			                    required />
			                   
			                   <span>Employee Code</span>
			                   <input type="text" class="form-control" maxlength="6" onKeyPress="return CheckIsAlphaNumeric(event)" data-ng-model="ctrl.employee.emp_code" data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee code" />
			                
			           
			             </div>         	
			             </div> 
			             
			             
			             <div class="col-lg-12">
		                <div class="col-lg-6 content-body">
		                 	   <span>Employee Category <span class="required">*</span></span>	         
			                   <!-- <select class="form-control" data-ng-model="ctrl.employee.empcategory" required>
			                   		<option>Driver</option>
			                   		<option>Courier Staff</option>
			                   		<option>System User</option>
			                   </select> -->
			               
			               		<angucomplete-alt id="empcategory" data-ng-model="ctrl.employee.empcategory"
									              placeholder="Ex : Driver"
									              pause="100"
									              selected-object="employeecategory"
									              remote-url="empCategory/"
						            			  remote_url-data-field="EmployeeMaster"
									              match-class="highlight"
									              search-fields="empcategory"
									              title-field="empcategory"
									              minlength="3"
									              field-required="true"
												  data-trigger="focus" data-toggle="popover" 
												  data-placement="top" data-content="Please Enter Employee category"
												  initial-value="{{ctrl.employee.empcategory}}"
												  
									              input-class="form-control form-control-small">
              					</angucomplete-alt>
			              </div> 

			               <div class="col-lg-6 content-body" >    
			                   <span>Branch Name <span class="required">*</span></span>
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
						              remote-url="getBranch4Employee/"
						              remote_url-data-field="Branch"
						              
						              search-fields="branch_name"
						              title-field="branch_name"
									  match-class="highlight"
									  initial-value="{{ctrl.employee.branchModel.branch_name}}"
						              minlength="3"
						              field-required="true"
						              data-trigger="focus" data-toggle="popover" 
						              data-placement="top" data-content="Please Enter Employee branch name"
						              onKeyPress="return CheckIsCharacter(event)"
						              input-class="form-control form-control-small">
              				</angucomplete-alt>

			           		<input type="hidden" id = "branch_id" name ="branch_id" value = "{{branch_name.originalObject}}" />
			             </div>         	
			             </div>  
			             
			             <div class="col-lg-12">
		                <div class="col-lg-12 content-body">
		                 	   <span>Address Line 1 <span class="required">*</span></span>	         
			                   <input type="text" class="form-control" data-ng-model="ctrl.employee.emp_address1" maxlength = "50"
			                   data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee address" required>
			                   
			                   <span>Address Line 2</span>
			                   <input type="text" class="form-control" data-ng-model="ctrl.employee.emp_address2" maxlength = "50"
			                   data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee address"
			                    >
			                   
			                   <span>Location <span class="required">*</span></span>
			                  <!--  <select class="form-control"  data-ng-model="ctrl.employee.location_id" required>
			                   		<option value="" selected>-- Select --</option>
			                   		<option>Peelamedu</option>
			                   		<option>RS Puram</option>
			                   		<option>TownHall</option>
			                   </select> -->
			                	
			           
			           			 <angucomplete-alt id="location_name" data-ng-model="ctrl.employee.location_name"
									              placeholder="Ex : Coimbatore"
									              pause="0"
									              remote-url="getLocation4emp/"
						             			  remote_url-data-field="Location"
						             			  
									              selected-object="location_name"
									              	
									              search-fields="location_name,pincode"
									              description-field="pincode"
									              title-field="location_name"
												  match-class="highlight"
												 
									              minlength="3"
	   											  data-trigger="focus" data-toggle="popover" 
	   											  data-placement="top" data-content="Please Enter Employee location"
	   											  onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" 
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
		                 	   <span>Phone No <span class="required">*</span></span>	         
			                  <input type="text" class="form-control" minlength = "10" maxlength="10" onKeyPress="return CheckIsNumeric(event)" data-ng-model="ctrl.employee.emp_phoneno" 
			                  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee mobile number" required />
			               
			              </div> 
			               <div class="col-lg-6 content-body">    
			                   <span>Email </span>
			                   <input type="email" class="form-control" data-ng-model="ctrl.employee.emp_email" 
			                   data-trigger="focus" data-toggle="popover" data-placement="top" maxlength = "30" data-content="Please Enter Employee email id" />
			                 
			                
			           
			             </div>         	
			             </div>  
			             
			             
			             <div class="col-lg-12">
			                <div class="col-lg-6 content-body">
			                 	   <span>Date of Birth </span> 
								   <div class=" input-group">
				                  	  <input type="text" class="form-control datepicker1" data-ng-model="ctrl.employee.dob"
			                               data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of birth" />
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i>
                                            </span>
	                                          
	                               </div> 
				               
				              </div> 
				              
				               <div class="col-lg-6 content-body">    
				                   <span>Date of Joining </span>	
				                
				           
				                  <div class=" input-group">
				                               <input type="text" class="form-control datepicker2" data-ng-model="ctrl.employee.doj" 
				                               data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of joining">
				                             
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
						<div class="col-lg-4 col-xs-4 footerLeft">
							<button type="button" class=" btn btn-warning  pull-left" data-ng-click="ctrl.close('Cancel')" > <i class="fa fa-ban" aria-hidden="true"></i>
							Cancel</button>
						</div>
						
						<div class="col-lg-4 col-xs-4" style="text-align:center; !important;">
							
							<a id="" class="btnPadding btn btn-danger"	 data-ng-click="ctrl.deleteEmployee()"  data-ng-show="ctrl.employee.emp_id!=null" ><i class="fa fa-trash"  aria-hidden="true"></i> &nbsp;Delete</a>
							<a id="" class="btnPadding btn btn-primary" data-ng-click = "ctrl.clear()" data-ng-show="!empForm.$pristine && (ctrl.employee.emp_id==null)"><i class="fa fa-eraser" aria-hidden="true"></i> Clear</a>							
						</div>
						
						<div class="col-lg-4 col-xs-4 footerRight" data-ng-show="!(ctrl.employee.emp_id== null)">
							<button class="btn btn-success " type="submit"
								
								id="saveclose" data-id="0" data-ng-click="save($event)"
								type="submit">
								<i class="fa fa-floppy-o "> </i> Update</button>
							<br>
						</div>
						
						<div class="col-lg-4 col-xs-4 footerRight" data-ng-show = "ctrl.employee.emp_id==null">

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
 
	
		<jsp:include page="../Dashboard/settings_nav.jsp"/>
	
	
 		
 	<sec:authorize access="hasRole('SUPER_ADMIN') or hasRole('MANAGER')">
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      
      		<div class="header "> 
             <div class="page-header header-size">
                 	  <b>${title}</b>
                 	  
                 	  <button class="btn btn-primary drawerOpen pull-right" onClick="drawerOpen('.drawer')" >Add New Employee</button>
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
								<button class="btn btn-primary dropdown-toggle"
									type="button" data-toggle="dropdown">
									Batch Action <span class="caret"></span>
								</button>
								<ul class="dropdown-menu">
									<li><a data-ng-click = "ctrl.makeActive()">Active</a></li>
									<li><a data-ng-click = "ctrl.makeinActive()">In Active</a></li>
								</ul>
								<!--<button type="button" class="btn btn-primary">Filter</button>-->
							</div>
							<!-- dropdown -->
							 <div class = "row paddingtop">
	                                    <div class = "col-md-12"> 
	                                    <select name ="shownoofrec" data-ng-model="shownoofrec" data-ng-options = "noofrec for noofrec in [10, 15, 25, 50, 100]" class ="form-control" data-ng-change="ctrl.shownoofRecord()">
	                                    	
	                                    </select>
	                                    </div>
                             </div>
						</div> 
                                </div>
                                
                               <div class="col-lg-6 icons-button">
                                   <div class="pull-right">
                                   
                                   <form name="empPrint" method = "POST" action = "employee_print" class="padding-button">
                                     <a type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a> 
                                     <div class="dropdown-menu regSettings pull-right" style="padding-right: 5px;">
                                     	<div class ="checkbox">
                                     		<label>
                                     			<i class = "fa" data-ng-class="{'fa-check': setting_empname == true, 'fa-times': setting_empname == false}"></i>
												<input type="checkbox" data-ng-init = "setting_empname=true" data-ng-model="setting_empname" /> Employee Name
											</label>
										</div>
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_empcode == true, 'fa-times': setting_empcode == false}"></i>
												<input type="checkbox" data-ng-init = "setting_empcode=true" data-ng-model="setting_empcode" /> Employee code
											</label>
										</div>
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_empcategory == true, 'fa-times': setting_empcategory == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_empcategory=true" data-ng-model="setting_empcategory" /> Employee category
											</label>
										</div>
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_empbranch == true, 'fa-times': setting_empbranch == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_empbranch=true" data-ng-model="setting_empbranch" /> Branch
											</label>
										</div>
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_empaddress == true, 'fa-times': setting_empaddress == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_empaddress=true" data-ng-model="setting_empaddress" /> Address
											</label>
										</div>
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_empmobileno == true, 'fa-times': setting_empmobileno == false}"></i>																				
												<input type="checkbox" data-ng-init = "setting_empmobileno=true" data-ng-model="setting_empmobileno" /> Mobileno
											</label>
										</div>
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_empemail == true, 'fa-times': setting_empemail == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_empemail=true" data-ng-model="setting_empemail" /> Email
											</label>
										</div>										
										<div class = "checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_empdob == true, 'fa-times': setting_empdob == false}"></i>
												<input type="checkbox" data-ng-init = "setting_empdob=true" data-ng-model="setting_empdob" /> DOB
											</label>
										</div>
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_empdoj == true, 'fa-times': setting_empdoj == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_empdoj=true" data-ng-model="setting_empdoj" /> DOJ
											</label>
										</div>
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_empstatus == true, 'fa-times': setting_empstatus == false}"></i>
												<input type="checkbox" data-ng-init = "setting_empstatus=true" data-ng-model="setting_empstatus" /> Status
											</label>
										</div>
										
									</div>	
							
                                      <a type="button" class="btn btn-primary" onclick="location.href='downloadExcelEmployee'; valid = true;"><i class="fa fa-file-excel-o fa-lg"></i></a>
                                      
                                      
	                                      <button type="submit" class="btn btn-primary"  data-ng-disabled = "ctrl.selected_employee.length == 0" ><i class="fa fa-print fa-lg"></i></button>
	                                      <input type = "hidden" name = "emp" value = "{{ctrl.selected_employee}}"/>
	                                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                      </form>
                                       
                                      <div class = "row paddingtop">
	                                    <div class = "col-md-12"><input type = "text" class="form-control" name = "search" placeholder = "Ex: Driver" data-ng-model = "ctrl.emp_regSearch" data-ng-keyup = "ctrl.registerSearch(ctrl.emp_regSearch)"/></div>
                                      </div>
                                	</div>
                                </div>
                              </div>
                            </div>
                             

                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                        	<th><input type="checkbox" data-ng-click="ctrl.empSelectall()" data-ng-model = "selectall" /></th>
                                            <!-- <th>S.No</th> -->
                                            <th data-ng-show = "setting_empname"
                                            data-ng-click="empName=!empName;sortTable('empName',empName);">Employee Name<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':empName,'fa fa-caret-down':!empName}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_empcode"
                                            data-ng-click="empCode=!empCode;sortTable('empCode',empCode);">Employee Code<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':empCode,'fa fa-caret-down':!empCode}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_empcategory"
                                            data-ng-click="empCategory=!empCategory;sortTable('empCategory',empCategory);">Employee Category<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':empCategory,'fa fa-caret-down':!empCategory}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_empbranch"
                                            data-ng-click="empBN=!empBN;sortTable('empBN',empBN);">Branch<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':empBN,'fa fa-caret-down':!empBN}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_empaddress"
                                            data-ng-click="empAdress1=!empAdress1;sortTable('empAdress1',empAdress1);">Address<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':empAdress1,'fa fa-caret-down':!empAdress1}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_empmobileno"
                                            data-ng-click="empMobileNo=!empMobileNo;sortTable('empMobileNo',empMobileNo);">Mobile<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':empMobileNo,'fa fa-caret-down':!empMobileNo}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_empemail"
                                            data-ng-click="empEmail=!empEmail;sortTable('empEmail',empEmail);">Email<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':empEmail,'fa fa-caret-down':!empEmail}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_empdob"
                                            data-ng-click="empDOB=!empDOB;sortTable('empDOB',empDOB);">Date of Birth<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':empDOB,'fa fa-caret-down':!empDOB}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_empdoj"
                                            data-ng-click="empDOJ=!empDOJ;sortTable('empDOJ',empDOJ);">Date of Joining<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':empDOJ,'fa fa-caret-down':!empDOJ}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_empstatus"
                                            data-ng-click="empStatus=!empStatus;sortTable('empStatus',empStatus);">Status<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':empStatus,'fa fa-caret-down':!empStatus}"
														aria-hidden="true"></i></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                       <!--  <tr
                                        	data-ng-repeat = "emp in ctrl.Filteremployees.slice(((currentPage-1)*itemsPerPage), ((currentPage)*itemsPerPage)) | orderBy : 'emp_name'"
                                        	data-ng-dblclick="ctrl.updateEmployee(emp)"> -->
                                        	 <tr
                                        	data-ng-repeat = "emp in ctrl.Filteremployees | limitTo:pageSize"
                                        	data-ng-dblclick="ctrl.updateEmployee(emp)">
                                        	<td><input type="checkbox" data-ng-change="ctrl.empSelect(emp)" data-ng-model = "emp.select" /></td>
                                            <!-- <td>{{(currentPage*10)-(10-($index+1))}}</td> -->
                                            <!-- <td>{{(currentPage*10)+($index+1)}}</td> -->
                                            <td data-ng-show = "setting_empname">{{emp.emp_name}}</td>
                                            <td data-ng-show = "setting_empcode">{{emp.emp_code}}</td>
                                            <td data-ng-show = "setting_empcategory">{{emp.empcategory}}</td>
                                            <td data-ng-show = "setting_empbranch">{{emp.branchModel.branch_name}}</td>
                                            <td data-ng-show = "setting_empaddress">
                                            	<div data-ng-if="!emp.emp_address1==''">{{emp.emp_address1}},</div>
                                           		<div data-ng-if="!emp.emp_address2==''">{{emp.emp_address2}},</div>
                                            	<div data-ng-if="!emp.location.location_name!==''">{{emp.location.location_name}},</div>
                                           		<div data-ng-if="!emp.location.address.city!==''">{{emp.location.address.city}},</div>
                                           		<!-- <div data-ng-if="!emp.location.address.district!==''">{{emp.location.address.district}},</div> -->
                                           		<div data-ng-if="!emp.location.address.state!==''">{{emp.location.address.state}},</div>
                                           		<div data-ng-if="!emp.location.pincode!==''">{{emp.location.pincode}}.</div>
                                           	</td>
                                            <td data-ng-show = "setting_empmobileno">{{emp.emp_phoneno}}</td>
                                            <td data-ng-show = "setting_empemail">{{emp.emp_email}}</td>
                                            <td data-ng-show = "setting_empdob">{{emp.dob}}</td>
                                            <td data-ng-show = "setting_empdoj">{{emp.doj}}</td>
                                            <td data-ng-show = "setting_empstatus" data-ng-class="{'makeGreen': emp.active=='Y', 'makeRed': emp.active=='N'}">{{emp.active == 'Y' ? 'ACTIVE' : 'INACTIVE'}}</td>
                                       </tr>
                                       
                                 
                                    </tbody>
                                </table>
                                
                                 <div class ="col-lg-6">
                                	<div class="pull-left">
                               			 Showing {{(currentPage*pageSize)+1}} to 
                               			 {{ (totalnof_records - (((currentPage+1)*pageSize))) > 0 ? (currentPage+1)*pageSize : totalnof_records }}
                               			 of {{totalnof_records}} entries
                               		</div>
                                </div>
                                
                                <div class="col-lg-6 icons-button">
                                   <div class="pull-right">
                                   		<!-- <ul>
                                   			<li class="btn btn-primary" data-ng-click = "paginatebyno($index+1)" data-ng-repeat = "i in counter(noofpages) track by $index"> {{$index+1}}</li>
                                   		</ul>  -->
                                     	<!-- <pagination total-items="totalItems" ng-model="currentPage" max-size="maxSize" class="pagination-sm" boundary-links="true" rotate="false" num-pages="numPages" items-per-page="itemsPerPage"></pagination>  -->
										 <button class="btn btn-primary" type = "button" data-ng-disabled="previouseDisabled" data-ng-click = "firstlastPaginate(1)">First</button>                                     											
										
										<button class="btn btn-primary" type = "button" data-ng-disabled="previouseDisabled" data-ng-click = "paginate(-1)">Previouse</button>
										<button class="btn btn-primary" type = "button" data-ng-disabled="nextDisabled" data-ng-click = "paginate(1)">Next</button>
										
										<button class="btn btn-primary" type = "button" data-ng-disabled="nextDisabled" data-ng-click = "firstlastPaginate(0)">Last</button>
                                	</div>
                                </div>
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
    </sec:authorize>
    <!-- /. WRAPPER  -->
    <sec:authorize access="hasRole('STAFF')">
	    <div id="wrapper">        	  
			<div id="page-wrapper"> 
				<div class="header "> 
		             <div class="page-header header-size">
		                 	  <b>${title}</b>		                 	 
		             </div>	   
             	</div>	
             	
             	<div id="page-inner">  
					<div class="row">
                		<div class="col-md-12">
                			 <div class="panel panel-default">
		                        <div class="panel-heading">
		                             Employees Register
		                        </div>
		                        <div class="panel-body">
		                        	Sorry..! You are not authorized to view this master..!
		                        </div>
		                      </div>
                		</div>
                	</div>
                </div>		
			 </div>
		</div>
	</sec:authorize>

<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script> -->

<!-- 	<script src="resources/libs/jspdf.min.js"></script>
	<script src="resources/libs/jspdf.plugin.autotable.src.js"></script>		
	<script src="resources/libs/examples.js"></script>   -->

<!-- <script src="resources/built-in/assets/js/jquery-1.10.2.js"></script>  -->


  <script src="resources/custom/js/custom.js"></script>
  <script src="resources/custom/js/employee_master/employee_controller.js"></script>
  <script src="resources/custom/js/employee_master/employee_service.js"></script>
  <script src="resources/custom/js/branch_master/branch_service.js"></script>
  <script src="resources/custom/js/Location/location_service.js"></script>
  <script src="resources/custom/js/confirmDialog.js"></script>   
  <script type="text/javascript" src="resources/custom/js/validation.js"></script>
  <!-- Custom Js -->

 	  
<script>
	$('[data-toggle="popover"]').popover();
	$('.regSettings').click(function(e) {
	    e.stopPropagation();
	});

</script>

    <script type="text/javascript">

    function getDate(){
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1; //January is 0!
        var yyyy = today.getFullYear();

        if(dd<10) {
            dd = '0'+dd
        } 

        if(mm<10) {
            mm = '0'+mm
        } 

        today =  yyyy+'-'+mm+ '-'+ dd;
        return today;
    }
	    $('.datepicker1').dateTimePicker({
	        limitMax: getDate()
	    });
	    
	    $('.datepicker2').dateTimePicker({
	        limitMax: getDate()
	    });
        </script>
</body>

</html>