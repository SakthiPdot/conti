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
     <link rel="icon" type="image/gif/png" href="resources/Image/conti_logo.png">
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
    <!--<link href='http://fonts.googleapis.com/css\?family=Open+Sans' rel='stylesheet' type='text/css' />-->
    <link rel="stylesheet" href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css"> 
	
	 <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	 <link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	 <link href="resources/built-in/assets/Drawer/animate.css" rel="stylesheet" />
	 <link href="resources/custom/css/custom.css" rel="stylesheet">
	 <link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
	 <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">
	 
	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/lodash.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <script src="resources/custom/js/app.js"></script>
</head>


<body style="overflow-x:hidden;" data-ng-app="contiApp" data-ng-controller="BranchController as ctrl">
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
 		<form data-ng-submit="ctrl.submit()" name="branchForm" class="form-horizonral formBottom">
 			<div class="row">
 			<div class="col-lg-12 trowserHeader">
 				 
                   <div class="col-lg-10 headerLeft">
                   		 <b class="model-title">Branch {{ctrl.heading}}</b>
                   </div>
                   
                   <div class="col-lg-2 headerRight">
                   		<i class="fa fa-times fa-2x drawerClose pull-right iconLeft" data-ng-click="ctrl.close('Close')"></i>
                   </div>
            
             </div>
 			</div>
               
                 
                 <input type="hidden" data-ng-model="ctrl.branch.branch_id" />
                 <div class="model-body">
                 
                   <div class="row">
			                <div class="col-lg-12 title_area">	                
			              
				          	<div class="col-lg-12 new-masters" >
				          		 <b  data-ng-show="ctrl.branch.branch_id == null" > New Branch</b>	
				          	</div> 
				            
				            </div>                
		          </div> 
		             
		             
	                <div class="row">
		                <div class="col-lg-12">
			                <div class="col-lg-12 content-body">
			                	<span>Branch Name<span style="color:red">&nbsp;*</span></span>			                	
			                	<input type="text" class="form-control" maxlength="30" onKeyPress="return CheckIsCharacterWithspace(event,this.value)"
			                	data-ng-model="ctrl.branch.branch_name" data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please enter branch name"
			                	data-ng-blur="ctrl.checkBranchName(ctrl.branch.branch_name)" required>
			                	<span class="makeRed" data-ng-show="branchnamewrong">Branch name Already Existing..!<br><br></span>
			                	
			                	<span>Branch Code<span style="color:red">&nbsp;*</span></span>			                	
			                	<input type="text" class="form-control" minlength="4" maxlength="4" onKeyPress = "return CheckIsAlphaNumeric(event)" required
			                	data-ng-model="ctrl.branch.branch_code" data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please enter branch code">
			                	
			                		                	
			                	<span>Address Line 1<span class="required">  *</span></span>			                	
			                	<input type="text" class="form-control" maxlength="100" 
			                	data-ng-model="ctrl.branch.branch_addressline1" data-trigger="focus" data-toggle="popover" 
			                	data-placement="top" data-content="Please enter addressline 1" required>
			                	
			                	<span>Address Line 2</span>			                	
			                	<input type="text" class="form-control" maxlength="100" 
			                	data-ng-model="ctrl.branch.branch_addressline2" data-trigger="focus" data-toggle="popover"
			                	data-placement="top" data-content="Please enter addressline 2">
			                	
			                	<span>Location<span class="required">  *</span></span>			                	
			                	<angucomplete-alt id="location_name"
									              placeholder="Ex : Coimbatore"
									              pause="0"
									              remote-url="getLocations4Search/"
						             			  remote_url-data-field="Location"
									              selected-object="location_name"
									              
									              search-fields="location_name,pincode"
									              description-field="pincode"
									              title-field="location_name"
												  match-class="highlight"
												  
									              minlength="3"
	   											  data-trigger="focus" data-toggle="popover" 
	   											  data-placement="top" data-content="Please enter branch location"
	   											  
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
			                	<span>Contact  Person<span style="color:red">&nbsp;*</span></span>			                	
			                	
			                	<input type="text" class="form-control" maxlength = "30" onKeyPress="return CheckIsCharacterWithspace(event,this.value)" data-ng-model="ctrl.branch.branch_contactperson" 
			                  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please enter branch contact person"  required/>
			               </div>	
			               
			               <div class="col-lg-6 content-body">
			                	<span>Contact Number<span style="color:red">&nbsp;*</span></span>			                	
			                	<input type="text" class="form-control"  maxlength="15"  onKeyPress="return CheckIsNumeric(event)" data-ng-model="ctrl.branch.branch_mobileno" 
			                   data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please enter branch contact number"  required/>
			              
			               </div>		                                
		                </div>
		                
		                
		                <div class="col-lg-12">
			                <div class="col-lg-12 content-body">
			                	 <span>Contact Mail<span style="color:red">&nbsp;*</span></span>			                	
			                	<input type="email" class="form-control" maxlength = "30"  data-ng-model="ctrl.branch.branch_email" 
			                  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please enter branch email id" required />
			               </div>		                                
		                </div>
		                
		                
		                <div class="col-lg-12">
			                <div class="col-lg-6 content-body">
			                	<span>LR Invoice No Prefix<span style="color:red">&nbsp;*</span></span>		
			                	<div class="input-group">
			                	<span class="input-group-addon"><span>L</span>	</span>		                	
				                	<input type="text" class="form-control" minlength= "4" maxlength = "4" onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" data-ng-model="ctrl.branch.lrno_prefix" 
				                 	 data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please enter branch LR invoice number prefix" required />
			                	</div>
			                	
			              
			               </div>	
			               
			               <div class="col-lg-6 content-body  ">
			                	<span>Receipt Invoice No Prefix<span style="color:red">&nbsp;*</span></span>
			                	<div class="input-group">
				                	<span class="input-group-addon"><span>R</span>	</span>		                	
				                	<input type="text" class=" form-control" minlength= "4" maxlength = "4" onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" data-ng-model="ctrl.branch.receiptno_prefix" 
				                  	data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please enter branch Receipt invoice number prefix"  required/>
			                  	</div>
			               </div>		                                
		                </div>                 
	                </div>      
	                            
	             </div>
                 
                 <div class="modal-footer footerHeight" >
				
				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-4 col-xs-4 footerLeft">
							<button type="button" class=" btn btn-warning  pull-left" data-ng-click="ctrl.close('Cancel')" ><i class="fa fa-ban" area-hidden="true"></i> Cancel</button>
						</div>
						
						<div class="col-lg-4 col-xs-4" style="text-align:center; !important;">
							<a id="" class="btnPadding btn btn-danger"	data-ng-click="ctrl.deleteBranch()" data-ng-show="ctrl.branch.branch_id!=null"><i class="fa fa-trash"  aria-hidden="true"></i> Delete</a> 
							<a id="" class="btnPadding btn btn-primary" data-ng-click="ctrl.clear()" data-ng-show="!branchForm.$pristine&&(ctrl.branch.branch_id==null)"><i class="fa fa-eraser"></i> Clear</a>							
						</div>
						
						<div class="col-lg-4 col-xs-4 footerRight" data-ng-show="!(ctrl.branch.branch_id==null)">
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
 
	
	<jsp:include page="../Dashboard/settings_nav.jsp"/>
	<sec:authorize access="hasRole('SUPER_ADMIN') or hasRole('MANAGER')">
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
												type="button" data-toggle="dropdown" >
												Batch Action <span class="caret"></span>
											</button>
											<ul class="dropdown-menu">
												<li><a data-ng-click="ctrl.makeActive()">Active</a></li>
												<li><a data-ng-click="ctrl.makeinActive()">InActive</a></li>
											</ul>
										</div>
										
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
                                    <form name="branchPrint" target="_blank" method = "POST" action = "branch_print" class="padding-button" >
                                     <a type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a> 
                                     	<div class="dropdown-menu regSettings pull-right" style="padding-right: 5px;">
	                                     	<div class ="checkbox">
	                                     		<label>
	                                     			<i class = "fa" data-ng-class="{'fa-check': setting_branchname == true, 'fa-times': setting_branchname == false}"></i>
													<input type="checkbox" data-ng-init = "setting_branchname=true" data-ng-model="setting_branchname" /> Branch Name
												</label>
											</div>
										
											<div class ="checkbox">
												<label>
													<i class = "fa" data-ng-class="{'fa-check': setting_branchcode == true, 'fa-times': setting_branchcode == false}"></i>
													<input type="checkbox" data-ng-init = "setting_branchcode=true" data-ng-model="setting_branchcode" /> Branch code
												</label>
											</div>
										
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_branchaddress == true, 'fa-times': setting_branchaddress == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_branchaddress=true" data-ng-model="setting_branchaddress" /> Address
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_branchcontactperson == true, 'fa-times': setting_branchcontactperson == false}"></i>																				
												<input type="checkbox" data-ng-init = "setting_branchcontactperson=true" data-ng-model="setting_branchcontactperson" /> Contact Person
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_branchcontactnumber == true, 'fa-times': setting_branchcontactnumber == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_branchcontactnumber=true" data-ng-model="setting_branchcontactnumber" /> Contact Number
											</label>
										</div>	
																			
										<div class = "checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_branchcontactemail == true, 'fa-times': setting_branchcontactemail == false}"></i>
												<input type="checkbox" data-ng-init = "setting_branchcontactemail=true" data-ng-model="setting_branchcontactemail" /> Contact Email
											</label>
										</div>
										
										<div class = "checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_branchlrnoprefix == true, 'fa-times': setting_brachlrnoprefix == false}"></i>
												<input type="checkbox" data-ng-init = "setting_branchlrnoprefix=true" data-ng-model="setting_branchlrnoprefix" /> LRno_prefix
											</label>
										</div>
										
										<div class = "checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_branchreceiptnoprefix == true, 'fa-times': setting_branchreceiptnoprefix == false}"></i>
												<input type="checkbox" data-ng-init = "setting_branchreceiptnoprefix=true" data-ng-model="setting_branchreceiptnoprefix" /> Receiptno_prefix
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_branchstatus == true, 'fa-times': setting_branchstatus == false}"></i>
												<input type="checkbox" data-ng-init = "setting_branchstatus=true" data-ng-model="setting_branchstatus" /> Status
											</label>
										</div>
										
									</div>	
							
                                      <a type="button" class="btn btn-primary" onclick="location.href='downloadExcelBranch';valid = true;"><i class="fa fa-file-excel-o fa-lg"></i></a>
                                      
                                      
	                                      <button type="submit" class="btn btn-primary" data-ng-disabled = "ctrl.selected_branch.length == 0" ><i class="fa fa-print fa-lg"></i></button>
	                                      <input type = "hidden" name = "branch" value = "{{ctrl.selected_branch}}" />
	                                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                      </form>
                                      
                                      <div class = "row paddingtop">
	                                    	<div class = "col-md-12"><input type = "text" class="form-control" name = "search" placeholder = "Ex: Branch Name" 
	                                    	data-ng-model = "ctrl.branch_regSearch" data-ng-keyup = "ctrl.registerSearch(ctrl.branch_regSearch)"/></div>
                                      </div>
                                      
                                	</div>
                                </div>
                              </div>
                            </div>
                            
                             <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox" data-ng-click="ctrl.branchSelectall()" data-ng-model="selectallbranches"></th>
                                            
                                            <th data-ng-show="setting_branchname"
                                            data-ng-click="branchName=!branchName;sortTable('branchName',branchName);">Branch Name<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':branchName,'fa fa-caret-down':!branchName}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_branchcode"
                                            data-ng-click="branchCode=!branchCode;sortTable('branchCode',branchCode);">Branch Code<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':branchCode,'fa fa-caret-down':!branchCode}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_branchaddress"
                                            data-ng-click="branchAddress=!branchAddress;sortTable('branchAddress',branchAddress);">Address<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':branchAddress,'fa fa-caret-down':!branchAddress}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_branchcontactperson"
                                            data-ng-click="branchContactPerson=!branchContactPerson;sortTable('branchContactPerson',branchContactPerson);">Contact Person<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':branchContactPerson,'fa fa-caret-down':!branchContactPerson}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_branchcontactnumber"
                                            data-ng-click="branchContactNumber=!branchContactNumber;sortTable('branchContactNumber',branchContactNumber);">Contact Number<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':branchContactNumber,'fa fa-caret-down':!branchContactNumber}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_branchcontactemail"
                                            data-ng-click="branchContactEmail=!branchContactEmail;sortTable('branchContactEmail',branchContactEmail);">Contact Mail<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':branchContactEmail,'fa fa-caret-down':!branchContactEmail}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_branchlrnoprefix"
                                            data-ng-click="lrNoPrefix=!lrNoPrefix;sortTable('lrNoPrefix',lrNoPrefix);">LR No Prefix<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':lrNoPrefix,'fa fa-caret-down':!lrNoPrefix}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_branchreceiptnoprefix"
                                            data-ng-click="receiptNoPrefix=!receiptNoPrefix;sortTable('receiptNoPrefix',receiptNoPrefix);">Receipt No Prefix<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':receiptNoPrefix,'fa fa-caret-down':!receiptNoPrefix}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_branchstatus"
                                            data-ng-click="branchStatus=!branchStatus;sortTable('branchStatus',branchStatus);">Status<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':branchStatus,'fa fa-caret-down':!branchStatus}"
														aria-hidden="true"></i></th>
                                            
                                        </tr>
                                    </thead>
                                    
                                    <tbody>
                                        <tr data-ng-repeat="branch in ctrl.Filterbranches|limitTo:pageSize"
                                        data-ng-dblclick="ctrl.updateBranch(branch)">
                                            <td><input type="checkbox" data-ng-change="ctrl.branchSelect(branch)" data-ng-model="branch.select"/></td>
                                           
                                            <td data-ng-show="setting_branchname">{{branch.branch_name}}</td>
                                            <td data-ng-show="setting_branchcode">{{branch.branch_code}}</td>
                                            <td data-ng-show="setting_branchaddress">
                                            	<div data-ng-if="!branch.branch_addressline1==''">{{branch.branch_addressline1}},</div>
                                           		<div data-ng-if="!branch.branch_addressline2==''">{{branch.branch_addressline2}},</div>
                                           		<div data-ng-if="!branch.location.location_name==''">{{branch.location.location_name}},</div>
                                           		<div data-ng-if="!branch.location.address.city==''">{{branch.location.address.city}},</div>
<!--                                            		<div data-ng-if="!branch.location.address.district==''">{{branch.location.address.district}},</div> -->
                                           		<div data-ng-if="!branch.location.address.state==''">{{branch.location.address.state}},</div>
                                           		<div data-ng-if="!branch.location.pincode==''">{{branch.location.pincode}}.</div>
                                            </td>
                                            <td data-ng-show="setting_branchcontactperson">{{branch.branch_contactperson}}</td>
                                            <td data-ng-show="setting_branchcontactnumber">{{branch.branch_mobileno}}</td>
                                            <td data-ng-show="setting_branchcontactemail">{{branch.branch_email}}</td>
                                            <td data-ng-show="setting_branchlrnoprefix">{{branch.lrno_prefix}}</td>
                                            <td data-ng-show="setting_branchreceiptnoprefix">{{branch.receiptno_prefix}}</td>
                                           	<td data-ng-show="setting_branchstatus" data-ng-class="{'makeGreen': branch.active=='Y', 'makeRed': branch.active=='N'}">{{branch.active == 'Y' ? 'ACTIVE' : 'INACTIVE'}}</td>
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
                                   		<button class="btn btn-primary" type = "button" data-ng-disabled="previouseDisabled" data-ng-click = "firstlastPaginate(1)">First</button>                                     											
										<button class="btn btn-primary" type = "button" data-ng-disabled="previouseDisabled" data-ng-click = "paginate(-1)">Previous</button>
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
		                             Branch Register
		                        </div>
		                        <div class="panel-body">
		                        	Sorry..! You have no authorized for view this master..!
		                        </div>
		                      </div>
                		</div>
                	</div>
                </div>		
			 </div>
		</div>
	</sec:authorize>

	<script>
		$('[data-toggle="popover"]').popover();
		$('.regSettings').click(function(e) {
			e.stopPropagation();
		});
	</script>
  <script src="resources/custom/js/custom.js"></script>
  <script src="resources/custom/js/branch_master/branch_controller.js"></script>
  <script src="resources/custom/js/branch_master/branch_service.js"></script>
  <script src="resources/custom/js/Location/location_service.js"></script>
  <script src="resources/custom/js/confirmDialog.js"></script>   
  <script type="text/javascript" src="resources/custom/js/validation.js"></script>
 
       
  

</body>

</html>