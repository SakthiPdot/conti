<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib
    prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
    <!--<link href='http://fonts.googleapis.com/css\?family=Open+Sans' rel='stylesheet' type='text/css' />-->
    <link rel="stylesheet" href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css"> 
	
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	  <link href="resources/custom/css/custom.css" rel="stylesheet">
	   <link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
	 <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">
	 
	 <link href="resources/custom/css/demo.css" rel="stylesheet">
<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script type="text/javascript" src="resources/built-in/js/lodash.js"></script> 
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <script src="resources/custom/js/app.js"></script>
</head>


<body style="overflow-x:hidden;" data-ng-app="contiApp" data-ng-controller="ManifestController as ctrl">
 
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
								<div class="col-lg-2 pull-right">
									<a class="pull-right" data-ng-click = "ctrl.viewShipemntClose()"><i class="fa fa-times" aria-hidden="true"></i></a>
								</div>
<!-- 								<div class="col-lg-2 pull-right"> -->
<!-- 									<a class="btn btn-info" data-ng-click = "ctrl.shipmentPrint(ctrl.shipment)"> <i class="fa fa-print" aria-hidden="true"></i>  LR print </a> -->
<!-- 								</div> -->
								
								
								 
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
		              
		               <b class = "pull-right">Shipment Date : {{ctrl.shipment.shipment_date.slice(0,-2)}}</b>            
		              
	              </div>
	              
              </div>
              <div class="col-md-12">
              		<div class="col-md-6">
		              
		               <b>Manifest No. : ${manifest_number}</b>            
		              
	              </div>
	               <div class="col-md-6">
		              
		               <b class = "pull-right">Manifest Date : ${manifest_date}</b>            
		              
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
                            			<span class="text-paddingwidth"> Name </span>
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
                            			<span class="text-paddingwidth">Mobile Number </span>
                            		    <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.customer_mobileno"
                            		    	data-ng-disabled = "true"
                            		    required />  
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Address line1 </span>
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
                            			<span class="text-paddingwidth">Location </span>
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
                            		    	id="sender_city"
                            		     /> 
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">State</span> 
                            		     <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sender_location.address.state"
                            		    	data-ng-disabled = "true"
                            		    	id="sender_state"
                            		     /> 
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Country</span>
                            		     <input type="text" class="form-control" 
                            		    	data-ng-model = "ctrl.shipment.sender_location.address.country"
                            		    	data-ng-disabled = "true"
                            		    	id="sender_country"
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
                            			<span class="text-paddingwidth">To Branch </span>
                            		    
                            		    <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.consignee_branch.branch_name"
                            		    	data-ng-disabled = "true"
                            		    required />  
                            		</div>
                          	
                          	      <div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Name </span>
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
                            			<span class="text-paddingwidth">Mobile Number </span>
                            		    <input type="text" class="form-control" maxlength="10"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.customer_mobileno"
                            		    	data-ng-disabled = "true"
                            		    required />  
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Address line1 </span>
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
                            			<span class="text-paddingwidth">Location </span>
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
	                            		    	id="consignee_city"
	                            		    />   
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">State</span> 
                            		   <input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consignee_location.address.state"
	                            		    	data-ng-disabled = "true"
	                            		    	id="consignee_state"
	                            		    /> 
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Country</span>
                            		     <input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consignee_location.address.country"
	                            		    	data-ng-disabled = "true"
	                            		    	id="consignee_country"
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
	                            			<span class="text-paddingwidth"> Service </span>
	                            		    			    
											 <input type="text" class="form-control" maxlength="15"
                            		    	data-ng-model = "ctrl.shipment.service.service_name"
                            		    	data-ng-disabled = "true"
                            		    /> 			    
	                            		    
	                            		</div>
	                            		<div class=" col-md-6 branchclass">
	                            			<span class="text-paddingwidth"> Status </span>
	                            		   <select class="form-control" data-ng-options = "status for status in ['Booked', 'Received','Pending','Return','Delivered','Intransit','Missing']" 
	                            		   		data-ng-model = "ctrl.shipment.status"
	                            		   		data-ng-disabled = "true"
				                              required>
				                           </select>                          		    
                            		    </div>
                                    </div>
                                    
                            		
                                    <div class="col-md-12">
                                    	<div class=" col-md-6 branchclass">
                            		    <span class="text-paddingwidth">No.of Parcel </span>
	                            		    <input type="text" class="form-control" maxlength="4"
	                            		    	data-ng-model = "ctrl.shipment.numberof_parcel"
	                            		    	data-ng-disabled = "true"
	                            		    required />  
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
                                            <th class = "text-center">Weight(KG)</th>
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
                           		<span class="text-paddingwidth">Shipment Value </span>
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
                       		    	data-ng-disabled = "true" />                               		    
                       		</div>
                            
                       		<div class="col-md-12">
                       			<span class="text-paddingwidth">Description</span>
                       		    <textarea class="form-control" data-ng-model = "ctrl.shipment.description"
                       		    style="height: 342px;width: 100%;" disabled rows="8"> </textarea>                           		    
                       		    
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
                        		    	data-ng-disabled = "true"/>  
                        		     <span class="input-group-addon"> % </span>
                       		    </div>                              		    
                       		</div> 
                            		
                       		<div class="col-md-6">
                       			<span class="text-paddingwidth">Discount amount</span>
                       		    <div class = "form-group input-group">
                        		    <input type="text" class="form-control" 
                        		    	data-ng-model = "ctrl.shipment.discount_amount" 
                        		    	data-ng-disabled = "true"/>  
                        		     <span class="input-group-addon"><i class="fa fa-inr" aria-hidden="true"></i></span>
                       		    </div>                          		    
                       		</div>                           		
                            		
                            		<!-- <div class="col-md-12">
                            			<span class="text-paddingwidth">Handling Charge </span>
                            		    <div class = "form-group input-group">
	                            		    <input type="text" class="form-control"
	                            		    	data-ng-model = "ctrl.shipment.handling_charge"
	                            		    	data-ng-disabled = "true"
	                            		    required />  
	                            		     <span class="input-group-addon"><i class="fa fa-inr" aria-hidden="true"></i></span>
                            		    </div> 
                            		</div> -->
                            		
                       		<div class="col-md-12">
                       			<span class="text-paddingwidth">Tax payable on Reverse Charge </span>
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
										data-ng-disabled = "true"/>  
                        		     <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
                       		    </div>
                       		</div>
                            		
                       		<div class="col-md-4">
                       			<span class="text-paddingwidth ">IGST</span>
                       				<div class = "form-group input-group">
                        		    <input type="text" class="form-control" 
                        		    	data-ng-model = "ctrl.shipment.igst"	                            		    	
										data-ng-disabled = "true"/>  
                        		     <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
                       		   		 </div>                      		    
                       		</div>
                            	                        	
                            	
                       		<div class="col-md-12">
                       			<span class="text-paddingwidth">Tax</span> 
                       			<div class = "form-group input-group">
                       		     <input type="text" class="form-control" 
                        		    	data-ng-model = "ctrl.shipment.tax"	                            		    	
										data-ng-disabled = "true"/>  
                        		      <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
                        		</div>                                		    
                       		</div>
                            	
                            	
                       		<div class="col-md-12">
                       			<span class="text-paddingwidth">Total Charges</span> 
                       			<div class = "form-group input-group">
                       		     <input type="text" class="form-control" 
                        		    	data-ng-model = "ctrl.shipment.total_charges"	                            		    	
										data-ng-disabled = "true" /> 
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
<!-- 						<div class="panel-heading">							 -->
<!-- 						</div> -->
					<div class="panel-body customer-font">
					<b>Manifest Detailed : ${manifest_number}</b>
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
                             View Manifest Register
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                            <div class="row">
                              <div class="col-lg-12">
                               <div class="col-xs-5">
                                   <div class="dataTables_length" id="dataTables-example_length">
                                 <input type=hidden id="branch_flag" value="${flag}"/>
                                  <sec:authorize access="hasRole('MANAGER') OR hasRole('STAFF')">  
                                   <input type=hidden id="authen_flag" value="MANAGER_OR_STAFF"/>
                                 </sec:authorize>
										<div class="dropdown">
										<button class="btn btn-primary dropdown-toggle"
											type="button" data-toggle="dropdown">
											Batch Action <span class="caret"></span>
										</button>
										<ul class="dropdown-menu">
											<li><a data-ng-click="ctrl.makeReceived()">Received</a></li>
											<li><a data-ng-click="ctrl.makeMissing()">Missing</a></li>
										</ul>
										</div>
									

																		
										<div class="row paddingtop">
											<div class="col-md-12">
												<select name="shownoofrec" data-ng-model="shownoofrec"
													data-ng-options="noofrec for noofrec in [10, 15, 25, 50]"
													class="form-control"
													data-ng-click="ctrl.shownoofRecord()">
												</select>
											</div>
										</div>
									</div> 
                                </div>
                              	<div class="col-lg-2 ">
											<a class="btn btn-primary" data-ng-click = "ctrl.manifestPrint(ctrl.manifestId)"> <i class="fa fa-print" aria-hidden="true"></i> Manifest Print </a>
										</div>
                                <div class="col-xs-5 icons-button">
                                   <div class="pull-right">
                                   
                                   <form name="manifestPrint" method="POST" action="manifest_print" class="padding-button">
                                     <a type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a>
                                     	<div class="dropdown-menu regSettings pull-right" style="padding-right: 5px;">
                                     	
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_sltnumber == true, 'fa-times': setting_sltnumber == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_sltnumber=true" data-ng-model="setting_sltnumber" /> SL No
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_date == true, 'fa-times': setting_date == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_date=true" data-ng-model="setting_date" /> Date
											</label>
										</div>
										
											
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_lrnumber == true, 'fa-times': setting_lrnumber == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_lrnumber=true" data-ng-model="setting_lrnumber" /> LR Number
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_product == true, 'fa-times': setting_product == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_product=true" data-ng-model="setting_product" />Product
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_origin == true, 'fa-times': setting_origin == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_origin=true" data-ng-model="setting_origin" />Origin
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_destination == true, 'fa-times': setting_destination == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_destination=true" data-ng-model="setting_destination" />Destination
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check':setting_sender == true, 'fa-times': setting_sender == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_sender=true" data-ng-model="setting_sender" />Sender
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check':setting_consignee == true, 'fa-times': setting_consignee == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_consignee=true" data-ng-model="setting_consignee" />Consignee
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check':setting_shipmentstatus == true, 'fa-times':setting_shipmentstatus == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_shipmentstatus=true" data-ng-model="setting_shipmentstatus" />Status
											</label>
										</div>
										
									</div>
<!-- 										<a type="button" class="btn btn-primary" onclick="location.href='downloadExcelManifest';valid = true;"><i class="fa fa-file-excel-o fa-lg"></i></a> -->
                                      	  <button type="submit" class="btn btn-primary" data-ng-disabled = true ><i class="fa fa-print fa-lg"></i></button>
	                                      <input type = "hidden" name = "cust" value = "{{ctrl.selected_manifest}}" />
	                                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                                     
	                                      <div class = "row paddingtop">
	                                    	<div class = "col-md-12"><input type = "text" class="form-control" name = "search" placeholder = "Ex: Driver" 
	                                    	data-ng-model = "ctrl.manifest_regSearch" data-ng-keyup = "ctrl.registerSearch(ctrl.manifest_regSearch)"/></div>
                                     	 </div>
                                     	 
										</form>
                                	</div>
                                </div>
                              </div>
                            </div>
                          	
                            
                            <input type="hidden" id="manifest_id" value="${m_id}" >
                          
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox" data-ng-click="ctrl.manifestDetailedSelectAll()" 
                                            data-ng-model="selectallmanifests"></th>
                                            <th data-ng-show="setting_sltnumber">SL NO</th>
                                            <th data-ng-show="setting_date">Date</th>
                                            <th data-ng-show="setting_lrnumber">LR Number</th>
                                            <th data-ng-show="setting_product">Product</th>
                                            <th data-ng-show="setting_origin">Origin</th>
                                            <th data-ng-show="setting_destination">Destination</th>
                                            <th data-ng-show="setting_sender">Sender</th>
                                            <th data-ng-show="setting_consignee">Consignee</th>
                                            <th data-ng-show="setting_shipmentstatus">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat = "manifestdetailed in ctrl.Filtermanifests" data-ng-dblclick = "ctrl.view1Shipmet(manifestdetailed.shipmentModel)">
                                        	<td><input type="checkbox" data-ng-click="ctrl.manifestSelect(manifestdetailed)"
                                        	 data-ng-model="manifestdetailed.select"
                                        	 ></td>
                                            <td data-ng-show="setting_sltnumber" >{{$index+1}}</td>
                                            <td data-ng-show="setting_date">{{manifestdetailed.shipmentModel.created_datetime.slice(0,-10)}}</td>
                                            <td data-ng-show="setting_lrnumber">{{manifestdetailed.shipmentModel.lrno_prefix}}</td>
                                            <td data-ng-show="setting_product">
                                         		 <div data-ng-repeat = "shipmentdet in manifestdetailed.shipmentModel.shipmentDetail">
                                           			{{shipmentdet.product.product_name}}<span data-ng-if = !($last)>,</span>
                                           		</div>
                                            </td>
                                            <td data-ng-show="setting_origin">{{manifestdetailed.shipmentModel.sender_branch.branch_name}}</td>
                                            <td data-ng-show="setting_destination">{{manifestdetailed.shipmentModel.consignee_branch.branch_name}}</td>
                                            <td data-ng-show="setting_sender">{{manifestdetailed.shipmentModel.sender_customer.customer_name}}</td>
                                            <td data-ng-show="setting_consignee">{{manifestdetailed.shipmentModel.consignee_customer.customer_name}}</td>
                                            <td data-ng-show="setting_shipmentstatus">{{manifestdetailed.shipmentModel.status}}</td>
                                           
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
                  
                </div>
            </div>
               </div> 
           
        </div>
        <!-- /. PAGE WRAPPER  -->
		
		
    </div>
    <!-- /. WRAPPER  -->

  
    <script src="resources/custom/js/custom.js"></script>
    <script src="resources/custom/js/manifest/view_manifest_detailed_controller.js"></script>
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