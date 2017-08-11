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
                			     
                			     <div class="col-lg-12 noPaddingLeft"> 
                			      <div class="col-lg-3 branchclass">
                			      		<span class="text-padding">From</span>
                			      		<select class="form-control" data-ng-options ="branch.branch_name for branch in ctrl.branches"
                			      		 data-ng-model="ctrl.receipt.frombranch">
                			      			<option value="">--Select--</option>
                			      		</select>
                			      </div>
                			      
                			       <div class="col-lg-3 branchclass">
                			      		<span class="text-padding">To</span>
                			      		<select class="form-control"  
                			      		data-ng-model="ctrl.receipt.tobranch" data-ng-model="ctrl.receipt.tobranch">
                			      			<option value=''>${branch_name}</option>
                			      			
                			      		</select>
                			      </div>
                			      </div>
                			     <div class="col-lg-12 noPaddingLeft"> 
                			        <div class="sec-padding">Specific Period</div>
                			         <div class="col-lg-3 branchclass">
	                			      		 <span class="paddingtop">From  </span>   	                                       
	                                          <div class="form-group input-group marginleftrightspace">
					                                <input type="text" class="form-control datepicker1" data-ng-model="ctrl.fromdate"
					                           			   data-trigger= "focus"data-toggle="popover" data-placement="top"
					                            		   data-content="Please select from date"/>
					                            	 <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
		                                     </div>
	                                  </div>
                			      
                			       <div class="col-lg-3 branchclass">
                			      		<span class="paddingtop">To</span>
                			      		 <div class="form-group input-group marginleftrightspace">
				                                <input type="text" class="form-control datepicker2" data-ng-model="ctrl.todate"
													  data-trigger= "focus"data-toggle="popover" data-placement="top"
					                            		data-content="Please select to date"/>
	                                            <span class="input-group-addon"><i class="fa fa-calendar"></i>
	                                            </span>
	                                     </div>
                			      </div>
                			      </div>
                			       
                			       <div class="col-lg-12 noPaddingLeft subhead-padding"> 
                			       		<div class="col-lg-3 branchclass">
                			      		 <span class="text-padding">Service</span>	                	                                       
                                            <select class="form-control" data-ng-options= "service for service in ['Counter','Door Delivery']"
                                            data-ng-model="ctrl.receipt.service">
                                            	<option value=''>--Select--</option>
                                             </select>
                                         </div>
                			            
                			            <div class="col-lg-3 branchclass">
                			      		 <span class="">Payment Mode</span>	                	                                       
                                            <select class="form-control" data-ng-options= "pay for pay in ['Cash','Credit','Check']"
                                            data-ng-model="ctrl.receipt.payment_mode">
                                            	<option value=''>--Select--</option>
                                               	
                                            </select>
                                           
                			            </div>
                			            
                			            <div class="col-lg-4 branchclass">
                			      		   <button class="btn btn-primary" data-ng-click="ctrl.viewShipment(ctrl.receipt)"> View Shipment</button>
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
                                            <input type="text" class="form-control searchbar" placeholder="LR Number">                                           
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
                    	
                    	</div>
                     <a type="button" class="btn btn-primary" onclick="location.href='downloadExcelReceipt';valid = true;"><i class="fa fa-file-excel-o fa-lg"></i></a>
                      	  <button type="submit" class="btn btn-primary" data-ng-disabled = "ctrl.selected_receipt.length == 0" ><i class="fa fa-print fa-lg"></i></button>
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
                                            <th><input type="checkbox" data-ng-click="ctrl.receiptSelectAll()" data-ng-model="selectallreceipts"></th>
                                            <th data-ng-show="setting-slnumber">S.No</th>
                                            <th data-ng-show="setting_receiptlrnumber">LR No</th>
                                            <th data-ng-show="setting_receiptorigin">Origin</th>
                                            <th data-ng-show="setting_receiptdestination">Destination</th>
                                            <th data-ng-show="setting_receiptsender">Sender</th>
                                            <th data-ng-show="setting_receiptconsignee">Consignee</th>
                                            <th data-ng-show="setting_receiptproduct">Product</th>
                                            <th data-ng-show="setting_receiptstatus">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat="receipt in ctrl.Filterreceipts|limitTo:pageSize" data-id="{{receipt.receipt_id}}">
                                            <td><input type="checkbox" data-ng-click="ctrl.receiptSelect(receipt)" data-ng-model="receipt.select"></td>
                                            <td data-ng-show="setting-slnumber">{{$index+1}}</td>
                                            <td data-ng-show="setting_receiptlrnumber">{{receipt.lr_number}}</td>
                                            <td data-ng-show="setting_receiptorigin">{{receipt.sender_branch.branch_name}}</td>
                                            <td data-ng-show="setting_receiptdestination">{{receipt.consignee_branch.branch_name}}</td>
                                            <td data-ng-show="setting_receiptsender">{{receipt.sender_customer.customer_name}}</td>
                                            <td data-ng-show="setting_receiptconsignee">{{receipt.consignee_customer.customer_name}}</td>
                                            <td data-ng-show="setting_receiptproduct">{{receipt.shipmentDetail[0].product.product_name}}</td>
                                            <td data-ng-show="setting_receiptstatus">{{receipt.status}}</td>
                                        </tr>
                                   </tbody>
                                </table>
                            </div>
                          <div class ="col-lg-6">
                    		<div class="pull-left">
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
                			      		   <button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
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
                
                 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Create Receipt</h4>
                                        </div>
                                        <div class="modal-body">
										 
										 <div class="branchclass">
												
												<span class="text-padding"> Courier Staff</span>
												<select class="form-control">
													<option>--Select--</option>
													<option>Murugan</option>
												</select>
										 </div>
										 
										  <div class="branchclass">	
												<span> Contact Number</span>
												<input type="text" class="form-control">
											
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
        <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
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

</body>

</html>