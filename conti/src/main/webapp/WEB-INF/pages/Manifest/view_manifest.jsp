<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@page session="true"%>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link rel="icon" type="image/gif/png"
	href="resources/Image/conti_logo.png">
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

<link href="resources/built-in/assets/Drawer/trouserDrawer.css"
	rel="stylesheet" />
<link href="resources/custom/css/custom.css" rel="stylesheet">

<link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">

<link href="resources/custom/css/demo.css" rel="stylesheet">
<script type="text/javascript"
	src="resources/built-in/js/angular.min.js"></script>
<script type="text/javascript"
	src="resources/built-in/js/angucomplete-alt.js"></script>
<link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
<script type="text/javascript" src="resources/built-in/js/lodash.js"></script>
<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
<script
	src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
<script src="resources/custom/js/app.js"></script>
</head>


<body style="overflow-x: hidden;" data-ng-app="contiApp"
	data-ng-controller="ManifestController as ctrl">

	<!-- ------------------------- Overlay for message begin ------------------ -----  -->
	<div class="overlay hideme"></div>
	<!-- ------------------------- Overlay for message end ------------------ -----  -->
	<!-- ------------------------- Success message begin ------------------ -----  -->
	<div class="success hideme">
		<i class="fa fa-check-circle" aria-hidden="true"></i> {{ctrl.message}}
		<span class="close" data-ng-click="ctrl.forgot_animateClose()"><i
			class="fa fa-times" aria-hidden="true"></i></span>
	</div>
	<!-- ------------------------- Success message end ------------------ -----  -->
	<!-- ------------------------- Failure message begin ------------------ -----  -->
	<div class="failure hideme">
		<i class="fa fa-times-circle" aria-hidden="true"></i> {{ctrl.message}}
		<!-- <span class="close" data-ng-click = "ctrl.forgot_animateClose()"><i class="fa fa-times" aria-hidden="true"></i></span> -->
	</div>
	<!-- ------------------------- Failure message end ------------------ -----  -->


	<jsp:include page="../Dashboard/nav.jsp" />

	<div id="wrapper">
		<div id="page-wrapper">


			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default panelMarginBottom">
						<!-- <div class="panel-heading"></div> -->
						<div class="panel-body customer-font">
							<b>Manifest</b>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-md-12">

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
											data-ng-model="ctrl.manifest.frombranch">
											<!-- 											data-ng-disabled = "ctrl.fromBranch_disable == true" > -->
											<option value="" >--Select Branch Name--</option>
										</select>
									</div>
									<div class="col-lg-3 branchclass">
										<span class="text-padding">To</span> <select
											class="form-control"
											data-ng-options="branch.branch_id as branch.branch_name for branch in ctrl.branches"
											data-ng-model="ctrl.manifest.tobranch">
											<option value="">--Select Branch Name--</option>

										</select>
									</div>
								</div>
								<input type="hidden" id="branch_id" value="${branch_id}" />
								 <input
									type="hidden" id="currentUserRole"
									value="<sec:authentication property="principal.authorities[0]"/>" />

								<div class="col-lg-12 noPaddingLeft">
									<div class="sec-padding">Specific Period</div>

									<div class="col-lg-3 branchclass">
										<span class="paddingtop">From </span>
										<div class="form-group input-group marginleftrightspace">
											<input type="text" class="form-control datepicker1"
												data-ng-model="ctrl.manifest.fromdate" data-trigger="focus"
												placeholder="Select From date"
												data-toggle="popover" data-placement="top"
												data-content="Please select from date" /> <span
												class="input-group-addon"><i class="fa fa-calendar"></i></span>
										</div>
									</div>

									<div class="col-lg-3 branchclass">
										<span class="paddingtop">To</span>
										<div class="form-group input-group spacemarginleftright">
											<input type="text" class="form-control datepicker2"
												data-ng-model="ctrl.manifest.todate" data-trigger="focus"
												placeholder="Select To date"
												data-toggle="popover" data-placement="top"
												data-content="Please select to date" /> <span
												class="input-group-addon"><i class="fa fa-calendar"></i>
											</span>

										</div>
									</div>

									<div class="col-lg-2"></div>
									<div class="col-lg-4 branchclass">
										<button class="btn btn-primary"
											data-ng-click="ctrl.manifestFilter()">View Manifest</button>
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
										<span class="text-padding boldletter">Search By</span> <select
											class="form-control " data-ng-model="ctrl.search.searchBy"
											data-ng-init="ctrl.search.searchBy='Manifest Number'"
											data-ng-options="searchBy for searchBy in ['Manifest Number','LR Number']">
										</select>
									</div>

									<div class="col-lg-3 branchclass">
										<span class="text-padding boldletter">Search</span> <input
											type="text" class="form-control searchbar"
											placeholder="Manifest/LR No"
											data-ng-model="ctrl.search.manifest_regSearch"
											data-ng-keyup="ctrl.manifestSearch(ctrl.search)">
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
							<div class="panel-heading">View Manifest Register</div>
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
														<ul class="dropdown-menu">
															<li><a data-ng-click="ctrl.deleteManifest()">Delete</a></li>
														</ul>
													</div>
													<div class="row paddingtop">
														<div class="col-md-12">
															<select name="shownoofrec" data-ng-model="shownoofrec"
																data-ng-options="noofrec for noofrec in [10, 15, 25, 50, 100]"
																class="form-control"
																data-ng-click="ctrl.shownoofRecord()">
															</select>
														</div>
													</div>

												</div>
											</div>

											<div class="col-xs-6 icons-button">
												<div class="pull-right">

													<form name="manifestPrint" target="_blank" method="POST"
														action="manifest_print" class="padding-button">
														<a type="button" class="btn btn-primary dropdown-toggle"
															data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a>
														<div class="dropdown-menu regSettings pull-right"
															style="padding-right: 5px;">

															<div class="checkbox">
																<label> <i class="fa"
																	data-ng-class="{'fa-check': setting_manifestnumber == true, 'fa-times': setting_manifestnumber == false}"></i>
																	<input type="checkbox"
																	data-ng-init="setting_manifestnumber=true"
																	data-ng-model="setting_manifestnumber" /> Manifest
																	Number
																</label>
															</div>

															<div class="checkbox">
																<label> <i class="fa"
																	data-ng-class="{'fa-check': setting_manifestorigin == true, 'fa-times': setting_manifestorigin == false}"></i>
																	<input type="checkbox"
																	data-ng-init="setting_manifestorigin=true"
																	data-ng-model="setting_manifestorigin" /> Origin
																</label>
															</div>

															<div class="checkbox">
																<label> <i class="fa"
																	data-ng-class="{'fa-check': setting_manifestdestination == true, 'fa-times': setting_manifestdestination == false}"></i>
																	<input type="checkbox"
																	data-ng-init="setting_manifestdestination=true"
																	data-ng-model="setting_manifestdestination" />
																	Destination
																</label>
															</div>

															<div class="checkbox">
																<label> <i class="fa"
																	data-ng-class="{'fa-check': setting_manifestvehicle == true, 'fa-times': setting_manifestvehicle == false}"></i>
																	<input type="checkbox"
																	data-ng-init="setting_manifestvehicle=true"
																	data-ng-model="setting_manifestvehicle" /> Vehicle
																	Number
																</label>
															</div>

															<div class="checkbox">
																<label> <i class="fa"
																	data-ng-class="{'fa-check': setting_manifestdriver == true, 'fa-times': setting_manifestdriver == false}"></i>
																	<input type="checkbox"
																	data-ng-init="setting_manifestdriver=true"
																	data-ng-model="setting_manifestdriver" /> Driver Name
																</label>
															</div>

															<div class="checkbox">
																<label> <i class="fa"
																	data-ng-class="{'fa-check': setting_manifeststatus == true, 'fa-times': setting_manifeststatus == false}"></i>
																	<input type="checkbox"
																	data-ng-init="setting_manifeststatus=true"
																	data-ng-model="setting_manifeststatus" /> Manifest
																	Status
																</label>
															</div>

															<div class="checkbox">
																<label> <i class="fa"
																	data-ng-class="{'fa-check': setting_noofarticles == true, 'fa-times': setting_noofarticles == false}"></i>
																	<input type="checkbox"
																	data-ng-init="setting_noofarticles=true"
																	data-ng-model="setting_noofarticles" />No of Articles
																</label>
															</div>

														</div>
														<a type="button" class="btn btn-primary"
															onclick="location.href='downloadExcelManifest';valid = true;"><i
															class="fa fa-file-excel-o fa-lg"></i></a>
														<button type="submit" class="btn btn-primary"
															data-ng-disabled="ctrl.selected_manifest.length == 0">
															<i class="fa fa-print fa-lg"></i>
														</button>
														<input type="hidden" name="manifest"
															value="{{ctrl.selected_manifest}}" /> <input
															type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</form>
													<!--                                       <button type="button" class="btn btn-primary"><i class="fa fa-cog fa-lg"></i></button> -->
													<!--                                       <button type="button" class="btn btn-primary"><i class="fa fa-file-excel-o fa-lg"></i></button> -->
													<!--                                       <button type="button" class="btn btn-primary"><i class="fa fa-print fa-lg"></i></button> -->
												</div>
											</div>
										</div>
									</div>

									<table class="table table-striped table-bordered table-hover"
										id="dataTables-example">
										<thead>
											<tr>
												<th><input type="checkbox"
													data-ng-click="ctrl.manifestSelectAll()"
													data-ng-model="selectallmanifests"></th>

												<th data-ng-show="setting_manifestnumber"
													data-ng-click="manifestNumber=!manifestNumber;sortTable('manifestNumber',manifestNumber);">Manifest
													Number <i data-ng-hide="disableSorting"
													data-ng-class="{'fa fa-caret-up':manifestNumber,'fa fa-caret-down':!manifestNumber}"
													aria-hidden="true"></i>
												</th>

												<th data-ng-show="setting_manifestorigin"
													data-ng-click="manifestOrigin=!manifestOrigin;sortTable('manifestOrigin',manifestOrigin);">Origin
													<i data-ng-hide="disableSorting"
													data-ng-class="{'fa fa-caret-up':manifestOrigin,'fa fa-caret-down':!manifestOrigin}"
													aria-hidden="true"></i>
												</th>

												<th data-ng-show="setting_manifestdestination"
													data-ng-click="manifestDestination=!manifestDestination;sortTable('manifestDestination',manifestDestination);">Destination
													<i data-ng-hide="disableSorting"
													data-ng-class="{'fa fa-caret-up':manifestDestination,'fa fa-caret-down':!manifestDestination}"
													aria-hidden="true"></i>
												</th>

												<th data-ng-show="setting_manifestvehicle"
													data-ng-click="manifestVehicle=!manifestVehicle;sortTable('manifestVehicle',manifestVehicle);">Vehicle
													Number <i data-ng-hide="disableSorting"
													data-ng-class="{'fa fa-caret-up':manifestVehicle,'fa fa-caret-down':!manifestVehicle}"
													aria-hidden="true"></i>
												</th>

												<th data-ng-show="setting_manifestdriver"
													data-ng-click="manifestDriver=!manifestDriver;sortTable('manifestDriver',manifestDriver);">Driver
													Name <i data-ng-hide="disableSorting"
													data-ng-class="{'fa fa-caret-up':manifestDriver,'fa fa-caret-down':!manifestDriver}"
													aria-hidden="true"></i>
												</th>

												<th data-ng-show="setting_manifeststatus"
													data-ng-click="manifestStatus=!manifestStatus;sortTable('manifestStatus',manifestStatus);">Manifest
													Status <i data-ng-hide="disableSorting"
													data-ng-class="{'fa fa-caret-up':manifestStatus,'fa fa-caret-down':!manifestStatus}"
													aria-hidden="true"></i>
												</th>

												<th data-ng-show="setting_noofarticles"
													data-ng-click="manifestArticles=!manifestArticles;sortTable('manifestArticles',manifestArticles);">No
													of Articles <i data-ng-hide="disableSorting"
													data-ng-class="{'fa fa-caret-up':manifestArticles,'fa fa-caret-down':!manifestArticles}"
													aria-hidden="true"></i>
												</th>

											</tr>
										</thead>
										<tbody>

											<tr
												data-ng-repeat="manifest in ctrl.Filtermanifests| limitTo:pageSize"
												data-id={{manifest.manifest_id}} ondblClick="test(this)">

												<td><input type="checkbox"
													data-ng-click="ctrl.manifestSelect(manifest)"
													data-ng-model="manifest.select"></td>
												<td data-ng-show="setting_manifestnumber">{{manifest.manifest_prefix}}</td>
												<td data-ng-show="setting_manifestorigin">{{manifest.branchModel1.branch_name}}</td>
												<td data-ng-show="setting_manifestdestination">{{manifest.branchModel2.branch_name}}</td>
												<td data-ng-show="setting_manifestvehicle">{{manifest.vehicle_number.vehicle_regno}}</td>
												<td data-ng-show="setting_manifestdriver">{{manifest.driver_name.emp_name}}</td>
												<td data-ng-show="setting_manifeststatus">{{manifest.manifest_status}}</td>
												<td data-ng-show="setting_noofarticles">{{manifest.manifestDetailModel.length}}</td>


											</tr>
										</tbody>
									</table>

								</div>

								<div class="col-lg-6">
									<div class="pull-left">Showing
										{{(currentPage*pageSize)+1}} to {{ (totalnof_records -
										(((currentPage+1)*pageSize))) > 0 ? (currentPage+1)*pageSize :
										totalnof_records }} of {{totalnof_records}} entries</div>
								</div>

								<div class="col-lg-6 icons-button">
									<div class="pull-right">
										<button class="btn btn-primary" type="button"
											data-ng-disabled="previouseDisabled"
											data-ng-click="firstlastPaginate(1)">First</button>
										<button class="btn btn-primary" type="button"
											data-ng-disabled="previouseDisabled"
											data-ng-click="paginate(-1)">Previous</button>
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
				</div>
			</div>

		</div>
		<!-- /. PAGE WRAPPER  -->
	</div>
	<!-- /. WRAPPER  -->
	<script src="resources/custom/js/custom.js"></script>
	<script src="resources/custom/js/manifest/view_manifest_controller.js"></script>
	<script src="resources/custom/js/manifest/view_manifest_service.js"></script>
	<script src="resources/custom/js/branch_master/branch_service.js"></script>
	<script src="resources/custom/js/confirmDialog.js"></script>
	<script type="text/javascript" src="resources/custom/js/validation.js"></script>
	<script>
		$('[data-toggle="popover"]').popover();
		$('.regSettings').click(function(e) {
			e.stopPropagation();
		});
	</script>

	<script type="text/javascript">
		function getDate() {
			var today = new Date();
			var dd = today.getDate();
			var mm = today.getMonth() + 1; //January is 0!
			var yyyy = today.getFullYear();

			if (dd < 10) {
				dd = '0' + dd
			}

			if (mm < 10) {
				mm = '0' + mm
			}

			today = yyyy + '-' + mm + '-' + dd;
			return today;
		}
		$('.datepicker1').dateTimePicker({
			limitMax : getDate()
		});

		$('.datepicker2').dateTimePicker({
			limitMax : getDate()
		});
	</script>

</body>

</html>