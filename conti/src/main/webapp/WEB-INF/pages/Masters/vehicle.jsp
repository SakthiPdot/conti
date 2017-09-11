
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib
    prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
<%@ page isELIgnored="false" %> 
<%@ page session="true"%>
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
	 
	  <link href="resources/built-in/assets/Drawer/animate.css" rel="stylesheet" />
	 <!-- Morris Chart Styles-->
    <link href="resources/built-in/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="resources/built-in/assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <!--<link href='http://fonts.googleapis.com/css\?family=Open+Sans' rel='stylesheet' type='text/css' />-->
    <link rel="stylesheet" href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css"> 
	
	
	<link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	<link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
	 <link href="resources/custom/css/custom.css" rel="stylesheet">
    
     <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">
   
    <script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script type="text/javascript" src="resources/built-in/js/lodash.js"></script>
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <script src="resources/custom/js/app.js"></script>
</head>


<body style="overflow-x:hidden;" data-ng-app = "contiApp" data-ng-controller = "VehicleController as ctrl">
 
 
<!-- ------------------------- Success message begin ------------------ -----  -->
	<div class="success hideme">
		<i class="fa fa-check-circle" aria-hidden="true"></i> {{ctrl.message}}
		<span class="close" data-ng-click = "ctrl.forgot_animateClose()"><i class="fa fa-times" aria-hidden="true"></i></span>
	</div>
<!-- ------------------------- Success message end ------------------ -----  -->

<!-- ------------------------- Failure message begin ------------------ -----  -->	
	<div class="failure hideme">
		<i class="fa fa-times-circle" aria-hidden="true"></i> {{ctrl.message}}
		
	</div>
<!-- ------------------------- Failure message end ------------------ -----  -->
 		<!-- ------------------------- Overlay for message begin ------------------ -----  -->
	<div class="overlay hideme"></div>
<!-- ------------------------- Overlay for message end ------------------ -----  -->	
 		
 		<div class="drawer hideme">
 		  <form data-ng-submit= "ctrl.submit()" name="vehicleForm" class="form-horizonal formBottom">
 			<div class="row">
 			<div class="col-lg-12 trowserHeader">
 				 
                   <div class="col-lg-10 col-md-8 col-sm-10 headerLeft">                   		 
                   <b class="model-title">Vehicle {{ctrl.heading}}</b>
                   </div>
                   
                   <div class="col-lg-2 col-md-4 col-sm-2 headerRight">
                   		<i class="fa fa-times fa-2x drawerClose  pull-right iconLeft" data-ng-click = "ctrl.close('Close')"></i>
                   </div>
            
             </div>
 			</div>
               
                 
                <input type="hidden" data-ng-model = "ctrl.vehicle.vehicle_id"/> 
                 <div class="model-body">
                 
                 		 <div class="row">
			                <div class="col-lg-12 title_area">	                
			              
				          	<div class="col-lg-12 new-masters" >
				          		 <b data-ng-show = "ctrl.vehicle.vehicle_id == null"> New Vehicle</b>	
				          	</div> 
				            
				            </div>                
		                 </div> 
		             
	                <div class="row">
		                <div class="col-lg-12">
			                
			               <div class="col-lg-12 content-body">
		                 	 
		                 	  <span>Vehicle Reg No<span class="required"> *</span></span>  
			                  <input type="text" class="form-control" maxlength="30" onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)"
			                  data-ng-blur = "ctrl.checkVehicleRegno(ctrl.vehicle.vehicle_regno)"
			                   data-ng-model= "ctrl.vehicle.vehicle_regno"
			                   data-trigger="focus" data-toggle="popover" data-placement="top" 
			                   data-content="Please Enter Vehicle Reg No" required>
			                  <span class="makeRed" data-ng-show = "nameWrong"> Vehicle RegNo Already Existing..!<br></span>
			                  
			                  <span>Vehicle Code</span>
			                 <input type="text" class="form-control" maxlength="6" onKeyPress="return CheckIsAlphaNumeric(event)" data-ng-model="ctrl.vehicle.vehicle_code" data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Vehicle code"/>
			                  
			                   <span>Branch Name <span class="required"> *</span></span>
			                   <angucomplete-alt id="branch_name" data-ng-model="ctrl.vehicle.branch_name"
						              placeholder="Ex : Coimbatore"
						              pause="100"
						              selected-object="branch_name"
						              local-data="ctrl.branches"
						              search-fields="branch_name"
						              title-field="branch_name"
									  match-class="highlight"
									  initial-value="{{ctrl.vehicle.branchModel.branch_name}}"
						              minlength="1"
						              field-required="true"
						              data-trigger="focus" data-toggle="popover" 
						              data-placement="top" data-content="Please Enter Vehicle Branch Name"
						              onKeyPress="return CheckIsCharacter(event)"
						              input-class="form-control form-control-small">
              				</angucomplete-alt>

			           		<input type="hidden" id = "branch_id" name ="branch_id" value = "{{branch_name.originalObject}}" />
			                  
			                  <span>Vehicle Model No<span class="required"> *</span></span>
			                 <input type="text" class="form-control" maxlength="25" data-ng-model="ctrl.vehicle.vehicle_modelno" data-trigger="focus" 
			                 onKeyPress="return CheckIsAlphaNumericWithspace(event,this.value)" data-toggle="popover" data-placement="top" data-content="Please Enter Vehicle Model No" required />
			                  
			                  <span> Vehicle Type<span class="required"> *</span></span>
			              <!--    <input type="text" class="form-control" maxlength="50" onKeyPress="return CheckIsCharacterWithspace(event,this.value)"  data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Vehicle Type" -->
			                    <!-- required /> -->
			                    <angucomplete-alt id="vehicle_type" data-ng-model ="ctrl.vehicle.vehicle_type"
						              
						              pause="100"
						              selected-object="vehicle_type"
						              remote-url = "vehicleType/"
			                          remote_url-data-field = "VehicleType"
						              search-fields="vehicle_type"
						              title-field="vehicle_type"
									  match-class="highlight"
									  initial-value="{{ctrl.vehicle.vehicle_type}}"
						              minlength="1"
						              field-required="true"
						              data-trigger="focus" data-toggle="popover" 
						              data-placement="top" data-content="Please Enter Vehicle Type"
						              onKeyPress="return CheckIsCharacter(event)"
						              input-class="form-control form-control-small">
              				</angucomplete-alt>
			                    
			                    
			                   <!--  <angucomplete-alt id="vehicle_type" 
			                   	 pause="100"
			                    selected-object = "vehicle_type"
			                    remote-url = "vehicleType/"
			                    remote_url-data-field = "VehicleType"
			                    search-fields = "vehicle_type"
			                    title-fields = "vehicle_type"
			                    match-class="highlight"
			                    minlength="1"
			                    field-required="true"
			                    initial-value = ""
			                    input-class="form-control form-control-small ">
			                    </angucomplete-alt> -->
			               
			             </div>  
			             
			                
			                	                
		                </div>                
	                </div>                
                 </div>
                 
                 <div class="modal-footer footerHeight">
				
				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-4 col-xs-4 footerLeft">
							<button type="button" class=" btn btn-warning pull-left" data-ng-click="ctrl.close('Cancel')"><i class="fa fa-ban"></i> Cancel</button>
						</div>
						
						<div class="col-lg-4 col-xs-4" style="text-align:center; !important;">
						   <a id="" class="btnPadding btn btn-danger" data-ng-click="ctrl.deleteVehicle()" data-ng-show="ctrl.vehicle.vehicle_id!=null"><i class="fa fa-trash"  aria-hidden="true"></i>  Delete</a>
							
							<a id="" class="btnPadding btn btn-primary" data-ng-click = "ctrl.clear()" data-ng-show="!vehicleForm.$pristine && (ctrl.vehicle.vehicle_id==null)"><i class="fa fa-eraser"></i> Clear</a>							
						</div>
						
						
						<div class="col-lg-4 col-xs-4 footerRight" data-ng-show="!(ctrl.vehicle.vehicle_id== null)">
							<button class="btn btn-success " type="submit"
								
								id="saveclose" data-id="0" data-ng-click="save($event)"
								type="submit">
								<i class="fa fa-floppy-o "> </i> Update</button>
							<br>
						</div>
						
						<div class="col-lg-4 col-xs-4 footerRight" data-ng-show = "ctrl.vehicle.vehicle_id==null">

							<div class="btn-group dropup" id="savebutton">
						 	 <button type="submit" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false">
									<i class="fa fa-floppy-o "></i> Save
							</button>
							<div class="dropdown-menu pull-right" style="padding-right: 5px;">
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
                 	  
                 	  <button class="btn btn-primary drawerOpen pull-right" onClick="drawerOpen('.drawer')" >Add New Vehicle</button>
             </div>
             </div>
      		
      		<div id="page-inner">  
		 <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                             Vehicle Master
                        </div>
                        <div class="panel-body">
                        
                        <div class="row">
                              <div class="col-lg-12">
                               <div class="col-xs-6">
                                   		<div class="dataTables_length" id="dataTables-example_length">
							<div class="dropdown">
								<button class="btn btn-primary dropdown-toggle"
									type="button" data-toggle="dropdown">
									Batch Action <span class="caret"></span>
								</button>
								<ul class="dropdown-menu">
									<li><a data-ng-click = "ctrl.makeActive()">Active</a></li>
									<li><a data-ng-click = "ctrl.makeinActive()">InActive</a></li>
								

								</ul>
								
							</div>
					
					
					       <div class="row paddingtop">
								<div class="col-md-12">
									<select name="shownoofrec" data-ng-model="shownoofrec" data-ng-options = "noofrec for noofrec in [10, 15, 25, 50, 100]" class="form-control" data-ng-change = "ctrl.shownoofRecord()">
									</select>
								</div>
							</div>
					
					

						</div>  
                                </div>
                                
                                <div class="col-xs-6 icons-button">
                                   <div class="pull-right">
                                   <form name = "vehiclePrint" method = "POST" action = "vehicle_print" class="padding-button">
                                     <a type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a>
                                    <div class="dropdown-menu regSettings pull-right" style="padding-right: 5px;">
                                  
										
										<div class="checkbox">
                                      			<label>
                                      				<i class="fa" data-ng-class="{'fa-check': setting_vehicleregno == true, 'fa-times': setting_vehicleregno == false}"></i>
                                      				<input type="checkbox" data-ng-init = "setting_vehicleregno=true" data-ng-model ="setting_vehicleregno"/> Vehicle RegNo
                                      			</label>
                                      	</div>
                                      	
                                      	
                                      		 <div class="checkbox">
                                      			<label>
                                      				<i class="fa" data-ng-class = "{'fa-check' : setting_vehiclecode == true, 'fa-times': setting_vehiclecode == false}"></i>
                                      				<input type="checkbox" data-ng-init = "setting_vehiclecode=true" data-ng-model = "setting_vehiclecode"/> Vehicle Code
                                      			</label>
                                      		</div>
                                      		
                                      		<div class="checkbox">
                                      			<label>
                                      				<i class="fa" data-ng-class="{'fa-check' : setting_branchname == true, 'fa-times' : setting_branchname == false}"></i>
                                      				<input type="checkbox" data-ng-init = "setting_branchname = true" data-ng-model = "setting_branchname"/> Branch Name
                                      			</label>
                                      		</div>
                                      		
                                      		<div class="checkbox">
                                      			<label>
                                      				<i class="fa" data-ng-class="{'fa-check' : setting_vehiclemodelno == true, 'fa-times' : setting_vehiclemodelno == false}"></i>
                                      				<input type="checkbox" data-ng-init = "setting_vehiclemodelno = true" data-ng-model = "setting_vehiclemodelno"/> Vehicle Model No
                                      			</label>
                                      		</div>
                                      		
                                      		<div class="checkbox">
                                      			<label>
                                      				<i class="fa" data-ng-class="{'fa-check': setting_vehicletype == true, 'fa-times' : setting_vehicletype == false}"></i>
                                      				<input type="checkbox" data-ng-init = "setting_vehicletype = true" data-ng-model = "setting_vehicletype"/> Vehicle Type
                                      			</label>
                                      		</div>
                                      		
                                      		<div class="checkbox">
                                      			<label>
                                      				<i class="fa" data-ng-class="{'fa-check': setting_vehiclestatus == true, 'fa-times' : setting_vehiclestatus == false}"></i>
                                      				<input type="checkbox" data-ng-init = "setting_vehiclestatus = true" data-ng-model = "setting_vehiclestatus"/> Status
                                      			</label>
                                      		</div> 
                                      		
									</div>
                                     
                                      <a type="button" class="btn btn-primary" onclick="location.href='downloadExcelVehicle';valid = true;"><i class="fa fa-file-excel-o fa-lg"></i></a>
                                      
                                      <button type="submit" class="btn btn-primary" data-ng-disabled = "ctrl.selected_vehicle.length == 0"><i class="fa fa-print fa-lg"></i></button>
                                      <input type="hidden" name="vehicle" value = "{{ctrl.selected_vehicle}}"/>
                                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                	</form>
                                	
                                	  <div class="row paddingtop">
                                      	<div class="col-md-12">
                                      		<input type="text" class="form-control" name="search" placeholder ="Search" data-ng-model = "ctrl.vehicle_regSearch" data-ng-keyup = "ctrl.registerSearch(ctrl.vehicle_regSearch)"/>
                                      	</div>
                                      </div>
                                      
                                      
                                	</div>
                                </div>
                              </div>
                            </div>
                          
                            <div class="table-responsive">
                             <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox" data-ng-click="ctrl.vehicSelectall()" data-ng-model = "selectall"/></th>
                                            <!-- <th>S.No</th> -->
                                            <th data-ng-show = "setting_vehicleregno"
                                             data-ng-click="vehicleRegNo=!vehicleRegNo;sortTable('vehicleRegNo',vehicleRegNo);">Vehicle Reg No<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':vehicleRegNo,'fa fa-caret-down':!vehicleRegNo}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_vehiclecode"
                                             data-ng-click="vehicleCode=!vehicleCode;sortTable('vehicleCode',vehicleCode);">Vehicle Code<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':vehicleCode,'fa fa-caret-down':!vehicleCode}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_branchname"
                                            data-ng-click="branchName=!branchName;sortTable('branchName',branchName);">Branch Name<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':branchName,'fa fa-caret-down':!branchName}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_vehiclemodelno"
                                            data-ng-click="vehicleModelNo=!vehicleModelNo;sortTable('vehicleModelNo',vehicleModelNo);">Vehicle Model No<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':vehicleModelNo,'fa fa-caret-down':!vehicleModelNo}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_vehicletype"
                                            data-ng-click="vehicleType=!vehicleType;sortTable('vehicleType',vehicleType);">Vehicle Type<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':vehicleType,'fa fa-caret-down':!vehicleType}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_vehiclestatus"
                                            data-ng-click="vehicleStatus=!vehicleStatus;sortTable('vehicleStatus',vehicleStatus);">Status<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':vehicleStatus,'fa fa-caret-down':!vehicleStatus}"
														aria-hidden="true"></i></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat = "vehicle in ctrl.Filtervehicles | limitTo:pageSize" 
                                        data-ng-dblclick = "ctrl.updateVehicle(vehicle)">
                                            <td><input type="checkbox" data-ng-change= "ctrl.vehicSelect(vehicle)" data-ng-model = "vehicle.select"></td>
                                           <!--  <td>{{$index+1}}</td> -->
                                            <td data-ng-show = "setting_vehicleregno">{{vehicle.vehicle_regno}}</td>
                                            <td data-ng-show = "setting_vehiclecode">{{vehicle.vehicle_code}}</td>
                                            <td data-ng-show = "setting_branchname">{{vehicle.branchModel.branch_name}}</td>
                                            <td data-ng-show = "setting_vehiclemodelno">{{vehicle.vehicle_modelno}}</td>
                                            <td data-ng-show = "setting_vehicletype">{{vehicle.vehicle_type}}</td>
                                            <td data-ng-show = "setting_vehiclestatus" data-ng-class="{'makeGreen': vehicle.active == 'Y', 'makeRed' : vehicle.active=='N'}">{{vehicle.active == 'Y' ? 'ACTIVE' : 'INACTIVE'}}</td>
                                       </tr>
                                                      
                                    </tbody>
                                </table>
                            </div>
                            
                            <div class ="col-lg-6">
                                	<div class="pull-left">
                               			 Showing {{(currentPage*pageSize)+1}} to 
                               			 {{ (totalnoof_records - (((currentPage+1)*pageSize))) > 0 ? (currentPage+1)*pageSize : totalnoof_records }}
                               			 of {{totalnoof_records}} entries
                               		</div>
                             </div>
                            
                             <div class="col-lg-6 icons-button">
                                	<div class="pull-right">
                                		<button class="btn btn-primary" type="button" data-ng-disabled = "previousDisabled" data-ng-click = "firstlastPaginate(1)">First</button>
                                		<button class="btn btn-primary" type="button" data-ng-disabled = "previousDisabled" data-ng-click = "paginate(-1)">Previous</button>
                                		<button class="btn btn-primary" type="button" data-ng-disabled = "nextDisabled" data-ng-click = "paginate(1)">Next</button>
                                		<button class="btn btn-primary" type="button" data-ng-disabled = "nextDisabled" data-ng-click = "firstlastPaginate(0)">Last</button>
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
    </sec:authorize>
    <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
    <!-- jQuery Js -->
    
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
		                             Vehicle Register
		                        </div>
		                        <div class="panel-body">
		                        	Sorry..! You have no authorized for view this master..!
		                        </div>
		                      </div>
                		</div>
                	</div>
                </div>		
			 </div>
		</div>
	</sec:authorize>
   
  <script src="resources/custom/js/custom.js"></script>
  <script src="resources/custom/js/vehicle_master/vehicle_controller.js"></script>
  <script src="resources/custom/js/vehicle_master/vehicle_service.js"></script>
  <script src="resources/custom/js/branch_master/branch_service.js"></script>  
  <script src="resources/custom/js/confirmDialog.js"></script>   
  <script type="text/javascript" src="resources/custom/js/validation.js"></script>
  <!-- Custom Js -->

	<script>
		$('[data-toggle="popover"]').popover();
		$('.regSettings').click(function(e) {
		    e.stopPropagation();
		});
	</script>

</body>

</html>