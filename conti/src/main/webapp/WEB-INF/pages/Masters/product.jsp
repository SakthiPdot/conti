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
     <link rel="icon" type="image/gif/png" href="resources/Image/conti_logo.png">
    <title>${title}</title>
    <!-- Bootstrap Styles-->
    <link href="resources/built-in/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="resources/built-in/assets/css/font-awesome.min.css" rel="stylesheet" />
	
	

    <!-- Custom Styles-->
    <link href="resources/built-in/assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <!--<link href='http://fonts.googleapis.com/css\?family=Open+Sans' rel='stylesheet' type='text/css' />-->
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
 		
  <!-- Master Drawer Beginning  -->
	<div class="drawer hideme ">
		<form data-ng-submit="proctrl.submit()" class="formBottom"
			name="productForm">
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

						<div class="col-lg-12 new-masters">
							<b data-ng-show="(proctrl.product.product_id== null)"> New
								Product</b>
						</div>

					</div>
				</div>

				<div class="row">
					<div class="col-lg-12">

						<div class="col-lg-12 content-body">




							<span>Product Name<span style="color: red">&nbsp;*</span></span>
							<input type="text" class="form-control" maxlength="50"
								onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)"
								data-ng-required="true" placeholder="Ex : Name"
								data-ng-blur="proctrl.checkProductName(proctrl.product.product_name)"
								data-trigger="focus" data-toggle="popover" data-placement="top"
								data-content="Please enter product name"
								data-ng-model="proctrl.product.product_name"> <span
								class="makeRed" data-ng-show="nameWrong">Product Name
								Already Existing..!<br>
							<br>
							</span> <span>Product Code</span> <input type="text"
								class="form-control" maxlength="10"
								onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)"
								data-trigger="focus" data-toggle="popover"
								placeholder="Ex : XYZ01" data-placement="top"
								data-content="Please enter product code"
								data-ng-model="proctrl.product.product_code"> <span>Product
								Type<span style="color: red">&nbsp;*</span>
							</span>

							<div angucomplete-alt id="selectedProductType" pause="0"
								data-trigger="focus" data-toggle="popover" data-placement="top"
								data-content="Please enter product type"								
							    remote-url="getProductTypeByStr/"
								remote-url-data-field="Product"											
								selected-object="product_type" 
								override-suggestions="true" placeholder="Ex : Box"
								search-fields="product_Type" title-field="product_Type"
								match-class="highlight"
								initial-value="{{proctrl.product.product_Type}}" minlength="1"
								input-class="form-control form-control-small"></div>

				
							<input type="hidden" class="form-control" maxlength="30"
								onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)"
								data-trigger="focus" data-toggle="popover" data-placement="top"
								data-content="Please enter product type"
								data-ng-model="proctrl.product.product_Type"> <span>Maximum
								Weight<span style="color: red">&nbsp;*</span>
							</span>
							<div class="input-group">
								<input type="text" class="form-control" data-ng-required="true"
									onKeyPress="return CheckIsNumericAnddot(event,this.value) "
									maxlength="8" placeholder="Ex : 10.01" data-trigger="focus"
									data-toggle="popover" data-placement="top"
									data-content="Please enter maximum weight"
									data-ng-model="proctrl.product.max_weight"> <span
									class="input-group-addon" id="basic-addon1"><label>kg</label></span>
							</div>

						</div>

					</div>


					<div class="col-lg-12">

						<div class="col-lg-12 content-body setup">

							<b><span>Dimension Setup <input type="radio"
									data-ng-model="proctrl.product.dimension_flag"
									data-ng-init="proctrl.product.dimension_flag=true"
									name="optionsRadios" id="optionsRadios1" value="Y" >Yes
									<input type="radio"
									data-ng-model="proctrl.product.dimension_flag"
									name="optionsRadios" id="optionsRadios1" value="N" checked="checked">No
							</span> </b>

						</div>

					</div>


					<div class="col-lg-12"
						data-ng-hide="proctrl.product.dimension_flag=='N'">

						<div class="col-lg-12 content-body">

							<span>Maximum Height</span>
							<div class="input-group">
								<input type="text" class="form-control"
									onKeyPress="return CheckIsNumericAnddot(event,this.value) "
									maxlength="8" placeholder="Ex : 10.01" data-trigger="focus"
									data-toggle="popover" data-placement="top"
									data-content="Please enter maximum height"
									data-ng-model="proctrl.product.max_height"> <span
									class="input-group-addon" id="basic-addon1"><label>cm</label></span>
							</div>

							<span>Maximum Width</span>
							<div class="input-group">
								<input type="text" class="form-control"
									onKeyPress="return CheckIsNumericAnddot(event,this.value) "
									maxlength="8" placeholder="Ex : 10.01" data-trigger="focus"
									data-toggle="popover" data-placement="top"
									data-content="Please enter maximum width"
									data-ng-model="proctrl.product.max_width"> <span
									class="input-group-addon" id="basic-addon1"><label>cm</label></span>
							</div>

							<span>Maximum Length</span>
							<div class="input-group">
								<input type="text" class="form-control"
									onKeyPress="return CheckIsNumericAnddot(event,this.value) "
									maxlength="8" placeholder="Ex : 10.01" data-trigger="focus"
									data-toggle="popover" data-placement="top"
									data-content="Please enter maximum length"
									data-ng-model="proctrl.product.max_length"> <span
									class="input-group-addon" id="basic-addon1"><label>cm</label></span>
							</div>



						</div>

					</div>

				</div>

			</div>


			<div class="modal-footer footerHeight">

				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-4 col-xs-4 footerLeft">
							<button type="button" class=" btn btn-warning  pull-left"
								data-ng-click="proctrl.close('Cancel')" data-ng-click="reset()">
								<i class="fa fa-ban" aria-hidden="true"></i>&nbsp;Cancel
							</button>
						</div>

						<div class="col-lg-4 col-xs-4"
							style="text-align: center; !important;">
							<a id="" class="btnPadding btn btn-danger"
								data-ng-click="proctrl.deleteProduct()"
								data-ng-show="!(proctrl.product.product_id== null)"><i
								class="fa fa-trash" aria-hidden="true"></i> &nbsp;Delete</a> <a
								id="" class="btnPadding btn btn-primary"
								data-ng-click="proctrl.resetForm()"
								data-ng-show="!productForm.$pristine && (proctrl.product.product_id== null)"><i
								class="fa fa-eraser" aria-hidden="true"></i> Clear</a>
						</div>



						<div class="col-lg-4 col-xs-4 footerRight"
							data-ng-show="!(proctrl.product.product_id== null)">
							<button class="btn btn-success " type="submit" id="saveclose"
								data-id="0" data-ng-click="save($event)" type="submit">
								<i class="fa fa-floppy-o "> </i> Update
							</button>
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
		</form>
	</div>
	<!-- Master Drawer Completed -->
	
  <!--=============================== form  Beginning============================  -->	
  
  
  	
		<jsp:include page="../Dashboard/settings_nav.jsp"/>


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
														
														
														<div class="row paddingtop">
															<div class="col-md-12">
																<select name="shownoofrec" data-ng-model="shownoofrec"
																	data-ng-options="noofrec for noofrec in [10, 15, 25, 50, 100]"
																	class="form-control"
																	data-ng-change="proctrl.shownoofRecord()">

																</select>
															</div>
														</div>
														
														
													</div>
												</div>

												<div class="col-xs-6 icons-button">
													<div class="pull-right">
														<form name="selectedProductForm" target="_blank" method="POST" class="padding-button"
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
																onclick="location.href='downloadExcelProduct';valid = true;"> <i
																class="fa fa-file-excel-o fa-lg"></i>
															</a>
															<!--=============== print============== -->
															<button type="submit" class="btn btn-primary"
															data-ng-disabled="proctrl.selectedProducts.length<1">
																<i class="fa fa-print fa-lg"></i>
															</button>
															<input type="hidden" name="SelectedProduct"
															
																value="{{proctrl.selectedProducts}}" /> <input
																type="hidden" name="${_csrf.parameterName}"
																value="${_csrf.token}" />
														</form>
														<!--===============seatch tab============== -->														
				                                      <div class = "row paddingtop">
				                                      
					                                    <div class = "col-md-12"><input type = "text" class="form-control" name = "search" placeholder = "Ex: Box" 
					                                     data-ng-model = "proctrl.product_search"
					                                     data-ng-keyup = "proctrl.registerSearch(proctrl.product_search)"/></div>
					                                     
				                                      </div>
				                                      
				                                      
													</div>
												</div>
											</div>
										</div>

										<div class="col-xs-6  col-xs-offset-6 " data-ng-hide="true">
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
													<!-- <th>S.No</th> -->
													<th data-ng-show="setting_proname"
														data-ng-click="productName=!productName;sortTable('productName',productName);">Product Name <i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':productName,'fa fa-caret-down':!productName}"
														aria-hidden="true"></i></th>
													<th data-ng-show="setting_procodename"
														data-ng-click="productCode=!productCode;sortTable('productCode',productCode);">Product Code<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':productCode,'fa fa-caret-down':!productCode}"
														aria-hidden="true"></i></th>
													<th data-ng-show="setting_protype"
														data-ng-click="productType=!productType;sortTable('productType',productType);">Product Type<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':productType,'fa fa-caret-down':!productType}"
														aria-hidden="true"></i></th>
													<th data-ng-show="setting_maxweight"
														data-ng-click="maxWeigt=!maxWeigt;sortTable('maxWeigt',maxWeigt);">Maximum Weight(Kg)<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':maxWeigt ,'fa fa-caret-down':!maxWeigt}"
														aria-hidden="true"></i></th>
													<th data-ng-show="setting_Dimension"
														data-ng-click="dimenSetUp=!dimenSetUp;sortTable('dimenSetUp',dimenSetUp);">Dimension Setup<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':dimenSetUp ,'fa fa-caret-down':!dimenSetUp}"
														aria-hidden="true"></i></th>
													<th data-ng-show="setting_height"
														data-ng-click="maxHeigt=!maxHeigt;sortTable('maxHeigt',maxHeigt);">Maximum Height(Cm)<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':maxHeigt ,'fa fa-caret-down':!maxHeigt}"
														aria-hidden="true"></i></th>
													<th data-ng-show="setting_Width"
														data-ng-click="maxWidth=!maxWidth;sortTable('maxWidth',maxWidth);">Maximum Width(Cm)<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':maxWidth ,'fa fa-caret-down':!maxWidth}"
														aria-hidden="true"></i></th>
													<th data-ng-show="setting_Length"
														data-ng-click="maxlength=!maxlength;sortTable('maxlength',maxlength);">Maximum Length(Cm)<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':maxlength ,'fa fa-caret-down':!maxlength}"
														aria-hidden="true"></i></th>
													<th data-ng-show="setting_status"
														data-ng-click="settingStatus=!settingStatus;sortTable('settingStatus',settingStatus);">Active/InActive<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':settingStatus  ,'fa fa-caret-down':!settingStatus }"
														aria-hidden="true"></i></th>
													
											<!-- 		<th data-ng-click="productName=false;
																	 productCode=false;
																	productType=false;																	
																	settingStatus=false;
																	maxWeigt=false;
																	dimenSetUp=false;
																	maxHeigt=false;
																	maxWidth=false;
																	maxlength=false;
																	settingStatus=false;
													">reset all</th> -->
													
												</tr>
											</thead>
											<tbody>
												<tr data-ng-dblclick="proctrl.updateProduct(x,$index)"
													data-ng-repeat="x in  proctrl.FilteredProducts| limitTo:pageSize  track by x.product_id">
													<td><input type="checkbox" data-ng-model="x.select"
														data-ng-click="proctrl.selectProduct(x)"></td>
													<!-- <td>{{(currentPage*10)-(10-($index+1))}}</td> -->
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

								   <!--====================pagination tab============================ -->
                                		
                                		          
                                <div class ="col-lg-6 col-md-6 col-xs-12">
                                	<div class="pull-left">
                               			 Showing {{(currentPage*pageSize)+1}} to 
                               			 {{ (totalnof_records - (((currentPage+1)*pageSize))) > 0 ? (currentPage+1)*pageSize : totalnof_records }}
                               			 of {{totalnof_records}} entries
                               		</div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-xs-12 icons-button">
                                
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
	 <script type="text/javascript" src="resources/built-in/js/lodash.js"></script> 
<!--====================================================== SCRIPTS END =========================================-->


</body>
</html>
