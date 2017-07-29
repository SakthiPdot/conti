<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib
    prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
<%@ page isELIgnored="false" %> 
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib
    prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
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
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css"> 
	
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	 <link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	 
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	 <link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
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


<body style="overflow-x:hidden;" data-ng-app = "contiApp" data-ng-controller = "ShipmentController as ctrl">
 
	 <jsp:include page="../Dashboard/nav.jsp"/>
	
	
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
              <div class="col-md-12 col-sm-12 col-xs-12">
              	  <div class="col-md-6 col-sm-6 col-xs-6 GenLeftRight">
	              <div  class="subHead">
	               <b>Branch Name : ${branch.branch_name}</b>            
	              </div>
	              
	              <div  class="subHead">               
	              <b>${title}</b>
	              </div>
	              </div>
	              
	              <div class="col-md-2">
	              </div>
	              
	              <div class="col-md-3 col-sm-4 col-xs-6">	              
	               <c:if test="${ lrno > 0 }"> <b>Last LR No : lrno   </b></c:if>     
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
                            		    required />                             		    
                            		    
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
                            		    required /> 
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">GSTIN Number</span>
                            		    <input type="text" class="form-control" maxlength="15"
                            		    	data-ng-model = "ctrl.shipment.sender_customer.gstin_number"
                            		    	onKeyPress="return CheckIsNumeric(event)"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer GSTIN no."
											onKeyPress="return CheckIsAlphaNumeric(event)"
											placeholder = "Ex: 11ABCDE1234F2Z5"
                            		    required />                               		    
                            		    
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
	                            		    required />                             		    
	                            		    
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
                            		    required />                            		    
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">GSTIN Number</span>
                            		     <input type="text" class="form-control" maxlength="15"
                            		    	data-ng-model = "ctrl.shipment.consignee_customer.gstin_number"
                            		    	onKeyPress="return CheckIsNumeric(event)"
                            		    	data-trigger="focus" data-toggle="popover" 
											data-placement="top" data-content="Please enter customer GSTIN no."
											onKeyPress="return CheckIsAlphaNumeric(event)"
											placeholder = "Ex: 11ABCDE1234F2Z5"
                            		    required />                              		    
                            		    
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
                                                <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" data-ng-model = "ctrl.shipment.bill_to" value="Sender" data-ng-disabled= "ctrl.shipment.pay_mode=='Credit'" data-ng-required = "!ctrl.shipment.bill_to"><b>Sender</b>
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" data-ng-model = "ctrl.shipment.bill_to" value="Consignee" data-ng-disabled= "ctrl.shipment.pay_mode=='Credit'" data-ng-required = "!ctrl.shipment.bill_to" ><b>Consignee</b>
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
                                    	<div class=" col-md-6 branchclass">
	                            			<span class="text-paddingwidth"> Status <span class="required">*</span></span>
	                            		   <select class="form-control" data-ng-options = "status for status in ['Booked']" data-ng-model = "ctrl.shipment.status"
				                             data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please select status" required>
				                           </select>                          		    
                            		    </div>
	                            		<div class="col-md-6">
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
                                            <th><input type="checkbox"></th>
                                            <th>S.No</th>
                                            <th>Product</th>
                                            <th>Product Type</th>                                        
                                            <th colspan="3">Dimensions(cm)</th>
                                            <th>Weight(Kg)</th>
                                            <th>Quantity</th>
                                            <th>Unit Price</th>
                                            <th>Total Price</th>
                                        </tr>
                                        
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat = "product in ctrl.products track by $index">
                                            <td><input type="checkbox" data-ng-model = "product.selected" ></td>
                                            <td>{{$index + 1}} <input type = "text" data-ng-model = "product.product_id" /> </td>
                                            <td> <input type = "text" data-ng-model = "product.product_name" /> </td>
                                            <td> <input type = "text" data-ng-model = "product.product_type" /> </td>
                                            <td> <input type = "text" data-ng-model = "product.product_height" /> </td>
                                            <td> <input type = "text" data-ng-model = "product.product_width" /> </td>
                                            <td> <input type = "text" data-ng-model = "product.product_length" /> </td>
                                            <td> <input type = "text" data-ng-model = "product.product_weight" /></td>
                                            <td> <input type = "text" data-ng-model = "product.product_quantity" /> </td>
                                            <td> <input type = "text" data-ng-model = "product.product_unitprice" /> </td>
                                            <td> <input type = "text" data-ng-model = "product.product_totalprice" /> </td>
                                     
                                        </tr>
                                        <tr>
                                            <td colspan = "11"> <a href="" data-toggle="modal" data-target="#myModal" style="text-decoration: none !important;"> Add HSN Details</a></td>                                        	
                                        </tr>
                                        
                                   </tbody>
                                </table>
                            </div>                           
                          
                          <div class="col-lg-12">
                          
                                    <button class="btn btn-primary " data-ng-click = "ctrl.addProduct()"><i class="fa fa-plus-circle"></i></button>
							 		<button class="btn btn-primary " data-ng-click = "ctrl.removeProduct()"><i class="fa fa-minus-circle"></i></button>
							 		
										 		
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
                            		
                            			
                            		<div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Service </span>
                            		    <input type="text" class="form-control">                            		    
                            		</div>
                            		
                           
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Shipment Value</span>
                            		    <input type="text" class="form-control" >                            		    
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Reference Invoice No</span>
                            		    <input type="text" class="form-control" >                            		    
                            		    
                            		</div>
                            
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Description</span>
                            		    <textarea class="form-control" rows="8"> </textarea>                           		    
                            		    
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
                        
                          	
                          	       <div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Chargeable Weight </span>
                            		    <input type="text" class="form-control">                            		    
                            		</div>
                            		
                           
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Delivery Charge</span>
                            		    <input type="text" class="form-control" >                            		    
                            		    
                            		</div>
                            		
                            		
                            	
                            		<div class="col-md-6 branchclass">
                            		
                            			<span class="text-paddingwidth discountspace ">Discount</span>
                            		      
                            		       <div class="form-group input-group discountval">
					                              <input type="text" class="form-control  marginLeftSpace " 
					                                 data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of birth" required/>
		                                            <span class="input-group-addon">%</span>
		                                          
		                                          
		                                   </div>                            		    
                            		
                            	   </div> 
                            		
                            		<div class="col-md-6 branchclass">
                            			<span class="text-paddingwidth">Discount.Amount</span>
                            		   
                            		   <div class="form-group input-group discountamount">
				                            
				                            <input type="text" class="form-control " data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of birth" disabled required/>
	                                            <span class="input-group-addon" ><i class="fa fa-inr"></i></span>
	                                          
	                                          
	                                    </div>                        		    
                            		    
                            		</div>                           		
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Handling Charge</span>
                            		    <input type="text" class="form-control">                            		    
                            		    
                            		</div>
                            	
                            	    <div class="col-md-6 branchclass">
                            			<span class="text-paddingwidth discountspace">CGST</span>                            		
                            		    
                            		       <div class="form-group input-group gstval">
				                                <input type="text" class="form-control" 
				                                     data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of birth" disabled required/>
	                                            <span class="input-group-addon" ><i class="fa fa-inr"></i></span>
	                                      </div>                         		    
                            		    
                            		</div>
                            		
                            		
                            		<div class="col-md-3 branchclass">
                            			<span class="text-paddingwidth">SGST</span>
                            		                         		    
	                            		    <div class="form-group input-group sgstval">
					                            <input type="text" class="form-control" 
					                               data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of birth" disabled required/>
		                                            <span class="input-group-addon" ><i class="fa fa-inr"></i></span>
		                                    </div>  
                            		</div>
                            		
                            		<div class="col-md-3 branchclass">
                            			<span class="text-paddingwidth ">IGST</span>
                            	
                            		       <div class="form-group input-group igstval">
				                             
				                              <input type="text" class="form-control" 
				                                data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of birth" disabled required/>
	                                            <span class="input-group-addon" ><i class="fa fa-inr"></i></span>
	                                    
	                                     </div>                         		    
                            		    
                            		</div>
                            	                        	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Tax</span> 
                            		    <input type="text" class="form-control">                            		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Total Charges</span> 
                            		    <input type="text" class="form-control" >                            		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		                        	
                        </div>
                    
                    </div>
                </div>
                
            </div>
            
                
             </div>
        
        
        
        
                      <div class="row">
                       <div class="col-lg-12">
                       
                       <div class="col-lg-6">
                       	<button type="button" class="btn btn-danger pull-right"><i class="fa fa-ban"></i>  Clear</button>
                       </div>
                       
                       <div class="col-lg-6">
                       	<button type="button" class="btn btn-success"><i class="fa fa-floppy-o"></i>  Save</button>
                       </div>
                       </div>
                       </div>
                       
                       
                       <div class="row">
                       		<div class="col-md-12">
                       		</div>
                       </div>
             
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                    
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">HSN Details</h4>
                                        </div>
                                        
                                        <div class="modal-body hsn-modal">
										 	<div class="col-lg-6">
										 		<span> HSN Code</span>
												<input type="text" class="form-control">
										 	</div>
										 	<div class="col-lg-6">
										 		<span> Description</span>
												<input type="text" class="form-control">
										 	</div>
										 	
										 	<div class="col-lg-6">
										 		
										 	</div>
										 	<div class="col-lg-6">
										 		<button class="btn btn-primary pull-right"><i class="fa fa-minus-circle fa-lg"></i></button>
										 		<button class="btn btn-primary pull-right"><i class="fa fa-plus-circle fa-lg"></i></button>
										 		
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
        </div>
        <!-- /. PAGE WRAPPER  -->
		
		
    
    <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
  <script src="resources/custom/js/shipment/shipment_controller.js"></script>
  <script src="resources/custom/js/shipment/shipment_service.js"></script>
  <script src="resources/custom/js/branch_master/branch_service.js"></script>
  <script src="resources/custom/js/custom.js"></script>
  <script src="resources/custom/js/confirmDialog.js"></script>   
  <script type="text/javascript" src="resources/custom/js/validation.js"></script>

<script>
	$('[data-toggle="popover"]').popover();
</script>
</body>

</html>