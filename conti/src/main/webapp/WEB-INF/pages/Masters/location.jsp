<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib
    prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
<%@ page isELIgnored="false" %> 
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
    <link href="resources/built-in/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="resources/built-in/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Morris Chart Styles-->
    <link href="resources/built-in/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="resources/built-in/assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <!--<link href='http://fonts.googleapis.com/css\?family=Open+Sans' rel='stylesheet' type='text/css' />-->
    <link rel="stylesheet" href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css"> 
	
	 <link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	  <link href="resources/built-in/assets/Drawer/animate.css" rel="stylesheet" />
	 <link href="resources/custom/css/custom.css" rel="stylesheet">
	<link rel="stylesheet" href="resources/custom/css/success_failure_msg.css">
	<link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet"> 
	
	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <script src="resources/custom/js/app.js"></script>



</head>


<body style="overflow-x:hidden;"
data-ng-app="contiApp" data-ng-controller="locationController as locctrl">
 
 <div class="overlay hideme"></div>
 
<div class="success hideme"><i class="fa fa-check-circle" aria-hidden="true"></i> {{locctrl.message}}</div>
<div class="failure hideme"><i class="fa fa-times-circle" aria-hidden="true"></i> {{locctrl.message}}</div>
 		
 		<div class="drawer hideme ">
 		<form data-ng-submit="locctrl.submit()" class="formBottom" name="locationForm">
 			<div class="row">
 			<div class="col-lg-12 trowserHeader">
 				 
                   <div class="col-lg-10 col-md-10 headerLeft">
                   		 <b class="model-title">Location {{locctrl.heading}}</b>
                   </div>
                   
                   <div class="col-lg-2 col-md-2 headerRight">
                   		<i class="fa fa-times fa-2x   pull-right iconLeft"  data-ng-click="locctrl.close('Close')"  data-ng-click="reset()"></i>
                   </div>
            
             </div>
 			</div>
               
                 
                 
                 <div class="model-body">
                 
	                  <div class="row">
			                <div class="col-lg-12 title_area">	
					          	<div class="col-lg-12 new-masters" >
					          		 <b  data-ng-show="locctrl.Location.location_id == null" > New Location</b>	
					          	</div> 				            
				            </div>                
		             </div> 
                 
	                <div class="row">
		                <div class="col-lg-12">			                
			               <div class="col-lg-12 content-body">
		                 	 
		                 	  <span>Location Name<span style="color:red">&nbsp;*</span></span>
			                  <input type="text"
			                  onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value) "
			                  data-ng-required="true"
			                  data-trigger="focus" data-toggle="popover"
							  data-placement="top" data-content="Please enter location name"
			                  data-ng-model="locctrl.Location.location_name" 
			                  data-ng-blur="locctrl.checkLocationName(locctrl.Location.location_name)"
			                  maxlength="50"
			                  class="form-control">
			                  
			                  <span class="makeRed" data-ng-show="locctrl.nameWrong">Location Name Already Existing..!<br><br></span>
			                  
			                  <span>Location Code</span>
			                  <input type="text"
			                  data-trigger="focus" data-toggle="popover"
							  data-placement="top" data-content="Please enter location code"							  
			                  onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value) "
							  maxlength="10"
			                  data-ng-model="locctrl.Location.location_code"
			                   class="form-control">
			                  
			                   <span>Abbreviation</span>
			                  <input type="text"			                  
			                  data-trigger="focus" data-toggle="popover"		              
							  onKeyPress="return CheckIsCharacterWithspace(event,this.value) "
							  data-placement="top" data-content="Please enter abbreviation"
			                  data-ng-model="locctrl.Location.abbreviation"
			                    maxlength="50"
			                   class="form-control">  
			                   
			                    
	                	    	     
			                
		            	 </div>  
			           </div> 
			             
			              
			             
			             <div class="col-lg-12">
	                		<div class="col-lg-6 content-body">
	                	     <span>City<span style="color:red">&nbsp;*</span></span>
	                	   
	                	      	
									       	 <div angucomplete-alt
							 					 id="selectedCity" 
									              placeholder="Ex : Coimbatore"
									              pause="0"		 data-ng-required="true"
		                  						 data-trigger="focus" data-toggle="popover"
							 					  data-placement="top" data-content="Please enter city"	
									              selected-object="city_name"								              
										    	  remote-url="getAddressTypeByStr/"
												  remote-url-data-field="Address"
									              title-field="city"
									              description-field="state"
												  match-class="highlight"
												   onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" 
												  initial-value="{{locctrl.Location.address.city}}"
									              minlength="1"
									              input-class="form-control form-control-small">
									              </div>  
									              
	                	     <select 
	                	    	 data-ng-model="locctrl.Location.selectedAddress"
	                	    	 data-ng-options="x.city  for x in locctrl.addresses|orderBy:'city' track by x.id"
	                	    	 class="form-control"	                	    	 
								data-ng-hide="true"
								
	                	    	 data-ng-change="updateAddressDetail()"
	                	    	 id="city">
	                	    		<option value="">--Select City --</option> 
	                	     </select>
	                	     
	                	     
								<input type="text"
								data-ng-hide="true"
								data-ng-model="locctrl.Location.address.id"
								id="city_id" 
			                  	class="form-control"/>
			                  	
								 <span>State<span style="color:red">&nbsp;*</span></span>
			                     <input type="text"
			                     tabindex="-1"
			                     id="stateValue"
			                     data-ng-model="locctrl.Location.address.state" 
			                      class="form-control disabled">
	                		</div>
	                			
	                		
	                		<div class="col-lg-6 content-body">
	                	           
			                  <span>Country<span style="color:red">&nbsp;*</span></span>
			                  <input type="text" class="form-control disabled"
			                  tabindex="-1"
			                  data-ng-model="locctrl.Location.address.country">
			                  
			                  <span>Pincode<span style="color:red">&nbsp;*</span></span>
			                  <input type="text" class="form-control"
			                   data-ng-required="true"
			                    data-trigger="focus" data-toggle="popover"
			                    maxlength="8"
			                    minlength="6"
							 	data-placement="top" data-content="Please enter pincode"	
							   onKeyPress="return CheckIsNumeric(event) "           
			                  data-ng-model="locctrl.Location.pincode">
			                  
	                		</div>
	                	</div>
	                	
	                	               
	                </div> 
	                
	                                
	                
	                </div>
                 
                 <div class="modal-footer footerHeight" >
				
				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-4 col-xs-4 footerLeft">
							<button type="button" class=" btn btn-warning  pull-left" data-ng-click="locctrl.close('Cancel')"  > <i class="fa fa-ban" aria-hidden="true"></i>
							Cancel</button>
						</div>
						
						<div class="col-lg-4 col-xs-4" style="text-align:center; !important;">
							<a id="" class="btnPadding btn btn-danger"	 data-ng-click="locctrl.deleteLocation()"  data-ng-show="!(locctrl.Location.location_id== null)" ><i class="fa fa-trash"  aria-hidden="true"></i>  Delete</a> 
							
							<a id="" class="btnPadding btn btn-primary"  data-ng-click="locctrl.resetForm()"  data-ng-show="!locationForm.$pristine && (locctrl.Location.location_id== null)"><i class="fa fa-eraser" aria-hidden="true"></i>
							Clear</a>							
						</div>
		
						<div class="col-lg-4 col-xs-4 footerRight" data-ng-show="!(locctrl.Location.location_id== null)">
							<button class="btn btn-success " type="submit"
								
								id="saveclose" data-id="0" data-ng-click="save($event)"
								type="submit">
								<i class="fa fa-floppy-o "> </i> Update</button>
							<br>
						</div>



						<div class="col-lg-4 col-xs-4 footerRight" 
									data-ng-show="(locctrl.Location.location_id== null)">
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
	
		<jsp:include page="../Dashboard/settings_nav.jsp"/>

<sec:authorize access="hasRole('SUPER_ADMIN') or hasRole('MANAGER')">	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      
      		<div class="header "> 
             <div class="page-header header-size">
                 	  <b>${title}</b>
                 	  
                 	  <button class="btn btn-primary  pull-right"   data-ng-click="locctrl.openDrawer();" >Add New Location</button>
             </div>             										
		   </div>


        
      		
      		<div id="page-inner" >  
		 <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                             Location Register
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                            <div class="row">
                              <div class="col-lg-12">
                               <div class="col-lg-6">
                                     <div class="dataTables_length" id="dataTables-example_length">
							<div class="dropdown">
								<button class="btn btn-primary dropdown-toggle"
									type="button" data-toggle="dropdown">
									Batch Action <span class="caret"></span>
								</button>
								<ul class="dropdown-menu">
									<li data-ng-click="locctrl.makeActive()" ><a>Active</a></li>
									<li data-ng-click="locctrl.makeInActive()"><a>InActive</a></li>

								</ul>
								<!--<button type="button" class="btn btn-primary">Filter</button>-->
							</div>
							<!-- dropdown -->
							
							
														<div class="row paddingtop">
															<div class="col-md-12">
																<select name="shownoofrec" data-ng-model="shownoofrec"
																	data-ng-options="noofrec for noofrec in [10, 15, 25, 50, 100]"
																	class="form-control"
																	data-ng-change="locctrl.shownoofRecord()">

																</select>
															</div>
														</div>
														

						</div> 
                                </div>
                                
                              <div class="col-lg-6 icons-button">
                                   <div class="pull-right">                                   
									<form name="selectedLocationform" target="_blank" method='POST'  action="location_print" class="padding-button">
                                     <a type="button" class="btn btn-primary dropdown-toggle"
                                     data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a>
                                    
                                    	<div class="dropdown-menu regSettings pull-right"
																style="padding-right: 5px;">
																<div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_locName == true, 'fa-times': setting_locName == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_locName = true"
																		data-ng-model="setting_locName" /> Location Name
																	</label>
																</div>
											 <div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_locCode == true, 'fa-times': setting_locCode == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_locCode = true"
																		data-ng-model="setting_locCode" /> Location Code
																	</label>
																</div>
                                         	 <div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_abbr == true, 'fa-times': setting_abbr == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_abbr = true"
																		data-ng-model="setting_abbr" /> Abbreviation
																	</label>
																</div>
                                            	 <div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_city == true, 'fa-times': setting_city == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_city = true"
																		data-ng-model="setting_city" /> City
																	</label>
																</div>
                                                	 <div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_state == true, 'fa-times': setting_state == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_state = true"
																		data-ng-model="setting_state" /> State
																	</label>
																</div>
                                            	 <div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_country == true, 'fa-times': setting_country == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_country = true"
																		data-ng-model="setting_country" /> Country
																	</label>
																</div>
                                            	 <div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_pincode == true, 'fa-times': setting_pincode == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_pincode = true"
																		data-ng-model="setting_pincode" /> Pincode
																	</label>
																</div>
                                             <div class="checkbox">
																	<label> <i class="fa"
																		data-ng-class="{'fa-check': setting_active == true, 'fa-times': setting_active == false}"></i>
																		<input type="checkbox"
																		data-ng-init="setting_active = true"
																		data-ng-model="setting_active" /> Active/Inactive
																	</label>
																</div>   
										</div>
                                    <!--=============== excel============== -->
                                      <a type="button" onclick="location.href='downloadExcelLocation';valid = true;" class="btn btn-primary"><i class="fa fa-file-excel-o fa-lg"></i></a>
                                     <!--=============== print============== -->
                                      <button type="submit" class="btn btn-primary"
                                      data-ng-disabled="locctrl.selectedLocation.length<1">
                                      <i class="fa fa-print fa-lg"></i></button>
                                      <input type="hidden" name="SelectedLocation"
																value="{{locctrl.selectedLocation}}" /> <input
																type="hidden" name="${_csrf.parameterName}"
																value="${_csrf.token}" />
                                      
                                      </form>
                                  	<!--===============search tab============== -->
									<div class="row paddingtop">
										<div class="col-md-12">
											<input type="text" class="form-control" name="search"
												placeholder="Ex: Chennai"
												data-ng-model="locctrl.location_search"
												data-ng-keyup="locctrl.registerSearch(locctrl.location_search)" />
										</div>
									</div>

									</div>
                                </div>
                              </div>
                            </div>
                                  
                          <!-- ==================================LOCATION TABLE============================= -->                        
                                <table 
                                class="table table-striped table-bordered table-hover" 
                                 id="dataTables-example">
                                    <thead>
                                        <tr>
                                        	<th><input type="checkbox"
                                        	data-ng-model="locctrl.selectAllLocation"
                                        	data-ng-click="locctrl.selectAll()"></th>
                                           <!--  <th data-ng-show="">S.No</th> -->
                                           <!-- <td >{{location_id}}</td> -->
                                            <th data-ng-show="setting_locName"
                                            data-ng-click="locationName=!locationName;sortTable('locationName',locationName);">Location Name<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':locationName,'fa fa-caret-down':!locationName}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_locCode"
                                             data-ng-click="locationCode=!locationCode;sortTable('locationCode',locationCode);">Location Code<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':locationCode,'fa fa-caret-down':!productName}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_abbr"
                                             data-ng-click="abbreviation=!abbreviation;sortTable('abbreviation',abbreviation);">Abbreviation<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':abbreviation,'fa fa-caret-down':!abbreviation}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_city"
                                             data-ng-click="locationCity=!locationCity;sortTable('locationCity',locationCity);">City<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':locationCity,'fa fa-caret-down':!locationCity}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_state"
                                             data-ng-click="locationState=!locationState;sortTable('locationState',locationState);">State<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':locationState,'fa fa-caret-down':!locationState}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_country"
                                             data-ng-click="locationCountry=!locationCountry;sortTable('locationCountry',locationCountry);">Country<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':locationCountry,'fa fa-caret-down':!locationCountry}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show="setting_pincode"
                                             data-ng-click="locationPincode=!locationPincode;sortTable('locationPincode',locationPincode);">Pincode<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':locationPincode,'fa fa-caret-down':!locationPincode}"
														aria-hidden="true"></i></th>   
                                            <th data-ng-show="setting_active"
                                             data-ng-click="locationActive=!locationActive;sortTable('locationActive',locationActive);">Active<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':locationActive,'fa fa-caret-down':!locationActive}"
														aria-hidden="true"></i></th>                                          
                                        </tr>
                                    </thead>
                                    
                                    <tbody>
                                      <tr 
                                       data-ng-repeat="x in locctrl.FilteredLocations | limitTo:pageSize  track by x.location_id"
	                	    			 data-ng-dblclick="updateLocation(x,$index)">                                            
                                            <td><input type="checkbox"
                                            data-ng-model="x.select"
                                            data-ng-click="locctrl.selectLocation(x);"></td>
                                            <!-- <td data-ng-show="">{{$index+1}}</td> -->
                                             <!-- <td >{{x.location_id}}</td> -->
                                            <td data-ng-show="setting_locName">{{x.location_name}}</td>
                                            <td data-ng-show="setting_locCode">{{x.location_code}}</td>
                                            <td data-ng-show="setting_abbr">{{x.abbreviation}}</td>
                                            <td data-ng-show="setting_city">{{x.address.city}}</td>
                                            <td data-ng-show="setting_state">{{x.address.state}}</td>
                                            <td data-ng-show="setting_country">{{x.address.country}}</td>
                                            <td data-ng-show="setting_pincode">{{x.pincode}}</td>
                                            <td
                                            data-ng-show="setting_active"
                                            data-ng-class="{'makeGreen':x.active=='Y','makeRed':x.active=='N'}">
                                            {{x.active=="Y"?"ACTIVE":"INACTIVE"}}</td>
                                          
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
                                <div class="col-lg-6  col-md-6 col-xs-12 icons-button">
                                
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
                      <!-- pager -->
                      

                </div>
            </div>
      </div>
      
            
        </div>
        <!-- /. PAGE WRAPPER  -->
		
    </div>
     </sec:authorize>
    <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
    
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
		                             Location Register
		                        </div>
		                        <div class="panel-body">
		                        	Sorry..! You are not authorized view this master..!
		                        </div>
		                      </div>
                		</div>
                	</div>
                </div>		
			 </div>
		</div>
	</sec:authorize>
	
	
    <!--====================================================== SCRIPTS START=========================================-->
      <script>$('[data-toggle="popover"]').popover();
      $('.regSettings').click(function(e) {
			e.stopPropagation();
		});
      </script>
    <script src="resources/custom/js/custom.js"></script>   
	<script type="text/javascript" src="resources/custom/js/validation.js"></script>
	<script type="text/javascript" src="resources/custom/js/Location/location_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/Address/address_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/Location/location_control.js"></script>
	  <script src="resources/custom/js/confirmDialog.js"></script>
	  <script type="text/javascript" src="resources/built-in/js/lodash.js"></script> 
   <!--====================================================== SCRIPTS END =========================================-->

</body>

</html>