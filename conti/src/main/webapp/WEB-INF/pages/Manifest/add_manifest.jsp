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
	
	 <link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	
	<link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
    <link href="resources/built-in/assets/Drawer/animate.css" rel="stylesheet" />
    <link href="resources/custom/css/custom.css" rel="stylesheet">
	<link rel="stylesheet" href="resources/custom/css/success_failure_msg.css">
	<link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet"> 
	
	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 	 
	<script type="text/javascript" src="resources/built-in/js/lodash.js"></script> 
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <script src="resources/custom/js/app.js"></script>



</head>


<body style="overflow-x:hidden;"
data-ng-app="contiApp" data-ng-controller="addManifestController as amctrl">
 
	 
	<jsp:include page="../Dashboard/nav.jsp"/>
	
	<div class="success hideme"><i class="fa fa-check-circle" aria-hidden="true"></i> {{amctrl.message}}</div>
	<div class="failure hideme"><i class="fa fa-times-circle" aria-hidden="true"></i> {{amctrl.message}}</div>


    <div id="wrapper">
		<div id="page-wrapper">


			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default panelMarginBottom">
						<div class="panel-heading"></div>
						<div class="panel-body customer-font">
							<b>Manifest</b>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12">
					<div class="col-md-6 col-sm-6 col-xs-6 GenLeftRight">
						<div class="subHead">
							<b>${title}</b>
						</div>
					</div>
	
					<div class="col-md-2"></div>

					<div class="col-md-3 col-sm-4 col-xs-6">
						<b>Last Manifest No : {{lastManifestNumber}}</b>
					</div>

				</div>
			</div>



			<div class="row">
				<div class="col-lg-12">
					<div class="col-lg-12 ">
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="branch-heading">Branch</div>

								<div class="col-lg-12 noPaddingLeft">
									<div class="col-lg-3 branchclass">
										<span class="text-padding">From</span>										
						
										<%-- <!-- defaultBranch -->										
										<sec:authorize access="hasRole('STAFF') or hasRole('MANAGER')">							
											<input type="text" class="form-control " data-ng-disabled="true" data-ng-model="branch_name">
										</sec:authorize> --%>
										
										
										<input type="hidden"  data-ng-model="amctrl.manifest.branchModel1">
										
										<%-- <sec:authorize access="hasRole('SUPER_ADMIN')"> --%>
											<select name="fromBranch" class="form-control"
												data-ng-model="amctrl.manifest.branchModel1">
												<option value="" data-ng-disabled="true">--Select
													Branch Name--</option>
												<option data-ng-repeat="x in amctrl.branches" value="{{x}}">{{x.branch_name}}</option>
											</select>
									<%-- 	</sec:authorize> --%>
									</div>

									<div class="col-lg-3 branchclass">
										<span class="text-padding">To</span> 
										<select name ="toBranch"
											class="form-control" data-ng-model="amctrl.manifest.branchModel2">														
											 <option value="" data-ng-disabled="true">--Select Branch Name--</option>
											 <option data-ng-repeat="x in amctrl.branches" value="{{x}}">{{x.branch_name}}</option>
										</select>
									</div>
								</div>

								<div class="col-lg-12 noPaddingLeft">
									<div class="sec-padding">Specific Period</div>
									<div class="col-lg-3 branchclass">
										<span class="text-padding" >From </span>
										<div class="form-group input-group">
											<input type="text" name="datePicker1" class="form-control datepicker1"
											placeholder="Enter From Date"
											 data-ng-model="amctrl.fromdate"/>
											 <span class="input-group-addon"><i class="fa fa-calendar"></i>
											</span>

										</div>
									</div>

									<div class="col-lg-3 branchclass">
										<span class="text-padding">To</span>
										<div class="form-group input-group ">
											<input type="text"  name="datePicker2" class="form-control datepicker2" 
											placeholder="Enter To Date"											
											data-trigger="focus" data-toggle="popover"
											data-placement="top" data-content="Please Select To Branch"
											data-ng-model="amctrl.todate" /> <span
												class="input-group-addon"><i class="fa fa-calendar"></i>
											</span>
										</div>
									</div>
								</div>


								<div class="col-lg-12 noPaddingLeft subhead-padding">
									<div class="col-lg-3 branchclass">
										<span class="text-padding" >Status</span>
										<select data-ng-model="amctrl.manifest.manifest_status" name="status"
											class="form-control">														
											 <option value="" data-ng-disabled="true">--Select Status--</option>
											<option>Booked</option>										
											<option>Missing</option>
										</select>
									</div>
									
									<div class="col-lg-4  col-lg-offset-3 branchclass">
										<button class="btn btn-primary" name="ViewShipmentButton" type="button"
										data-ng-init="count=0"
										data-ng-click="amctrl.viewShipment();count=count+1">View Shipment</button>									
									</div>		
									
									
							
								</div>
									
							</div>
						</div>
					</div>
				</div>
			</div>


			<div class="row">
				<div class="col-lg-12">
					<div class="col-lg-12 ">
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="col-lg-12 noPaddingLeft">
									<div class="col-lg-3 branchclass">
										<span class="text-padding boldletter">Search</span>
										 <input
										 data-ng-model="amctrl.search"
										 data-ng-keyup="amctrl.registerSearch(amctrl.search)"
											type="text" class="form-control searchbar"
											placeholder="LR Number">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


			<div class="row">
				<div class="col-md-12">
					<div class="col-md-12">
						<!-- Advanced Tables -->
						<div class="panel panel-default">
							<div class="panel-heading">Add Manifest</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-lg-12">
										<div class="col-lg-6">
                                     <div class="dataTables_length" id="dataTables-example_length">
											<div class="row paddingtop">
												<div class="col-md-12">
													<select name="shownoofrec" data-ng-model="shownoofrec"
														data-ng-options="noofrec for noofrec in [10, 15, 25, 50, 100]"
														class="form-control"
														data-ng-change="amctrl.shownoofRecord()">
													</select>
												</div>
											</div>
										</div>
									</div>
										<div class="col-xs-6 icons-button">
											<div class="pull-right">
												<form name="selectManifestForm" method="post" action="shipmentPrint" class="padding-button">
							                      <a type="button" class="btn btn-primary dropdown-toggle"
                                   				  data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a>
                                   				  
                                   				      	<div class="dropdown-menu regSettings pull-right"
																style="padding-right: 5px;">
																<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_date == true, 'fa-times': setting_date== false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_date = true"
																		data-ng-model="setting_date" /> Date
																	</label>
																</div>
																<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_lrno == true, 'fa-times': setting_lrno == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_lrno = true"
																		data-ng-model="setting_lrno" /> LR No
																	</label>
																</div>
																<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_origin == true, 'fa-times': setting_origin == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_origin = true"
																		data-ng-model="setting_origin" /> Origin
																	</label>
																</div>
																	<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_destination == true, 'fa-times': setting_destination == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_destination = true"
																		data-ng-model="setting_destination" /> Destination
																	</label>
																</div>
																	<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_sender == true, 'fa-times': setting_sender == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_sender = true"
																		data-ng-model="setting_sender" /> Sender
																	</label>
																</div>
																	<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_consignee == true, 'fa-times': setting_consignee == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_consignee = true"
																		data-ng-model="setting_consignee" /> Consignee
																	</label>
																</div>
																	<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_totalparcel == true, 'fa-times': setting_totalparcel == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_totalparcel= true"
																		data-ng-model="setting_totalparcel" /> Total Parcel
																	</label>
																</div>
																	<div class="checkbox" data-ng-hide="true">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_weight == true, 'fa-times': setting_weight == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_weight = true"
																		data-ng-model="setting_weight" /> Weight
																	</label>
																</div>
																		<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_sevice == true, 'fa-times': setting_sevice ==false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_sevice = true"
																		data-ng-model="setting_sevice" /> Service
																	</label>
																</div>
																	<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_status == true, 'fa-times': setting_status== false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_status = true"
																		data-ng-model="setting_status" /> Status
																	</label>
																</div>
																		
														</div>
												<!--=============== excel============== -->
												 <a type="button" onclick="location.href='downloadExcelForAddManifest';valid = true;" class="btn btn-primary"><i class="fa fa-file-excel-o fa-lg"></i></a>											
												<!--=============== print ============== -->
												<button type="submit"  
												data-ng-disabled="amctrl.selectedManifest.length<1"
												class="btn btn-primary">
													<i class="fa fa-print fa-lg"></i></button>
													 
													 <input type="hidden" name="selectedShipment"
																value="{{amctrl.selectedManifest}}" />
																
													 <input type="hidden" name="${_csrf.parameterName}"
																value="${_csrf.token}" />
																
												
												</form>
											</div>
										</div>
									</div>
								</div>

								<div class="table-responsive">						
									<table class="table table-striped table-bordered table-hover"
										id="dataTables-example" data-ng-cloak>
										<thead>
											<tr>
												<th><input type="checkbox"
												data-ng-model="amctrl.selectAllManifest"
												data-ng-click="amctrl.selectAll()"></th>
												<th data-ng-show="setting_date"
												data-ng-click="date=!date;sortTable('date',date);">Date<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':date,'fa fa-caret-down':!date}"
														aria-hidden="true"></i></th>
												<th data-ng-show="setting_lrno"
												data-ng-click="lrno=!lrno;sortTable('lrno',lrno);">LR No<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':lrno,'fa fa-caret-down':!lrno}"
														aria-hidden="true"></i></th>
												<th data-ng-show="setting_origin"
												data-ng-click="origin=!origin;sortTable('origin',origin);">Origin<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':origin,'fa fa-caret-down':!origin}"
														aria-hidden="true"></i></th>
												<th data-ng-show="setting_destination"
												data-ng-click="destination=!destination;sortTable('destination',destination);">Destination<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':destination,'fa fa-caret-down':!destination}"
														aria-hidden="true"></i></th>
												<th data-ng-show="setting_sender"
												data-ng-click="sender=!sender;sortTable('sender',sender);">Sender<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':sender,'fa fa-caret-down':!sender}"
														aria-hidden="true"></i></th>
												<th data-ng-show="setting_consignee"
												data-ng-click="consignee=!consignee;sortTable('consignee',consignee);">Consignee<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':consignee,'fa fa-caret-down':!consignee}"
														aria-hidden="true"></i></th>
												<th data-ng-show="setting_totalparcel"
												data-ng-click="totalParcel=!totalParcel;sortTable('totalParcel',totalParcel);">Total Parcel<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':totalParcel,'fa fa-caret-down':!totalParcel}"
														aria-hidden="true"></i></th>
												<th
												data-ng-hide="true"
												 data-ng-show="setting_weight"
												data-ng-click="weight=!weight;sortTable('weight',weight);">Weight<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':weight,'fa fa-caret-down':!weight}"
														aria-hidden="true"></i></th>
												<th data-ng-show="setting_sevice"
												data-ng-click="service=!service;sortTable('service',service);">Service<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':service,'fa fa-caret-down':!service}"
														aria-hidden="true"></i></th>
																<th data-ng-show="setting_status"
												data-ng-click="status=!status;sortTable('status',status);">Status<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':status,'fa fa-caret-down':!status}"
														aria-hidden="true"></i></th>
														
											</tr>
										</thead>
										<tbody>
											<tr 
											data-ng-repeat='x in amctrl.FilteredManifests | limitTo:pageSize track by x.shipment_id'>
												<td><input type="checkbox"
												data-ng-model="x.select"
												data-ng-click="amctrl.selectManifest(x)"></td>
												<td data-ng-hide="true">{{x.sender_branch.branch_id}}</td>
												<td data-ng-show="setting_date">{{x.updated_datetime.slice(0,-10)}}</td>
												<td data-ng-show="setting_lrno">{{x.lrno_prefix}}</td>
												<td data-ng-show="setting_origin">{{x.sender_branch.branch_name}}</td>
												<td data-ng-show="setting_destination">{{x.consignee_branch.branch_name}}</td>
												<td data-ng-show="setting_sender">{{x.sender_customer.customer_name}}</td>
												<td data-ng-show="setting_consignee">{{x.consignee_customer.customer_name}}</td>
												<td data-ng-show="setting_totalparcel">{{x.numberof_parcel}}</td>
												<td data-ng-show="setting_weight" data-ng-hide="true">{{x.chargeable_weight}}</td>
												<td data-ng-show="setting_sevice">{{x.service.service_name}}</td>
												<td data-ng-show="setting_status">{{x.status}}</td>
											</tr>
										</tbody>
									</table>
									
									        <!--====================pagination tab============================ -->                               		
                                		          
                                <div class ="col-lg-6 col-md-6 col-xs-12">
                                	<div class="pull-left" data-ng-cloak>
                               			 Showing {{(currentPage*pageSize)+1}} to 
                               			 {{ (totalnof_records - (((currentPage+1)*pageSize))) > 0 ? (currentPage+1)*pageSize : totalnof_records }}
                               			 of {{totalnof_records}} entries
                               		</div>
                                </div>
                                <div class="col-lg-6  col-md-6 col-xs-12 icons-button">
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


			<div class="row">
				<div class="col-lg-12">
					<div class="col-lg-12 ">
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="col-lg-12 noPaddingLeft">
									<div class="col-lg-5 branchclass"></div>
									<div class="col-lg-2 branchclass">
										<%-- <button class="btn btn-primary btn-lg" 
										type="button"
										data-ng-disabled="amctrl.selectedManifest.length<1"
										data-toggle="modal" data-ng-click="amctrl.checkOriginAndDestination()"
											data-target="#myModal">Add Manifest</button> --%>	
										<button class="btn btn-primary btn-lg" 
										type="button"
										data-ng-disabled="amctrl.selectedManifest.length<1"
										 data-ng-click="amctrl.checkOriginAndDestination()"
										>Add Manifest</button>
									</div>
									<div class="col-lg-5 branchclass"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		
<!--================================================== Modal==================================================== -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">Add Manifest</h4>
						</div>
						<div class="modal-body">

						<div class="branchclass">
									<div class="col-lg-12">
										<div class="col-lg-6">
											<span>Driver Name <span class="required">*</span></span>
										</div>
										<div class="col-lg-6">
											<angucomplete-alt id="driver_name"
												data-ng-model="amctrl.manifest.driver_name=emp_name.originalObject"
												 placeholder="Ex: Sankar"
												pause="100" selected-object="emp_name"
												remote-url="getEmployeeDriver4Search/"
												remote_url-data-field="Employees" search-fields="emp_name"
												title-field="emp_name" match-class="highlight"
											    minlength="1" field-required="true"
												data-trigger="focus" data-toggle="popover"
												data-placement="top"
												data-content="Please Enter Employee Name"
												onKeyPress="return CheckIsCharacter(event)"
												input-class="form-control form-control-small">
											</angucomplete-alt>
										</div>
									</div>
								</div>
					

								<div class="branchclass">
									<div class="col-lg-12">
										<div class="col-lg-6">
											<span> Vehicle Number<span class="required">*</span></span></span>
										</div>

										<div class="col-lg-6">
										
											<angucomplete-alt id="vehicle_type"
												data-ng-model="amctrl.manifest.vehicle_number=vehicle_type.originalObject" 
												maxlength="30" onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)"
												pause="100"
												selected-object="vehicle_type" remote-url="vehicleRegNo/"
												remote_url-data-field="VehicleType"
												search-fields="vehicle_regno" title-field="vehicle_regno"
												match-class="highlight" minlength="1"
												field-required="true" data-trigger="focus"
												data-toggle="popover" data-placement="top"
												data-content="Please Enter Vehicle Number"
												placeholder="EX : TN 32 BX 7114"
												input-class="form-control form-control-small">
											</angucomplete-alt>
										</div>
									</div>
								</div>

								<div class="branchclass">
									<div class="col-lg-12">
										<div class="col-lg-6">
											<span> Vehicle Destination<span class="required">*</span></span></span>
										</div>
										<div class="col-lg-6">
										<div angucomplete-alt id="vehicleDestinationBranch"
										    data-ng-model="amctrl.manifest.vehicle_destination=branch_name.originalObject"
											placeholder="Ex : Coimbatore" pause="0"
											selected-object="branch_name" remote-url="getBranchByStr/"
											remote-url-data-field="Branch" title-field="branch_name"
											match-class="highlight" minlength="1" maxlength="30"
											input-class="form-control form-control-small"
											onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)"
											data-trigger="focus" data-toggle="popover"
											data-placement="top" data-content="Please Enter Branch Name"></div>
										</div>
									</div>
								</div>

							</div>
						<div class="modal-footer">
							<button type="button" 
							class="btn btn-danger pull-left"
							data-ng-click="amctrl.clearModalValue()"
								data-dismiss="modal">
								<i class="fa fa-times"></i> Cancel
							</button> 
							<button type="submit" 
							data-ng-click="amctrl.submitManifest()"
							data-ng-disabled="amctrl.manifest.driver_name==null ||  amctrl.manifest.vehicle_number==null || amctrl.manifest.vehicle_destination==null;"
							class="btn btn-success">
								<i class="fa fa-floppy-o"></i> Save
							</button>
		
						</div>
					</div>
				</div>
			</div>
		</div>
	<!--================================================== Modal end==================================================== -->	
		<!-- /. PAGE WRAPPER  -->
	</div>
    <!-- /. WRAPPER  -->
     <!-- DATA TABLE SCRIPTS -->
      <script>$('[data-toggle="popover"]').popover();
      $('.regSettings').click(function(e) {
			e.stopPropagation();
		});
      </script>
     <script src="resources/custom/js/custom.js"></script>
     <script type="text/javascript" src="resources/custom/js/validation.js"></script>
  	<script src="resources/custom/js/session.js"></script>  	
	<script src="resources/custom/js/confirmDialog.js"></script>
  	<script src="resources/custom/js/manifest/add_manifest_service.js"></script>  	
    <script src="resources/custom/js/branch_master/branch_service.js"></script>
  	<script src="resources/custom/js/manifest/add_manifest_controller.js"></script>
	  <script type="text/javascript" src="resources/built-in/js/lodash.js"></script>	
  	
        <script>
            $('[data-toggle="popover"]').popover();
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
        
         <!-- Custom Js -->

</body>

</html>