<!DOCTYPE html>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib
    prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
data-ng-app="contiApp" data-ng-controller="productController as proctrl">
  
 <div class="success hideme"><i class="fa fa-check-circle" aria-hidden="true"></i> {{proctrl.message}}</div>
<div class="failure hideme"><i class="fa fa-times-circle" aria-hidden="true"></i> {{proctrl.message}}</div>
 
 		<div class="overlay hideme"></div>
 	 	

 
 	
  <!-- form  Beginning  -->	
 		
 		<form data-ng-submit="proctrl.submit()" name="productForm">
 		
  <!-- Master Drawer Beginning  -->
  
  
 		<div class="drawer hideme">
 			<div class="row">
 			<div class="col-lg-12 trowserHeader">
 				 
                   <div class="col-lg-10 col-md-10 headerLeft">
                   		 <b class="model-title">Product {{proctrl.heading}}</b>
                   </div>
                   
                    <div class="col-lg-2 col-md-2 headerRight">
                   		<i class="fa fa-times fa-2x   pull-right iconLeft" 
                   		 data-ng-click="proctrl.close('Close')"></i>
                   </div>
            
            </div>
 			</div>
               
                 
                 
             <div class="model-body">                 
                <div class="row">
		            <div class="col-lg-12 title_area">                
		              
			          	<div class="col-lg-12 new-masters" >
			          		 <b  data-ng-show="(proctrl.product.product_id== null)"> New Product</b>	
			          	</div>  
			          	
			        </div>                
	            </div> 
	                
	            <div class="row">
		            <div class="col-lg-12">
			                
			           <div class="col-lg-12 content-body">
		                
		                
					
		                 
	                 	  <span>Product Name<span style="color:red">&nbsp;*</span></span>
		                  <input type="text" class="form-control"
		                  maxlength="50"
		                  onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)"
		                    data-ng-required="true"
		                    placeholder="Eg. Name"
			                  data-trigger="focus" data-toggle="popover"
							  data-placement="top" data-content="Please Enter Product Name"
		                  data-ng-model="proctrl.product.product_name">
		                  
		                  <span>Product Code</span>
		                  <input type="text" class="form-control"
		                  maxlength="10"		                 
		                  onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" 
			                  data-trigger="focus" data-toggle="popover"
			                  placeholder="Eg. XYZ01"
							  data-placement="top" data-content="Please Enter Product Code"
		                  data-ng-model="proctrl.product.product_code">
		                  
		                   <span>Product Type<span style="color:red">&nbsp;*</span></span>	
		                   
		                   		 <div angucomplete-alt
							 					 id="selectedProductType" 
									              pause="0"										              
									  			  data-trigger="focus" data-toggle="popover"
							 					  data-placement="top" data-content="Please Enter Product Type"
									              selected-object="product_type"
									              local-data="proctrl.products"
									              placeholder="Eg.Box"
									              search-fields="product_Type"
									              title-field="product_Type"
												  match-class="highlight"
												  initial-value="{{proctrl.product.product_Type}}"
									              minlength="1"
									              input-class="form-control form-control-small">
									              </div>
									              
									         	                  
		                  <input type="hidden" class="form-control"
		                  maxlength="30"
		                  onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)"
		                    data-ng-required="true"
			                  data-trigger="focus" data-toggle="popover"
							  data-placement="top" data-content="Please Enter Product Type"
		                  data-ng-model="proctrl.product.product_Type">
		                  
		                  <span>Maximum Weight<span style="color:red">&nbsp;*</span></span>
		                  <div class="input-group">
		                  <input type="text" class="form-control"		                  
		                    data-ng-required="true"		                  
		                    onKeyPress="return CheckIsNumericAnddot(event,this.value) "
		                    maxlength="8"		                    
						   placeholder="Eg.10.01"
			                  data-trigger="focus" data-toggle="popover"
							  data-placement="top" data-content="Please Enter Maximum Weight"
		                    data-ng-model="proctrl.product.max_weight">
							<span class="input-group-addon" id="basic-addon1"><label>kg</label></span>
						</div>
			               
			          </div>  
			        
			        </div>
			             
			             
			        <div class="col-lg-12">
			                
			            <div class="col-lg-12 content-body setup">
		                 	 
                            <b><span>Dimension Setup 
                            <input type="radio" data-ng-model="proctrl.product.dimension_flag" 
                            data-ng-init="proctrl.product.dimension_flag=true" name="optionsRadios" id="optionsRadios1" value="Y" checked>Yes
                            <input type="radio" data-ng-model="proctrl.product.dimension_flag"  name="optionsRadios" id="optionsRadios1" value="N">No
                             </span>
                            </b>
			               
			            </div>  
			        
			        </div>
			             
			             
			        <div class="col-lg-12" 
			                  data-ng-hide="proctrl.product.dimension_flag=='N'">
			                
			            <div class="col-lg-12 content-body">
		                 	 
		                 	  <span>Maximum Height</span>	
		                  <div class="input-group">
			                  <input type="text" class="form-control"			                  
		                    onKeyPress="return CheckIsNumericAnddot(event,this.value) "
		                    maxlength="8"            
		                    placeholder="Eg.10.01"     
			                  data-trigger="focus" data-toggle="popover"
							  data-placement="top" data-content="Please Enter Maximum Height"
			                  data-ng-model="proctrl.product.max_height">			                  
							<span class="input-group-addon" id="basic-addon1"><label>cm</label></span>
						</div>
			                  
			                  <span>Maximum Width</span>
		                  <div class="input-group">
			                  <input type="text" class="form-control"				                  
		                    onKeyPress="return CheckIsNumericAnddot(event,this.value) "
		                    maxlength="8"
		                    placeholder="Eg.10.01"		                
			                  data-trigger="focus" data-toggle="popover"
							  data-placement="top" data-content="Please Enter Maximum Width"		                  
			                  data-ng-model="proctrl.product.max_width">			                  
							<span class="input-group-addon" id="basic-addon1"><label>cm</label></span>
						</div>
			                  
						<span>Maximum Length</span>
		                  <div class="input-group">
			                  <input type="text" class="form-control"				                  
		                    onKeyPress="return CheckIsNumericAnddot(event,this.value) "
		                    maxlength="8"		
		                    placeholder="Eg.10.01"                  
			                  data-trigger="focus" data-toggle="popover"
							  data-placement="top" data-content="Please Enter Maximum Length"
			                   data-ng-model="proctrl.product.max_length">	                  
							<span class="input-group-addon" id="basic-addon1"><label>cm</label></span>
						</div>	
						
						             
			                 	
			           </div>  
			       
			       </div>
			                             
	            </div>   
	                
	        </div>
                 
                            
                 <div class="modal-footer footerHeight" >
				
				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-4 col-xs-4 footerLeft">
							<button type="button" class=" btn btn-danger  pull-left" data-ng-click="proctrl.close('Cancel')"  data-ng-click="reset()" > <i class="fa fa-times" aria-hidden="true"></i>
							Cancel</button>
						</div>
						
						<div class="col-lg-4 col-xs-4" style="text-align:center; !important;">
							<a id="" class="btnPadding btn btn-warning"	 data-ng-click="proctrl.deleteProduct()"  data-ng-show="!(proctrl.product.product_id== null)" ><i class="fa fa-trash"  aria-hidden="true"></i> &nbsp;Delete</a> 
							
							<a id="" class="btnPadding btn btn-primary"  data-ng-click="proctrl.resetForm()"  data-ng-show="!productForm.$pristine && (proctrl.product.product_id== null)"><i class="fa fa-eraser" aria-hidden="true"></i>
							Clear</a>							
						</div>



						<div class="col-lg-4 col-xs-4 footerRight" data-ng-show="!(proctrl.product.product_id== null)">
							<button class="btn btn-success " type="submit"
								
								id="saveclose" data-id="0" data-ng-click="save($event)"
								type="submit">
								<i class="fa fa-floppy-o "> </i> Update</button>
							<br>
						</div>



						<div class="col-lg-4 col-xs-4 footerRight" 
									data-ng-show="(proctrl.product.product_id== null)">
							<div class="btn-group dropup" id="savebutton">

								<button type="button" class="btn btn-success dropdown-toggle"
									data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false">
									<i class="fa fa-floppy-o "></i> Save
								</button>
								<div class="dropdown-menu pull-right"
									style="padding-right: 5px;">
									<button class="farmsave mybutton" id="saveclose" data-id="0"
										data-ng-click="save($event)" type="submit">Save and
										Close</button>
									<br>
									<button class="farmsave mybutton" id="savenew" data-id="1"
										data-ng-click="save($event)" type="submit">Save and
										New</button>
									<br>
								</div>
							</div>
						</div>
					</div>
				</div>
            </div>			
 		</div> 
	<!-- Master Drawer Completed -->
	</form>
  <!--=============================== form  Beginning============================  -->	
  
  
  	
	<jsp:include page="../Dashboard/nav.jsp"/>


<sec:authorize access="hasRole('SUPER_ADMIN') or hasRole('MANAGER')">
	<div id="wrapper">
		<div id="page-wrapper">


			<div class="header ">
				<div class="page-header header-size">
					<b>${title}</b>

					<button class="btn btn-primary  pull-right"
					data-ng-click="proctrl.reset()" onClick="drawerOpen('.drawer')">Add
						New Product</button>
				</div>

			</div>


				<div id="page-inner">
					<div class="row">
						<div class="col-md-12">
							<!-- Advanced Tables -->
							<div class="panel panel-default">
								<div class="panel-heading">Product Register</div>
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
																<li data-ng-click="proctrl.makeActive()"><a>Active</a></li>
																<li data-ng-click="proctrl.makeInActive()"><a>InActive</a></li>
															</ul>
														</div>
													</div>
												</div>

												<div class="col-xs-6 icons-button">
													<div class="pull-right">
														<form name="selectedProductForm" method="POST"
															action="product_print">
															<a type="button" class="btn btn-primary dropdown-toggle"
																data-toggle="dropdown"> <i class="fa fa-cog fa-lg"></i>
															</a>
															<div class="dropdown-menu regSettings pull-right"
																style="padding-right: 5px;">
																<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_proname == true, 'fa-times':setting_proname == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_proname=true"
																		data-ng-model="setting_proname" /> Product Name
																	</label>
																</div>
																<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_procodename == true, 'fa-times':setting_procodename == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_procodename=true"
																		data-ng-model="setting_procodename" /> Product Code
																	</label>
																</div>
																<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_protype == true, 'fa-times':setting_protype == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_protype=true"
																		data-ng-model="setting_protype" /> Product Type
																	</label>
																</div>
																<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_maxweight == true, 'fa-times':setting_maxweight == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_maxweight=true"
																		data-ng-model="setting_maxweight" /> Max Weight
																	</label>
																</div>
																<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_Dimension == true, 'fa-times':setting_Dimension == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_Dimension=true"
																		data-ng-model="setting_Dimension" /> Dimension Setup
																	</label>
																</div>
																<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_height == true, 'fa-times':setting_height == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_height=true"
																		data-ng-model="setting_height" /> Max Height
																	</label>
																</div>
																<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_Width == true, 'fa-times':setting_Width == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_Width=true"
																		data-ng-model="setting_Width" /> Max Width
																	</label>
																</div>
																<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_Length== true, 'fa-times':setting_Length==false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_Length=true"
																		data-ng-model="setting_Length" /> Max Length
																	</label>
																</div>
																<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_status== true, 'fa-times':setting_status==  false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_status=true"
																		data-ng-model="setting_status" /> Active/Inactive
																	</label>
																</div>
															</div>


															<!--=============== excel============== -->
															<a type="button" class="btn btn-primary"
																onclick="location.href='downloadExcelProduct'"> <i
																class="fa fa-file-excel-o fa-lg"></i>
															</a>
															<!--=============== print============== -->
															<button type="submit" class="btn btn-primary">
																<i class="fa fa-print fa-lg"></i>
															</button>
															<input type="hidden" name="SelectedProduct"
																value="{{proctrl.selectedProducts}}" /> <input
																type="hidden" name="${_csrf.parameterName}"
																value="${_csrf.token}" />
														</form>
														<!--=============== print end============== -->
													</div>
												</div>
											</div>
										</div>

										<div class="col-xs-6  col-xs-offset-6 ">
											<div class="pull-right">
												<input type="text" class="form-control"
													placeholder="Search " ng-model="search">
											</div>
										</div>


										<table class="table table-striped table-bordered table-hover"
											id="dataTables-example">
											<thead>
												<tr>
													<th><input type="checkbox"
														data-ng-model="proctrl.selectAllProduct"
														data-ng-click="proctrl.selectAll()"></th>
													<th>S.No</th>
													<th data-ng-show="setting_proname">Product Name</th>
													<th data-ng-show="setting_procodename">Product Code</th>
													<th data-ng-show="setting_protype">Product Type</th>
													<th data-ng-show="setting_maxweight">Maximum Weight
														(Kg)</th>
													<th data-ng-show="setting_Dimension">Dimension Setup</th>
													<th data-ng-show="setting_height">Maximum Height(Cm)</th>
													<th data-ng-show="setting_Width">Maximum Width(Cm)</th>
													<th data-ng-show="setting_Length">Maximum Length(Cm)</th>
													<th data-ng-show="setting_status">Active/InActive</th>
												</tr>
											</thead>
											<tbody>
												<tr data-ng-dblclick="proctrl.updateProduct(x,$index)"
													data-ng-repeat="x in  proctrl.products.slice((currentPage-1)*itemsPerPage,(currentPage)*itemsPerPage) | filter:search track by x.product_id">
													<td><input type="checkbox" data-ng-model="x.select"
														data-ng-click="proctrl.selectProduct(x)"></td>
													<td>{{(currentPage*10)-(10-($index+1))}}</td>
													<td data-ng-show="setting_proname">{{x.product_name}}</td>
													<td data-ng-show="setting_procodename">{{x.product_code}}</td>
													<td data-ng-show="setting_protype">{{x.product_Type}}</td>
													<td data-ng-show="setting_maxweight">{{x.max_weight}}</td>
													<td data-ng-show="setting_Dimension">{{x.dimension_flag}}</td>
													<td data-ng-show="setting_height">{{x.dimension_flag=="Y"?x.max_height:""}}</td>
													<td data-ng-show="setting_Width">{{x.dimension_flag=="Y"?x.max_width:""}}</td>
													<td data-ng-show="setting_Length">{{x.dimension_flag=="Y"?x.max_length:""}}</td>
													<td data-ng-show="setting_status" 
													data-ng-class="{'makeGreen': x.active=='Y', 'makeRed': x.active=='N'}">
													{{x.active=="Y"?"ACTIVE" : "INACTIVE" }}</td>
												</tr>
											</tbody>
										</table>

										<div class="col-lg-6 col-lg-offset-3 " align="center">
											<pagination total-items="totalItems" ng-model="currentPage"	max-size="maxSize" class="pagination-sm"
												boundary-links="true" rotate="false" num-pages="numPages"
												items-per-page="itemsPerPage"></pagination>
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
	 </sec:authorize>

  <!--======================================================ONLY FOR STAFF=========================================-->
		<sec:authorize access="hasRole('STAFF')">
			<div id="wrapper">        	  
				<div id="page-wrapper"> 
					<div class="header "> 
						 <div class="page-header header-size">
								  <b>${title}</b>		                 	 
						 </div>	   
					</div>	
					
					<div id="page-inner">  
						<div class="row">
							<div class="col-md-12">
								 <div class="panel panel-default">
									<div class="panel-heading">
										 Product Register
									</div>
									<div class="panel-body">
										Sorry..! You are not authorized to view this master..!
									</div>
								  </div>
							</div>
						</div>
					</div>		
				 </div>
			</div>
		</sec:authorize>
	<!--====================================================== SCRIPTS START=========================================-->
	<script>
		$('[data-toggle="popover"]').popover();
		$('.regSettings').click(function(e) {
			e.stopPropagation();
		});
	</script>
	<script src="resources/custom/js/custom.js"></script>  
	<script type="text/javascript" src="resources/custom/js/validation.js"></script>
	<script type="text/javascript" src="resources/custom/js/Location/location_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/CompanySetting/company_setting_directive.js"></script>
	<script type="text/javascript" src="resources/custom/js/Product/product_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/Address/address_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/Product/product_control.js"></script>
	  <script src="resources/custom/js/confirmDialog.js"></script>   
<!--====================================================== SCRIPTS END =========================================-->


</body>
</html>
