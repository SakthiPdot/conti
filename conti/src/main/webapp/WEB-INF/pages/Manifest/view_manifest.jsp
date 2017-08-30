<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ taglib
    prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
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
									<a class="btn btn-danger" data-ng-click = "ctrl.shipmentCancel(ctrl.shipment)"> <i class="fa fa-ban" aria-hidden="true"></i> Cancel </a>
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
		              
		               <b class = "pull-right">Shipment Date. : {{ctrl.shipment.shipment_date}}</b>            
		              
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
										<span class="text-padding">From</span> 
										<select
											class="form-control"
											data-ng-options="branch.branch_id as branch.branch_name for branch in ctrl.branches"
											data-ng-model="ctrl.manifest.frombranch">
<!-- 											data-ng-disabled = "ctrl.fromBranch_disable == true" > -->
											<option value="" disabled>--Select--</option>
										</select>
									</div>
									<div class="col-lg-3 branchclass">
										<span class="text-padding">To</span> <select
											class="form-control"
											data-ng-options="branch.branch_id as branch.branch_name for branch in ctrl.branches"
											data-ng-model="ctrl.manifest.tobranch">
											<option value=''>--Select--</option>

										</select>
									</div>
								</div>
								 <input type="hidden" id="branch_id" value="${branch_id}" />
									<input type = "hidden" id = "currentUserRole" value = "<sec:authentication property="principal.authorities[0]"/>" />

								<div class="col-lg-12 noPaddingLeft">
									<div class="sec-padding">Specific Period</div>

									<div class="col-lg-3 branchclass">
										<span class="text-padding">From </span>
										<div class="form-group input-group ">
											<input type="text" class="form-control datepicker1"
												data-ng-model="ctrl.manifest.fromdate" data-trigger="focus"
												data-toggle="popover" data-placement="top"
												data-content="Please select from date" /> <span
												class="input-group-addon"><i class="fa fa-calendar"></i></span>
										</div>
									</div>

									<div class="col-lg-3 branchclass">
										<span class="text-padding">To</span>
										<div class="form-group input-group ">
											<input type="text" class="form-control datepicker2"
												data-ng-model="ctrl.manifest.todate" data-trigger="focus"
												data-toggle="popover" data-placement="top"
												data-content="Please select to date" /> <span
												class="input-group-addon"><i class="fa fa-calendar"></i>
											</span>

										</div>
									</div>

									<div class="col-lg-2"></div>
									<div class="col-lg-4 branchclass">
										<button class="btn btn-primary"
											data-ng-click="ctrl.manifestFilter()">
											View Manifest</button>
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

													<form name="manifestPrint" method="POST"
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