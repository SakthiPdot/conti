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


<form name="addManifestForm" data-ng-submit="amctrl.submit()">
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
						<b>Last Manifest No : MNFT {{lastManifestNumber}}</b>
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
										
									
										<select name ="fromBranch"
											class="form-control" data-ng-model="amctrl.fromBranch">				
											 <option value="" data-ng-disabled="true">--Select Branch Name--</option>
											 <option data-ng-repeat="x in amctrl.branches" value="{{x.branch_id}}">{{x.branch_name}}</option>
										</select>
										
										
									</div>

									<div class="col-lg-3 branchclass">
										<span class="text-padding">To</span> 
										<select name ="toBranch"
											class="form-control" data-ng-model="amctrl.toBranch">														
											 <option value="" data-ng-disabled="true">--Select Branch Name--</option>
											 <option data-ng-repeat="x in amctrl.branches" value="{{x.branch_id}}">{{x.branch_name}}</option>
										</select>
										
										
									</div>
								</div>

								<div class="col-lg-12 noPaddingLeft">
									<div class="sec-padding">Specific Period</div>
									<div class="col-lg-3 branchclass">
										<span class="paddingtop" >From </span>
										<div class="form-group input-group marginleftrightspace">
											<input type="text" name="datePicker1" class="form-control datepicker1"
											placeholder="Enter From Date"
											 data-ng-model="amctrl.fromdate"/>
											 <span class="input-group-addon"><i class="fa fa-calendar"></i>
											</span>

										</div>
									</div>

									<div class="col-lg-3 branchclass">
										<span class="paddingtop">To</span>
										<div class="form-group input-group spacemarginleftright">
											<input type="text"  name="datePicker2" class="form-control datepicker2" 
											placeholder="Enter To Date"
											data-ng-model="amctrl.todate" /> <span
												class="input-group-addon"><i class="fa fa-calendar"></i>
											</span>
										</div>
									</div>
							

								</div>


								<div class="col-lg-12 noPaddingLeft subhead-padding">
									<div class="col-lg-3 branchclass">
										<span class="text-padding" >Status</span>
										<select data-ng-model="amctrl.status" name="status"
											class="form-control">														
											 <option value="" data-ng-disabled="true">--Select Status--</option>
											<option>Booked</option>										
											<option>Missing</option>
										</select>
									</div>
									<div class="col-lg-4  col-lg-offset-3 branchclass">
										<button class="btn btn-primary" 
										data-ng-click="amctrl.viewShipment()">View Shipment</button>									
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
										<div class="col-xs-6"></div>

										<div class="col-xs-6 icons-button">
											<div class="pull-right">
												<button type="button" class="btn btn-primary">
													<i class="fa fa-cog fa-lg"></i>
												</button>
												<button type="button" class="btn btn-primary">
													<i class="fa fa-file-excel-o fa-lg"></i>
												</button>
												<button type="button" 
												data-ng-disabled="amctrl.selectedManifest.length<1"
												class="btn btn-primary">
													<i class="fa fa-print fa-lg"></i>
												</button>
											</div>
										</div>
									</div>
								</div>

								<div class="table-responsive">


									<table class="table table-striped table-bordered table-hover"
										id="dataTables-example">
										<thead>
											<tr>
												<th><input type="checkbox"
												data-ng-model="amctrl.selectAllManifest"
												data-ng-click="amctrl.selectAll()"></th>
												<th>LR No</th>
												<th>Origin</th>
												<th>Destination</th>
												<th>Sender</th>
												<th>Consignee</th>
												<th>Total Parcel</th>
												<th>Weight</th>
												<th>Service</th>
											</tr>
										</thead>
										<tbody>
											<tr 
											data-ng-repeat='x in amctrl.FilteredManifests | limitTo:pageSize track by x.shipment_id'>
												<td><input type="checkbox"
												data-ng-model="x.select"
												data-ng-click="amctrl.selectManifest(x)"></td>
												<td>{{x.lr_number}}</td>
												<td>{{x.sender_branch.branch_name}}</td>
												<td>{{x.consignee_branch.branch_name}}</td>
												<td>{{x.sender_customer.customer_name}}</td>
												<td>{{x.consignee_customer.customer_name}}</td>
												<td>{{x.numberof_parcel}}</td>
												<td>{{x.chargeable_weight}}</td>
												<td>{{x.service.service_name}}</td>
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


			<div class="row">
				<div class="col-lg-12">
					<div class="col-lg-12 ">
						<div class="panel panel-default">
							<div class="panel-body">
								<div class="col-lg-12 noPaddingLeft">
									<div class="col-lg-5 branchclass"></div>

									<div class="col-lg-2 branchclass">
										<button class="btn btn-primary btn-lg" 
										data-ng-disabled="amctrl.selectedManifest.length<1"
										data-toggle="modal"
											data-target="#myModal">Add Manifest</button>
									</div>

									<div class="col-lg-5 branchclass"></div>


								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


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
												data-ng-model="amctrl.manifest.driver_name" placeholder="Ex: Sankar"
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
												maxlength="30" onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)"
												data-ng-model="amctrl.manifest.vehicle_number" pause="100"
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
										data-ng-model="amctrl.manifest.vehicle_destination"
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
							<button type="submit" class="btn btn-success">
								<i class="fa fa-floppy-o"></i> Save
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- /. PAGE WRAPPER  -->


	</div>
	</form>
    <!-- /. WRAPPER  -->


  
     <!-- DATA TABLE SCRIPTS -->
     <script src="resources/custom/js/custom.js"></script>
  	<script src="resources/custom/js/session.js"></script>  	
	<script src="resources/custom/js/confirmDialog.js"></script>
  	<script src="resources/custom/js/manifest/add_manifest_controller.js"></script>
  	<script src="resources/custom/js/manifest/add_manifest_service.js"></script>  	
    <script src="resources/custom/js/branch_master/branch_service.js"></script>
  	
        <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
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
        
         <!-- Custom Js -->

</body>

</html>