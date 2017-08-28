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
	
	 <link href="resources/built-in/assets/Drawer/animate.css" rel="stylesheet" />
	 
    <!-- Morris Chart Styles-->
    <link href="resources/built-in/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="resources/built-in/assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css"> 
	
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	  <link href="resources/custom/css/custom.css" rel="stylesheet">
	   <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">
	<link rel="stylesheet" href="resources/custom/css/success_failure_msg.css">
	 <link href="resources/custom/css/demo.css" rel="stylesheet">
<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script type="text/javascript" src="resources/built-in/js/lodash.js"></script> 
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <script src="resources/custom/js/app.js"></script>
</head>


<body style="overflow-x:hidden;" data-ng-app="contiApp" data-ng-controller="ReceiptController as ctrl">
 
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
	
	
	<jsp:include page="../Dashboard/nav.jsp"/>
	
	<div class="success hideme"><i class="fa fa-check-circle" aria-hidden="true"></i> {{ctrl.message}}</div>
	<div class="failure hideme"><i class="fa fa-times-circle" aria-hidden="true"></i> {{ctrl.message}}</div>
	
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      		<div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default panelMarginBottom">                            
						<div class="panel-heading">
							
						</div>
						<div class="panel-body customer-font">
						<b>Receipt</b>
						</div>
                        </div>
                    </div>
              </div>
              
              
              <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
              	  <div class="col-md-6 col-sm-6 col-xs-6 GenLeftRight">
	              <div  class="subHead">
	              <b>${title}</b>
	              </div>
	              </div>
	              
	              <div class="col-md-2">
	              </div>
	              
	              <div class="col-md-3 col-sm-4 col-xs-6">	              
	              <b>Last Receipt No :{{lastReceiptNumber}}</b>	              
	              </div>
	              
              </div>
              </div>
              
                
                <div class="row">
                	<div class="col-lg-12">
                		<div class="col-lg-12 ">                		
                		<div class="panel panel-default">
                			<div class="panel-body">
                			     <div class="branch-heading">Branch</div>
                			     
                			     <div class="col-lg-12 noPaddingLeft "> 
                			      <div class="col-lg-3 branchclass">
                			      		<span class="text-padding">From</span>
                			      		<select class="form-control" 
                			      		 data-ng-model="frombranch_filter">
                			      			<option value="" data-ng-disabled="true">--Select Branch Name--</option>
                			      			<option data-ng-repeat="x in ctrl.branches" value="{{x.branch_id}}">{{x.branch_name}}</option>
                			      		</select>
                			      </div>
                			      
                			       <input type="hidden" value="${paid}" id="paid"/>
                			       <input type="hidden" value="${to_pay}" id="to_pay"/>
                			      
                			      <input type="hidden" value="${branch_id}" id="branchid"/>
                			      
                			       <div class="col-lg-3 branchclass">
                			      		<span class="text-padding">To</span>
                			      		
                			<%--       		<sec:authorize access="hasRole('STAFF') or hasRole('MANAGER')">							
											<input type="hidden" class="form-control " data-ng-model="tobranch_filter" >
											<input type="text" class="form-control " data-ng-disabled="true" data-ng-model="tobranch_sample">
										</sec:authorize> --%>
										
                			      		<%-- <sec:authorize access="hasRole('SUPER_ADMIN')"> --%>
                			      		<select class="form-control" 
                			      		data-ng-model="tobranch_filter">
                			      			<option value="" data-ng-disabled="true">--Select Branch Name--</option>                			      			
                			      			<option data-ng-repeat="x in ctrl.branches" value="{{x.branch_id}}">{{x.branch_name}}</option>
                			      		</select>
                			      		<%-- </sec:authorize> --%>
                			      		
                			      </div>
                			      </div>
                			      
                			      



								<div class="col-lg-12 noPaddingLeft ">

									<div class="sec-padding">Specific Period</div>
									<div class="col-lg-3 branchclass">
										<span class="text-padding">From </span>
										<div class=" input-group ">
											<input type="text" class="form-control datepicker1"
												data-ng-model="fromdate_filter" data-trigger="focus"
												placeholder="Enter From Date"
												data-toggle="popover" data-placement="top"
												data-content="Please select from date" /> <span
												class="input-group-addon"><i class="fa fa-calendar"></i></span>
										</div>
									</div>

									<div class="col-lg-3 branchclass">
										<span class="text-padding">To</span>
										<div class=" input-group ">
											<input type="text" class="form-control datepicker2"
												data-ng-model="todate_filter" data-trigger="focus"
												placeholder="Enter To Date"
												data-toggle="popover" data-placement="top"
												data-content="Please select to date" /> <span
												class="input-group-addon"><i class="fa fa-calendar"></i>
											</span>
										</div>
									</div>
								</div>

								<div class="col-lg-12"><br></div>
								
								<div class="col-lg-12 noPaddingLeft subhead-padding"> 
                			       		<div class="col-lg-3 branchclass">
                			      		 <span class="text-padding">Service</span>	                	                                       
                                            <select class="form-control" data-ng-options= "service for service in ['Counter','Door Delivery']"
                                            data-ng-model="service_filter">
                                            	<option value='' data-ng-disabled="true">--Select Service--</option>
                                             </select>
                                         </div>
                			            
                			            <div class="col-lg-3 branchclass">
                			      		 <span class="">Payment Mode</span>	                	                                       
                                            <select class="form-control" data-ng-options= "pay for pay in ['Cash','Credit','Check']"
                                            data-ng-model="paymode_filter">
                                            	<option value='' data-ng-disabled="true">--Select Payment Mode--</option>
                                            </select>
                			            </div>
                			            
                			            <div class="col-lg-4 branchclass">
                			      		   <button class="btn btn-primary" data-ng-click="ctrl.viewShipment()"> View Shipment</button>
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
                			      		 <span class="text-padding boldletter" >Search</span>	                	                                       
                                            <input type="text" class="form-control searchbar" placeholder="LR Number"
                                            data-ng-model="ctrl.search" 
                                            data-ng-keyup="ctrl.registerSearch(ctrl.search)">  
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
                        <div class="panel-heading">
                            Receipt Generation
                        </div>
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
														data-ng-change="ctrl.shownoofRecord()">
													</select>
												</div>
											</div>
										</div>
									</div>
                                
                               <div class="col-xs-6 icons-button">
                                   <div class="pull-right">
                                   
                                   <form name="receiptPrint" method="POST" action="shipmentPrint" class="padding-button">
                    	<a type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a>
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
																	<div class="checkbox" data-ng-show="false">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_status == true, 'fa-times': setting_status== false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_status = true"
																		data-ng-model="setting_status" /> Status
																	</label>
																</div>
																<div class="checkbox" >
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_pm == true, 'fa-times': setting_pm == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_pm = true"
																		data-ng-model="setting_pm" /> Payment Mode
																	</label>
																</div>
																		
														</div>
                     <a type="button" class="btn btn-primary" onclick="location.href='downloadExcelForAddReceipt';valid = true;"><i class="fa fa-file-excel-o fa-lg"></i></a>
                      	
                      	
                      	  <button type="submit" class="btn btn-primary" data-ng-disabled = "ctrl.selected_receipt.length <1" >
                      	  <i class="fa fa-print fa-lg"></i></button>
                      	  
                          <input type = "hidden" name = "selectedShipment" value = "{{ctrl.selected_receipt}}" />
                          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          
				</form>
                                    </div>
                                </div>
                              </div>
                            </div>
                          
                            <div class="table-responsive">                    
                                
                                
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                   <thead>
											<tr>
												<th><input type="checkbox"
												data-ng-model="selectallreceipts"
												data-ng-click="ctrl.receiptSelectAll()"></th>
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
																<th data-ng-show="setting_status" data-ng-hide="true"
												data-ng-click="status=!status;sortTable('status',status);">Status<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':status,'fa fa-caret-down':!status}"
														aria-hidden="true"></i></th>
														
												<th data-ng-show="setting_pm"
												data-ng-click="pm=!pm;sortTable('pm',pm);">Payment Mode<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':pm,'fa fa-caret-down':!pm}"
														aria-hidden="true"></i></th>	
											</tr>
										</thead>
                            		<tbody>
											<tr 
											data-ng-repeat='x in ctrl.Filterreceipts| limitTo:pageSize track by x.shipment_id'>
												<td><input type="checkbox"
												data-ng-model="x.select"
												data-ng-click="ctrl.receiptSelect(x)"></td>
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
												<td data-ng-show="setting_status" data-ng-hide="true">{{x.status}}</td>
												<td data-ng-show="setting_pm">{{x.pay_mode}}</td>
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
                			       		<div class="col-lg-5 branchclass">
                			      		 </div>
                                        <div class="col-lg-2 branchclass">
                			      		   <button class="btn btn-primary btn-lg"
                			      		   data-ng-disabled = "ctrl.selected_receipt.length <1"
                			      		    data-toggle="modal" data-target="#myModal">
                                               Receipt Generate
                                            </button>                                     
                                        </div>
                                        <div class="col-lg-5 branchclass">
                			      	 </div>
                                  </div>
                			 </div>
                		  </div>
                		</div>
                	</div>
                </div>
                
                <!--================================================== Modal==================================================== -->
                 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
                 data-backdrop="static" data-keyboard="false">
                                <div class="modal-dialog" style="width: auto ! important;height: auto ! important;">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Create Receipt</h4>
                                        </div>
						<div class="modal-body">


							<table  data-ng-cloak class="table table-striped table-bordered table-hover"
								id="dataTables-example">
								<thead>
									<tr>

										<!-- <th></th> -->
										<th>LR Number</th>
										<th>Parcel</th>
										<th>Handling
											Charge</th>

									</tr>
								</thead>
								<tbody>
									<tr data-ng-repeat="receipt in ctrl.selected_receipt"
										data-id="{{receipt.receipt_id}}">


										<!-- <td><input type="checkbox"
											data-ng-click="ctrl.receiptSelect(receipt)"
											data-ng-model="receipt.select"></td> -->

										<td>{{receipt.lrno_prefix}}</td>

										<td>{{receipt.numberof_parcel}}</td>

										<td>
										
										<div class="input-group">
											<input	
													data-ng-model="receipt.h_charge"																					
													data-trigger="focus" data-toggle="popover"
													data-placement="top"
													onKeyPress="return CheckIsNumericAnddot(event,this.value) "
													maxlength="8"
													data-content="Please Enter Handling Charge"
													placeholder="Ex:99.99"
												type="text" class="form-control">
												<span class="input-group-addon" id="basic-addon2"><i class="fa fa-inr" aria-hidden="true"></i></span>
											</div>
										</td>
										

									</tr>
								</tbody>
							</table>
							
							
							<div data-ng-cloak class='row'  >
							<fieldset data-ng-disabled="true">
								<div class="col-lg-12 ">
									<div class="col-lg-6">
										<span> Freight Charge</span>
									</div>
									<div class="col-lg-6 ">
									<div class="input-group Bottom" >
										<input type="text" class="form-control"
										data-ng-model="allLR_freight_charge"
										onKeyPress="return CheckIsNumericAnddot(event,this.value) "
										maxlength="10"
										placeholder="Ex:100.00">
										<span class="input-group-addon"><i class="fa fa-inr"></i></span>
									</div>
									</div>
								</div>
								</fieldset>
							</div>
							
							
							<div class='row'>
								<div class="col-lg-12 ">
									<div class="col-lg-6">
										<span> Local Transport</span>
									</div>
									<div class="col-lg-6 ">
									<div class="input-group">
										<input type="text" class="form-control"
										onKeyPress="return CheckIsNumericAnddot(event,this.value) "
										maxlength="8"
										data-ng-model="ctrl.receipt.local_transport"
										placeholder="Ex:72.25">
										<span class="input-group-addon"><i class="fa fa-inr" aria-hidden="true"></i></span>
									</div>
									</div>
									
								</div>
							</div>
							
							
							<div data-ng-show="ctrl.receipt.local_transport.length>0 || showDoorDelivery">
							<h4 class="text-center">Door Delivery</h4>
							
							<div class='row'>
								<div class="col-lg-12 ">
									<div class="col-lg-6">
										<span> Courier Staff</span>
									</div>
									
									
									<div class="col-lg-6 ">
										
												<angucomplete-alt id="driver_name"
												 placeholder="Ex: xyz"
												 onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)"
												pause="100" selected-object="staff_name"
												remote-url="getStaffManifest4Search/"
												override-suggestions="true"
												remote_url-data-field="staff" search-fields="courier_staff"
												title-field="courier_staff" match-class="highlight"
											    minlength="1" field-required="true"
												onKeyPress="return CheckIsCharacter(event)"
												input-class="form-control form-control-small">
											</angucomplete-alt>
											
									</div>
									
								
									
								</div>
							</div>

							<div class='row'>
								<div class="col-lg-12">
									<div class="col-lg-6">
										<span> Contact Number</span>
									</div>
									<div class="col-lg-6 ">
										<input type="text" class="form-control" list="contact_number"
										data-ng-model="ctrl.receipt.contact_number"
									onKeyPress="return CheckIsNumericAnddot(event,this.value) "
										placeholder="Ex.9876543210">
										<datalist id="contact_number">
										</datalist>
									</div>
								</div>
							</div>
							</div>
							
							
						</div>


						<div class="modal-footer">
                                            <button type="button" class="btn btn-danger pull-left" data-dismiss="modal"> <i class="fa fa-times"></i> Cancel</button>
                                            <button type="button" data-ng-click="ctrl.receiptSubmit()" class="btn btn-success"><i class="fa fa-floppy-o"></i> Save</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
            
        </div>
        <!-- /. PAGE WRAPPER  -->
		
		
    </div>

	<script src="resources/custom/js/custom.js"></script>
    <script src="resources/custom/js/receipt/add_receipt_controller.js"></script>
    <script src="resources/custom/js/receipt/add_receipt_service.js"></script>
    <script src="resources/custom/js/branch_master/branch_service.js"></script>
    <script src="resources/custom/js/confirmDialog.js"></script>   
    <script type="text/javascript" src="resources/custom/js/validation.js"></script>    
  	<script src="resources/custom/js/manifest/add_manifest_service.js"></script> 
    <script>
        $('[data-toggle="popover"]').popover();
    </script>
   

    <script type="text/javascript">

    
    function getDate()
    {
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
   	<style>
      .bottom {
            	padding-bottom:5px;
            }
     </style>
</body>

</html>