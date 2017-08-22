<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page isELIgnored="false"%>
<%@page session="true"%>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>${title}</title>
<!-- Bootstrap Styles-->
<link href="resources/built-in/assets/css/bootstrap.css"
	rel="stylesheet" />
<!-- FontAwesome Styles-->
<link href="resources/built-in/assets/css/font-awesome.css"
	rel="stylesheet" />

<link href="resources/built-in/assets/Drawer/animate.css"
	rel="stylesheet" />

<!-- Morris Chart Styles-->
<link href="resources/built-in/assets/js/morris/morris-0.4.3.min.css"
	rel="stylesheet" />
<!-- Custom Styles-->
<link href="resources/built-in/assets/css/custom-styles.css"
	rel="stylesheet" />
<!-- Google Fonts-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
<link rel="stylesheet"
	href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css">

<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css"
	rel="stylesheet" />

<link href="resources/built-in/assets/Drawer/trouserDrawer.css"
	rel="stylesheet" />
<link href="resources/custom/css/success_failure_msg.css"
	rel="stylesheet">
<link href="resources/custom/css/custom.css" rel="stylesheet">
<link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">

<link href="resources/custom/css/demo.css" rel="stylesheet">

<script type="text/javascript"
	src="resources/built-in/js/angular.min.js"></script>
<script type="text/javascript"
	src="resources/built-in/js/angucomplete-alt.js"></script>
<script type="text/javascript" src="resources/built-in/js/lodash.js"></script>
<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
<script
	src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
<script src="resources/custom/js/app.js"></script>
</head>


<body style="overflow-x: hidden;" data-ng-app="contiApp"
	data-ng-controller="ViewShipmentController as ctrl">


	<jsp:include page="../Dashboard/nav.jsp" />

	<div id="wrapper">
		<div id="page-wrapper">


			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default panelMarginBottom">

						<div class="panel-body customer-font">
							<b>Shipment</b>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="GenLeftRight">
						<div class="subHead">
							<b>${title}</b>
						</div>
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
										<span class="text-padding">From</span> <select
											class="form-control"
											data-ng-options="branch.branch_id as branch.branch_name for branch in ctrl.branches"
											data-trigger= "focus"data-toggle="popover" data-placement="top"
					                        data-content="Please select from branch"
											data-ng-model="ctrl.viewShipment.from_branch" data-ng-disabled = "ctrl.fromBranch_disable == true">
											<option value="">--Select--</option>
										</select>
									</div>

									<div class="col-lg-3 branchclass">
										<span class="text-padding">To</span> <select
											class="form-control"
											data-ng-options="branch.branch_id as branch.branch_name for branch in ctrl.branches"
											data-trigger= "focus"data-toggle="popover" data-placement="top"
					                        data-content="Please select to branch"
											data-ng-model="ctrl.viewShipment.to_branch">
											<option value="">--Select--</option>
										</select>
									</div>

									<input type="hidden" id="branch_id" value="${branch_id}" />
									<input type = "hidden" id = "currentUserRole" value = "<sec:authentication property="principal.authorities[0]"/>" />
								</div>




								<div class="col-lg-12 noPaddingLeft">
									<div class="sec-padding">Specific Period</div>


									<div class="col-lg-3 branchclass">
										<span class="paddingtop">From </span>
										<div class="form-group input-group marginleftrightspace">


											<input type="text" class="form-control datepicker1" data-ng-model="ctrl.viewShipment.fromdate"
					                           			   data-trigger= "focus"data-toggle="popover" data-placement="top"
					                            		   data-content="Please select from date"/> <span
												class="input-group-addon"><i class="fa fa-calendar"></i>
											</span>

										</div>

									</div>

									<div class="col-lg-3 branchclass">
										<span class="paddingtop">To</span>
										<div class="form-group input-group spacemarginleftright">


											<input type="text" class="form-control datepicker2" data-ng-model="ctrl.viewShipment.todate"
					                           			   data-trigger= "focus"data-toggle="popover" data-placement="top"
					                            		   data-content="Please select to date"/> <span
												class="input-group-addon"><i class="fa fa-calendar"></i>
											</span>

										</div>
									</div>
								</div>

								<div class="col-lg-12 noPaddingLeft subhead-padding">
									<div class="col-lg-3 branchclass">
										<span class="text-padding">Status</span> 
										<select class="form-control" data-ng-model = "ctrl.viewShipment.status"
										data-trigger= "focus"data-toggle="popover" data-placement="top"
					                        data-content="Please select status" 
					                        data-ng-options = "status for status in ['Booked', 'Intransit', 'Pending', 'Return']"
										>
											<option value="">--Select--</option>
											
										</select>

									</div>

									<div class="col-lg-3 branchclass">
										<span class="text-padding">Product</span> 
										<!-- <select class="form-control" data-ng-model = "ctrl.product_name"
											data-trigger= "focus"data-toggle="popover" data-placement="top"
					                        data-content="Please select product" 
										>
											<option>--Select--</option>
											
										</select> -->
										
										<div angucomplete-alt id="product_name" data-ng-model = "ctrl.viewShipment.product_name"
															maxlength="5"
															placeholder="Ex : Box (Large)" 
															pause="0"											
															selected-object="product_name"
														    remote-url="getProductByStr/"
															remote-url-data-field="Product"
				             								title-field="product_name"
															match-class="highlight"
															minlength="1" 																						
														    maxlength="50"	
															input-class="form-control form-control-small"	
															onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)"									
    														data-trigger="focus" data-toggle="popover" 
			   											    data-placement="top" data-content="Please enter & select prduct"
															
											></div>

									</div>

									<div class="col-lg-3 branchclass">
										<button class="btn btn-primary" data-ng-click = "ctrl.filterShipment()">View Shipment</button>
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
										<span class="text-padding boldletter">Search</span> <input
											type="text" class="form-control searchbar"
											placeholder="Manifest/LR No/Receipt No">
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
							<div class="panel-heading">View Shipment Register</div>
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
														<!-- <ul class="dropdown-menu">
									<li><a href="#">Active</a></li>
									<li><a href="#">InActive</a></li>
									<li><a href="#">Archive</a></li>

								</ul> -->

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
												<th>Date</th>
												<th>LR No</th>
												<th>Product</th>
												<th>Origin</th>
												<th>Destination</th>
												<th>Sender</th>
												<th>Consignee</th>
												<th>Status</th>

											</tr>
										</thead>
										<tbody>
											<tr data-ng-repeat="shipment in ctrl.shipments">
												<td><input type="checkbox"
													data-ng-model="shipment.select" /></td>
												<td>{{shipment.shipment_date}}</td>
												<td>{{shipment.lrno_prefix}}</td>
												<td>
													<div
														data-ng-repeat="shipmentDet in shipment.shipmentDetail">
														{{shipmentDet.product.product_name}}<span
															data-ng-if="!($last)">,</span>
													</div>
												</td>
												<td>{{shipment.sender_branch.branch_name}}</td>
												<td>{{shipment.consignee_branch.branch_name}}</td>
												<td>{{shipment.sender_customer.customer_name}}</td>
												<td>{{shipment.consignee_customer.customer_name}}</td>
												<td>{{shipment.status}}</td>

											</tr>
										<tbody>
									</table>

									<div class="col-lg-6 icons-button"></div>
									<div class="col-lg-6 icons-button">
										<div class="pull-right">
											<!-- <ul>
                                   			<li class="btn btn-primary" data-ng-click = "paginatebyno($index+1)" data-ng-repeat = "i in counter(noofpages) track by $index"> {{$index+1}}</li>
                                   		</ul>  -->
											<!-- <pagination total-items="totalItems" ng-model="currentPage" max-size="maxSize" class="pagination-sm" boundary-links="true" rotate="false" num-pages="numPages" items-per-page="itemsPerPage"></pagination>  -->
											<button class="btn btn-primary" type="button"
												data-ng-disabled="previouseDisabled"
												data-ng-click="firstlastPaginate(1)">First</button>

											<button class="btn btn-primary" type="button"
												data-ng-disabled="previouseDisabled"
												data-ng-click="paginate(-1)">Previouse</button>
											<button class="btn btn-primary" type="button"
												data-ng-disabled="nextDisabled" data-ng-click="paginate(1)">Next</button>

											<button class="btn btn-primary" type="button"
												data-ng-disabled="nextDisabled"
												data-ng-click="firstlastPaginate(0)">Last</button>
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

	<script src="resources/custom/js/shipment/viewshipment_controller.js"></script>
	<script src="resources/custom/js/shipment/shipment_service.js"></script>
	<script src="resources/custom/js/user_master/user_service.js"></script>
	<script src="resources/custom/js/branch_master/branch_service.js"></script>
	<script
		src="resources/custom/js/price_setting/s_price_setting_service.js"></script>
	<script
		src="resources/custom/js/CompanySetting/company_setting_service.js"></script>
	<script src="resources/custom/js/custom.js"></script>
	<script src="resources/custom/js/confirmDialog.js"></script>
	<script type="text/javascript" src="resources/custom/js/validation.js"></script>


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