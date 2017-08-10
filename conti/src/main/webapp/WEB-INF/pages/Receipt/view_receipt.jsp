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


<body style="overflow-x:hidden;" data-ng-app="contiApp" data-ng-controller= "ReceiptController as ctrl">
 
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
              <div class="col-lg-12">
              	  <div class="GenLeftRight">
	              <div  class="subHead">
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
                			      		<span class="text-padding">From</span>
                			      		<select class="form-control" data-ng-options ="branch.branch_name for branch in ctrl.branches"
                			      		 data-ng-model="ctrl.receipt.frombranch" data-ng-init="ctrl.branches[0].branch_id">
                			      			<option value="">--Select--</option>
                			      		</select>
                			      </div>
                			      
                			       <div class="col-lg-3 branchclass">
                			      		<span class="text-padding">To</span>
                			      		<select class="form-control" data-ng-options ="branch.branch_name for branch in ctrl.branches" 
                			      		data-ng-model="ctrl.receipt.tobranch">
                			      			<option value=''>--Select--</option>
                			      			
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
		                                            <span class="input-group-addon"><i class="fa fa-calendar"></i>
		                                            </span>
		                                          
		                                     </div>
	                                  </div>
                			      
                			       <div class="col-lg-3 branchclass">
                			      		<span class="paddingtop">To</span>
                			      		  <div class="form-group input-group spacemarginleftright">
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
                			      		 <span class="text-padding">Status</span>	                	                                       
                                            <select class="form-control">
                                            	<option>--Select--</option>
                                            	<option value='delivered'>Delivered</option>  
                                            	<option value='pending'>Pending</option>                                            	
                                            </select>
                                           
                			            </div>
                			            
                			            <div class="col-lg-3 branchclass">
                			      		   <button class="btn btn-primary"> View Receipt</button>                                         
                			            </div>
                			            
                			            <div class="col-lg-4 branchclass">		      		               	                                       
                                           
                                           
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
                                            <input type="text" class="form-control searchbar" placeholder="Manifest/LR No/Receipt No">                                           
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
                             View Receipt Register
                        </div>
                 <div class="panel-body">
                     <div class="table-responsive">
                     <div class="row">
                       <div class="col-lg-12">
                        <div class="col-xs-6">
                      <div class="dataTables_length" id="dataTables-example_length">
					<div class="dropdown">
						<button class="btn btn-primary dropdown-toggle"
							type="button" data-toggle="dropdown">
							Batch Action <span class="caret"></span>
						</button>
						<ul class="dropdown-menu">
							<li><a data-ng-click=''>Pending</a></li>
							<li><a data-ng-click=''>Return</a></li>
						</ul>
						</div>
					</div> 
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
									<i class = "fa" data-ng-class="{'fa-check': setting_receiptdate == true, 'fa-times':setting_receiptdate == false}"></i>										
									<input type="checkbox" data-ng-init = "setting_receiptdate=true" data-ng-model="setting_receiptdate" /> Date
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
									<i class = "fa" data-ng-class="{'fa-check': setting_receiptnumber== true, 'fa-times':setting_receiptnumber == false}"></i>										
									<input type="checkbox" data-ng-init = "setting_receiptnumber=true" data-ng-model="setting_receiptnumber" /> Receipt
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
									<i class = "fa" data-ng-class="{'fa-check':setting_receiptmanifest== true, 'fa-times':setting_receiptmanifest== false}"></i>										
									<input type="checkbox" data-ng-init = "setting_receiptmanifest=true" data-ng-model="setting_receiptmanifest" /> Manifest
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
                      <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                             <thead>
                                 <tr>
                                     <th><input type="checkbox" data-ng-click="ctrl.receiptSelectAll()" data-ng-model="selectallreceipts"></th>
                                     <th data-ng-show="setting_sltnumber">SL no</th>
                                     <th data-ng-show="setting_receiptdate">Date</th>
                                     <th data-ng-show="setting_receiptlrnumber">LR Number</th>
                                     <th data-ng-show="setting_receiptnumber">Receipt</th>
                                     <th data-ng-show="setting_receiptproduct">Product</th>
                                     <th data-ng-show="setting_receiptorigin">Origin</th>
                                     <th data-ng-show="setting_receiptdestination">Destination</th>
                                     <th data-ng-show="setting_receiptsender">Sender</th>
                                     <th data-ng-show="setting_receiptconsignee">Consignee</th>
                                     <th data-ng-show="setting_receiptmanifest">Manifest</th>
                                     <th data-ng-show="setting_receiptstatus">Status</th>
                             	</tr>
                             </thead>
                             <tbody>
                                 <tr data-ng-repeat="receipt in ctrl.Filterreceipts|limitTo:pageSize"
                                 data-id="{{receipt.receipt_id}}">
                                     <td><input type="checkbox" data-ng-click="ctrl.receiptSelect(receipt)" data-ng-model="receipt.select"></td>
                                     <td data-ng-show="setting_sltnumber" >{{$index+1}}</td>
                                     <td data-ng-show="setting_receiptdate">{{receipt.created_datetime}}</td>
                                     <td data-ng-show="setting_receiptlrnumber">{{receipt.shipmentModel.lr_number}}</td>
                                     <td data-ng-show="setting_receiptnumber">{{receipt.receipt_id}}</td>
                                     <td data-ng-show="setting_receiptproduct">{{receipt.shipmentModel.shipmentDetail[0].product.product_name}}</td>
                                     <td data-ng-show="setting_receiptorigin">{{receipt.manifestModel.branchModel1.branch_name}}</td>
                                     <td data-ng-show="setting_receiptdestination">{{receipt.manifestModel.branchModel2.branch_name}}</td>
                                     <td data-ng-show="setting_receiptsender">{{receipt.shipmentModel.sender_customer.customer_name}}</td>
                                     <td data-ng-show="setting_receiptconsignee">{{receipt.shipmentModel.consignee_customer.customer_name}}</td>
                                     <td data-ng-show="setting_receiptmanifest">{{receipt.manifestModel.manifest_number}}</td>
                                     <td data-ng-show="setting_receiptstatus">{{receipt.shipmentModel.status}}</td>
                                 
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
        </div>
        <!-- /. PAGE WRAPPER  -->
		
		
    </div>
    <!-- /. WRAPPER  -->
  
  
    <script src="resources/custom/js/custom.js"></script>
    <script src="resources/custom/js/receipt/receipt_controller.js"></script>
    <script src="resources/custom/js/receipt/receipt_service.js"></script>
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