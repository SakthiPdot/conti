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
                                       data-ng-click="filter_branch=false;filter_lr=false;filter_all=false;ctrl.date_required=true;ctrl.filterReset();"value="filter_date"
                                       name="optionsRadiosInline" id="optionsRadiosInline1" > Date Wise
                                   </label>
                                   <label class="radio-inline">
                                       <input type="radio"  data-ng-model = "filter_branch" value="filter_branch"
                                       data-ng-click="filter_date= false;filter_lr=false;filter_all=false;ctrl.date_required=false;ctrl.filterReset();ctrl.resetDate();"
                                       name="optionsRadiosInline" id="optionsRadiosInline2"> Branch Wise
                                   </label>
                                   <label class="radio-inline">
                                       <input type="radio" data-ng-model="filter_lr"  value="filter_lr" 
                                       data-ng-click="filter_branch=false;filter_date=false;filter_all=false;ctrl.date_required=false;ctrl.filterReset();ctrl.resetDate();"
                                        name="optionsRadiosInline" id="optionsRadiosInline3" > LR No Wise
                                   </label>
                                   <label class="radio-inline">
                                   	<input type="radio"  data-ng-model ="filter_all" data-ng-init="filter_all=true" value="filter_all" 
                                   	 data-ng-click="filter_branch=true;filter_date=true;filter_lr=true;ctrl.date_required=true;ctrl.filterReset();"
                                   	name="optionsRadiosInline" id="optionsRadiosInline4" data-ng-checked="true"> All
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
				
				<div class="branch-heading" data-ng-show="filter_date || filter_all">Shipment</div>
				
				<div class="col-lg-12 noPaddingLeft" data-ng-show="filter_date || filter_all" >
					<div class="col-lg-3 report_class">
						<span>From</span>  <span class="required">*</span>
					       <div class="form-group input-group">
                                  <input type="text" id="datepicker1" class="form-control datepicker1" data-ng-model="ctrl.report.fromtoday" data-ng-required = "ctrl.date_required">
                                  <span class="input-group-btn">
                                      <button class="btn btn-default " type="button"><i class="fa fa-calendar"></i>
                                      </button>
                                  </span>
                            </div>
					</div>
					
					<div class="col-lg-3 report_class">
						<span>To</span> <span class="required">*</span>
					       <div class="form-group input-group">
                                  <input type="text" id="datepicker2" class="form-control datepicker2" data-ng-model="ctrl.report.todate | date : 'yyyy-MM-dd' " data-ng-required = "ctrl.date_required">
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
				<div class="col-lg-12 noPaddingLeft report_padding" data-ng-hide="filter_all || filter_branch">
					
					<div class="col-lg-3 branchclass">
						<b class="text-padding">Branch </b>
						<select class="form-control" data-ng-options = "branch.branch_id as branch.branch_name for branch in ctrl.branches"
						data-ng-change = "ctrl.filterReset()"
						data-ng-model="ctrl.report.branch">
							<option value="" disabled>-- Select --</option>														
						</select>
					</div>				
				</div>
				
				<div class="col-lg-12 noPaddingLeft" data-ng-show="filter_all || filter_branch">
					<div class="sec-padding">Branch</div>
					<div class="col-lg-3 branchclass">
						<span class="text-padding">From </span>
						<select class="form-control" data-ng-options = "branch.branch_id as branch.branch_name for branch in ctrl.branches"
						data-ng-change = "ctrl.filterReset()"
						data-ng-model = "ctrl.report.frombranch">
							<option value="" disabled>-- Select --</option>							
						</select>
					</div>
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">To </span>
						<select class="form-control" data-ng-options = "branch.branch_id as branch.branch_name for branch in ctrl.branches"
						data-ng-change = "ctrl.filterReset()"
						data-ng-model="ctrl.report.tobranch">
							<option value="" disabled>-- Select --</option>
							
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
						local-data="ctrl.shipments"
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
						local-data="ctrl.shipments"
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
				
				
				<div class="col-lg-12 noPaddingLeft report_padding">
					
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
				
				
				
				<div class="col-lg-12 noPaddingLeft report_padding">
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">Payment Mode </span>
						<select class="form-control" data-ng-model="ctrl.report.paymentmode"
						data-ng-change = "ctrl.filterReset()" 
						data-ng-options="paymentmode for paymentmode in ['Cash','Credit']">
							<option value="">-- Select --</option>
							
							
						</select>
					</div>				
				</div>
					
					<div class="col-lg-12 noPaddingLeft report_padding">
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">Status </span>
						<select class="form-control" data-ng-model="ctrl.report.status"
						data-ng-change = "ctrl.filterReset()" 
						data-ng-options = "status for status in ['Booked', 'Intransit', 'Delivered', 'Return', 'Received', 'Pending']">
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
                	
                	<!-- <div class="col-lg-4">
                		<a class="btn btn-primary" data-ng-click = "ctrl.excelReport();" data-ng-disabled = "ctrl.excelFlag">	<i class="fa fa-file-excel-o"></i> Excel Report</a>
                	</div> -->
                </div>
                </div>
               </form> 
           			 <div class="col-lg-4">
	           			 <form name="shipmentPrint" method = "POST" action = "downloadExcelForReport" class="padding-button">
	           			 	<input type="hidden" name="filterShip" value = "{{ctrl.filterReport}}" />
	           			 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                		<button type="submit" class="btn btn-primary" data-ng-disabled = "ctrl.excelFlag">	<i class="fa fa-file-excel-o"></i> Excel Report</button>
	                	 </form>
                	</div>
             <br>
             <div class="row">
                <div class="col-lg-12">
                   <div class="col-lg-12">
                    <div class="panel panel-default">
                        <!-- <div class="panel-heading">
                        </div> -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            
                                            <th>LR No</th>
                                            <th>Product</th>
                                            <th>Origin</th>
                                            <th>Destination</th>
                                            <th>Sender</th>
                                            <th>Consignee</th>
                                            <th>Total Parcel</th>
                                            <th>Weight</th>
                                            <th>Service</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="odd gradeX" data-ng-repeat = "report in ctrl.filterReport">
                                            
                                            <td>{{report.lrno_prefix}}</td>
                                            <td>
                                            		<div data-ng-repeat="shipmentDet in report.shipmentDetail">
														{{shipmentDet.product.product_name}}<span
															data-ng-if="!($last)">,</span>
													</div>
											</td>
                                            <td>{{report.sender_branch.branch_name}}</td>
                                            <td>{{report.consignee_branch.branch_name}}</td>
                                            <td>{{report.sender_customer.customer_name}}</td>
                                            <td>{{report.consignee_customer.customer_name}}</td>
                                            <td>{{report.numberof_parcel}}</td>
                                            <td>{{report.chargeable_weight}} Kg.</td>
                                            <td>{{report.service.service_name}}</td>
                                            <td>{{report.status}}</td>
                                        </tr>
                                 
                                    </tbody>
                                </table>
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
   		
   		/* $('#dates').val() = getDate(); */
   		
   		
   	</script>
   	

   
</body>

</html>