<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page isELIgnored="false" %> 
<%@page session="true"%>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
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
	
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	 <link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	 
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	 <link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
	 <link href="resources/custom/css/custom.css" rel="stylesheet">
	 <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">
	 
	 <link href="resources/custom/css/demo.css" rel="stylesheet">
 <link rel="icon" type="image/gif/png" href="resources/Image/conti_logo.png">
	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script type="text/javascript" src="resources/built-in/js/lodash.js"></script> 
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <script src="resources/custom/js/app.js"></script>
</head>


<body style="overflow-x:hidden;" data-ng-app = "contiApp" data-ng-controller = "ShipmentController as ctrl">
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

<!-- ------------------------- Failure message begin ------------------ -----  -->	

<!-- ------------------------- Failure message end ------------------ -----  -->

	 <jsp:include page="../Dashboard/nav.jsp"/>
	
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
           
      	    <form name = "shipment" data-ng-submit = "ctrl.submit()" >		
      	    	<input type = "hidden" data-ng-model = "ctrl.shipment.shipment_id" />
      	    	<input type="hidden" id="lr_number" value = "${lrno}" />
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
              <div class="col-md-12 col-sm-12 col-xs-12">
              	  <div class="col-md-6 col-sm-6 col-xs-6 ">
	              <div  class="subHead">
	               <b>Branch Name : ${branch.branch_name}</b>      
	                 
	              </div>
	              
	              <div  class="subHead">               
	              <b>${title}</b>
	              </div>
	              </div>
	              
	              <!-- <div class="col-md-5">
	              </div> -->
	              
	              <div class="col-md-6 col-sm-6 col-xs-6">	
	              <div  class="subHead pull-right">              
	               <c:if test="${ lrno > 0 }"> <b>Last LR No : <span style = "color : #0b67af;">{{maxlrno}}</span>   </b></c:if>    
	               </div> 
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
									              placeholder="Ex : 9876543210 / Sachin"
									              pause="100"
									              selected-object="sender_search_mbl"
									              remote-url="fetchAllCustomer4Search/"
						            			  remote_url-data-field="Customers"
									              match-class="highlight"
									              search-fields="customer_name,customer_mobileno"
									              title-field="customer_mobileno"
									              description-field="customer_name"
									              minlength="3"
									              field-required="true"
												  data-trigger="focus" data-toggle="popover" 
												  data-placement="top" data-content="Please enter customer mobileno"
												  
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
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer name"
											placeholder = "Ex: Sachin"
                            		    required />                            		    
                            		</div>
                            		
                       			    <div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Company Name </span>
                            		    <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.company_name"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter company name"
											placeholder = "Ex: Conti Cargo"
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
                            			<span class="text-paddingwidth">Address line1 <!-- <span class="required">*</span> --></span>
                            		   <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.customer_addressline1"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer address"
											placeholder = "Ex: #111, Kamaraj street"
                            		     />                             		    
                            		    
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
                            			<span class="text-paddingwidth">Location <!-- <span class="required">*</span> --></span>
                            		   <angucomplete-alt id="sender_location_name"
									              placeholder="Ex : Coimbatore"
									              pause="0"
									              remote-url="getLocation4emp/"
						             			  remote_url-data-field="Location"
						             			  selected-object="sender_location_name"
									              search-fields="location_name,pincode"
									              title-field="location_name"
									              description-field="pincode"
												  match-class="highlight"
												  minlength="3"
	   											  data-trigger="focus" data-toggle="popover" 
	   											  data-placement="top" data-content="Please enter & select location"
	   											  onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" 
									              input-class="form-control" style="width:100%">
              							</angucomplete-alt>                          		    
                            		     
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">City <span class="required">*</span></span> 
                            			<!-- <input type="text" class="form-control disabled" tabindex = "-1" id = "sender_city"/> -->
                            		     <angucomplete-alt id="sender_city"
									              placeholder="Ex : Coimbatore"
									              pause="0"
									              remote-url="getCity4Ship/"
						             			  remote_url-data-field="city"
						             			  selected-object="sender_city"
									              search-fields="city"
									              title-field="city"
									              description-field="state"
												  match-class="highlight"
												  minlength="3"
	   											  data-trigger="focus" data-toggle="popover" 
	   											  data-placement="top" data-content="Please enter & select city"
	   											  onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" 
									              input-class="form-control" style="width:100%">
              							</angucomplete-alt>   
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
                            		    <input type="email" class="form-control" maxlength="30"
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
									              placeholder="Ex : 9876543210 / Sachin"
									              pause="0"
									              selected-object="consignee_search_mbl"
									              remote-url="fetchAllCustomer4Search/"
						            			  remote_url-data-field="Customers"
									              match-class="highlight"
									              search-fields="customer_name,customer_mobileno"
									              title-field="customer_mobileno"
									              description-field="customer_name"
									              minlength="3"
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
								              remote-url="getBranch4shipment/"
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
                            		    	
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer name"
												
											placeholder = "Ex: Dravid"
                            		    required />                            		    
                            		</div>
                            		
                        		   <div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Company Name </span>
                            		    <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.company_name"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter company name"
											placeholder = "Ex: Conti Cargo"
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
                            			<span class="text-paddingwidth">Address line1 <span class="required" data-ng-show="ctrl.serviceDoor">*</span></span>
                            		   <input type="text" class="form-control" maxlength="50"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.customer_addressline1"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer address"
											placeholder = "Ex: #111, Kamaraj street"
                            		    data-ng-required="ctrl.serviceDoor" />                             		    
                            		    
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
                            			<span class="text-paddingwidth">Location <span class="required" data-ng-show="ctrl.serviceDoor">*</span></span>
                            		    <angucomplete-alt id="consignee_location_name"
									              placeholder="Ex : Coimbatore"
									              pause="0"
									              remote-url="getLocation4emp/"
						             			  remote_url-data-field="Location"
						             			  selected-object="consignee_location_name"
									              search-fields="location_name,pincode"
									              title-field="location_name"
									              description-field="pincode"
												  match-class="highlight"
												  minlength="3"
	   											  data-trigger="focus" data-toggle="popover" 
	   											  data-placement="top" data-content="Please enter & select location"
	   											  onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" 
									              input-class="form-control" style="width:100%">
              							</angucomplete-alt>                       		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">City <span class="required" data-ng-show="!ctrl.serviceDoor">*</span></span> 
                            			<!-- <input type="text" class="form-control disabled" tabindex = "-1" id = "consignee_city"/> -->
                            		     <angucomplete-alt id="consignee_city"
									              placeholder="Ex : Coimbatore"
									              pause="0"
									              remote-url="getCity4Ship/"
						             			  remote_url-data-field="city"
						             			  selected-object="consignee_city"
									              search-fields="city"
									              title-field="city"
									              description-field="state"
												  match-class="highlight"
												  minlength="3"
	   											  data-trigger="focus" data-toggle="popover" 
	   											  data-placement="top" data-content="Please enter & select city"
	   											  onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" 
									              input-class="form-control" style="width:100%">
              							</angucomplete-alt>   
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
                            		    <input type="email" class="form-control" maxlength="30"
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
                                                <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" data-ng-model = "ctrl.shipment.bill_to" value="Paid" data-ng-required = "true" data-ng-click = "ctrl.tax_payable()"><b>Paid</b>
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" data-ng-model = "ctrl.shipment.bill_to" value="To Pay" data-ng-checked = "ctrl.shipment.pay_mode == 'Credit'" data-ng-required = "true" data-ng-click = "ctrl.tax_payable()"><b>To Pay</b>
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
	                            		    
	                            		     <!-- <div angucomplete-alt id="service_name" 
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
														    ></div> --> 
														    
														    <select class="form-control" data-ng-options = "service as service.service_name for service in ctrl.services" 
														     		data-ng-model = "ctrl.shipment.service"
				                             						data-trigger="focus" data-toggle="popover" data-placement="top" 
				                             						data-ng-change = "ctrl.statusChange(ctrl.shipment.service)"
				                             						data-content="Please select service" required>
				                             						<option value ="" disabled>--Select--</option>
				                         				 	 </select> 
	                            		    
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
                                            <th class = "text-center" style="color:#FFF;">select</th>
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
                                            <td><input type="checkbox" style ="width:40%;" class="form-control" data-ng-model = "product.selected"  /> </td>
                                            <td>{{$index + 1}}
	                                            <input type = "hidden" class="form-control" data-ng-model = "product.shipmentdetail_id" data-ng-value = "product_name.originalObject.product_id" /> 
                                            </td>
                                            <td> 
                                            	
                                            	<div angucomplete-alt id="product_name{{$index}}" data-ng-model = "product.product_name"
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
                                            <td> <!-- <input type = "number" placeholder="Product height"  class="form-control" 
                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product height"
													data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="0.01"
													data-ng-model = "product.height" />  -->
													<input type = "text" placeholder="Product height"  class="form-control" 
	                                            		data-trigger="focus" data-toggle="popover" 
				   										data-placement="top" data-content="Please enter product height"
														maxlength="5" onKeyPress="return CheckIsNumericAnddot(event,this.value)"
														data-ng-model = "product.height" /> 	
													
											</td>
                                            <td> <!-- <input type = "number" placeholder="Product width" class="form-control" 

                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product width"
													data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="0.01"
                                            		data-ng-model = "product.width" /> -->
                                            		<input type = "text" placeholder="Product width" class="form-control" 

                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product width"
													maxlength="5" onKeyPress="return CheckIsNumericAnddot(event,this.value)"
                                            		data-ng-model = "product.width" /> </td>
                                            <td> <!-- <input type = "number" placeholder="Product length" class="form-control" 

                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product length"
													data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="0.01"
                                            		data-ng-model = "product.length" /> --> 
                                            		<input type = "text" placeholder="Product length" class="form-control" 
                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product length"
													maxlength="5" onKeyPress="return CheckIsNumericAnddot(event,this.value)"
                                            		data-ng-model = "product.length" /></td>
                                            <td> <!-- <input type = "number" placeholder="Product weight" class="form-control" 

                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product weight"
													data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="0.01"
                                            		data-ng-model = "product.weight" data-ng-keyup = "ctrl.priceby_weight($index)" required/> -->
                                            		<input type = "text" placeholder="Product weight" class="form-control" 

                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product weight"
													maxlength="5" onKeyPress="return CheckIsNumericAnddot(event,this.value)"
                                            		data-ng-model = "product.weight" data-ng-keyup = "ctrl.priceby_weight($index)" required/> </td>
                                            <td> <input type = "text" placeholder="Product weight" class="form-control" 
                                          			onkeypress="return CheckIsNumeric(event)"
                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product quantity"
													data-ng-model = "product.quantity" data-ng-keyup = "ctrl.checkQuantity($index)" required/>
													 </td>
                                            <td> <!-- <input type = "number" placeholder="unit price" class="form-control" 
                                            
                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product price"
													data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="0.01"
                                            		data-ng-model = "product.unit_price" data-ng-keyup = "ctrl.calc_totalprice($index)" required/> -->
                                            		<input type = "text" placeholder="unit price" class="form-control" 
                                            
                                            		data-trigger="focus" data-toggle="popover" 
			   										data-placement="top" data-content="Please enter product price"
													maxlength="10" onKeyPress="return CheckIsNumericAnddot(event,this.value)"
                                            		data-ng-model = "product.unit_price" data-ng-keyup = "ctrl.calc_totalprice($index)" required/>
                                            		 </td>
                                            <td> <input type = "text" class="form-control" data-ng-model = "product.total_price" data-ng-disabled = "true"/> </td>
                                     
                                        </tr>
                                            
                                   </tbody>
                                </table>
                                
                            </div>                           
                          
                          <div class="col-lg-12">
                          
                                    <a class="btn btn-primary" data-ng-click = "ctrl.addProduct()" data-ng-disabled = "ctrl.disable_add_product"><i class="fa fa-plus-circle"></i></a>
							 		<a class="btn btn-primary " id="addprod" data-ng-click = "ctrl.removeProduct()"><i class="fa fa-minus-circle"></i></a>
							 		
										 		
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
                            			<span class="text-paddingwidth">Shipment Value </span>
                            			
                            			<div class = "form-group input-group">
	                            		    <!-- <input type="number" class="form-control" min = "1" max="999999.99"
	                            		    	data-ng-model = "ctrl.shipment.shipment_value"
	                            		    	data-trigger="focus" data-toggle="popover" 
												data-placement="top" data-content="Please enter value of shipment"
												placeholder = "Ex: 100.50"
												data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="0.01"
												aria-describedby="basic-addon1"
												onKeyPress="return CheckIsNumericAnddot(event,this.value)"
	                            		     />  --> 
	                            		     <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.shipment_value"
	                            		    	data-trigger="focus" data-toggle="popover" 
												data-placement="top" data-content="Please enter value of shipment"
												placeholder = "Ex: 100.50"												
												aria-describedby="basic-addon1"
												maxlength="10"
												onKeyPress="return CheckIsNumericAnddot(event,this.value)"
	                            		     /> 
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
                            		    	style="height: 321px;width: 100%;"
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
	                            		    	data-ng-model = "ctrl.shipment.chargeable_weight" data-ng-disabled="true"
	                            		    required />  
	                            		     <span class="input-group-addon">kg.</span>
                            		    </div>                           		    
                            		</div>
                            		
                           
                            	
                            	
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Delivery Charge </span>
                            			
                            			 <div class = "form-group input-group">
	                            		    <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.delivery_charge" data-ng-disabled="true"
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
												data-ng-pattern="/^[0-9]+(\.[0-9]{1,2})?$/" step="0.01"
												data-ng-keyup = "ctrl.calc_discount()"
	                            		     />  
	                            		     <span class="input-group-addon"> % </span>
                            		    </div>                              		    
                            		
                            	   </div> 
                            		
                            		<div class="col-md-6">
                            			<span class="text-paddingwidth">Discount amount</span>
                            		    
	                                    <div class = "form-group input-group">
	                            		    <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.discount_amount" data-ng-disabled="true"
	                            		    />  
	                            		     <span class="input-group-addon"><i class="fa fa-inr" aria-hidden="true"></i></span>
                            		    </div>                          		    
                            		    
                            		</div>                           		
                            		
                            		<!-- <div class="col-md-12">
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
                            		</div> -->
                            		
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
	                            		    <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.cgst"	                            		    	
												data-ng-disabled="true"											
	                            		     />  
	                            		     <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
                            		    </div>                              		    
                            		
                            	   </div> 
                            		
                            		<div class="col-md-4">
                            			<span class="text-paddingwidth">SGST</span>
                            		                         		    
	                            		  <div class = "form-group input-group">
	                            		    <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.sgst"	                            		    	
												data-ng-disabled="true"											
	                            		     />  
	                            		     <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
                            		    </div>
                            		</div>
                            		
                            		<div class="col-md-4">
                            			<span class="text-paddingwidth ">IGST</span>
                            	
                            		       <div class = "form-group input-group">
	                            		    <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.igst"	                            		    	
												data-ng-disabled="true"					
	                            		     />  
	                            		     <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
                            		    </div>                      		    
                            		    
                            		</div>
                            	                        	
                            	
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Tax</span> 
                            			<div class = "form-group input-group">
                            		     <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.tax"	                            		    	
												data-ng-disabled="true"										
	                            		     />  
	                            		      <span class="input-group-addon"> <i class="fa fa-inr"></i> </span>
	                            		</div>                                		    
                            		    
                            		</div>
                            	
                            	
                            		<div class="col-md-12">
                            			<span class="text-paddingwidth">Net freight Charges</span> 
                            			<div class = "form-group input-group">
                            		     <input type="text" class="form-control" 
	                            		    	data-ng-model = "ctrl.shipment.total_charges"	                            		    	
												data-ng-disabled="true"										
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
        </div>
       
        <!-- /. PAGE WRAPPER  -->
		
		
    
    <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
  <script src="resources/custom/js/shipment/shipment_controller.js"></script>
  <script src="resources/custom/js/shipment/shipment_service.js"></script>
  <script src="resources/custom/js/branch_master/branch_service.js"></script>
  <script src="resources/custom/js/service_master/service_service.js"></script>
  <script src="resources/custom/js/price_setting/s_price_setting_service.js"></script>
  <script src="resources/custom/js/CompanySetting/company_setting_service.js"></script>
  <script src="resources/custom/js/custom.js"></script>
  <script src="resources/custom/js/confirmDialog.js"></script>   
  <script type="text/javascript" src="resources/custom/js/validation.js"></script>

<script>
$('[data-toggle="popover"]').popover();
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();   
});
</script>
<script>
var elements = document.querySelectorAll('input,select,textarea');

for (var i = elements.length; i--;) {
    elements[i].addEventListener('invalid', function () {
        this.scrollIntoView(false);
    });
}
</script>

</body>

</html>