<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib
    prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
<%@ page isELIgnored="false" %> 
<%@page session="true"%>
<html lang="en">
<head>
<link rel="icon" type="image/gif/png"
	href="resources/Image/conti_logo.png">
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
	 <link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
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
 <!-- ------------------------- VIEW SELECTED SHIPEMNT BEGIN ------------------ -----  -->
		<div class="shipment_View hideme">
			<form name = "shipment" >		
      	    	<input type = "hidden" data-ng-model = "ctrl.shipment.shipment_id" />
      	    	
      		  <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default panelMarginBottom">                            
						
						<div class="panel-body customer-font">
							<div class = "col-lg-4"> <b>Shipment details</b> </div>
							<div class = "col-lg-8">
								<div class="col-lg-1 pull-right">
									<a class="pull-right" data-ng-click = "ctrl.viewShipemntClose()"><i class="fa fa-times" aria-hidden="true"></i></a>
								</div>
								
								<div class="col-lg-3 pull-right">
									<a class="btn btn-info" data-ng-click = "ctrl.receiptPrint(ctrl.receiptPr_id)"> <i class="fa fa-print" aria-hidden="true"></i> Receipt Print </a>
								</div>	  
								<div class="col-lg-3 pull-right">
									<a class="btn btn-info" data-ng-click = "ctrl.shipmentPrint(ctrl.shipment)"> <i class="fa fa-print" aria-hidden="true"></i>  LR Print </a>
								</div>
								 
							</div>
						</div>
                        </div>
                    </div>
              </div>

           
              <div class="row">
              <div class="col-md-12">
              	  <div class="col-md-6">
		              
		               <b>L.R. No. : {{ctrl.shipment.lrno_prefix}}</b>            
		              
	              </div>
	              
	              <div class="col-md-6">
		              
		               <b class = "pull-right">Shipment Date. : {{ctrl.shipment.shipment_date.slice(0,-2)}}</b>            
		              
	              </div>
	              
              </div>
              
              <div class="col-md-12">
              		<div class="col-md-6">
		              
		               <b>Receipt No. : {{ctrl.receipt_number}}</b>            
		              
	              </div>
              </div>
              </div>
              
              <div class="row">
              	 
              	<div class="col-md-12">
              		<div class="col-md-6">
              			<b>Payment mode : {{ctrl.shipment.pay_mode}}</b>  
              		</div>
              		 <div class="col-md-6">         
              		</div>
              	</div>
              	
              	
              </div>
         
              <div class="row">
              	
              	<div class="col-md-12">
              		
              		
              		<div class="col-md-12 GenLeftRight">
              			<div class="subhead">
              			Sender &amp; Consignee Info
              			</div>
              		</div>
              	</div>
              	
              	
              	
              	
              	<div class="col-lg-12 col-md-12">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           Sender Info
                        </div>
                        <div class="panel-body">
                            	                            
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">From Branch</span>
                            		    <input type="text" class="form-control" tabindex = "-1" id = "sender_branch_name" 
                            		    	data-ng-model = "ctrl.shipment.sender_branch.branch_name" 
                            		    	data-ng-disabled = "true"/>                        		    
                            		    
                            		</div>
                            		
                            		<div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Name <span class="required">*</span></span>
                            		    <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.customer_name"
                            		    	data-ng-disabled = "true"
                            		    required />                            		    
                            		</div>
                            		
                       			    <div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Company Name </span>
                            		    <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.company_name"
                            		    	data-ng-disabled = "true"
                            		    />                            		    
                            		</div>
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Mobile Number <span class="required">*</span></span>
                            		    <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.customer_mobileno"
                            		    	data-ng-disabled = "true"
                            		    required />  
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Address line1 <span class="required">*</span></span>
                            		   <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sendercustomer_address1"
                            		    	data-ng-disabled = "true"
                            		    required />                             		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Address line2 </span>
                            		   <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sendercustomer_address2"
                            		    	data-ng-disabled = "true"
                            		     />                             		    
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Location <span class="required">*</span></span>
                            		    <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sender_location.location_name"
                            		    	data-ng-disabled = "true"
                            		     />                       		    
                            		     
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">City</span> 
                            			 <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sender_location.address.city"
                            		    	data-ng-disabled = "true"
                            		     /> 
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">State</span> 
                            		     <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sender_location.address.state"
                            		    	data-ng-disabled = "true"
                            		     /> 
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Country</span>
                            		     <input type="text" class="form-control" 
                            		    	data-ng-model = "ctrl.shipment.sender_location.address.country"
                            		    	data-ng-disabled = "true"
                            		     /> 
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Pincode</span>
                            		    <input type="text" class="form-control" 
                            		    	data-ng-model = "ctrl.shipment.sender_location.pincode"
                            		    	data-ng-disabled = "true"
                            		     /> 
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Email</span>
                            		   <input type="text" class="form-control" 
                            		    	data-ng-model = "ctrl.shipment.sender_customer.customer_email"
                            		    	data-ng-disabled = "true"
                            		     /> 
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">GSTIN Number</span>
                            		    <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.gstin_number"
                            		    	data-ng-disabled = "true"
                            		    	
                            		    />                               		    
                            		    
                            		</div>
                            		
                    		      <!--  <div class="col-md-12 col-sm-12 col-xs-12">
                    		        	<div class="col-md-6">
                    		        	
                    		        	</div>	
                    		        	
                    		        	<div class="col-md-6">
	                    		            <label class="checkbox-inline">
		                                        <input type="checkbox">Save Address
		                                    </label>
                    		        	</div>	
                    		        	                    		       
                                    </div> -->
                                    
                            	
                        </div>
                      
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                          Consignee Info
                        </div>
                        <div class="panel-body">
                          	
                          		   <div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">To Branch <span class="required">*</span></span>
                            		    
                            		    <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.consignee_branch.branch_name"
                            		    	data-ng-disabled = "true"
                            		    required />  
                            		</div>
                          	
                          	      <div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Name <span class="required">*</span></span>
                            		    <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.customer_name"
                            		    	data-ng-disabled = "true"
                            		    required />                            		    
                            		</div>
                            		
                        		   <div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Company Name </span>
                            		    <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.company_name"
                            		    	data-ng-disabled = "true"
                            		    />                            		    
                            		</div>
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Mobile Number <span class="required">*</span></span>
                            		    <input type="text" class="form-control" maxlength="10"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.customer_mobileno"
                            		    	data-ng-disabled = "true"
                            		    required />  
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Address line1 <span class="required">*</span></span>
                            		   <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.consigneecustomer_address1"
                            		    	data-ng-disabled = "true"
                            		    required />                             		    
                            		    
                            		</div>
                            	
	                            	<div class="col-md-12 branchclass">
	                            			<span class="text-paddingwidth">Address line2 </span>
	                            		   <input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consigneecustomer_address2"
	                            		    	data-ng-disabled = "true"
	                            		    />                             		    
	                            		    
	                            		</div>
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Location <span class="required">*</span></span>
                            		    <input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consignee_location.location_name"
	                            		    	data-ng-disabled = "true"
	                            		    />                     		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">City</span> 
                            			<input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consignee_location.address.city"
	                            		    	data-ng-disabled = "true"
	                            		    />   
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">State</span> 
                            		   <input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consignee_location.address.state"
	                            		    	data-ng-disabled = "true"
	                            		    /> 
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Country</span>
                            		     <input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consignee_location.address.country"
	                            		    	data-ng-disabled = "true"
	                            		    /> 
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Pincode</span>
                            		     <input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consignee_location.pincode"
	                            		    	data-ng-disabled = "true"
	                            		    /> 
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Email</span>
                            		    <input type="text" class="form-control" maxlength="30"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.customer_email"
                            		    	data-ng-disabled = "true"
                            		    />                            		    
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">GSTIN Number</span>
                            		     <input type="text" class="form-control" maxlength="15"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.gstin_number"
                            		    	data-ng-disabled = "true"
                            		    />                              		    
                            		    
                            		</div>
                            		
                    		         <!-- <div class="col-md-12 col-sm-12 col-xs-12">
                    		        	<div class="col-md-6">
                    		        	
                    		        	</div>	
                    		        	
                    		        	<div class="col-md-6">
	                    		            <label class="checkbox-inline">
		                                        <input type="checkbox">Save Address
		                                    </label>
                    		        	</div>	
                    		        	                    		       
                                    </div>  -->
                          	
                        </div>
                    
                    </div>
                </div>
                        
            </div>
            
            
            <div class="col-lg-12 col-md-12">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="panel panel-default">
                       
                        <div class="panel-body">
                            		
                            <div class="col-md-5">
                    		</div>
                    		
                    		<div class="col-md-4">
                    			<span class="spanclass"><b>Bill To</b></span>
                    			<label class="radio-inline">
                                                <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" data-ng-model = "ctrl.shipment.bill_to" value="Paid" data-ng-disabled = "true" ><b>Paid</b>
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" data-ng-model = "ctrl.shipment.bill_to" value="To Pay" data-ng-disabled = "true"><b>To Pay</b>
                                            </label>  
                    		 </div>

                    		<div class="col-md-3">
                    		</div>
                            	
                        </div>
                      
                    </div>
                </div>
                
           </div>
            
            
         
                    	
             </div>
      
                
                
              <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                                   
                                 Shipment Info
                        </div>
                        <div class="panel-body">
                        
                                    <div class="col-md-12">
                                    	
	                            		<div class="col-md-6 branchclass">
	                            			<span class="text-paddingwidth"> Service <span class="required">*</span></span>
	                            		    			    
											 <input type="text" class="form-control" maxlength="15"
                            		    	data-ng-model = "ctrl.shipment.service.service_name"
                            		    	data-ng-disabled = "true"
                            		    /> 			    
	                            		    
	                            		</div>
	                            		<div class=" col-md-6 branchclass">
	                            			<span class="text-paddingwidth"> Status <span class="required">*</span></span>
	                            		   <select class="form-control" data-ng-options = "status for status in ['Pending','Delivered']" 
	                            		   		data-ng-model = "ctrl.shipment.status"
	                            		   		data-ng-disabled = "true"
				                              required>
				                           </select>                          		    
                            		    </div>
                                    </div>
                                    
                            		
                                    <div class="col-md-12">
                                    	<div class=" col-md-6 branchclass">
                            		    <span class="text-paddingwidth">No.of Parcel <span class="required">*</span></span>
	                            		    <input type="text" class="form-control" maxlength="4"
	                            		    	data-ng-model = "ctrl.shipment.numberof_parcel"
	                            		    	data-ng-disabled = "true"
	                            		    required />  
                            		    </div>
	                            		<div classTo Branch="col-md-6">
	                            		</div>
                                    </div>
                                    
                                    
                                    <div class="col-md-12">
                  
                   
                       
                   
                          
                            <div class="col-md-12">
                            <div class="table-responsive">                    
                                
                                
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <!-- <th class = "text-center"><input type="checkbox" data-ng-model = "ctrl.selectAll_product" data-ng-click = "ctrl.product_selectAll()"></th> -->
                                            <th class = "text-center">S.No</th>
                                            <th class = "text-center">Product</th>
                                            <th class = "text-center">Product Type</th>                                        
                                            <th colspan="3" class = "text-center">Dimensions(cm)</th>
                                            <th class = "text-center">Weight(Kg)</th>
                                            <th class = "text-center">Quantity</th>
                                            <th class = "text-center">Unit Price</th>
                                            <th class = "text-center">Total Price</th>
                                        </tr>
                                        
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat = "product in ctrl.shipment.shipmentDetail track by $index">                                           
                                            <td>{{$index + 1}}
	                                            <input type = "hidden" class="form-control" data-ng-model = "product.shipmentdetail_id" data-ng-value = "product_name.originalObject.product_id" /> 
                                            </td>
                                            <td> 
                                            			    
											    <input type = "text" placeholder="Product height"  class="form-control" 
													data-ng-model = "product.product.product_name" 
													data-ng-disabled = "true"/> 
                                            	<a href="" data-toggle="modal" data-target="#HSNmodal{{$index}}" id = "HSNmodal_a{{$index}}" data-toggle="tooltip" style="text-decoration: none !important;"> View HSN Details</a>

                                            	<!-- HSN MODAL BEGIN -->
                                            	
				                                            	<div class="modal fade" id="HSNmodal{{$index}}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"  data-backdrop="static" data-keyboard="false" aria-hidden="true">
									                                <div class="modal-dialog hsnModal">
									                                    <div class="modal-content">
									                                    
									                                        <div class="modal-header">
									                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
									                                            <h4 class="modal-title" id="myModalLabel">HSN Details</h4>
									                                        </div>
									                                        
									                                        <div class="modal-body hsn-modal">
									                                        	<div class = "col-lg-12">
										                                        	<table  class="table table-striped table-bordered table-hover" id="dataTables-example">
										                                        		<thead>
											                                        	<tr> 
											                                        		<th> S.NO </th>
											                                        		<th> HSN Code </th>
											                                        		<th> Description </th>
											                                        	</tr>
											                                        	</thead>
											                                        	
											                                        	<tbody>
											                                        		<tr data-ng-repeat = "hsn in product.shipmentHsnDetail track by $index">
											                                        			<td> {{$index + 1}}  <input type="hidden" class="form-control" data-ng-model = "hsn.shipmenthsndetail_id" />  </td>
											                                        			<td> 
											                                        				<input type = "text" class="form-control" 
                                            															data-ng-model = "hsn.hsn.hsn_code"
                                            															data-ng-disabled = "true"
                                            															/> 
											                                        															                                        				
											                                        			</td>
											                                        			<td> 
											                                        				<input type = "text" class="form-control" 
                                            															data-ng-model = "hsn.hsn.hsn_description"
                                            															data-ng-disabled = "true"
                                            															/>
											                                        					
											                                        			</td>
											                                        		</tr>
											                                        	</tbody>
										                                        	</table>
																			 	</div>
																			 	
																			</div>
																			
									                                        <div class="modal-footer">
									                                           
									                                        </div>
									                                        
									                                    </div>
									                                </div>
									                            </div>
									                            
									                    <!-- HSN MODAL END -->             
                                            </td>
                                            <td> 
                                            	<input type = "text" class="form-control" 
                                            		data-ng-model = "product.product.product_Type"
                                            		data-ng-disabled = "true"
                                            		/> 
                                            </td>
                                            <td> <input type = "text" class="form-control" 
													data-ng-model = "product.height"
													data-ng-disabled = "true" 
													/> 
											</td>
                                            <td> <input type = "text" class="form-control" 
                                            		data-ng-model = "product.width"
                                            		data-ng-disabled = "true"  
                                            		/> 
                                            </td>
                                            <td> <input type = "text" class="form-control" 
                                            		data-ng-model = "product.length" 
                                            		data-ng-disabled = "true"
                                            		/> </td>
                                            <td> <input type = "text" class="form-control" 
                                            		data-ng-model = "product.weight"
                                            		data-ng-disabled = "true" 
                                            		/> </td>
                                            <td> <input type = "text" class="form-control" 
                                          			data-ng-model = "product.quantity"
                                          			data-ng-disabled = "true" 
													/> </td>
                                            <td> <input type = "text" class="form-control" 
                                            		data-ng-model = "product.unit_price"
                                            		data-ng-disabled = "true" 
                                            		/> </td>
                                            <td> <input type = "text" class="form-control"  
                                            		data-ng-model = "product.total_price" 
                                            		data-ng-disabled = "true" 
                                            		/> </td>
                                     
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
            </div>  
                
                		
                 
              
              <div class="row">
              	
              	<div class="col-md-12">
              		              		
              		<div class="col-md-12 GenLeftRight">
              			<div class="subhead">
              			Service &amp;Payment Info
              			</div>
              		</div>
              	</div>
              	
              	
              	
              	
              	<div class="col-lg-12 col-md-12">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           Services
                        </div>
                        <div class="panel-body">
                            		 		
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Shipment Value <span class="required">*</span></span>
                            			
                            			<div class = "form-group input-group">
	                            		    <input type="text" class="form-control" min = "1" max="999999.99"
	                            		    	data-ng-model = "ctrl.shipment.shipment_value"
	                            		    	data-ng-disabled = "true"
	                            		    required />  
	                            		     <span class="input-group-addon" id = "basic-addon1"><i class="fa fa-inr" aria-hidden="true"></i></span>
                            		    </div>
                            		  
                            		</div>
                            		
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Reference Invoice No</span>
                            		    <input type="text" class="form-control" maxlength="15"
                            		    	data-ng-model = "ctrl.shipment.reference_invoice_no"
                            		    	data-ng-disabled = "true"
                            		    />                               		    
                            		    
                            		</div>
                            
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Description</span>
                            		    <textarea class="form-control" data-ng-model = "ctrl.shipment.description"
                            		    style="height: 342px;width: 100%;"
                            		   		disabled
                            		    	 rows="8"> </textarea>                           		    
                            		    
                            		</div>
                         </div>
                      
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                         Payment Details
                        </div>
                        <div class="panel-body">
                        
                          	
                          	       <div class=" col-md-12">
                            			<span class="text-paddingwidth"> Chargeable Weight </span>
                            		    <div class = "form-group input-group">
	                            		    <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.chargeable_weight" 
	                            		    	data-ng-disabled = "true"
	                            		    required />  
	                            		     <span class="input-group-addon">kg.</span>
                            		    </div>                           		    
                            		</div>
                            		
                           
                            	
                            	
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Delivery Charge </span>
                            			
                            			 <div class = "form-group input-group">
	                            		    <input type="text" class="form-control disabled" 
	                            		    	data-ng-model = "ctrl.shipment.delivery_charge" 
	                            		    	data-ng-disabled = "true"
	                            		    required />  
	                            		     <span class="input-group-addon"><i class="fa fa-inr" aria-hidden="true"></i></span>
                            		    </div>   
                            		  
                            		</div>
                            		
                            		
                            	
                            		<div class="col-md-6">
                            		
                            			<span class="text-paddingwidth discountspace ">Discount percentage</span>
                            		       <div class = "form-group input-group">
	                            		    <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.discount_percentage"
	                            		    	data-ng-disabled = "true"
	                            		     />  
	                            		     <span class="input-group-addon"> % </span>
                            		    </div>                              		    
                            		
                            	   </div> 
                            		
                            		<div class="col-md-6">
                            			<span class="text-paddingwidth">Discount amount</span>
                            		    
	                                    <div class = "form-group input-group">
	                            		    <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.discount_amount" 
	                            		    	data-ng-disabled = "true"
	                            		    />  
	                            		     <span class="input-group-addon"><i class="fa fa-inr" aria-hidden="true"></i></span>
                            		    </div>                          		    
                            		    
                            		</div>                           		
                            		
                            		<!-- <div class="col-md-12">
                            			<span class="text-paddingwidth">Handling Charge <span class="required">*</span></span>
                            		    <div class = "form-group input-group">
	                            		    <input type="text" class="form-control"
	                            		    	data-ng-model = "ctrl.shipment.handling_charge"
	                            		    	data-ng-disabled = "true"
	                            		    required />  
	                            		     <span class="input-group-addon"><i class="fa fa-inr" aria-hidden="true"></i></span>
                            		    </div> 
                            		</div> -->
                            		
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Tax payable on Reverse Charge <span class="required">*</span></span>
                            			     <select class="form-control" data-ng-options = "tax_payable for tax_payable in ['Yes', 'No']" 
                            			     	data-ng-model = "ctrl.shipment.taxin_payable"
					                            data-ng-disabled = "true" required>
					                             <option value = "" disabled>---Select--</option>
					                           </select>	                            		   
                            		    
                            		</div>
                            		
                            		<div class="col-md-4">
                            		
                            			<span class="text-paddingwidth discountspace">CGST</span>
                            		       <div class = "form-group input-group">
	                            		    <input type="text" class="form-control" 
	                            		   		data-ng-disabled = "true"
	                            		    	data-ng-model = "ctrl.shipment.cgst"	                            		    	
																							
	                            		     />  
	                            		     <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
                            		    </div>                              		    
                            		
                            	   </div> 
                            		
                            		<div class="col-md-4">
                            			<span class="text-paddingwidth">SGST</span>
                            		                         		    
	                            		  <div class = "form-group input-group">
	                            		    <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.sgst"	                            		    	
												data-ng-disabled = "true"											
	                            		     />  
	                            		     <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
                            		    </div>
                            		</div>
                            		
                            		<div class="col-md-4">
                            			<span class="text-paddingwidth ">IGST</span>
                            	
                            		       <div class = "form-group input-group">
	                            		    <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.igst"	                            		    	
												data-ng-disabled = "true"										
	                            		     />  
	                            		     <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
                            		    </div>                      		    
                            		    
                            		</div>
                            	                        	
                            	
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Tax</span> 
                            			<div class = "form-group input-group">
                            		     <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.tax"	                            		    	
												data-ng-disabled = "true"										
	                            		     />  
	                            		      <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
	                            		</div>                                		    
                            		    
                            		</div>
                            	
                            	
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Total Charges</span> 
                            			<div class = "form-group input-group">
                            		     <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.total_charges"	                            		    	
												data-ng-disabled = "true"										
	                            		     /> 
	                            		     <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>                           		    
                            		    </div>
                            		</div>
                            	
                            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            	
                            		                        	
                        </div>
                    
                    </div>
                </div>
                
            </div>
            
                
             </div>
        
              
       		 </form>
			
			
		</div>
	<!-- ------------------------- VIEW SELECTED SHIPEMNT END ------------------ -----  -->
	<jsp:include page="../Dashboard/nav.jsp"/>
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      		  <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default panelMarginBottom">                            
<!-- 						<div class="panel-heading"> -->
							
<!-- 						</div> -->
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
                			      		<select class="form-control" 
                			      		data-ng-options ="branch.branch_id as branch.branch_name for branch in ctrl.branches"
                			      		data-ng-model="ctrl.receipt.frombranch"
                			      		>
                			      			<option value='' disabled>--Select--</option>
                			      		</select>
                			      </div>
                			      
                			       <div class="col-lg-3 branchclass">
                			      		<span class="text-padding">To</span>
                			      		<select class="form-control" data-ng-options ="branch.branch_id as branch.branch_name for branch in ctrl.branches" 
                			      		data-ng-model="ctrl.receipt.tobranch">
                			      			<option value=''>--Select--</option>
                			      			
                			      		</select>
                			      </div>
                			      </div>
                			      <input type="hidden" id="branch_id" value="${branch_id}" />
									<input type = "hidden" id = "currentUserRole" value = "<sec:authentication property="principal.authorities[0]"/>" />
                			      <div class="col-lg-12 noPaddingLeft"> 
                			        <div class="sec-padding">Specific Period</div>
                			         
                			         <div class="col-lg-3 branchclass">
	                			      		 <span class="paddingtop">From  </span>   	                                       
	                                          <div class="form-group input-group marginleftrightspace">
					                                <input type="text" class="form-control datepicker1" data-ng-model="ctrl.receipt.fromdate"
					                           			   data-trigger= "focus"data-toggle="popover" data-placement="top"
					                            		   data-content="Please select from date"/>
		                                            <span class="input-group-addon"><i class="fa fa-calendar"></i>
		                                            </span>
		                                          
		                                     </div>
	                                  </div>
                			      
                			       <div class="col-lg-3 branchclass">
                			      		<span class="paddingtop">To</span>
                			      		  <div class="form-group input-group spacemarginleftright">
				                               <input type="text" class="form-control datepicker2" data-ng-model="ctrl.receipt.todate"
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
                                            <select class="form-control" data-ng-model="ctrl.receipt.status">
                                            	<option value=''>--Select--</option>
                                            	<option value='Delivered'>Delivered</option>  
                                            	<option value='Pending'>Pending</option>                                            	
                                            </select>
                                        </div>
                			            <div class="col-lg-3 branchclass">
                			      		   <button class="btn btn-primary" data-ng-click="ctrl.receiptFilter()"> View Receipt</button>                                         
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
                                            <input type="text" class="form-control searchbar" 
                                            placeholder="Manifest/LR No/Receipt No"
                                            data-ng-model="ctrl.search"
                                            data-ng-keyup="ctrl.receiptSearch(ctrl.search)">                                           
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
							<li><a data-ng-click="ctrl.makePending()">Pending</a></li>
							<li><a data-ng-click="ctrl.makeReturn()">Return</a></li>
							<li><a data-ng-click="ctrl.makeDelete()">Delete</a></li>
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
<!--                                      <th data-ng-show="setting_receiptmanifest">Manifest</th> -->
                                     <th data-ng-show="setting_receiptstatus">Status</th>
                             	</tr>
                             </thead>
                             <tbody>
                                 <tr data-ng-repeat="receipt in ctrl.Filterreceipts|limitTo:pageSize"
                                 data-id="{{receipt.receipt_id}}" data-ng-dblclick = "ctrl.view1Shipmet(receipt)">
                                     <td><input type="checkbox" data-ng-click="ctrl.receiptSelect(receipt)" data-ng-model="receipt.select"></td>
                                     <td data-ng-show="setting_sltnumber" >{{$index+1}}</td>
                                     <td data-ng-show="setting_receiptdate">{{receipt.temp_date.slice(0,-10)}}</td>
                                     <td data-ng-show="setting_receiptlrnumber">{{receipt.shipmentModel.lrno_prefix}}</td>
                                     <td data-ng-show="setting_receiptnumber">{{receipt.temp_receiptno}}</td>
                                     <td data-ng-show="setting_receiptproduct">
                                    	 <div data-ng-repeat = "shipmentdet in receipt.shipmentModel.shipmentDetail">
                                           	{{shipmentdet.product.product_name}}<span data-ng-if = !($last)>,</span>
                                         </div>
                                     </td>
                                     <td data-ng-show="setting_receiptorigin">{{receipt.shipmentModel.sender_branch.branch_name}}</td>
                                     <td data-ng-show="setting_receiptdestination">{{receipt.shipmentModel.consignee_branch.branch_name}}</td>
                                     <td data-ng-show="setting_receiptsender">{{receipt.shipmentModel.sender_customer.customer_name}}</td>
                                     <td data-ng-show="setting_receiptconsignee">{{receipt.shipmentModel.consignee_customer.customer_name}}</td>
<!--                                      <td data-ng-show="setting_receiptmanifest">{{receipt.manifestModel.manifest_prefix}}</td> -->
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
                    <!--End Advanced Tables -->
                    </div>
                </div>
            </div>
        </div>
        <!-- /. PAGE WRAPPER  -->
   </div>
    <!-- /. WRAPPER  -->
  
  
    <script src="resources/custom/js/custom.js"></script>
    <script src="resources/custom/js/receipt/view_receipt_controller.js"></script>
    <script src="resources/custom/js/receipt/view_receipt_service.js"></script>
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