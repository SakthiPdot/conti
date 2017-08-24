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
	              <b>Last Receipt No : RECPT No 59202</b>	              
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
                			      		
                			      		<sec:authorize access="hasRole('STAFF') or hasRole('MANAGER')">							
											<input type="hidden" class="form-control " data-ng-model="tobranch_filter" >
											<input type="text" class="form-control " data-ng-disabled="true" data-ng-model="tobranch_sample">
										</sec:authorize>
										
                			      		<sec:authorize access="hasRole('SUPER_ADMIN')">
                			      		<select class="form-control" 
                			      		data-ng-model="tobranch_filter">
                			      			<option value="" data-ng-disabled="true">--Select Branch Name--</option>                			      			
                			      			<option data-ng-repeat="x in ctrl.branches" value="{{x.branch_id}}">{{x.branch_name}}</option>
                			      		</select>
                			      		</sec:authorize>
                			      		
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
                               <div class="col-xs-6">
                                     
                                </div>
                                
                               <div class="col-xs-6 icons-button">
                                   <div class="pull-right">
                                   
                                   <form name="receiptPrint" method="POST" action="receipt_print" class="padding-button">
                    	<a type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a>
                    	<div class="dropdown-menu regSettings pull-right" style="padding-right: 5px;">
	                    	
	                    		<div class="checkbox">
											<label> <i class="fa"
												data-ng-class="{'fa-check': setting_date == true, 'fa-times': setting_date== false}"></i>
												<input type="checkbox"
												data-ng-init="setting_date = true"
												data-ng-model="setting_date" /> Date
											</label>
										</div>
							
	                    	<div class ="checkbox">
								<label>
									<i class = "fa" data-ng-class="{'fa-check': setting_sltnumber == true, 'fa-times': setting_sltnumber == false}"></i>										
									<input type="checkbox" data-ng-init = "setting_sltnumber=true" data-ng-model="setting_sltnumber" /> SL no
								</label>
							</div>
							
							<div class ="checkbox">
								<label>
									<i class = "fa" data-ng-class="{'fa-check': setting_receiptlrnumber== true, 'fa-times':setting_receiptlrnumber == false}"></i>										
									<input type="checkbox" data-ng-init = "setting_receiptlrnumber=true" data-ng-model="setting_receiptlrnumber" /> LR No
								</label>
							</div>
														
							<div class ="checkbox">
								<label>
									<i class = "fa" data-ng-class="{'fa-check': setting_receiptproduct == true, 'fa-times':setting_receiptproduct == false}"></i>										
									<input type="checkbox" data-ng-init = "setting_receiptproduct=true" data-ng-model="setting_receiptproduct" /> Product
								</label>
							</div>
							
							<div class ="checkbox">
								<label>
									<i class = "fa" data-ng-class="{'fa-check': setting_receiptorigin == true, 'fa-times':setting_receiptorigin == false}"></i>										
									<input type="checkbox" data-ng-init = "setting_receiptorigin=true" data-ng-model="setting_receiptorigin" /> Origin
								</label>
							</div>
							
							<div class ="checkbox">
								<label>
									<i class = "fa" data-ng-class="{'fa-check':setting_receiptdestination == true, 'fa-times':setting_receiptdestination== false}"></i>										
									<input type="checkbox" data-ng-init = "setting_receiptdestination=true" data-ng-model="setting_receiptdestination" /> Destination
								</label>
							</div>
							
							<div class ="checkbox">
								<label>
									<i class = "fa" data-ng-class="{'fa-check':setting_receiptsender== true, 'fa-times':setting_receiptsender== false}"></i>										
									<input type="checkbox" data-ng-init = "setting_receiptsender=true" data-ng-model="setting_receiptsender" /> Sender
								</label>
							</div>
							
							<div class ="checkbox">
								<label>
									<i class = "fa" data-ng-class="{'fa-check':setting_receiptconsignee== true, 'fa-times':setting_receiptconsignee== false}"></i>										
									<input type="checkbox" data-ng-init = "setting_receiptconsignee=true" data-ng-model="setting_receiptconsignee" /> Consignee
								</label>
							</div>
							
							<div class ="checkbox">
								<label>
									<i class = "fa" data-ng-class="{'fa-check':setting_receiptstatus== true, 'fa-times':setting_receiptstatus== false}"></i>										
									<input type="checkbox" data-ng-init = "setting_receiptstatus=true" data-ng-model="setting_receiptstatus" /> Status
								</label>
							</div>

							<div class="checkbox" data-ng-hide="true">
								<label> <i class="fa"
									data-ng-class="{'fa-check': setting_sevice == true, 'fa-times': setting_sevice ==false}"></i>
									<input type="checkbox"
									data-ng-init="setting_sevice = true"
									data-ng-model="setting_sevice" /> Service
								</label>
							</div>
							<div class="checkbox">
								<label> <i class="fa"
									data-ng-class="{'fa-check': setting_paymentMode == true, 'fa-times': setting_paymentMode ==false}"></i>
									<input type="checkbox"
									data-ng-init="setting_paymentMode = true"
									data-ng-model="setting_paymentMode" /> Payment Mode
								</label>
							</div>

						</div>
                     <a type="button" class="btn btn-primary" onclick="location.href='downloadExcelReceipt';valid = true;"><i class="fa fa-file-excel-o fa-lg"></i></a>
                      	  <button type="submit" class="btn btn-primary" data-ng-disabled = "ctrl.selected_receipt.length <1" ><i class="fa fa-print fa-lg"></i></button>
                          <input type = "hidden" name = "receipt" value = "{{ctrl.selected_receipt}}" />
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
                                            data-ng-click="ctrl.receiptSelectAll()" 
                                            data-ng-model="selectallreceipts"></th>
                                            
                                            
                                            <th data-ng-show="setting-slnumber">S.No</th>
                                                <td data-ng-show="setting-slnumber">{{$index+1}}</td>
												<th data-ng-show="setting_date"
													data-ng-click="date=!date;sortTable('date',date);">Date<i
													data-ng-hide="disableSorting"
													data-ng-class=" {'fa fa-caret-up':date,'fa fa-caret-down':!date}"
													aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_receiptlrnumber">LR Number</th>
                                            <th data-ng-show="setting_receiptorigin">Origin</th>
                                            <th data-ng-show="setting_receiptdestination">Destination</th>
                                            <th data-ng-show="setting_receiptsender">Sender</th>
                                            <th data-ng-show="setting_receiptconsignee">Consignee</th>
                                            <th data-ng-show="setting_receiptproduct">Product</th>
                                            <th data-ng-show="setting_sevice"
												data-ng-click="service=!service;sortTable('service',service);">Service<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':service,'fa fa-caret-down':!service}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_receiptstatus" data-ng-hide="true">Status</th>                                            
                                            <th data-ng-show="setting_paymentMode" >Payment Mode</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat="receipt in ctrl.Filterreceipts|limitTo:pageSize" data-id="{{receipt.receipt_id}}">
                                            <td><input type="checkbox" data-ng-click="ctrl.receiptSelect(receipt)" data-ng-model="receipt.select"></td>
                                        	<td data-ng-show="setting_date">{{receipt.updated_datetime.slice(0,-10)}}</td>
											<td data-ng-show="setting_receiptlrnumber">{{receipt.lrno_prefix}}</td>
                                            <td data-ng-show="setting_receiptorigin">{{receipt.sender_branch.branch_name}}</td>
                                            <td data-ng-show="setting_receiptdestination">{{receipt.consignee_branch.branch_name}}</td>
                                            <td data-ng-show="setting_receiptsender">{{receipt.sender_customer.customer_name}}</td>
                                            <td data-ng-show="setting_receiptconsignee">{{receipt.consignee_customer.customer_name}}</td>
                                            <td data-ng-show="setting_receiptproduct">{{receipt.shipmentDetail[0].product.product_name}}</td>
                                            <td data-ng-show="setting_sevice">{{receipt.service.service_name}}</td>
                                            <td data-ng-show="setting_receiptstatus" data-ng-hide="true">{{receipt.status}}</td>
                                            <td data-ng-show="setting_paymentMode">{{receipt.pay_mode}}</td>
                                        </tr>
                                   </tbody>
                                </table>
                            </div>
                          <div class ="col-lg-6">
                    		<div class="pull-left" data-ng-cloak>
                   			 Showing {{(currentPage*pageSize)+1}} to 
                   			 {{ (totalnof_records - (((currentPage+1)*pageSize))) > 0 ? (currentPage+1)*pageSize : totalnof_records }}
                   			 of {{totalnof_records}} entries
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
										<th data-ng-show="setting_receiptlrnumber">LR Number</th>
										<th data-ng-show="setting_receiptorigin">Parcel</th>
										<th data-ng-show="setting_receiptdestination">Handling
											Charge</th>

									</tr>
								</thead>
								<tbody>
									<tr data-ng-repeat="receipt in ctrl.selected_receipt"
										data-id="{{receipt.receipt_id}}">


										<!-- <td><input type="checkbox"
											data-ng-click="ctrl.receiptSelect(receipt)"
											data-ng-model="receipt.select"></td> -->

										<td data-ng-show="setting_receiptlrnumber">{{receipt.lrno_prefix}}</td>

										<td data-ng-show="setting_receiptorigin">{{receipt.numberof_parcel}}</td>

										<td data-ng-show="setting_receiptdestination">
										
										<div class="input-group">
											<input									
													data-trigger="focus" data-toggle="popover"
													data-placement="top"
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
								<div class="col-lg-12 ">
									<div class="col-lg-6">
										<span> Freight Charge</span>
									</div>
									<div class="col-lg-6 ">
									<div class="input-group Bottom" >
										<input type="text" class="form-control"
										data-ng-model="allLR_freight_charge"
										placeholder="Ex:100.00">
										<span class="input-group-addon"><i class="fa fa-inr"></i></span>
									</div>
									</div>
								</div>
							</div>
							
							
							<div class='row'>
								<div class="col-lg-12 ">
									<div class="col-lg-6">
										<span> Local Transport</span>
									</div>
									<div class="col-lg-6 ">
									<div class="input-group">
										<input type="text" class="form-control"
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
										<select class="form-control"
										data-ng-model="ctrl.receipt.courier_staff">
											<option>--Select Staff--</option>
											<option>Murugan</option>
										</select>
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
										placeholder="Ex.9876543210">
										<datalist id="contact_number">
										  <option value="0123456789">
										  <option value="9876543210">
										</datalist>
									</div>
								</div>
							</div>
							</div>
							
							
						</div>


						<div class="modal-footer">
                                            <button type="button" class="btn btn-danger pull-left" data-dismiss="modal"> <i class="fa fa-times"></i> Cancel</button>
                                            <button type="button" class="btn btn-success"><i class="fa fa-floppy-o"></i> Save</button>
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