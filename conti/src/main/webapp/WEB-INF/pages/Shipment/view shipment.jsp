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
	<!-- ------------------------- VIEW SELECTED SHIPEMNT BEGIN ------------------ -----  -->
		<div class="shipment_View hideme">
			<!-- <div class = "row">
				<div class = "col-lg-12">
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default panelMarginBottom">
								<div class="panel-body customer-font">
									<b>Shipment</b>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div> -->
			
			
			
			<form name = "shipment" >		
      	    	<input type = "hidden" data-ng-model = "ctrl.shipment.shipment_id" />
      	    	
      		  <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default panelMarginBottom">                            
						
						<div class="panel-body customer-font">
							<div class = "col-lg-6"> <b>Shipment details</b> </div>
							<div class = "col-lg-6">
								<a data-ng-click = "ctrl.viewShipemntClose()"><i class="fa fa-times pull-right" aria-hidden="true"></i></a>
								<a class="btn btn-danger pull-right" data-ng-click = ""> <i class="fa fa-ban" aria-hidden="true"></i> Cancel </a>  
								<a class="btn btn-info pull-right" data-ng-click = ""> <i class="fa fa-print" aria-hidden="true"></i>  LR print </a>
								 
							</div>
						</div>
                        </div>
                    </div>
              </div>

           
              <div class="row">
              <div class="col-md-12">
              	  <div class="col-md-6">
		              
		               <b>LR No. : {{ctrl.shipment.lrno_prefix}}</b>            
		              
	              </div>
	              
	              <div class="col-md-6">
		              
		               <b>LR No. : {{ctrl.shipment.shipment_date}}</b>            
		              
	              </div>
	              
              </div>
              </div>
              
              <div class="row">
              
                
              	
              	<div class="col-md-12">
              		<div class="col-md-4">
              		</div>
              		<div class="col-md-4">
              		</div>
              		
              		<div class="col-md-1 branchclass paddingtop">
              			Shipment Date
              		</div>
              		
              		<div class="col-md-3 branchclass">            			 
                		                                        
                     
                      
                       		        <div class="form-group input-group">
				                  
				                  
				                               <input type="text" class="form-control datepicker marginLeftSpace" data-ng-model="ctrl.shipment.shipment_date"
				                               data-trigger="focus" data-toggle="popover" data-placement="top" data-ng-disabled = "true" required/>
	                                            <span class="input-group-addon" ><i class="fa fa-calendar" ></i>
	                                            </span>
	                                          
	                                          
	                               </div>
                        
              		</div>
              	</div>
              	
              	
              	
              	<div class="col-md-12">
              		<div class="col-md-4">
              		</div>
              		<div class="col-md-4">
              		</div>
              		<div class="col-md-4 branchclass">              			 
                			 <span class="text-paddingwidth">Payment Mode</span>	                	                                       
                             <select class="form-control" data-ng-options = "paymode for paymode in ['Cash','Credit']" data-ng-model = "ctrl.shipment.pay_mode" data-ng-change = "ctrl.changePaymentmode(ctrl.shipment.pay_mode)" 
                             data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please select payment mode" required>
                             	<option value="" disabled>--Select--</option>
                             	
                             </select>
                        
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
                            		
                            			<div class="col-md-6">
                            			</div>
                            			<div class=" col-md-6 branchclass">
	                            			<span class="searchcls"> Search </span>
	                            		    <!-- <input type="text" class="form-control searchbar" onKeyPress="return CheckIsNumeric(event)" maxlength = "10"
	                            		     data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please enter customer mobile number" placeholder="Mobile No"> -->
	                            		     
	                            		     <angucomplete-alt id="sender_search_mbl"
									              placeholder="Ex : 9876543210"
									              pause="100"
									              selected-object="sender_search_mbl"
									              remote-url="fetchAllCustomer4Search/"
						            			  remote_url-data-field="Customers"
									              match-class="highlight"
									              search-fields="customer_mobileno"
									              title-field="customer_mobileno"
									              minlength="5"
									              field-required="true"
												  data-trigger="focus" data-toggle="popover" 
												  data-placement="top" data-content="Please enter customer mobileno"
												  onKeyPress="return CheckIsNumeric(event)"
									              input-class="form-control form-control-small searchbar" style="width:100%">
              							</angucomplete-alt>
	                            		     
	                            		     
                            		    </div>
                            		
                            
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">From Branch</span>
                            		    <input type="text" class="form-control disabled" tabindex = "-1" id = "sender_branch_name" value = "${branch.branch_name}"/>                        		    
                            		    <input type="hidden" class="form-control" id = "sender_branch_id" value = "${branch.branch_id}"/>
                            		</div>
                            		
                            		<div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Name <span class="required">*</span></span>
                            		    <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.customer_name"
                            		    	onKeyPress="return CheckIsCharacterWithspace(event,this.value)"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer name"
											onKeyPress="return CheckIsNumeric(event)"	
											placeholder = "Ex: Sachin"
                            		    required />                            		    
                            		</div>
                            		
                       			    <div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Company Name </span>
                            		    <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.company_name"
                            		    	onKeyPress="return CheckIsCharacterWithspace(event,this.value)"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter company name"
											onKeyPress="return CheckIsNumeric(event)"	
											placeholder = "Ex: Pointdot"
                            		    />                            		    
                            		</div>
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Mobile Number <span class="required">*</span></span>
                            		    <input type="text" class="form-control" maxlength="10"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.customer_mobileno"
                            		    	onKeyPress="return CheckIsNumeric(event)"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer mobileno"
											onKeyPress="return CheckIsNumeric(event)"
											placeholder = "Ex: 9876543210"
                            		    required />  
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Address line1 <span class="required">*</span></span>
                            		   <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.customer_addressline1"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer address"
											placeholder = "Ex: #111, Kamaraj street"
                            		    required />                             		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Address line2 </span>
                            		   <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.customer_addressline2"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer address"
											placeholder = "Ex: NGO Colony, Landmark: post office opp."
                            		     />                             		    
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Location <span class="required">*</span></span>
                            		   <angucomplete-alt id="sender_location_name"
									              placeholder="Ex : Coimbatore"
									              pause="0"
									              remote-url="getLocation4emp/"
						             			  remote_url-data-field="Location"
						             			  selected-object="sender_location_name"
									              search-fields="location_name,pincode"
									              title-field="location_name,pincode"
												  match-class="highlight"
												  minlength="3"
	   											  data-trigger="focus" data-toggle="popover" 
	   											  data-placement="top" data-content="Please enter & select location"
	   											  onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" 
									              input-class="form-control" style="width:100%">
              							</angucomplete-alt>                          		    
                            		     
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">City</span> 
                            			<input type="text" class="form-control disabled" tabindex = "-1" id = "sender_city"/>
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">State</span> 
                            		    <input type="text" class="form-control disabled" tabindex = "-1" id = "sender_state"/>
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Country</span>
                            		    <input type="text" class="form-control disabled" tabindex = "-1" id = "sender_country"/>
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Pincode</span>
                            		    <input type="text" class="form-control disabled" tabindex = "-1" id = "sender_pincode"/>
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Email</span>
                            		    <input type="text" class="form-control" maxlength="30"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.customer_email"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer email address"
											placeholder = "Ex: sachin@gmail.com"
                            		    /> 
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">GSTIN Number</span>
                            		    <input type="text" class="form-control" maxlength="15"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.gstin_number"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer GSTIN no."
											onKeyPress="return CheckIsAlphaNumeric(event)"
											placeholder = "Ex: 11ABCDE1234F2Z5"
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
                        
                                        <div class="col-md-6">
                            			</div>
                            			<div class=" col-md-6 branchclass">
	                            			<span class="searchcls"> Search </span>
	                            		    <angucomplete-alt id="consignee_search_mbl"
									              placeholder="Ex : 9876543210"
									              pause="0"
									              selected-object="consignee_search_mbl"
									              remote-url="fetchAllCustomer4Search/"
						            			  remote_url-data-field="Customers"
									              match-class="highlight"
									              search-fields="customer_mobileno"
									              title-field="customer_mobileno"
									              minlength="5"
									              field-required="true"
												  data-trigger="focus" data-toggle="popover" 
												  data-placement="top" data-content="Please enter customer mobileno"
												  onKeyPress="return CheckIsNumeric(event)"
									              input-class="form-control form-control-small searchbar" style="width:100%">
              								</angucomplete-alt>
                            		    </div>
                          	
                          		   <div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">To Branch <span class="required">*</span></span>
                            		    <angucomplete-alt id="consignee_branch_name" 
								              placeholder="Ex : Coimbatore"
								              pause="0"
								              selected-object="consignee_branch_name"
								              remote-url="getBranch4Employee/"
								              remote_url-data-field="Branch"
								              search-fields="branch_name"
								              title-field="branch_name"
											  match-class="highlight"
								              minlength="3"
								              data-trigger="focus" data-toggle="popover" 
								              data-placement="top" data-content="Please enter & select branch name"
								              onKeyPress="return CheckIsCharacter(event)"
								              input-class="form-control form-control-small" style = "width: 100%">
		              					</angucomplete-alt>                          		    
                            		    
                            		</div>
                          	
                          	      <div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Name <span class="required">*</span></span>
                            		    <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.customer_name"
                            		    	onKeyPress="return CheckIsCharacterWithspace(event,this.value)"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer name"
											onKeyPress="return CheckIsNumeric(event)"	
											placeholder = "Ex: Dravid"
                            		    required />                            		    
                            		</div>
                            		
                        		   <div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Company Name </span>
                            		    <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.company_name"
                            		    	onKeyPress="return CheckIsCharacterWithspace(event,this.value)"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter company name"
											onKeyPress="return CheckIsNumeric(event)"	
											placeholder = "Ex: Pointdot"
                            		    />                            		    
                            		</div>
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Mobile Number <span class="required">*</span></span>
                            		    <input type="text" class="form-control" maxlength="10"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.customer_mobileno"
                            		    	onKeyPress="return CheckIsNumeric(event)"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer mobileno"
											onKeyPress="return CheckIsNumeric(event)"
											placeholder = "Ex: 9876543210"
                            		    required />  
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Address line1 <span class="required">*</span></span>
                            		   <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.customer_addressline1"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer address"
											placeholder = "Ex: #111, Kamaraj street"
                            		    required />                             		    
                            		    
                            		</div>
                            	
	                            	<div class="col-md-12 branchclass">
	                            			<span class="text-paddingwidth">Address line2 </span>
	                            		   <input type="text" class="form-control" maxlength="50"
	                            		    	data-ng-model = "ctrl.shipment.consignee_customer.customer_addressline2"
	                            		    	data-trigger="focus" data-toggle="popover" 
												data-placement="top" data-content="Please enter customer address"
												placeholder = "Ex: NGO Colony, Landmark: post office opp."
	                            		    />                             		    
	                            		    
	                            		</div>
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Location <span class="required">*</span></span>
                            		    <angucomplete-alt id="consignee_location_name"
									              placeholder="Ex : Coimbatore"
									              pause="0"
									              remote-url="getLocation4emp/"
						             			  remote_url-data-field="Location"
						             			  selected-object="consignee_location_name"
									              search-fields="location_name,pincode"
									              title-field="location_name,pincode"
												  match-class="highlight"
												  minlength="3"
	   											  data-trigger="focus" data-toggle="popover" 
	   											  data-placement="top" data-content="Please enter & select location"
	   											  onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" 
									              input-class="form-control" style="width:100%">
              							</angucomplete-alt>                       		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">City</span> 
                            			<input type="text" class="form-control disabled" tabindex = "-1" id = "consignee_city"/>
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">State</span> 
                            		    <input type="text" class="form-control disabled" tabindex = "-1" id = "consignee_state"/>
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Country</span>
                            		    <input type="text" class="form-control disabled" tabindex = "-1" id = "consignee_country"/>
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Pincode</span>
                            		    <input type="text" class="form-control disabled" tabindex = "-1" id = "consignee_pincode"/>
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Email</span>
                            		    <input type="text" class="form-control" maxlength="30"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.customer_email"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer email address"
											placeholder = "Ex: dravid@gmail.com"
                            		    />                            		    
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">GSTIN Number</span>
                            		     <input type="text" class="form-control" maxlength="15"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.gstin_number"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer GSTIN no."
											onKeyPress="return CheckIsAlphaNumeric(event)"
											placeholder = "Ex: 11ABCDE1234F2Z5"
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
                                                <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" data-ng-model = "ctrl.shipment.bill_to" value="Sender" data-ng-required = "true" data-ng-click = "ctrl.tax_payable()"><b>Sender</b>
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" data-ng-model = "ctrl.shipment.bill_to" value="Consignee" data-ng-required = "true" data-ng-click = "ctrl.tax_payable()"><b>Consignee</b>
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
	                            		    
	                            		    <div angucomplete-alt id="service_name" 
															maxlength="5"
															placeholder="Ex : Counter" 
															pause="0"											
															selected-object="service_name"
														    remote-url="getservice4Shipment/"
															remote-url-data-field="Service"
				             								title-field="service_name"
															match-class="highlight"
															minlength="1" 																						
														    maxlength="50"	
															input-class="form-control form-control-small"	
															onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)"									
    														data-trigger="focus" data-toggle="popover" 
			   											    data-placement="top" data-content="Please enter & select service"
															style="width:100%"
														    ></div>
	                            		    
	                            		</div>
	                            		<div class=" col-md-6 branchclass">
	                            			<span class="text-paddingwidth"> Status <span class="required">*</span></span>
	                            		   <select class="form-control" data-ng-options = "status for status in ['Booked']" data-ng-model = "ctrl.shipment.status"
				                             data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please select status" required>
				                           </select>                          		    
                            		    </div>
                                    </div>
                                    
                            		
                                    <div class="col-md-12">
                                    	<div class=" col-md-6 branchclass">
                            		    <span class="text-paddingwidth">No.of Parcel <span class="required">*</span></span>
	                            		    <input type="text" class="form-control" maxlength="4"
	                            		    	data-ng-model = "ctrl.shipment.numberof_parcel"
	                            		    	onKeyPress="return CheckIsNumeric(event)"
	                            		    	data-trigger="focus" data-toggle="popover" 
												data-placement="top" data-content="Please enter number of parcel"
												onKeyPress="return CheckIsNumeric(event)"
												placeholder = "Ex: 100"
												data-ng-keyup = "ctrl.checkQuantity(-1)"
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
                                            <th class = "text-center"></th>
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
                                            <td><input type="checkbox" class="form-control" data-ng-model = "product.selected"  /> </td>
                                            <td>{{$index + 1}}
	                                            <input type = "hidden" class="form-control" data-ng-model = "product.shipmentdetail_id" data-ng-value = "product_name.originalObject.product_id" /> 
                                            </td>
                                            <td> 
                                            	
                                            	<div angucomplete-alt id="product_name" data-ng-model = "product.product_name"
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
															
														    ></div>
                                            	<a href="" data-toggle="modal" data-target="#HSNmodal{{$index}}" id = "HSNmodal_a{{$index}}" data-toggle="tooltip" style="text-decoration: none !important;"> {{product.viewHSNDetail_link? product.shipmentHsnDetail.length+' HSN added' : 'Add HSN Details'}}</a>

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
											                                        		<th> </th>
											                                        		<th> S.NO </th>
											                                        		<th> HSN Code </th>
											                                        		<th> Description </th>
											                                        	</tr>
											                                        	</thead>
											                                        	
											                                        	<tbody>
											                                        		<tr data-ng-repeat = "hsn in product.shipmentHsnDetail track by $index">
											                                        			<td> <input type ="checkbox" data-ng-model = "hsn.selected" /> </td>
											                                        			<td> {{$index + 1}}  <input type="hidden" class="form-control" data-ng-model = "hsn.shipmenthsndetail_id" />  </td>
											                                        			<td> 
											                                        				
											                                        				<div angucomplete-alt id="{{'product' + $parent.$index +'_hsn_code' + $index}}" data-ng-model = "hsn.hsn_code"
																										maxlength="5"
																										placeholder="Ex : 336001" 
																										pause="0"											
																										selected-object="hsn_code"
																									    remote-url="getHSNCode4Search/"
																										remote-url-data-field="hsn_code"
															             								title-field="hsn_code"
																										match-class="highlight"
																										minlength="1" 																						
																									    maxlength="50"	
																										input-class="form-control form-control-small"	
																										></div>
											                                        				
											                                        			</td>
											                                        			<td> 
											                                        				<div angucomplete-alt id="{{'product'+ $parent.$index +'_hsn_description' + $index}}" data-ng-model = "hsn.hsn_description"
																										maxlength="5"
																										placeholder="Ex : bags" 
																										pause="0"											
																										selected-object="hsn_description"
																									    remote-url="getHSNDesc4Search/"
																										remote-url-data-field="hsn_description"
															             								title-field="hsn_description"
																										match-class="highlight"
																										minlength="1" 																						
																									    maxlength="50"	
																										input-class="form-control form-control-small"	
																										></div>
											                                        					
											                                        			</td>
											                                        		</tr>
											                                        	</tbody>
										                                        	</table>
																			 	</div>
																			 	<div class="col-lg-12">
																				 	<div class="col-lg-6">
																				 		
																				 	</div>
																				 	<div class="col-lg-6">
																					 	<a class="btn btn-primary pull-right"  data-ng-click = "ctrl.removeHSN($index)"><i class="fa fa-minus-circle fa-lg"></i></a>
																				 		<a class="btn btn-primary pull-right" data-ng-click = "ctrl.addHSN($index)"><i class="fa fa-plus-circle fa-lg"></i></a>
																				 	</div>
																			 	</div>
																			 	
																			 	<div class = "col-lg-12">
																			 			<!-- <a type="button" class="btn btn-danger pull-left" data-ng-click="ctrl.hsnCancel()" data-dismiss="modal"> <i class="fa fa-times"></i> Cancel</a> -->
																				 		<a type="button" class="btn btn-success" data-dismiss="modal"><i class="fa fa-floppy-o"></i> Save</a>
										                                            
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
                                            	<input type = "text" class="form-control disabled" tabindex = "-1" data-ng-model = "product.product_type"/> 
                                            </td>
                                            <td> <input type = "number" placeholder="Product height"  class="form-control" 

                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product height"
													data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="0.01"
													data-ng-model = "product.height" /> 
											</td>
                                            <td> <input type = "number" placeholder="Product width" class="form-control" 

                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product width"
													data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="0.01"
                                            		data-ng-model = "product.width" /> </td>
                                            <td> <input type = "number" placeholder="Product length" class="form-control" 

                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product length"
													data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="0.01"
                                            		data-ng-model = "product.length" /> </td>
                                            <td> <input type = "number" placeholder="Product weight" class="form-control" 

                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product weight"
													data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="0.01"
                                            		data-ng-model = "product.weight" data-ng-keyup = "ctrl.priceby_weight($index)" required/> </td>
                                            <td> <input type = "text" placeholder="Product weight" class="form-control" 
                                          			onkeypress="return CheckIsNumeric(event)"
                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product quantity"
													data-ng-model = "product.quantity" data-ng-keyup = "ctrl.checkQuantity($index)" required/> </td>
                                            <td> <input type = "number" placeholder="unit price" class="form-control" 
                                            
                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product price"
													data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="0.01"
                                            		data-ng-model = "product.unit_price" data-ng-keyup = "ctrl.calc_totalprice($index)" required/> </td>
                                            <td> <input type = "text" class="form-control disabled" tabindex = "-1" data-ng-model = "product.total_price" /> </td>
                                     
                                        </tr>
                                            
                                   </tbody>
                                </table>
                                
                            </div>                           
                          
                          <div class="col-lg-12">
                          
                                    <a class="btn btn-primary " data-ng-click = "ctrl.addProduct()" data-ng-disabled = "ctrl.disable_add_product"><i class="fa fa-plus-circle"></i></a>
							 		<a class="btn btn-primary " data-ng-click = "ctrl.removeProduct()"><i class="fa fa-minus-circle"></i></a>
							 		
										 		
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
                            		
                            			
                            		<!-- <div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Service </span>
                            		    <input type="text" class="form-control">                            		    
                            		</div> -->
                           
                            		
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Shipment Value <span class="required">*</span></span>
                            			
                            			<div class = "form-group input-group">
	                            		    <input type="number" class="form-control" min = "1" max="999999.99"
	                            		    	data-ng-model = "ctrl.shipment.shipment_value"
	                            		    	data-trigger="focus" data-toggle="popover" 
												data-placement="top" data-content="Please enter value of shipment"
												placeholder = "Ex: 100.50"
												data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="1.00"
												aria-describedby="basic-addon1"
	                            		    required />  
	                            		     <span class="input-group-addon" id = "basic-addon1"><i class="fa fa-inr" aria-hidden="true"></i></span>
                            		    </div>
                            		  
                            		</div>
<!--                             		 <div class="input-group input-group">
  <span class="input-group-addon" id="sizing-addon1">@</span>
  <input type="text" class="form-control" placeholder="Username" aria-describedby="sizing-addon1">
</div>                       		
           -->                  		  
                            		
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Reference Invoice No</span>
                            		    <input type="text" class="form-control" maxlength="15"
                            		    	data-ng-model = "ctrl.shipment.reference_invoice_no"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter reference invoice no."
											onKeyPress="return CheckIsAlphaNumeric(event)"
											placeholder = "Ex: 11ABCDE1234F2Z5"
                            		    />                               		    
                            		    
                            		</div>
                            
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Description</span>
                            		    <textarea class="form-control" data-ng-model = "ctrl.shipment.description"
                            		    maxlength = "100"
                            		    onkeypress="return CheckIsCharacterWithspace(event,this.value)"
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
	                            		    <input type="text" class="form-control disabled" 
	                            		    	data-ng-model = "ctrl.shipment.chargeable_weight" tabindex="-1"
	                            		    required />  
	                            		     <span class="input-group-addon">kg.</span>
                            		    </div>                           		    
                            		</div>
                            		
                           
                            	
                            	
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Delivery Charge </span>
                            			
                            			 <div class = "form-group input-group">
	                            		    <input type="text" class="form-control disabled" 
	                            		    	data-ng-model = "ctrl.shipment.delivery_charge" tabindex="-1"
	                            		    required />  
	                            		     <span class="input-group-addon"><i class="fa fa-inr" aria-hidden="true"></i></span>
                            		    </div>   
                            		  
                            		</div>
                            		
                            		
                            	
                            		<div class="col-md-6">
                            		
                            			<span class="text-paddingwidth discountspace ">Discount percentage</span>
                            		       <div class = "form-group input-group">
	                            		    <input type="number" class="form-control" min = "0" max = "100.00"
	                            		    	data-ng-model = "ctrl.shipment.discount_percentage"
	                            		    	data-trigger="focus" data-toggle="popover" 
												data-placement="top" data-content="Please enter discount %"
												placeholder = "Ex: 10.22%"
												data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="1.00"
												data-ng-keyup = "ctrl.calc_discount()"
	                            		     />  
	                            		     <span class="input-group-addon"> % </span>
                            		    </div>                              		    
                            		
                            	   </div> 
                            		
                            		<div class="col-md-6">
                            			<span class="text-paddingwidth">Discount amount</span>
                            		    
	                                    <div class = "form-group input-group">
	                            		    <input type="text" class="form-control disabled" 
	                            		    	data-ng-model = "ctrl.shipment.discount_amount" tabindex="-1"
	                            		    />  
	                            		     <span class="input-group-addon"><i class="fa fa-inr" aria-hidden="true"></i></span>
                            		    </div>                          		    
                            		    
                            		</div>                           		
                            		
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Handling Charge <span class="required">*</span></span>
                            		    <div class = "form-group input-group">
	                            		    <input type="number" class="form-control" min = "0" max = "999999.99"
	                            		    	data-ng-model = "ctrl.shipment.handling_charge"
	                            		    	data-trigger="focus" data-toggle="popover" 
												data-placement="top" data-content="Please enter handling charges"
												placeholder = "Ex: 10.22"
												data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="1.00"
												data-ng-keyup = "ctrl.calc_discount()"
	                            		    required />  
	                            		     <span class="input-group-addon"><i class="fa fa-inr" aria-hidden="true"></i></span>
                            		    </div> 
                            		</div>
                            		
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Tax payable on Reverse Charge <span class="required">*</span></span>
                            			     <select class="form-control" data-ng-options = "tax_payable for tax_payable in ['Yes', 'No']" data-ng-model = "ctrl.shipment.taxin_payable"
					                             data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please select tax payable on Reverse Charge"
					                             data-ng-change="ctrl.calc_discount()" required>
					                             <option value = "" disabled>---Select--</option>
					                           </select>	                            		   
                            		    
                            		</div>
                            		
                            		<div class="col-md-4">
                            		
                            			<span class="text-paddingwidth discountspace">CGST</span>
                            		       <div class = "form-group input-group">
	                            		    <input type="text" class="form-control disabled" 
	                            		    	data-ng-model = "ctrl.shipment.cgst"	                            		    	
												tabindex="-1"											
	                            		     />  
	                            		     <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
                            		    </div>                              		    
                            		
                            	   </div> 
                            		
                            		<div class="col-md-4">
                            			<span class="text-paddingwidth">SGST</span>
                            		                         		    
	                            		  <div class = "form-group input-group">
	                            		    <input type="text" class="form-control disabled" 
	                            		    	data-ng-model = "ctrl.shipment.sgst"	                            		    	
												tabindex="-1"											
	                            		     />  
	                            		     <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
                            		    </div>
                            		</div>
                            		
                            		<div class="col-md-4">
                            			<span class="text-paddingwidth ">IGST</span>
                            	
                            		       <div class = "form-group input-group">
	                            		    <input type="text" class="form-control disabled" 
	                            		    	data-ng-model = "ctrl.shipment.igst"	                            		    	
												tabindex="-1"											
	                            		     />  
	                            		     <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
                            		    </div>                      		    
                            		    
                            		</div>
                            	                        	
                            	
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Tax</span> 
                            			<div class = "form-group input-group">
                            		     <input type="text" class="form-control disabled" 
	                            		    	data-ng-model = "ctrl.shipment.tax"	                            		    	
												tabindex="-1"											
	                            		     />  
	                            		      <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
	                            		</div>                                		    
                            		    
                            		</div>
                            	
                            	
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Total Charges</span> 
                            			<div class = "form-group input-group">
                            		     <input type="text" class="form-control disabled" 
	                            		    	data-ng-model = "ctrl.shipment.total_charges"	                            		    	
												tabindex="-1"											
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
        
        
        
        
                      <div class="row">
                       <div class="col-lg-12">
                       
                       <div class="col-lg-6">
                       	<a type="button" class="btn btn-danger pull-right"><i class="fa fa-ban"></i>  Clear</a>
                       </div>
                       
                       <div class="col-lg-6">
                       	<button type="submit" class="btn btn-success" data-ng-disabled = " ctrl.disable_save"><i class="fa fa-floppy-o"></i>  Save</button>
                       </div>
                       </div>
                       </div>
                       
                       
                       <div class="row">
                       		<div class="col-md-12">
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
										<!-- <select class="form-control" data-ng-model = "ctrl.product_name"
											data-trigger= "focus"data-toggle="popover" data-placement="top"
					                        data-content="Please select product" 
										>
											<option>--Select--</option>
											
										</select> -->
										
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
														<!-- <ul class="dropdown-menu">
									<li><a href="#">Active</a></li>
									<li><a href="#">InActive</a></li>
									<li><a href="#">Archive</a></li>

								</ul> -->

													</div>


												</div>
											</div>

											<div class="col-xs-6 icons-button">
												<div class="pull-right">
													<button type="button" class="btn btn-primary">
														<i class="fa fa-cog fa-lg"></i>
													</button>
													<button type="button" class="btn btn-primary">
														<i class="fa fa-file-excel-o fa-lg"></i>
													</button>
													<button type="button" class="btn btn-primary">
														<i class="fa fa-print fa-lg"></i>
													</button>
												</div>
											</div>
										</div>
									</div>



									<table class="table table-striped table-bordered table-hover"
										id="dataTables-example">
										<thead>
											<tr>
												<th><input type="checkbox"></th>
												<th>Date</th>
												<th>LR No</th>
												<th>Product</th>
												<th>Origin</th>
												<th>Destination</th>
												<th>Sender</th>
												<th>Consignee</th>
												<th>Status</th>

											</tr>
										</thead>
										<tbody>
											<tr data-ng-repeat="shipment in ctrl.FilterShipment"
												data-ng-dblclick = "ctrl.view1Shipmet(shipment)"
											>
												<td><input type="checkbox"
													data-ng-model="shipment.select" /></td>
												<td>{{shipment.shipment_date}}</td>
												<td>{{shipment.lrno_prefix}}</td>
												<td>
													<div
														data-ng-repeat="shipmentDet in shipment.shipmentDetail">
														{{shipmentDet.product.product_name}}<span
															data-ng-if="!($last)">,</span>
													</div>
												</td>
												<td>{{shipment.sender_branch.branch_name}}</td>
												<td>{{shipment.consignee_branch.branch_name}}</td>
												<td>{{shipment.sender_customer.customer_name}}</td>
												<td>{{shipment.consignee_customer.customer_name}}</td>
												<td>{{shipment.status}}</td>

											</tr>
										<tbody>
									</table>

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