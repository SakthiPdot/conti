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
<link rel="icon" type="image/gif/png" href="resources/Image/conti_logo.png">
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
							<div class = "col-lg-6"> <b>Shipment details</b> </div>
							<div class = "col-lg-6">
								<div class="col-lg-2 pull-right">
									<a class="pull-right" data-ng-click = "ctrl.viewShipemntClose()"><i class="fa fa-times" aria-hidden="true"></i></a>
								</div>
								<div class="col-lg-2 pull-right">
									<a class="btn btn-info" data-ng-click = "ctrl.shipmentPrint(ctrl.shipment)"> <i class="fa fa-print" aria-hidden="true"></i>  LR print </a>
								</div>
								<div class="col-lg-2 pull-right">
									<a class="btn btn-danger" data-ng-click = "ctrl.shipmentCancel(ctrl.shipment)"> <i class="fa fa-ban" aria-hidden="true"></i> Delete </a>
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
                            		    	data-ng-model = "ctrl.shipment.sender_customer.customer_addressline1"
                            		    	data-ng-disabled = "true"
                            		    required />                             		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Address line2 </span>
                            		   <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.customer_addressline2"
                            		    	data-ng-disabled = "true"
                            		     />                             		    
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Location <span class="required">*</span></span>
                            		    <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.location.location_name"
                            		    	data-ng-disabled = "true"
                            		     />                       		    
                            		     
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">City</span> 
                            			 <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.location.address.city"
                            		    	data-ng-disabled = "true"
                            		     /> 
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">State</span> 
                            		     <input type="text" class="form-control"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.location.address.state"
                            		    	data-ng-disabled = "true"
                            		     /> 
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Country</span>
                            		     <input type="text" class="form-control" 
                            		    	data-ng-model = "ctrl.shipment.sender_customer.location.address.country"
                            		    	data-ng-disabled = "true"
                            		     /> 
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Pincode</span>
                            		    <input type="text" class="form-control" 
                            		    	data-ng-model = "ctrl.shipment.sender_customer.location.pincode"
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
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.customer_addressline1"
                            		    	data-ng-disabled = "true"
                            		    required />                             		    
                            		    
                            		</div>
                            	
	                            	<div class="col-md-12 branchclass">
	                            			<span class="text-paddingwidth">Address line2 </span>
	                            		   <input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consignee_customer.customer_addressline2"
	                            		    	data-ng-disabled = "true"
	                            		    />                             		    
	                            		    
	                            		</div>
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Location <span class="required">*</span></span>
                            		    <input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consignee_customer.location.location_name"
	                            		    	data-ng-disabled = "true"
	                            		    />                     		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">City</span> 
                            			<input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consignee_customer.location.address.city"
	                            		    	data-ng-disabled = "true"
	                            		    />   
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">State</span> 
                            		   <input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consignee_customer.location.address.state"
	                            		    	data-ng-disabled = "true"
	                            		    /> 
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Country</span>
                            		     <input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consignee_customer.location.address.country"
	                            		    	data-ng-disabled = "true"
	                            		    /> 
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Pincode</span>
                            		     <input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consignee_customer.location.pincode"
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
	                            		   <select class="form-control" data-ng-options = "status for status in ['Booked', 'Intransit', 'Pending', 'Return']" 
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
			   											    input-class="form-control form-control-small" style = "width: 100%"
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
										<span class="text-padding boldletter">Search</span> 
										<input type="text" class="form-control searchbar"
											data-ng-model = "ctrl.lr_search" data-ng-keyup = "ctrl.searchby_LR(ctrl.lr_search)"
											placeholder="LR No">
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
														 <ul class="dropdown-menu">
																<li><a data-ng-click="ctrl.makeCancel()">Cancel</a></li>
														</ul> 

													</div>

													<div class = "row paddingtop">
					                                    <div class = "col-md-12"> 
					                                    <select name ="shownoofrec" data-ng-model="shownoofrec" data-ng-options = "noofrec for noofrec in [10, 15, 25, 50, 100]" class ="form-control" data-ng-change="ctrl.shownoofRecord()">
					                                    	
					                                    </select>
					                                    </div>
				                            		 </div>
												</div>
												
												
                             
											</div>

											<div class="col-xs-6 icons-button">
												<div class="pull-right">
													<form name="shipmentPrint" method = "POST" action = "viewshipment_print" class="padding-button">
														
														<a type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a>
														<div class="dropdown-menu regSettings pull-right" style="padding-right: 5px;">
															<div class ="checkbox">
					                                     		<label>
					                                     			<i class = "fa" data-ng-class="{'fa-check': setting_shipdate == true, 'fa-times': setting_shipdate == false}"></i>
																	<input type="checkbox" data-ng-init = "setting_shipdate=true" data-ng-model="setting_shipdate" /> Date
																</label>
															</div>
															<div class ="checkbox">
					                                     		<label>
					                                     			<i class = "fa" data-ng-class="{'fa-check': setting_shiplrno == true, 'fa-times': setting_shiplrno == false}"></i>
																	<input type="checkbox" data-ng-init = "setting_shiplrno=true" data-ng-model="setting_shiplrno" /> LR No.
																</label>
															</div>
															<div class ="checkbox">
					                                     		<label>
					                                     			<i class = "fa" data-ng-class="{'fa-check': setting_shipprod == true, 'fa-times': setting_shipprod == false}"></i>
																	<input type="checkbox" data-ng-init = "setting_shipprod=true" data-ng-model="setting_shipprod" /> Product
																</label>
															</div>
															<div class ="checkbox">
					                                     		<label>
					                                     			<i class = "fa" data-ng-class="{'fa-check': setting_shiporigin == true, 'fa-times': setting_shiporigin == false}"></i>
																	<input type="checkbox" data-ng-init = "setting_shiporigin=true" data-ng-model="setting_shiporigin" /> Origin
																</label>
															</div>
															<div class ="checkbox">
					                                     		<label>
					                                     			<i class = "fa" data-ng-class="{'fa-check': setting_shipdestinate == true, 'fa-times': setting_shipdestinate == false}"></i>
																	<input type="checkbox" data-ng-init = "setting_shipdestinate=true" data-ng-model="setting_shipdestinate" /> Destination
																</label>
															</div>
															<div class ="checkbox">
					                                     		<label>
					                                     			<i class = "fa" data-ng-class="{'fa-check': setting_shipsender == true, 'fa-times': setting_shipsender == false}"></i>
																	<input type="checkbox" data-ng-init = "setting_shipsender=true" data-ng-model="setting_shipsender" /> Sender
																</label>
															</div>
															<div class ="checkbox">
					                                     		<label>
					                                     			<i class = "fa" data-ng-class="{'fa-check': setting_shipconsignee == true, 'fa-times': setting_shipconsignee == false}"></i>
																	<input type="checkbox" data-ng-init = "setting_shipconsignee=true" data-ng-model="setting_shipconsignee" /> Consignee
																</label>
															</div>
															<div class ="checkbox">
					                                     		<label>
					                                     			<i class = "fa" data-ng-class="{'fa-check': setting_shipstatus == true, 'fa-times': setting_shipstatus == false}"></i>
																	<input type="checkbox" data-ng-init = "setting_shipstatus=true" data-ng-model="setting_shipstatus" /> Status
																</label>
															</div>
														</div>
														<a type="button" class="btn btn-primary" onclick="location.href='downloadExcelForViewShpiment'; valid = true;">
															<i class="fa fa-file-excel-o fa-lg"></i>
														</a>
														<button type="submit" class="btn btn-primary"  data-ng-disabled = "ctrl.selected_shipment.length == 0" >
															<i class="fa fa-print fa-lg"></i>
														</button>
														
														<input type = "hidden" name = "shipment" value = "{{ctrl.selected_shipment}}"/>
	                                    				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													</form>
												</div>
											</div>
										</div>
									</div>



									<table class="table table-striped table-bordered table-hover"
										id="dataTables-example">
										<thead>
											<tr>
												<th><input type="checkbox" data-ng-click="ctrl.shipmentSelectall()" data-ng-model = "selectall" /></th>
												<th data-ng-show = "setting_shipdate">Date</th>
												<th data-ng-show = "setting_shiplrno">LR No</th>
												<th data-ng-show = "setting_shipprod">Product</th>
												<th data-ng-show = "setting_shiporigin">Origin</th>
												<th data-ng-show = "setting_shipdestinate">Destination</th>
												<th data-ng-show = "setting_shipsender">Sender</th>
												<th data-ng-show = "setting_shipconsignee">Consignee</th>
												<th data-ng-show = "setting_shipstatus">Status</th>

											</tr>
										</thead>
										<tbody>
											<tr data-ng-repeat="shipment in ctrl.FilterShipment | limitTo:pageSize"
												data-ng-dblclick = "ctrl.view1Shipmet(shipment)"
											>
												<td><input type="checkbox" data-ng-change="ctrl.shipmentSelect(shipment)" data-ng-model = "shipment.select" /></td>
												<td data-ng-show = "setting_shipdate">{{shipment.shipment_date.slice(0,-2)}}</td>
												<td data-ng-show = "setting_shiplrno">{{shipment.lrno_prefix}}</td>
												<td data-ng-show = "setting_shipprod">
													<div
														data-ng-repeat="shipmentDet in shipment.shipmentDetail">
														{{shipmentDet.product.product_name}}<span
															data-ng-if="!($last)">,</span>
													</div>
												</td>
												<td data-ng-show = "setting_shiporigin">{{shipment.sender_branch.branch_name}}</td>
												<td data-ng-show = "setting_shipdestinate">{{shipment.consignee_branch.branch_name}}</td>
												<td data-ng-show = "setting_shipsender">{{shipment.sender_customer.customer_name}}</td>
												<td data-ng-show = "setting_shipconsignee">{{shipment.consignee_customer.customer_name}}</td>
												<td data-ng-show = "setting_shipstatus">{{shipment.status}}</td>

											</tr>
										<tbody>
									</table>
 								<div class ="col-lg-6">
                                	<div class="pull-left">
                               			 Showing {{(currentPage*pageSize)+1}} to 
                               			 {{ (totalnof_records - (((currentPage+1)*pageSize))) > 0 ? (currentPage+1)*pageSize : totalnof_records }}
                               			 of {{totalnof_records}} entries
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