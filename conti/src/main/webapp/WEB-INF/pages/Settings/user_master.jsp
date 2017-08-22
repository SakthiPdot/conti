
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
	
	 <link href="resources/built-in/assets/Drawer/animate.css" rel="stylesheet" />
	 
    <!-- Morris Chart Styles-->
    <link href="resources/built-in/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <!-- Custom Styles-->
   <!--  <link href="resources/built-in/assets/css/custom-styles.css" rel="stylesheet" /> -->
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css"> 
	
	
	 <link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	 
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	 <link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
	 <link href="resources/custom/css/custom.css" rel="stylesheet">
	 <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">
	 

	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script type="text/javascript" src="resources/built-in/js/lodash.js"></script> 
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <script src="resources/custom/js/app.js"></script>

	
</head>


<body style="overflow-x:hidden;" data-ng-app = "contiApp" data-ng-controller = "UserController as ctrl" >
 <%-- <input type = "text" id = "currentUserRole" value = "<sec:authentication property="principal.authorities[0]"/>" /> --%>
  <!-- ------------------------- Overlay for message begin ------------------ -----  -->
	<div class="overlay hideme"></div>
<!-- ------------------------- Overlay for message end ------------------ -----  -->	

<!-- ------------------------- Success message begin ------------------ -----  -->
	<div class="success hideme">
		<i class="fa fa-check-circle" aria-hidden="true"></i> {{ctrl.message}}
		<span class="close" data-ng-click = "ctrl.forgot_animateClose()"><i class="fa fa-times" aria-hidden="true"></i></span>
	</div>
<!--------------------------- Success message end ------------------ -----  -->

<!--------------------------- Failure message begin ------------------ -----  -->	
	<div class="failure hideme">
		<i class="fa fa-times-circle" aria-hidden="true"></i> {{ctrl.message}}
	</div>
<!-- ------------------------- Failure message end ------------------------->
 
 		<div class="drawer hideme">
 		<form data-ng-submit = "ctrl.submit()" name = "userForm" class="formBottom form-horizontal">
 			
 			<div class="row">
 			<div class="col-lg-12 trowserHeader"  >
 			
                   <div class="col-lg-10 col-md-8 col-sm-10  headerLeft">
                   		 <b class="model-title">User {{ctrl.heading}} </b>
                   </div>
                   
                    <div class="col-lg-2 col-md-4 col-sm-2 headerRight">
                   		<i class="fa fa-times fa-2x drawerClose  pull-right iconLeft" data-ng-click = "ctrl.close('Close')"></i>
                   </div>
            
             </div>
 			</div>
 			
               
                 
                 <input type="hidden" data-ng-model = "ctrl.user.user_id"/>
                 <div class="model-body">
                 
                     <div class="row">
		                <div class="col-lg-12 title_area">	                
		              
			          	<div class="col-lg-12 new-masters" >
			          		<b data-ng-show = "ctrl.user.user_id == null"> New User</b>
			          	</div>  
			          </div>                
	                </div> 
	                
	                <div class="row">
		                <div class="col-lg-12">              
			              
			         	<div class="col-lg-12 content-body" >
		                 	 
		                 	  <span>Branch Name <span class="required">*</span></span>
			                  
			                 <angucomplete-alt id="branch_name" data-ng-model="ctrl.user.branch_name"
						              placeholder="Ex : Coimbatore"
						              pause="100"
						              selected-object="branch_name"
						              remote-url="getBranch4Employee/"
						              remote_url-data-field="Branch"
						              
						              search-fields="branch_name"
						              title-field="branch_name"
									  match-class="highlight"
									  initial-value="{{ctrl.user.branchModel.branch_name}}"
						              minlength="3"
						              field-required="true"
						              data-trigger="focus" data-toggle="popover" 
						              data-placement="top" data-content="Please enter branch name"
						              onKeyPress="return CheckIsCharacter(event)"
						              input-class="form-control form-control-small" tabindex = "-1" data-ng-class = "{'disabled' : ctrl.user.user_id != null}">
              				</angucomplete-alt>
			                  <input type="hidden" id = "branch_id" name ="branch_id" value = "{{branch_name.originalObject}}" />
			                  
			                   <span>Employee Name <span class="required">*</span></span>
			                  <angucomplete-alt id="employee_name" data-ng-model = "ctrl.user.emp_name"
			                  placeholder = "Ex: Sankar" pause="100"
			                  selected-object="emp_name"
			                  remote-url="getEmployee4Search/"
						      remote_url-data-field="Employees"
			                 
			                  search-fields="emp_name"
			                  title-field = "emp_name"
			                  match-class="highlight"
			                  initial-value = "{{ctrl.user.employeeMaster.emp_name}}"
			                  minlength="1"
			                  field-required="true"
			                  data-trigger = "focus" data-toggle="popover"
			                  data-placement="top" data-content="Please Enter Employee Name"
			                  onKeyPress = "return CheckIsCharacter(event)"
			                  input-class="form-control form-control-small" data-ng-class = "{'disabled' : ctrl.user.user_id != null}">
			                  </angucomplete-alt>
			                  			                  
			                  <input type="hidden" id="emp_id" name="emp_id" value="{{emp_name.originalObject}}"/>
			                  
			                   <span>Role Name <span class="required">*</span></span>
			                  <select class="form-control" data-ng-options="role.role_Id as role.role_Name for role in ctrl.roles" data-ng-change = "ctrl.getPassword(ctrl.user.userpassword)" data-ng-model="ctrl.user.role_id" required>
			                  	<option value = "">--Select Role--</option>
			                  </select>
			                  
			                   <span>User Name <span class="required">*</span></span>
			                  <input type="text" class="form-control" onKeyPress="return CheckIsAlphaNumeric(event)" minlength="5" maxlength= "20" data-ng-model="ctrl.user.username" data-trigger="focus"
			                  data-toggle="popover" data-placement="top" data-content="Please Enter Username" data-ng-blur="ctrl.checkUsername(ctrl.user.username)" required >
			                  <div data-ng-show = "ctrl.errorUsername" class ="makeRed">This username is not available</div>
			                    <span>Password <span class="required">*</span></span>
			                  <input type="password" class="form-control" min= "8" data-ng-model="ctrl.user.userpassword" data-trigger="focus"
			                  data-toggle="popover" data-placement="top" data-content="Please Enter Password" data-ng-keyup = "ctrl.getPassword(ctrl.user.userpassword)" required>
			                  
			                  
			                    <span>Confirm Password <span class="required">*</span></span>
			                   <input type="password" class="form-control" min= "8" data-ng-model="ctrl.user.confpassword" data-trigger="focus"
			                  data-toggle="popover" data-placement="top" data-content="Please Enter ConfirmPassword" data-ng-keyup = "ctrl.checkPassword(ctrl.user.userpassword, ctrl.user.confpassword)" required>
			                  
		                  	<span data-ng-show = "!ctrl.checkPWD" class ="makeRed">Password doesn't match</span>
			               
			                <div class="passward_validate hidden">
											<ul>
												<li>
													<i class="fa fa-check-circle caps makeRed" aria-hidden="true"></i> at least one capital letter
												</li>
												<li>
													<i class="fa fa-check-circle num makeRed" aria-hidden="true"></i> at least one numeric
												</li>
												<li>
													<i class="fa fa-check-circle specialchar makeRed" aria-hidden="true"></i> at least one special character
												</li>
												<li>
													<i class="fa fa-check-circle minchar makeRed" aria-hidden="true"></i> minimum 8 characters
												</li>
											</ul>
										</div> 
										
										
			              </div>         
			                	 
			                	              
		                </div>   
		                
		                			
										             
	                </div>  
	                    				
							 				
										             
	                              
                 </div>
                 
                 
                 <div class="modal-footer footerHeight">
                 	<div class="row">
                 		<div class="col-lg-12">
                 				<div class="col-lg-4 col-xs-4  footerLeft">
                 					<button type ="button" class="btn btn-warning pull-left " data-ng-click="ctrl.close('Cancel')"><i class="fa fa-ban" aria-hidden="true"></i> Cancel</button>
                 				</div>
                 				
                 					<div class="col-lg-4 col-xs-4 " style="text-align:center; !important;">
							<a id="" class="btnPadding btn btn-danger"	data-ng-click="ctrl.deleteUser()" data-ng-show="ctrl.user.user_id!=null"><i class="fa fa-trash"  aria-hidden="true"></i>  Delete</a> 
							
							<a id="" class="btnPadding btn btn-primary" data-ng-click="ctrl.clear()" data-ng-show="!userForm.$pristine && (ctrl.user.user_id==null)"><i class="fa fa-eraser"></i> Clear</a>							
						</div>
                 				
           				<div class="col-lg-4 col-xs-4 footerRight" data-ng-show="!(ctrl.user.user_id == null)">
           					<button type="submit" class="btn btn-success" type="submit" id="saveclose" data-id="0" data-ng-click="save($event)"
           					data-ng-disabled = "((!ctrl.errorUsername) && (ctrl.resetBtn) && (ctrl.checkPWD))? false : true"><i class="fa fa-floppy-o "></i> Update</button>
           				</div>  
           				
           				
           				<div class="col-lg-4 col-xs-4 footerRight" data-ng-show = "ctrl.user.user_id==null">

							<div class="btn-group dropup" id="savebutton">
						 	 <button type="submit" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false" data-ng-disabled = "((!ctrl.errorUsername) && (ctrl.resetBtn) && (ctrl.checkPWD))? false : true">
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
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
        
        <div class="header "> 
             <div class="page-header header-size">
                 	  <b>${title}</b>
                 	  
                 	  <button class="btn btn-primary drawerOpen pull-right" onClick="drawerOpen('.drawer')" >Add New User</button>
             </div>	
             
             										
		 </div>
      		
      		<div id="page-inner">  
		 <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                             User Register
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
									<li><a data-ng-click = "ctrl.makeActive()">Active </a></li>
									<li><a data-ng-click = "ctrl.makeinActive()">InActive</a></li>					

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
                                
                                <div class="col-xs-6 icons-button">
                                   <div class="pull-right">
                                     <form name = "userPrint" method = "POST" action = "user_print" class="padding-button">
                                     <a type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a>
                                    <div class="dropdown-menu regSettings pull-right" style="padding-right: 5px;">
                                  
                                 		  <div class="checkbox">
                                      			<label>
                                      				<i class="fa" data-ng-class = "{'fa-check' : setting_employeename == true, 'fa-times': setting_employeename == false}"></i>
                                      				<input type="checkbox" data-ng-init = "setting_employeename=true" data-ng-model = "setting_employeename"/> Employee Name
                                      			</label>
                                      	</div>
										
										
										
										<div class="checkbox">
                                     			<label>
                                      				<i class="fa" data-ng-class="{'fa-check' : setting_username == true, 'fa-times' : setting_username == false}"></i>
                                      				<input type="checkbox" data-ng-init = "setting_username = true" data-ng-model = "setting_username"/> User Name
                                      			</label>
                                    		</div>
                                    		
                                    		<div class="checkbox">
                                      			<label>
                                      				<i class="fa" data-ng-class="{'fa-check' : setting_rolename == true, 'fa-times' : setting_rolename == false}"></i>
                                      				<input type="checkbox" data-ng-init = "setting_rolename = true" data-ng-model = "setting_rolename"/> Role Name
                                      			</label>
                                      		</div>
                                      		
                                      		
                                    		
										<div class="checkbox">
                                      			<label>
                                      				<i class="fa" data-ng-class="{'fa-check': setting_branchname == true, 'fa-times': setting_branchname == false}"></i>
                                      				<input type="checkbox" data-ng-init = "setting_branchname=true" data-ng-model ="setting_branchname"/> Branch Name
                                      			</label>
                                      	</div>
                                      	
                                      	
                                      		
                                      		
                                   		<div class="checkbox">
                                   			<label>
                                   				<i class="fa" data-ng-class="{'fa-check': setting_userstatus == true, 'fa-times' : setting_userstatus == false}"></i>
                                   				<input type="checkbox" data-ng-init = "setting_userstatus = true" data-ng-model = "setting_userstatus"/> Status
                                   			</label>
                                   		</div>
                                      		
                                      		                                      		
									</div>
                                     
                                      <a type="button" class="btn btn-primary" onclick="location.href='downloadExcelUser'; valid = true;"><i class="fa fa-file-excel-o fa-lg"></i></a>
                                      
                                      <button type="submit" class="btn btn-primary"  data-ng-disabled = "ctrl.selected_user.length == 0" ><i class="fa fa-print fa-lg"></i></button>
                                      <input type="hidden" name="user" value = "{{ctrl.selected_user}}"/>
                                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                	</form>
                                	
                                	 <div class = "row paddingtop">
	                                    <div class = "col-md-12"><input type = "text" class="form-control" name = "search" placeholder = "Ex: Raj" data-ng-model = "ctrl.user_regSearch" data-ng-keyup = "ctrl.registerSearch(ctrl.user_regSearch)"/></div>
                                      </div>
                                	</div>
                                </div>
                              </div>
                            </div>
                          
                            <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox" data-ng-click="ctrl.userSelectall()" data-ng-model = "selectall"></th>
                                            <th data-ng-show = "setting_employeename"
                                            data-ng-click="empName=!empName;sortTable('empName',empName);">Employee Name<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':empName,'fa fa-caret-down':!empName}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "">Employee Code</th>
                                            <th data-ng-show = "setting_username"
                                            data-ng-click="usrName=!usrName;sortTable('usrName',usrName);">User Name<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':usrName,'fa fa-caret-down':!usrName}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_rolename"
                                            data-ng-click="usrRole=!usrRole;sortTable('usrRole',usrRole);">Role<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':usrRole,'fa fa-caret-down':!usrRole}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_branchname"
                                            data-ng-click="branchName=!branchName;sortTable('branchName',branchName);">Branch<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':branchName,'fa fa-caret-down':!branchName}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_userstatus"
                                            data-ng-click="usrStatus=!usrStatus;sortTable('usrStatus',usrStatus);">Status<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':usrStatus,'fa fa-caret-down':!usrStatus}"
														aria-hidden="true"></i></th>
                                                                                
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat = "user in ctrl.FilterUsers | limitTo:pageSize"
                                        data-ng-dblclick = "ctrl.updateUser(user)">
                                           	<td><input type="checkbox" data-ng-change = "ctrl.userSelect(user)" data-ng-model = "user.select"></td>
                                            <td data-ng-show = "setting_employeename">{{user.employeeMaster.emp_name}}</td>
                                            <td data-ng-show = "">{{user.employeeMaster.emp_code}}</td>
                                            <td data-ng-show = "setting_username">{{user.username}}</td>
                                            <td data-ng-show = "setting_rolename">{{user.role.role_Name}}</td>
                                            <td data-ng-show = "setting_branchname">{{user.branchModel.branch_name}}</td>                                            
                                            <td data-ng-show = "setting_userstatus" data-ng-class = "{'makeGreen' : user.active == 'Y', 'makeRed' : user.active == 'N'}">{{user.active == 'Y' ? 'ACTIVE' : 'INACTIVE'}}</td>
                                          
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
    <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
    <!-- jQuery Js -->
    
  <script src="resources/custom/js/custom.js"></script>
  <script src="resources/custom/js/user_master/user_control.js"></script>
  <script src="resources/custom/js/user_master/user_service.js"></script>
  <script src="resources/custom/js/branch_master/branch_service.js"></script>  
  <script src="resources/custom/js/employee_master/employee_service.js"></script>
  <script src="resources/custom/js/confirmDialog.js"></script>   
  <script type="text/javascript" src="resources/custom/js/validation.js"></script>
  <!-- Custom Js -->
  
  <script>
  	$('[data-toggle="popover"]').popover();
  	$('.regSettings').click(function(e) {
	    e.stopPropagation();
	});
  </script>
 
</body>

</html>