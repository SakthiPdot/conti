<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <link href="resources/built-in/assets/css/font-awesome.min.css" rel="stylesheet" />	
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- Custom Styles-->
    <link href="resources/built-in/assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css">    
 	<link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
 	<link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
  	<link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">	  
 	<link href="resources/custom/css/custom.css" rel="stylesheet">
 	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <script src="resources/custom/js/app.js"></script>
	</head>


<body style="overflow-x:hidden;"
data-ng-app="contiApp"
data-ng-controller="priceSettingController as psctrl">
	<jsp:include page="../Dashboard/settings_nav.jsp"/>
	
 	<form data-ng-submit="psctrl.submit()" class="formBottom" name="priceSettingForm">
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      		  <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">                            
						<div class="panel-body customer-font">
						<b>${title}</b>
						</div>
                        </div>
                    </div>
                </div>

			<div class="row customer-field">
				<div class="col-lg-12">
					<div class="col-lg-8 col-lg-offset-2">

						<div class="panel panel-default">
							<div class="panel-body">
								<div class="col-lg-6 col-xs-12">

									<span>From Branch</span> 

  									 <div angucomplete-alt id="selectedBranch"
											placeholder="Ex : Coimbatore" pause="0"											
											selected-object="branch_name"
										    remote-url="getBranchByStr/"
											remote-url-data-field="Branch"
             								title-field="branch_name"
											match-class="highlight"
											minlength="1" 
											input-class="form-control form-control-small"										
										    ></div>
										
										<input type="hidden" id="fromBranch" data-ng-model="self.priceSetting.branch" />  			
										    <!-- description-field="branch_code" -->
									
								    <span>Service</span> 
									<div angucomplete-alt id="selectedService"
											placeholder="Ex : Door Delivery" pause="0"											
											selected-object="service_name"
										    remote-url="getServiceByStr/"
											remote-url-data-field="Service"
             								title-field="service_name"
											match-class="highlight"
											minlength="1" 											
											input-class="form-control form-control-small"										
										    ></div>
										
									
									<input type="hidden" id="service" data-ng-model="self.priceSetting.service" />     
										    
										    
									 <span>Product</span> 
									<div angucomplete-alt id="selectedProduct"
											placeholder="Ex : Box (Large)" pause="0"											
											selected-object="product_name"
										    remote-url="getProductByStr/"
											remote-url-data-field="Product"
             								title-field="product_name"
											match-class="highlight"
											minlength="1" 
											input-class="form-control form-control-small"										
										    ></div>
										
										
									<input type="hidden" id="product" data-ng-model="self.priceSetting.product" />  
										
									<span>Product Type</span> 
									
									
									       	 <div angucomplete-alt
							 					 id="selectedProductType" 
									              placeholder="Ex : Coimbatore"
									              pause="0"		 data-ng-required="true"
		                  						 data-trigger="focus" data-toggle="popover"
							 					  data-placement="top" data-content="Please Enter Product Type"	
									              selected-object="city_name"
									              local-data=""
									              search-fields="city,state"
									              title-field="city,state"
												  match-class="highlight"
												   onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" 
												  initial-value="{{psctrl.Location.address.city}}"
									              minlength="1"
									              tabindex="-1"
									              input-class="form-control form-control-small disabled">
									              </div> 
									              
								</div>


								<div class="col-lg-6 col-xs-12 default-price">
									<input type="checkbox" data-ng-click="defaultPrice(defaultPriceCheckBox)" data-ng-model="defaultPriceCheckBox" value=""> &nbsp;&nbsp; 
									<span>Default Price</span>
									 <input type="text" data-ng-disabled="!showTable" data-ng-model="psctrl.priceSetting.default_price" class="form-control"> 
										
										
									<input type="checkbox" 
									data-ng-click="defaultHCPrice(defaultHandlingChargeCheckBox)"
									data-ng-model="defaultHandlingChargeCheckBox" value=""> &nbsp;&nbsp; 
									<span>Default Handling Charges</span>
									 <input type="text" data-ng-disabled="!defaultHandlingChargeCheckBox"  
									 data-ng-model="psctrl.priceSetting.defaulthandling_charge" class="form-control">\
									 
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>


  <!--====================================================== Dynamic table=========================================-->

			<div class="row">
                <div class="col-lg-12 " >           	
                	        <div class="col-lg-8 col-lg-offset-2">                	
                               <div class="panel panel-default">                                
                                <div class="panel-body">
                                  <div class="table-responsive">
                                  <fieldset data-ng-disabled="showTable">
                                     <table  class="table table-striped table-bordered table-hover">
	                                    <thead>
	                                        <tr>
	                                          
	                                            <th class="text-center">To Branch</th>
	                                            <th class="text-center" colspan="3">Weight Range</th>	                                         
	                                            <th class="text-center" >Price</th>
	                                            <th class="text-center" >Actions</th>
	                                        </tr>
	                                    </thead>
		                                    <tbody>
		                                        <tr data-ng-repeat="psdetails in psctrl.priceSetting.priceSettingDetail  track by $index" >
		                                            <td>
		                                            <input type="hidden" class="form-control" id="toBatch" data-ng-model="psdetails.branch.branch_name">
		                                            
	                                            	 <div angucomplete-alt id="selectedBranchTo"
														placeholder="Ex : Chennai" pause="0"											
														selected-object="branch_name_To"
													    remote-url="getBranchByStr/"
														remote-url-data-field="Branch"
			             								title-field="branch_name"
														match-class="highlight"
														minlength="1" 
														input-class="form-control form-control-small"										
												    ></div>
												    
		                                             </td>
		                                            <td class="col-sm-1"><input type="text" class="form-control" data-ng-model="psdetails.ps_weightfrom"></td>
		                                            <td class="col-sm-1" style="text-align:center;">To</td>
		                                            <td class="col-sm-1"><input type="text" class="form-control" data-ng-model="psdetails.ps_weightto"></td>
		                                            <td><input type="text" class="form-control" data-ng-model="psdetails.ps_price"></td>
		                                            <td class="text-center">
                                                    <div class="col-lg-12">  
	                                                    <div class="col-lg-6 col-md-6  text-center">
	                                                   	 <button class="btn btn-primary"><i class="fa fa-pencil-square-o fa-lg"></i>  Edit</button>
	                                                    </div>
	                                                    <div class="col-lg-6 col-md-6 text-center">
	                                                   	 <button class="btn btn-danger" data-ng-click="psctrl.removePriceDetails($index,psdetails)"><i class="fa fa-trash fa-lg" ></i>  Delete</button>
	                                                    </div>
		                                            </div>
		                                            </td>
		                                           
		                                        </tr>
		                                        
		                                    </tbody>
                                   </table>
                                  </fieldset> 
                                   <button  type="button" class="btn btn-primary" data-ng-click="psctrl.addNew()"><i class="fa fa-plus fa-lg"></i></button> 
                            </div>
                        </div>
                    </div>
                   </div>  
                </div>
                </div> 
                
                <!--====================================================== Dynamic table end =========================================-->            
               <br>
               <br>
                
                <div class="row">
                <div class="col-lg-12 col-md-12 col-xs-12">
                
                	<div class="col-lg-1 col-lg-offset-5 col-md-3  col-md-offset-3 col-xs-8">
                		<button type="button" class="btn btn-danger"><i class="fa fa-eraser"></i>  Clear</button>
                	</div>
                	
                	<div class="col-lg-2 col-md-3 col-xs-4">
                		<button type="submit" class="btn btn-success"><i class="fa fa-floppy-o" aria-hidden="true"></i>    Save</button>
                	</div> 
                	 
                </div>
                </div>
        </div>
        <!-- /. PAGE WRAPPER  -->
    </div>
    </form>
    <!-- /. WRAPPER  -->
 <!--====================================================== SCRIPTS START=========================================-->
      <script>$('[data-toggle="popover"]').popover();
      $('.regSettings').click(function(e) {
			e.stopPropagation();
		});
      </script>
    <script src="resources/custom/js/custom.js"></script>   
    <script type="text/javascript" src="resources/custom/js/price_setting/c_price_setting_control.js"></script>
	<script type="text/javascript" src="resources/custom/js/validation.js"></script>
	<script type="text/javascript" src="resources/custom/js/Location/location_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/Address/address_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/price_setting/s_price_setting_service.js"></script>
	<script src="resources/custom/js/confirmDialog.js"></script>	 
 	<script type="text/javascript" src="resources/built-in/js/lodash.js"></script> 
   <!--====================================================== SCRIPTS END =========================================-->

</body>

</html>