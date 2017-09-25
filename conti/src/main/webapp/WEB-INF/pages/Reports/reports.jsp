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
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
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


<body style="overflow-x:hidden;"data-ng-app="contiApp" data-ng-controller = "ReportController as ctrl">
 
 <!-- ------------------  Overlay for message begin ----------- -->
 		<div class="overlay hideme"></div>
 <!-- ------------------  Overlay for message end ------------- -->
 
 <!-- ------------------  Success message begin --------------- -->
 		<div class="success hideme">
 			<i class="fa fa-check-circle"></i> {{ctrl.message}}
 			<span class="close" data-ng-click = "ctrl.forgot_animateClose()"><i class="fa fa-times"></i></span>
 		</div>
 <!-- ------------------  Success message end ----------------- -->
 
 <!-- -----------------  Failure message begin ---------------- -->
 		
 		<div class="failure hideme">
 			<i class="fa fa-check-circle"></i> {{ctrl.message}}
 		</div>
 <!-- -----------------  Failure message end ------------------ -->
	<input type = "hidden" id = "currentuserid" value = "${userid}" />
	<input type = "hidden" id = "currentUserRole" value = "<sec:authentication property="principal.authorities[0]"/>" />
	<jsp:include page="../Dashboard/nav.jsp"/>
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      
      	    		
   		   <div class="row">
                 <div class="col-lg-12">
                     <div class="panel panel-default">
                     <div class="panel-body customer-font">
						<b>${title}</b>
					 </div>
                     </div>
                 </div>
           </div>
                
                
                
           <div class="row">
               <div class="col-lg-12">
               
               		<div class="col-lg-4">
               		</div>
                
					<div class="col-lg-4">
						<div class="panel panel-default">                            
							<div class="panel-heading">
								 Filter by
							</div>
						
						<div class="panel-body customer-field">
                                   
                                   <label class="radio-inline">
                                       <input type="radio" data-ng-model = "filter_date" 
                                       data-ng-click="filter_branch=false;filter_lr=false;filter_billto=false;filter_all=false;ctrl.date_required=true;ctrl.filterReset();"value="filter_date"
                                       name="optionsRadiosInline" id="optionsRadiosInline1" > Date Wise
                                   </label>
                                   <label class="radio-inline">
                                       <input type="radio"  data-ng-model = "filter_branch" value="filter_branch"
                                       data-ng-click="filter_date= false;filter_lr=false;filter_all=false;filter_billto=false;ctrl.date_required=false;ctrl.filterReset();ctrl.resetDate();"
                                       name="optionsRadiosInline" id="optionsRadiosInline2"> Branch Wise
                                   </label>
                                   <label class="radio-inline">
                                       <input type="radio" data-ng-model="filter_lr"  value="filter_lr" 
                                       data-ng-click="filter_branch=false;filter_date=false;filter_all=false;filter_billto=false;ctrl.date_required=false;ctrl.filterReset();ctrl.resetDate();"
                                        name="optionsRadiosInline" id="optionsRadiosInline3" > LR No Wise
                                   </label>
                                   <label class="radio-inline">
                                   	<input type="radio"  data-ng-model ="filter_all"  value="filter_all" 
                                   	 data-ng-click="filter_branch=true;filter_date=true;filter_lr=true;filter_billto = false;ctrl.date_required=true;ctrl.filterReset();"
                                   	name="optionsRadiosInline" id="optionsRadiosInline4"> All
                                   </label>
                                   <label class="radio-inline">
                                   	<input type="radio"  data-ng-model ="filter_billto" data-ng-init="filter_billto=true"  value="filter_billto" 
                                   	 data-ng-click="filter_branch=true;filter_date=false;filter_lr=false;filter_all=false;ctrl.date_required=false;ctrl.filterReset();"
                                   	name="optionsRadiosInline" id="optionsRadiosInline5"  data-ng-checked="true"> Daily Hand over
                                   </label>
						
						</div>
			            </div>  
			        </div>
		
                   <div class="col-lg-4">
                   </div>
                   
               </div>
           </div>
                
                
                
                
                <form name = "report" data-ng-submit = "ctrl.submit()" >
                <div class="row">
                <div class="col-lg-12">
                <div class="col-lg-12">
                <div class="panel panel-default">                            
						
				<div class="panel-body">
				
				
								
				
				<div class="col-lg-12 noPaddingLeft report_padding" data-ng-show="filter_billto">
					
					<div class="col-lg-3 report_class">
						<span class="text-padding"> Date <span class="required">*</span></span>
						
						<div class="form-group input-group">
                                  <input type="text" id="datepicker3" class="form-control datepicker3"
                                  placeholder="Select or Enter  date" 
                                  data-ng-model="ctrl.report.today" data-ng-required = "filter_billto">
                                  <span class="input-group-btn">
                                      <button class="btn btn-default " type="button"><i class="fa fa-calendar"></i>
                                      </button>
                                  </span>
                            </div>
						
					</div>				
				</div>
				
				
				
				<div class="branch-heading" data-ng-show="filter_date || filter_all">Shipment</div>
				
				<div class="col-lg-12 noPaddingLeft" data-ng-show="filter_date || filter_all" >
					<div class="col-lg-3 report_class">
						<span>From</span>  <span class="required">*</span>
					       <div class="form-group input-group">
                                  <input type="text" id="datepicker1" class="form-control datepicker1"
                                  placeholder="Select or Enter from date" 
                                  data-ng-model="ctrl.report.fromtoday" data-ng-required = "ctrl.date_required">
                                  <span class="input-group-btn">
                                      <button class="btn btn-default " type="button"><i class="fa fa-calendar"></i>
                                      </button>
                                  </span>
                            </div>
					</div>
					
					<div class="col-lg-3 report_class">
						<span>To</span> <span class="required">*</span>
					       <div class="form-group input-group">
                                  <input type="text" id="datepicker2" class="form-control datepicker2"
                                  placeholder="Select or Enter to date" 
                                  data-ng-model="ctrl.report.todate | date : 'yyyy-MM-dd' " data-ng-required = "ctrl.date_required">
                                  <span class="input-group-btn">
                                      <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i>
                                      </button>
                                  </span>
                            </div>
					</div>
					
					<div class="col-lg-3 report_class">
					<span>Condition</span>
						<select class="form-control" data-ng-model="ctrl.report.datecondition"
						 data-ng-change = "ctrl.filterReset()"
						 data-ng-options="datecondition for datecondition in ['AND','OR']">
												
						</select>
						
					</div>
					
					<div class="col-lg-3 report_class">
						<span>Date Filter</span>
					       <select class="form-control" data-ng-model="datefilter" data-ng-options="datefilter for datefilter in ['Today','This Week','This Month','This Quater']" 
					       data-ng-change="ctrl.dateformat(datefilter)">
					       		<option value="" >-- Select --</option>					      
					       </select>
					</div>
				</div>
				<!-- Selected : {{datefilter}}<br>
				From Date  :  {{fromtoday}} <br>
				To Date : {{todate |date:'yyyy-MM-dd' }}<br> -->
				
				<!-- End Date : {{ curr2 | date:'yyyy-MM-dd' }}  -->
				<div class="col-lg-12 noPaddingLeft report_padding" data-ng-hide="filter_all || filter_branch || filter_billto">
					
					<div class="col-lg-3 branchclass">
						<b class="text-padding">Branch </b>
						<select class="form-control" data-ng-options = "branch.branch_id as branch.branch_name for branch in ctrl.branches"
						data-ng-change = "ctrl.filterReset()"
						data-ng-model="ctrl.report.branch">
							<option value="" disabled>-- Select --</option>														
						</select>
					</div>				
				</div>
				
				<div class="col-lg-12 noPaddingLeft" data-ng-show="filter_all || filter_branch || filter_billto">
					<div class="sec-padding">Branch</div>
					<div class="col-lg-3 branchclass">
						<span class="text-padding">From </span>
						<select class="form-control" data-ng-options = "branch.branch_id as branch.branch_name for branch in ctrl.branches"
						data-ng-change = "ctrl.filterReset()"
						data-ng-required = "filter_billto"
						data-ng-model = "ctrl.report.frombranch">
							<option value="">-- Select --</option>							
						</select>
					</div>
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">To </span>
						<select class="form-control" data-ng-options = "branch.branch_id as branch.branch_name for branch in ctrl.branches"
						data-ng-change = "ctrl.filterReset()"
						data-ng-required = "filter_billto"
						data-ng-model="ctrl.report.tobranch">
							<option value="">-- Select --</option>
							
						</select>
					</div>
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">Condition</span>
						<select class="form-control" data-ng-model = "ctrl.report.branchcondition"
						data-ng-change = "ctrl.filterReset()" 
						data-ng-options="branchcondition for branchcondition in ['AND','OR']">
							<option value="">-- Select --</option>
							
						</select>
					</div>
					
				</div>
				
				
				<div class="col-lg-12 noPaddingLeft" data-ng-show="filter_lr || filter_all">
					<div class="sec-padding">LR No</div>
					<div class="col-lg-3 branchclass">
						<span class="text-padding">From </span>						
						<angucomplete-alt id="from_lrno" data-ng-model="ctrl.report.from_lrno"
						placeholder="Ex:LR No"
						pause="100" selected-object="from_lrno"
						 remote-url="getshipment4report/"
						 remote_url-data-field="shipment"
						search-fields="lrno_prefix"
						title-field="lrno_prefix"
						match-class="highlight"
						initial-value="{{ctrl.report.shipmentModel.lrno_prefix}}"
						minlength="1" field-required="true" data-trigger="focus" data-toggle="popover"
						data-placement="top" data-content="Please enter & select LR No"
						input-class="form-control form-control-small" style="width:100%">
						</angucomplete-alt>
						
					</div>
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">To </span>						
						<angucomplete-alt id="to_lrno" data-ng-model="ctrl.report.from_lrno"
						placeholder="Ex:LR No" pause="100"
						selected-object="to_lrno"
						remote-url="getshipment4report/"
						 remote_url-data-field="shipment"
						search-fields="lrno_prefix"
						title-field="lrno_prefix"
						match-class="highlight"
						initial-value="{{ctrl.report.shipmentModel.lrno_prefix}}"
						minlength="1" field-required="true"
						data-trigger="focus" data-toggle="popover"
						data-placement="top" data-content="Please enter & select LR No"
						input-class="form-control form-control-small" style = "width: 100%"></angucomplete-alt>
						
					</div>
					
					<div class="col-lg-3 branchclass">
					<span class="text-padding">Condition </span>
						<select class="form-control" data-ng-model="ctrl.report.lrcondition"
						data-ng-change = "ctrl.filterReset()"  
						data-ng-options="lrcondition for lrcondition in ['AND','OR']">
							<option value="">-- Select --</option>
							
						</select>
					</div>
					
				</div>
				
				
				<div class="col-lg-12 noPaddingLeft report_padding" data-ng-hide="filter_billto">
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">Product </span>
						<div angucomplete-alt id="product_name" data-ng-model="ctrl.report.product_name"
						placeholder="Ex:Box"
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
						data-placement="top" data-content="please enter & select product " style="width:100%"
						></div>
					</div>				
				</div>
				
				
				
				<div class="col-lg-12 noPaddingLeft report_padding" data-ng-hide="filter_billto">
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">Payment Mode </span>
						<select class="form-control" data-ng-model="ctrl.report.paymentmode"
						data-ng-change = "ctrl.filterReset()" 
						data-ng-options="paymentmode for paymentmode in ['Cash','Credit']">
							<option value="">-- Select --</option>
							
							
						</select>
					</div>				
				</div>
					
					<div class="col-lg-12 noPaddingLeft report_padding" data-ng-hide="filter_billto">
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">Status </span>
						<select class="form-control" data-ng-model="ctrl.report.status"
						data-ng-change = "ctrl.filterReset()" 
						data-ng-options = "status for status in ['Booked', 'Intransit', 'Delivered', 'Return', 'Received', 'Pending']">
							<option value = "">-- Select --</option>
							
							
						</select>
					</div>				
				</div>
				
				<div class="col-lg-12 noPaddingLeft report_padding" data-ng-show="filter_billto">
					
					<div class="col-lg-3 branchclass">
						<!-- <span class="text-padding">Username </span>
						<select class="form-control" data-ng-model="ctrl.report.billto"
						data-ng-change = "ctrl.filterReset()" 
						data-ng-options = "billto for billto in ['Paid', 'To Pay']">
							<option value = "">-- Select --</option>
						</select>  --> 
						<label class="radio-inline">
                             <input type="radio" data-ng-model = "ctrl.report.billto" 
                             data-ng-click="" value="Paid"
                             data-ng-checked="true"
                             name="billto" id="billto" data-ng-required = "filter_billto"> To Pay / Paid
                        </label>
						<label class="radio-inline">
                             <input type="radio" data-ng-model = "ctrl.report.billto" 
                             data-ng-click="" value="Receipt"
                             name="billto" id="billto" data-ng-required = "filter_billto"> Receipt
                        </label>
					</div>				
				</div>
				
				
				<div class="col-lg-12 noPaddingLeft report_padding" data-ng-show="filter_billto">
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">Username </span>
						<select class="form-control" data-ng-model="ctrl.report.username"
						data-ng-change = "ctrl.filterReset()" data-ng-disabled="user_disable"
						data-ng-required = "filter_billto"
						data-ng-options = "user.user_id as user.username for user in ctrl.users">
							<option value = "">-- Select --</option>
							
							
						</select>
					</div>				
				</div>
				
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				
                </div>
                		
                </div>
                </div>
                </div>
                </div>
                <br>
                <div class="row">
                <div class="col-lg-12">
                	<div class="col-lg-4">
                		
                	</div>
                	
                	<div class="col-lg-4">
                		<button type="submit" class="btn btn-primary" >View Report</button>
                	</div>
                	
                </div>
                </div>
               </form> 
           			
             <br>
             <div class="row">
                <div class="col-lg-12">
                	<div class="col-lg-6">
                		<div class="pull-left">
	                		<select name ="shownoofrec" data-ng-model="shownoofrec" 
	                			data-ng-options = "noofrec for noofrec in [10, 15, 25, 50, 100]" class ="form-control" 
	                			data-ng-change="ctrl.shownoofRecord()">
						     </select>
					     </div>
                	</div>
	                	
		                	 <div class="col-xs-6 icons-button">
		                	 	<div class="pull-right">
			           			 <form name="shipmentPrint" method = "POST" action = "downloadExcelForReport" class="padding-button">
			           			 	<input type="hidden" name="filterShip" value = "{{ctrl.filterReport}}" />
			           			 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			           			 	<a type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a>
			           			 	<div class="dropdown-menu regSettings pull-right" style="padding-right: 5px;">
			           			 		<!-- <div class ="checkbox">
                                     		<label>
                                     			<i class = "fa" data-ng-class="{'fa-check': setting_sno == true, 'fa-times': setting_sno == false}"></i>
												<input type="checkbox" data-ng-init = "setting_sno=true" data-ng-model="setting_sno" /> S.No.												
											</label>											
										</div> -->
										<div class ="checkbox">
                                     		<label>
                                     			<i class = "fa" data-ng-class="{'fa-check': setting_shipmentdate == true, 'fa-times': setting_shipmentdate == false}"></i>
												<input type="checkbox" data-ng-init = "setting_shipmentdate=true" data-ng-model="setting_shipmentdate" /> Shipment Date												
											</label>											
										</div>
										
			           			 		<div class ="checkbox">
                                     		<label>
                                     			<i class = "fa" data-ng-class="{'fa-check': setting_lrno == true, 'fa-times': setting_lrno == false}"></i>
												<input type="checkbox" data-ng-init = "setting_lrno=true" data-ng-model="setting_lrno" /> L.R.No.												
											</label>											
										</div>
										<div class="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_product == true, 'fa-times': setting_product == false}"></i>
												<input type="checkbox" data-ng-init = "setting_product=true" data-ng-model="setting_product" /> Product
											</label>
										</div>
										<div class="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_origin == true, 'fa-times': setting_origin == false}"></i>
												<input type="checkbox" data-ng-init = "setting_origin=true" data-ng-model="setting_origin" /> Origin
											</label>
										</div>
										<div class="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_destination == true, 'fa-times': setting_destination == false}"></i>
												<input type="checkbox" data-ng-init = "setting_destination=true" data-ng-model="setting_destination" /> Destination
											</label>
										</div>
										<div class="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_sender == true, 'fa-times': setting_sender == false}"></i>
												<input type="checkbox" data-ng-init = "setting_sender=true" data-ng-model="setting_sender" /> Sender
											</label>
										</div>
										<div class="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_consignee == true, 'fa-times': setting_consignee == false}"></i>
												<input type="checkbox" data-ng-init = "setting_consignee=true" data-ng-model="setting_consignee" /> Consignee
											</label>
										</div>
										<div class="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_totparcel == true, 'fa-times': setting_totparcel == false}"></i>
												<input type="checkbox" data-ng-init = "setting_totparcel=true" data-ng-model="setting_totparcel" /> No. of Parcel
											</label>
										</div>
										<div class="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_service == true, 'fa-times': setting_service == false}"></i>
												<input type="checkbox" data-ng-init = "setting_service=true" data-ng-model="setting_service" /> Service
											</label>
										</div>
										<div class="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_receiptdate == true, 'fa-times': setting_receiptdate == false}"></i>
												<input type="checkbox" data-ng-init = "setting_receiptdate=true" data-ng-model="setting_receiptdate" /> Receipt date
											</label>
										</div>
										<div class="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_receiptno == true, 'fa-times': setting_receiptno == false}"></i>
												<input type="checkbox" data-ng-init = "setting_receiptno=true" data-ng-model="setting_receiptno" /> Receipt No.
											</label>
										</div>
										<div class="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_billto == true, 'fa-times': setting_billto == false}"></i>
												<input type="checkbox" data-ng-init = "setting_billto=true" data-ng-model="setting_billto" /> Bill To
											</label>
										</div>
										<div class="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_paymode == true, 'fa-times': setting_paymode == false}"></i>
												<input type="checkbox" data-ng-init = "setting_paymode=true" data-ng-model="setting_paymode" /> Pay mode
											</label>
										</div>
										
										<div class="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_freightcharge == true, 'fa-times': setting_freightcharge == false}"></i>
												<input type="checkbox" data-ng-init = "setting_freightcharge=true" data-ng-model="setting_freightcharge" /> L.R. Freight Charge
											</label>
										</div>
										<div class="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_receiptcharge == true, 'fa-times': setting_receiptcharge == false}"></i>
												<input type="checkbox" data-ng-init = "setting_receiptcharge=true" data-ng-model="setting_receiptcharge" /> Receipt Charge
											</label>
										</div>
										<div class="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_status == true, 'fa-times': setting_status == false}"></i>
												<input type="checkbox" data-ng-init = "setting_status=true" data-ng-model="setting_status" /> Status
											</label>
										</div>
										
			           			 	</div>
			           			 	<button type="submit" name="excel" class="btn btn-primary" data-ng-disabled = "ctrl.excelFlag">	<i class="fa fa-file-excel-o"></i></button>
			                		<button type="submit" name="print" class="btn btn-primary" data-ng-disabled = "ctrl.excelFlag">	<i class="fa fa-print fa-lg"></i></button>
			                	 </form>
			                	
			                	 </div>
			                </div>
	                	
                	
                   <div class="col-lg-12">
                    <div class="panel panel-default">
                        <!-- <div class="panel-heading">
                        </div> -->
                        
                        <div class="panel-body">
                        
                        
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th data-ng-show = "setting_shipmentdate">Shipment Date</th>
                                            <th data-ng-show = "setting_lrno">L.R.No.</th>
                                            <th data-ng-show = "setting_product">Product</th>
                                            <th data-ng-show = "setting_origin">Origin</th>
                                            <th data-ng-show = "setting_destination">Destination</th>
                                            <th data-ng-show = "setting_sender">Sender</th>
                                            <th data-ng-show = "setting_consignee">Consignee</th>
                                            <th data-ng-show = "setting_totparcel">No. of Parcel</th>
                                            <th data-ng-show = "setting_service">Service</th>
                                            <th data-ng-show = "setting_receiptdate">Receipt date</th>
                                            <th data-ng-show = "setting_receiptno">Receipt No.</th>
                                            <th data-ng-show = "setting_billto">Bill To</th>
                                            <th data-ng-show = "setting_paymode">Pay mode</th>
                                            <th data-ng-show = "setting_freightcharge">L.R. Freight Charge</th>
                                            <th data-ng-show = "setting_receiptcharge">Receipt Charge</th>
                                            <th data-ng-show = "setting_status">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="odd gradeX" data-ng-repeat = "report in ctrl.filterReport | limitTo:pageSize">
                                            <td data-ng-show = "setting_shipmentdate">{{report.shipment_date.slice(0,-10)}}</td>
                                            <td data-ng-show = "setting_lrno">{{report.lrno_prefix}}</td>
                                            <td data-ng-show = "setting_product">
                                            		<div data-ng-repeat="shipmentDet in report.shipmentDetail">
														{{shipmentDet.product.product_name}}<span
															data-ng-if="!($last)">,</span>
													</div>
											</td>
                                            <td data-ng-show = "setting_origin">{{report.sender_branch.branch_name}}</td>
                                            <td data-ng-show = "setting_destination">{{report.consignee_branch.branch_name}}</td>
                                            <td data-ng-show = "setting_sender">{{report.sender_customer.customer_name}}</td>
                                            <td data-ng-show = "setting_consignee">{{report.consignee_customer.customer_name}}</td>
                                            <td data-ng-show = "setting_totparcel">{{report.numberof_parcel}}</td>                                           
                                            <td data-ng-show = "setting_service">{{report.service.service_name}}</td>
                                            <td data-ng-show = "setting_receiptdate">{{report.receipt_date.slice(0,-10)}}</td>
                                            <td data-ng-show = "setting_receiptno">{{report.receipt_no}}</td>
                                            <td data-ng-show = "setting_billto">{{report.bill_to}}</td>
                                            <td data-ng-show = "setting_paymode">{{report.pay_mode}}</td>
                                            <td data-ng-show = "setting_freightcharge">{{report.total_charges}}</td>
                                            <td data-ng-show = "setting_receiptcharge">{{report.receipt_charge}}</td>
                                            <td data-ng-show = "setting_status">{{report.status}}</td>
                                        </tr>
                                 
                                    </tbody>
                                    <tfoot data-ng-show="ctrl.tbl_nodata">
                                    	<tr><td colspan="17" align="center">No data found</td></tr>
                                    </tfoot>
                                </table>
                                
                                <div class ="col-lg-6">
                                	<div class="pull-left" data-ng-show="!ctrl.tbl_nodata">
                               			 Showing {{(currentPage*pageSize)+1}} to 
                               			 {{ (totalnof_records - (((currentPage+1)*pageSize))) > 0 ? (currentPage+1)*pageSize : totalnof_records }}
                               			 of {{totalnof_records}} entries
                               		</div>
                               		<div class="pull-left" data-ng-show="ctrl.tbl_nodata">
                               			 Showing NaN to of entries
                               		</div>
                                </div>
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
                 </div>
                </div>
            </div>
             
             
             
             
             
             
                
              
            
        </div>
        <!-- /. PAGE WRAPPER  -->
		
		
    </div>
    <!-- /. WRAPPER  -->
    
    <script src="resources/custom/js/custom.js"></script>
    <script type="text/javascript" src="resources/custom/js/reports/report_controller.js"></script>
    <script src="resources/custom/js/user_master/user_service.js"></script>
    <script type="text/javascript" src="resources/custom/js/reports/report_service.js"></script> 
    <script src="resources/custom/js/shipment/shipment_service.js"></script>
    <script src="resources/custom/js/branch_master/branch_service.js"></script>
    <script src="resources/custom/js/confirmDialog.js"></script>
	<script type="text/javascript" src="resources/custom/js/validation.js"></script>
   
   	
   	<script>
   		$('[data-toggle= "popover"]').popover();
   		$('.regSettings').click(function(e) {
   			e.stopPropagation();
   		});
   	</script>
   	
   	<script type="text/javascript">
   		function getDate() {
   			var today = new Date();
   			var dd = today.getDate();
   			var mm = today.getMonth()+1;
   			var yyyy = today.getFullYear();
   			
   			if(dd < 10) {
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
   		
   		$('.datepicker3').dateTimePicker({
   			limitMax : getDate()
   		});
   		/* $('#dates').val() = getDate(); */
   		
   		
   	</script>
   	

   
</body>

</html>