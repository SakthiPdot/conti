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
data-ng-controller="priceSettingRegisterController as psrctrl"> 
	
	
<div class="success hideme"><i class="fa fa-check-circle" aria-hidden="true"></i> {{psrctrl.message}}</div>
<div class="failure hideme"><i class="fa fa-times-circle" aria-hidden="true"></i> {{psrctrl.message}}</div>
 
 
 
	<jsp:include page="../Dashboard/settings_nav.jsp"/>
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      
      	    		
      		  <div class="header "> 
	             <div class="page-header header-size">
	                 	  <b>${title}</b>	                 	  
	                 	 <a href="price_settings"><button class="btn btn-primary drawerOpen pull-right"> Add New Price Settings</button></a> 
	             </div>  
              </div>
      		
                
                <div id="page-inner">  
		 <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                             Price Settings Register
                        </div>
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
															<li><a data-ng-click="psrctrl.makeActive()">Active</a></li>
															<li><a data-ng-click="psrctrl.makeInActive()">InActive</a></li>
														</ul>
													</div>
													
														<div class="row paddingtop">
															<div class="col-md-12">
																<select name="shownoofrec" data-ng-model="shownoofrec"
																	data-ng-options="noofrec for noofrec in [10, 15, 25, 50, 100]"
																	class="form-control"
																	data-ng-click="psrctrl.shownoofRecord()">

																</select>
															</div>
														</div>
														
												</div>
											</div>

											<div class="col-xs-6 icons-button">
                                   <div class="pull-right">
                                   
                                   <form name="" method="POST" action="priceSetting_Print">
                                   <!--=============== settings============== -->                                   
                                      <a type="button" class="btn btn-primary dropdown-toggle"
                                     data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a>
                                     
                                           	<div class="dropdown-menu regSettings pull-right"
																style="padding-right: 5px;">
																<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_FromBranch == true, 'fa-times': setting_FromBranch == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_FromBranch = true"
																		data-ng-model="setting_FromBranch" /> From Branch
																	</label>
																</div>
																
																		<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_Service == true, 'fa-times': setting_Service == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_Service = true"
																		data-ng-model="setting_Service" /> Service 
																	</label>
																</div>
																
																		<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_Product == true, 'fa-times': setting_Product == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_Product = true"
																		data-ng-model="setting_Product" /> Product 
																	</label>
																</div>
																
																		<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_ProductType == true, 'fa-times': setting_ProductType == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_ProductType = true"
																		data-ng-model="setting_ProductType" /> Product Type
																	</label>
																</div>
																
																		<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_DefaultPrice == true, 'fa-times': setting_DefaultPrice == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_DefaultPrice = true"
																		data-ng-model="setting_DefaultPrice" /> Default Price
																	</label>
																</div>
																
																		<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_DefaultHandlingCharges == true, 'fa-times': setting_DefaultHandlingCharges == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_DefaultHandlingCharges = true"
																		data-ng-model="setting_DefaultHandlingCharges" /> Default Handling Charges
																	</label>
																</div>
																
																		<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_Active == true, 'fa-times': setting_Active == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_Active = true"
																		data-ng-model="setting_Active" /> Active
																	</label>
																</div>
																
											</div>
                                     
                                      <!--=============== excel============== -->
                                      <a type="button" onclick="location.href='downloadExcelPriceSetting';valid = true;" class="btn btn-primary"><i class="fa fa-file-excel-o fa-lg"></i></a>
                                      
                                       <!--=============== print============== --> 
                                      <button type="submit" class="btn btn-primary"
                                      data-ng-disabled="psrctrl.selectedPriceSetting.length<1"
                                      ><i class="fa fa-print fa-lg"></i></button>                                      
                                      <input type="hidden" name="SelectedPriceSetting"
																value="{{psrctrl.selectedPriceSetting}}" /> <input
																type="hidden" name="${_csrf.parameterName}"
																value="${_csrf.token}" />
                                      </form>
                                     <!--===============search tab============== -->
									<div class="row paddingtop">
										<div class="col-md-12">
											<input type="text" class="form-control" name="search"
												placeholder="Ex: Box"
												data-ng-model="psrctrl.priceSetting_search"
												data-ng-keyup="psrctrl.registerSearch(psrctrl.priceSetting_search)" />
										</div>
									</div>
                                	</div>
                                </div>
                              </div>
                            </div>
                          
                            
                            
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    
                                    
                                    
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox"
                                            data-ng-model="psrctrl.selectAllPriceSetting"
                                            data-ng-click="psrctrl.selectAll()"></th>
                                            <th data-ng-show="setting_FromBranch">From Branch</th>
                                            <th data-ng-show="setting_Service">Service</th>
                                            <th data-ng-show="setting_Product">Product</th>
                                            <th data-ng-show="setting_ProductType">Product Type</th>
                                            <th data-ng-show="setting_DefaultPrice">Default Price</th>
                                            <th data-ng-show="setting_DefaultHandlingCharges">Default Handling Charges</th> 
                                            <th data-ng-show="setting_Active">Active</th>    
                                        </tr>
                                    </thead>
                                    
                                    
                                    
                                    
                                    <tbody>
                                        <tr
                                        data-ng-dblclick="psrctrl.editPS(x.pricesetting_id)"
                                        data-ng-repeat='x in psrctrl.filteredPriceSetting | limitTo:pageSize  track by x.pricesetting_id'>
                                            <td><input type="checkbox"
                                            data-ng-model="x.select"
                                            data-ng-click="psrctrl.selectPriceSetting(x)"></td> 
                                            <td data-ng-show="setting_FromBranch">{{x.branch.branch_name}}</td>
                                            <td data-ng-show="setting_Service">{{x.service.service_name}}</td>
                                            <td data-ng-show="setting_Product">{{x.product.product_name}}</td>
                                            <td data-ng-show="setting_ProductType">{{x.product.product_Type}} </td>
                                            <td data-ng-show="setting_DefaultPrice">{{x.default_price==0 ?"" :x.default_price }}</td>
                                            <td data-ng-show="setting_DefaultHandlingCharges">{{x.defaulthandling_charge==0?"":x.defaulthandling_charge}}</td>
                                             <td
                                              data-ng-show="setting_Active"                                             
                                            data-ng-class="{'makeGreen':x.active=='Y','makeRed':x.active=='N'}">
                                            {{x.active=="Y"?"ACTIVE":"INACTIVE"}}</td>
                                          
                                       </tr>
                                      </tbody>
                                </table>
                                
                                <!--====================pagination tab============================ -->
                                		
                                		          
                                <div class ="col-lg-6">
                                	<div class="pull-left">
                               			 Showing {{(currentPage*pageSize)+1}} to 
                               			 {{ (totalnof_records - (((currentPage+1)*pageSize))) > 0 ? (currentPage+1)*pageSize : totalnof_records }}
                               			 of {{totalnof_records}} entries
                               		</div>
                                </div>
                                <div class="col-lg-6 icons-button">
                                
                                   <div class="pull-right">
										<button class="btn btn-primary" type = "button" data-ng-disabled="previouseDisabled" data-ng-click = "firstlastPaginate(1)">First</button>                      											
										<button class="btn btn-primary" type = "button" data-ng-disabled="previouseDisabled" data-ng-click = "paginate(-1)">Previous</button>
										<button class="btn btn-primary" type = "button" data-ng-disabled="nextDisabled" data-ng-click = "paginate(1)">Next</button>
										<button class="btn btn-primary" type = "button" data-ng-disabled="nextDisabled" data-ng-click = "firstlastPaginate(0)">Last</button>
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
 <!--====================================================== SCRIPTS START=========================================-->
      <script>$('[data-toggle="popover"]').popover();
      $('.regSettings').click(function(e) {
			e.stopPropagation();
		});
      </script>
    <script src="resources/custom/js/custom.js"></script>  
    <script type="text/javascript" src="resources/custom/js/price_setting_register/c_price_setting_register.js"></script>
	<script type="text/javascript" src="resources/custom/js/validation.js"></script>
	<script type="text/javascript" src="resources/custom/js/Location/location_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/Address/address_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/price_setting_register/s_price_setting_service.js"></script>
	<script src="resources/custom/js/confirmDialog.js"></script>	 
 	<script type="text/javascript" src="resources/built-in/js/lodash.js"></script> 
   <!--====================================================== SCRIPTS END =========================================-->

</body>

</html>