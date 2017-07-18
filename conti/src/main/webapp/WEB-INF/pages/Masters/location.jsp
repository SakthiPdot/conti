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

    
    <title>${title}</title>
    <!-- Bootstrap Styles-->
    <link href="resources/built-in/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="resources/built-in/assets/css/font-awesome.css" rel="stylesheet" />
	
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	 
    <!-- Morris Chart Styles-->
    <link href="resources/built-in/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="resources/built-in/assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
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
 
 
<div class="success hideme"><i class="fa fa-check-circle" aria-hidden="true"></i> {{locctrl.message}}</div>
<div class="failure hideme"><i class="fa fa-times-circle" aria-hidden="true"></i> {{locctrl.message}}</div>
 
 
 		<div class="overlay hideme"></div>
 		
 		<form data-ng-submit="locctrl.submit()" name="locationForm">
 		<div class="drawer hideme">
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
							  data-placement="top" data-content="Please Enter Location Name"
			                  data-ng-model="locctrl.Location.location_name" 
			                  maxlength="50"
			                  class="form-control">
			                  
			                  <span>Location Code</span>
			                  <input type="text"
			                  data-trigger="focus" data-toggle="popover"
							  data-placement="top" data-content="Please Enter Location Code"							  
			                  onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value) "
							  maxlength="10"
			                  data-ng-model="locctrl.Location.location_code"
			                   class="form-control">
			                  
			                   <span>Abbreviation</span>
			                  <input type="text"			                  
			                  data-trigger="focus" data-toggle="popover"		              
							  onKeyPress="return CheckIsCharacterWithspace(event,this.value) "
							  data-placement="top" data-content="Please Enter Abbreviation"
			                  data-ng-model="locctrl.Location.abbreviation"
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
							 					  data-placement="top" data-content="Please Enter city"	
									              selected-object="city_name"
									              local-data="locctrl.addresses"
									              search-fields="city,state"
									              title-field="city,state"
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
			                  <input type="number" class="form-control"
			                   data-ng-required="true"
			                    data-trigger="focus" data-toggle="popover"
							 	data-placement="top" data-content="Please Enter Pincode"	
							 	min="100000"
								max="1000000 " 
								onKeyPress="return CheckIsNumericAndHyphen(event,this.value) "           
			                  data-ng-model="locctrl.Location.pincode">
			                  
	                		</div>
	                	</div>
	                	
	                	
	                	               
	                </div> 
	                
	                                
	                
	                </div>
                 
                 <div class="modal-footer footerHeight" >
				
				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-4 col-xs-4 footerLeft">
							<button type="button" class=" btn btn-danger  pull-left" data-ng-click="locctrl.close('Cancel')"  > <i class="fa fa-times" aria-hidden="true"></i>
							Cancel</button>
						</div>
						
						<div class="col-lg-4 col-xs-4" style="text-align:center; !important;">
							<a id="" class="btnPadding btn btn-warning"	 data-ng-click="locctrl.deleteLocation()"  data-ng-show="!(locctrl.Location.location_id== null)" ><i class="fa fa-trash"  aria-hidden="true"></i> &nbsp;Delete</a> 
							
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
 			
 			
 			
 		</div>
 		</form>
	
	<jsp:include page="../Dashboard/nav.jsp"/>

<sec:authorize access="hasRole('SUPER_ADMIN') or hasRole('MANAGER')">	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      
      		<div class="header "> 
             <div class="page-header header-size">
                 	  <b>${title}</b>
                 	  
                 	  <button class="btn btn-info  pull-right"   data-ng-click="locctrl.openDrawer();" >Add New Location</button>
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
								<button class="btn btn-info dropdown-toggle"
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

						</div> 
                                </div>
                                
                              <div class="col-lg-6 icons-button">
                                   <div class="pull-right">                                   
									<form name="selectedLocationform" method='POST' action="location_print">
                                     <a type="button" class="btn btn-info"><i class="fa fa-cog fa-lg"></i></a>
                                    <!--=============== excel============== -->
                                      <a type="button" onclick="location.href='downloadExcelLocation'" class="btn btn-info"><i class="fa fa-file-excel-o fa-lg"></i></a>
                                     <!--=============== print============== -->
                                      <button type="button" class="btn btn-info"><i class="fa fa-print fa-lg"></i></button>
                                      </form>
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
                                            <th>S.No</th>
                                            <th>Location Name</th>
                                            <th>Location Code</th>
                                            <th>Abbreviation</th>
                                            <th>City</th>
                                            <th>State</th>
                                            <th>Country</th>
                                            <th>Pincode</th>   
                                            <th>Active</th>                                          
                                        </tr>
                                    </thead>
                                    
                                    <tbody>
                                      <tr 
                                       data-ng-repeat="x in locctrl.Locations  track by x.location_id"
	                	    			 data-ng-dblclick="updateLocation(x,$index)">                                            
                                            <td><input type="checkbox"
                                            data-ng-model="x.select"
                                            data-ng-click="locctrl.selectLocation(x);"></td>
                                            <td>{{$index+1}}</td>
                                            <td>{{x.location_name}}</td>
                                            <td>{{x.location_code}}</td>
                                            <td>{{x.abbreviation}}</td>
                                            <td>{{x.address.city}}</td>
                                            <td>{{x.address.state}}</td>
                                            <td>{{x.address.country}}</td>
                                            <td>{{x.pincode}}</td>
                                            <td
                                            data-ng-class="{'makeGreen':x.active=='Y','makeRed':x.active=='N'}">
                                            {{x.active=="Y"?"ACTIVE":"INACTIVE"}}</td>
                                          
                                        </tr>                         
                                    </tbody>
                                </table>
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
      <script>$('[data-toggle="popover"]').popover();</script>
        
     
    <script src="resources/custom/js/custom.js"></script>   
	<script type="text/javascript" src="resources/custom/js/validation.js"></script>
	<script type="text/javascript" src="resources/custom/js/Location/location_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/Address/address_service.js"></script>
	<script type="text/javascript" src="resources/custom/js/Location/location_control.js"></script>
	  <script src="resources/custom/js/confirmDialog.js"></script>
   <!--====================================================== SCRIPTS END =========================================-->

</body>

</html>