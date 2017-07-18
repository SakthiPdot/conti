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
	 <link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
	 <link href="resources/custom/css/custom.css" rel="stylesheet">
	 <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">
	 

	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <script src="resources/custom/js/app.js"></script>

</head>


<body style="overflow-x:hidden;" data-ng-app = "contiApp" data-ng-controller = "CustomerController as ctrl">
 
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
 		<form data-ng-submit="ctrl.submit()" name="customerForm" class="form-horizontal">
 			<div class="row">
 			<div class="col-lg-12 trowserHeader" >
 				 
                   <div class="col-lg-6 headerLeft">
                   		 <b class="model-title">Customer {{ctrl.heading}}</b>
                   </div>
                   
                   <div class="col-lg-6 headerRight">
                   		<i class="fa fa-times fa-2x drawerClose pull-right iconLeft" data-ng-click = "ctrl.close()"></i>
                   </div>
            
             </div>
 			</div>
                
                 
                 <input type="hidden" data-ng-model="ctrl.customer.customer_id" />
                 <div class="model-body">
                 
                    <div class="row">
			                <div class="col-lg-12 title_area">	                
			              
				          	<div class="col-lg-12 new-masters" >
				          		 <b data-ng-model="ctrl.customer.customer_id"> New Customer</b>	
				          		 
				          	</div> 
				            
				            </div>                
		             </div> 
                 
	                <div class="row">
		                <div class="col-lg-12">
		                <div class="col-lg-12 content-body">
		                 	   <span>Customer Name </span>	         
			                   <input type="text" class="form-control" maxlength="50" onKeyPress="return CheckIsCharacterWithspace(event,this.value)" data-ng-model="ctrl.customer.customer_name" data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Customer Name">
			                   
			                   <span>Customer Code</span>
			                   <input type="text" class="form-control" maxlength="50" onKeyPress="return CheckIsAlphaNumeric(event,this.value)" data-ng-model="ctrl.customer.customer_code" data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Customer code">
			                   
			                    <span>Phone Number</span>
			                   <input type="text" class="form-control" maxlength="10" onKeyPress="return CheckIsNumeric(event)" data-ng-model="ctrl.customer.customer_mobileno" data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Customer phone number">
			                
			           
			             </div>         	
			             </div> 
			             
			             
			             <div class="col-lg-12">
			                	<div class="col-lg-6 content-body">
			                 	   <span>Customer Type </span>	         
				                   <select class="form-control" name="customer_type" data-ng-options="custtype for custtype in ['Credit','Debit','Regular']" data-ng-model="ctrl.customer.customer_type">
				                   
<!-- 				                   		<option>Credit</option> -->
<!-- 				                   		<option>Credit</option>	 -->
<!-- 				                   		<option>Credit</option> -->
				                   </select>
				               
				              	</div> 
				               	<div class="col-lg-6 content-body">    
				                   <span>Branch Name</span>
				                  <angucomplete-alt id="branch_name" data-ng-model="ctrl.customer.branch_name"
						              placeholder="Ex : Coimbatore"
						              pause="100"
						              selected-object="branch_name"
						              local-data="ctrl.branches"
						              search-fields="branch_name"
						              title-field="branch_name"
									  match-class="highlight"
									  initial-value="{{ctrl.customer.branchModel.branch_name}}"
						              minlength="1"
						              field-required="true"	
						              data-trigger="focus" data-toggle="popover" 
						              data-placement="top" data-content="Please Enter Customer branch name"
						              onKeyPress="return CheckIsCharacter(event)"
						              input-class="form-control form-control-small">
              				</angucomplete-alt>

			           		<input type="hidden" id = "branch_id" name ="branch_id" value = "{{branch_name.originalObject}}" />
				                
				           
				             	</div>         	
			             </div>  
			             
			             <div class="col-lg-12">
			                	<div class="col-lg-6 content-body">
			                 	   <span>Tax is Payable on Reverse Charge </span>	         
				                   <select class="form-control" data-ng-model="ctrl.customer.taxin_payable" data-ng-options="payable for payable in ['Yes','No']">
<!-- 				                   		<option>Yes</option> -->
<!-- 				                   		<option>No</option> -->
				                   		
				                   </select>
				               
				              	</div> 
				               	<div class="col-lg-6 content-body">    
				                   <span>GSTIN number</span>
				                   <input type="text" class="form-control" data-ng-model="ctrl.customer.gstin_number" maxlength="20" 
			                   data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter GSTIN number" >
				           
				             	</div>         	
			             </div>  
			             
			             <div class="col-lg-12">
		                <div class="col-lg-12 content-body">
		                
		                       <span>Company Name </span>	         
			                   <input type="text" class="form-control" data-ng-model="ctrl.customer.company_name" maxlength="50" 
			                   data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Customer Company name" >
			                   
		                 	   <span>Address Line 1 </span>	         
			                   <input type="text" class="form-control" data-ng-model="ctrl.customer.customer_addressline1"  maxlength="150" 
			                   data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Address Line1	" >
			                   
			                   <span>Address Line 2</span>
			                   <input type="text" class="form-control" data-ng-model="ctrl.customer.customer_addressline2"  maxlength="150" 
			                   data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Address Line2	" >
			             </div>         	
			             </div>
			             
			             <div class="col-lg-12">
		                <div class="col-lg-6 content-body">
		                     <span>Location</span>
			                   		<angucomplete-alt id="location_name" data-ng-model="ctrl.customer.location_name"
									              placeholder="Ex : Coimbatore"
									              pause="0"
									              selected-object="location_name"
									              local-data="ctrl.locations"
									              search-fields="location_name,pincode"
									              title-field="location_name,pincode"
												  match-class="highlight"
												  initial-value="{{ctrl.customer.location.location_name}}"
									              minlength="1"
	   											  data-trigger="focus" data-toggle="popover" 
	   											  data-placement="top" data-content="Please Enter Customer location"
	   											  onKeyPress="return CheckIsCharacter(event)"
									              input-class="form-control form-control-small">
              						</angucomplete-alt>
              						<input type="hidden" id = "location_id" name ="location_id" value = "{{location_name.originalObject}}" />
		                
		                 	 	<span>City </span>	         
			                    <input type="text" id="city" class="form-control disabled locations" tabindex="-1" value="{{location_name.originalObject.address.city}}">
			                    
			                     <span>State </span>	         
			                    <input type="text" id="state" class="form-control disabled locations" tabindex="-1" value="{{location_name.originalObject.address.state}}">
			               
			              </div> 
			               <div class="col-lg-6 content-body">    
			                     <span>Country </span>	         
			                    <input type="text" id="country" class="form-control disabled locations" tabindex="-1" value="{{location_name.originalObject.address.country}}">
			                    
			                     <span>Pincode </span>	         
			                    <input type="text" id="pincode" class="form-control disabled locations" tabindex="-1" maxlength="6" onKeyPress="return CheckIsNumeric(event)" value="{{location_name.originalObject.pincode}}">
			                     <span>Email</span>
			                   <input type="email" class="form-control" data-ng-model="ctrl.customer.customer_email" 
			                   data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Customer email id"  />
			                 
			           
			             </div>         	
			             </div> 
			             
			   
			       </div>
	              
	          </div>
                 
                 <div class="modal-footer footerHeight">
				
					<div class="row">
						<div class="col-lg-12">
						<div class="col-lg-4 col-xs-4 footerLeft">
							<button type="button" class=" btn btn-danger  pull-left" data-ng-click="ctrl.close()" > <i class="fa fa-times" aria-hidden="true"></i>
							Cancel</button>
						</div>
						
						<div class="col-lg-4" style="text-align:center; !important;">
							
							<a id="" class="btnPadding btn btn-warning"	 data-ng-click="ctrl.deleteCustomer()"  data-ng-show="ctrl.customer.customer_id!=null" ><i class="fa fa-trash"  aria-hidden="true"></i> &nbsp;Delete</a>
							<a id="" class="btnPadding btn btn-primary" data-ng-click = "ctrl.clear()" data-ng-show="!empForm.$pristine && (ctrl.customer.customer_id==null)">Clear</a>							
						</div>
						
						<div class="col-lg-4 col-xs-4 footerRight" data-ng-show="!(ctrl.customer.customer_id== null)">
							<button class="btn btn-success " type="submit"
								
								id="saveclose" data-id="0" data-ng-click="save($event)"
								type="submit">
								<i class="fa fa-floppy-o "> </i> Update</button>
							<br>
						</div>
						
						<div class="col-lg-4 footerRight" data-ng-show = "ctrl.customer.customer_id==null">

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
	<sec:authorize access="hasRole('SUPER_ADMIN') or hasRole('MANAGER')">
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
									<li><a data-ng-click = "ctrl.makeActive()">Active</a></li>
									<li><a data-ng-click = "ctrl.makeinActive()">In Active</a></li>
								</ul>
								
							</div>
								<div class = "row paddingtop">
                                   <div class = "col-md-12"> 
                                   <select name ="shownoofrec" data-ng-model="shownoofrec" data-ng-options = "noofrec for noofrec in [10, 15, 25, 50, 100]" class ="form-control" data-ng-click="ctrl.shownoofRecord()">
                                   	
                                   </select>
	                             </div>
                             </div>

						</div> 
                                </div>
                                
                               <div class="col-xs-6 icons-button">
                                  <div class="pull-right">
                                   	<form name="custPrint" method="POST" action="customer_print">
                                     <a type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a>
                                     	<div class="dropdown-menu regSettings pull-right" style="padding-right: 5px;">
                                     	<div class ="checkbox">
                                     		<label>
                                     			<i class = "fa" data-ng-class="{'fa-check': setting_custname == true, 'fa-times': setting_custname == false}"></i>
												<input type="checkbox" data-ng-init = "setting_custname=true" data-ng-model="setting_custname" /> Customer Name
											</label>
										</div>
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_custcode == true, 'fa-times': setting_custcode == false}"></i>
												<input type="checkbox" data-ng-init = "setting_custcode=true" data-ng-model="setting_custcode" /> Customer Code
											</label>
										</div>
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_custtype == true, 'fa-times': setting_custtype == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_custtype=true" data-ng-model="setting_custtype" /> Customer Type
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_custbranch == true, 'fa-times': setting_custbranch == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_custbranch=true" data-ng-model="setting_custbranch" /> Branch Name
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_custcompany == true, 'fa-times': setting_custcompany == false}"></i>																				
												<input type="checkbox" data-ng-init = "setting_custcompany=true" data-ng-model="setting_custcompany" /> Company Name
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_custaddress == true, 'fa-times': setting_custaddress == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_custaddress=true" data-ng-model="setting_custaddress" /> Address
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_custemail == true, 'fa-times': setting_custemail == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_custemail=true" data-ng-model="setting_custemail" /> Email
											</label>
										</div>		
										
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_custstatus == true, 'fa-times': setting_custstatus == false}"></i>
												<input type="checkbox" data-ng-init = "setting_custstatus=true" data-ng-model="setting_custstatus" /> Status
											</label>
										</div>
																		
									</div>
										<a type="button" class="btn btn-primary" onclick="location.href='downloadExcelCustomer'"><i class="fa fa-file-excel-o fa-lg"></i></a>
                                      	  <button type="submit" class="btn btn-primary"><i class="fa fa-print fa-lg"></i></button>
	                                      <input type = "hidden" name = "cust" value = "{{ctrl.selected_customer}}" />
	                                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</form>
									<div class = "row paddingtop">
	                                    <div class = "col-md-12"><input type = "text" class="form-control" name = "search" placeholder = "Ex: Driver" data-ng-model = "ctrl.cust_regSearch" data-ng-keyup = "ctrl.registerSearch(ctrl.cust_regSearch)"/></div>
                                      </div>
                                </div>
                              </div>
                            </div>
                          </div>
                            
                            
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox" data-ng-click="ctrl.customerSelectall()" data-ng-model = "selectall"></th>
                                           
                                            <th data-ng-show = "setting_custname">Customer Name</th>
                                            <th data-ng-show = "setting_custcode">Customer Code</th>
                                            <th data-ng-show = "setting_custtype">Customer Type</th>
                                            <th data-ng-show = "setting_custbranch">Branch Name</th>
                                            <th data-ng-show = "setting_custcompany">Company Name</th>
                                            <th data-ng-show = "setting_custaddress">Address</th>
                                            <th data-ng-show = "setting_custemail">Email</th>
                                   			<th data-ng-show = "setting_custstatus">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
<!--                                         <tr -->
<!--                                         data-ng-repeat="cust in ctrl.customers.slice(((currentPage-1)*itemsPerPage),((currentPage)*itemsPerPage)) | orderBy:'customer_name'" -->
<!--                                         data-ng-dblclick="ctrl.updateCustomer(cust)"> -->

											<tr data-ng-repeat="cust in ctrl.Filtercustomers | limitTo:pageSize"
												data-ng-dblclick="ctrl.updateCustomer(cust)">
                                            <td><input type="checkbox" data-ng-change="ctrl.empSelect(emp)" data-ng-model = "emp.select" /></td>
<!--                                             <td>{{(currentPage*10)-(10-($index+1))}}</td> -->
                                            <td data-ng-show = "setting_custname">{{cust.customer_name}}</td>
                                            <td data-ng-show = "setting_custcode">{{cust.customer_code}}</td>
                                            <td data-ng-show = "setting_custtype">{{cust.customer_type}}</td>
                                            <td data-ng-show = "setting_custbranch">{{cust.branchModel.branch_name}}</td>
                                            <td data-ng-show = "setting_custcompany">{{cust.company_name}}</td>
                                            
                                       
                                            <td data-ng-show = "setting_custaddress">{{cust.customer_addressline1}},{{cust.customer_addressline2}},
                                            {{cust.location.location_name}},{{cust.location.address.city}},{{cust.location.address.district}}
                                            {{cust.location.address.state}},{{cust.location.address.pincode}}</td>
                                            
                                            <td data-ng-show = "setting_custemail">{{cust.customer_email}}</td>
                                       	    <td data-ng-show = "setting_custstatus" data-ng-class="{'makeGreen': cust.active=='Y', 'makeRed': cust.active=='N'}">{{cust.active == 'Y' ? 'ACTIVE' : 'INACTIVE'}}</td>
                                       </tr>
                                       
                          
                                                               
                                
                                 
                                    </tbody>
                                </table>
                                
                                <div class="col-lg-6 icons-button">
                                   <div class="pull-right">
                                   		
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
        <!-- /. PAGE WRAPPER  -->
	</div>	
    </div>
       </sec:authorize>
    <script src="resources/custom/js/custom.js"></script>
  <script src="resources/custom/js/customer_master/customer_controller.js"></script>
  <script src="resources/custom/js/customer_master/customer_service.js"></script>
  <script src="resources/custom/js/branch_master/branch_service.js"></script>
  <script src="resources/custom/js/Location/location_service.js"></script>
  <script src="resources/custom/js/confirmDialog.js"></script>   
  <script type="text/javascript" src="resources/custom/js/validation.js"></script>
  <!-- Custom Js -->
        <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
    </script>
         <!-- Custom Js -->


     

</body>

</html>