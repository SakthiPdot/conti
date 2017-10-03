<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib  prefix="c"  uri="http://java.sun.com/jsp/jstl/core" 
%>
<%@ page isELIgnored="false" %> 
<%@page session="true"%>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}">
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
	<link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	 <link href="resources/built-in/assets/Drawer/animate.css" rel="stylesheet" />
	 <link href="resources/custom/css/custom.css" rel="stylesheet">
    
     <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">
     <script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script type="text/javascript" src="resources/built-in/js/lodash.js"></script>
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <script src="resources/custom/js/app.js"></script>
    <!--  <link href="resources/custom/css/ng-table.min.css"> -->
</head>



<body style="overflow-x:hidden;" data-ng-app = "contiApp" data-ng-controller = "ServiceController as ctrl">
 
 <!-- ---------------------  Overlay for message begin  -------------------- -->
 		<div class="overlay hideme"></div>
 <!-- ---------------------  Overlay for message end ---------------------- -->	
 
 <!-- ----------------------  Success message begin -------------------------- -->
 		<div class="success hideme">
 			<i class="fa fa-check-circle"  aria-hidden="true"></i>  {{ctrl.message}}
 			<span class="close" data-ng-click = "ctrl.forgot_animateClose()"><i class="fa fa-times" aria-hidden="true"></i></span>
 		</div>	
 <!-- ----------------------  Success message end  --------------------------- -->
 
 <!-- ----------------------  Failure message begin  ------------------------- -->
 		<div class="failure hideme">
 			<i class="fa fa-times-circle" aria-hidden="true"></i>{{ctrl.message}}
 		</div>
 
 <!-- ----------------------  Failure message end ----------------------------- -->
 		
 		
 		<div class="drawer hideme">
 		  <form data-ng-submit="ctrl.submit()" name="serviceForm" class="formBottom form-horizontal">
 			<div class="row">
 			<div class="col-lg-12 trowserHeader">
 				 
                   <div class="col-lg-10 col-md-8 col-sm-10 headerLeft">
                   		 <b class="model-title">Service {{ctrl.heading}}</b>
                   </div>
                   
                   <div class="col-lg-2 col-md-4 col-sm-2 headerRight">
                   		<i class="fa fa-times fa-2x drawerClose pull-right iconLeft" data-ng-click = "ctrl.close('Close')"></i>
                   </div>
            
             </div>
 			</div>
               
                 
                 
                 <input type="hidden" data-ng-model ="ctrl.service.service_id"/>
                 <div class="model-body">
                 
                 
                  <div class="row">
			                <div class="col-lg-12 title_area">	                
			                 	<div class="col-lg-12 new-masters" >
					          		 <b data-ng-show = "ctrl.service.service_id == null">New Service</b>	
					          	</div> 
				            </div>                
		          </div>
		             
	                <div class="row">
		                <div class="col-lg-12">
			                
			               <div class="col-lg-12 content-body">
		                 	 
		                 	  <span>Service Name<span class="required"> *</span></span>
			                  <input type="text" class="form-control" maxlength="50"
			                   onKeypress = "return CheckIsCharacterWithspace(event,this.value)" 
			                   data-ng-blur = "ctrl.checkServiceName(ctrl.service.service_name)"
			                   data-ng-model = "ctrl.service.service_name" 
			                   data-trigger = "focus" data-toggle ="popover" data-placement="top"
			                   data-content ="Please enter service name" placeholder="Ex : Counter" required/>
			                   <span class="makeRed" data-ng-show ="nameWrong">Service Name Already Existing..!</span><br>
			                  
			                   <span>Service Code</span>
			                  <input type="text" class="form-control" maxlength="6" onKeyPress = "return CheckIsAlphaNumeric(event)" data-ng-model = "ctrl.service.service_code" data-trigger = "focus"
			                  data-toggle="popover" data-placement="top" data-content = "Please enter service code" placeholder= "Ex : S001">
			               
			                </div>  
			             
			            </div>                
	                </div>
	                                
                 </div>
                 
                 <div class="modal-footer footerHeight">
				
				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-4 col-xs-4  footerLeft">
							<button type="button" class=" btn btn-warning pull-left" data-ng-click = "ctrl.close('Cancel')" ><i class="fa fa-ban"></i> Cancel</button>
						</div>
						
						 <div class="col-lg-4 col-xs-4" style="text-align:center; !important;">
							<a id="" class="btnPadding btn btn-danger" data-ng-click = "ctrl.deleteService()" data-ng-show="ctrl.service.service_id!=null"><i class="fa fa-trash"  aria-hidden="true"></i>  Delete</a> 
							
							<a id="" class="btnPadding btn btn-primary" data-ng-click="ctrl.clear()" data-ng-show="!serviceForm.$pristine && (ctrl.service.service_id==null)"><i class="fa fa-eraser"></i> Clear</a>							
						</div> 
						
						<div class="col-lg-4 col-xs-4 footerRight" data-ng-show="!(ctrl.service.service_id==null)" >
								<button class="btn btn-success" type="submit" id="saveclose" data-id="0" 
								data-ng-click ="save($event)" type="submit">
								<i class="fa fa-floppy-o"></i> Update</button>
						</div>
					
						<div class="col-lg-4 col-xs-4  footerRight"  data-ng-show="ctrl.service.service_id==null">
							<div class="btn-group dropup" id="savebutton">
								<button type="submit" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
								aria-expended="false">
								<i class="fa fa-floppy-o"></i>  Save
								</button>
						
							
							<div class="dropdown-menu pull-right" style="padding-right: 5px;">
								<button class="farmsave mybutton" id="saveclose" data-id="0"
								data-ng-click="save($event)" type="submit">
								Save and Close
								</button>
								
								<button class="farmsave mybutton" id="savenew" data-id="1"
								data-ng-click = "save($event)" type="submit">
								Save and New
								</button>
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
                 	  
                 	  <button class="btn btn-primary drawerOpen pull-right" onClick="drawerOpen('.drawer')" >Add New Service</button>
             </div>	
             
             										
		 </div>
      		
     <div id="page-inner">  
		 <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                             Service Register
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
                                   <form name="servicePrint" target="_blank" method = "POST" action = "service_print" class="padding-button" >
                                     <a type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a> 
                                     <div class="dropdown-menu regSettings pull-right" style="padding-right: 5px;">
                                     	<div class ="checkbox">
                                     		<label>
                                     			<i class = "fa" data-ng-class="{'fa-check': setting_servicename == true, 'fa-times': setting_servicename == false}"></i>
												<input type="checkbox" data-ng-init = "setting_servicename=true" data-ng-model="setting_servicename" /> Service Name
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_servicecode == true, 'fa-times': setting_servicecode == false}"></i>
												<input type="checkbox" data-ng-init = "setting_servicecode=true" data-ng-model="setting_servicecode" /> Service Code
											</label>
										</div>
										
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_servicestatus == true, 'fa-times': setting_servicestatus == false}"></i>
												<input type="checkbox" data-ng-init = "setting_servicestatus=true" data-ng-model="setting_servicestatus" /> Status
											</label>
										</div>
										
									</div>	
							
                                      <a type="button" class="btn btn-primary" onclick="location.href='downloadExcelService';valid = true;"><i class="fa fa-file-excel-o fa-lg"></i></a>
                                      
                                      
	                                      <button type="submit" class="btn btn-primary" data-ng-disabled = "ctrl.selected_service.length == 0"><i class="fa fa-print fa-lg"></i></button>
	                                      <input type = "hidden" name = "service" value = "{{ctrl.selected_service}}" />
	                                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                      </form>
                                      
                                      <div class="row paddingtop">
                                      	<div class="col-md-12">
                                      		<input type="text" class="form-control" name="search" placeholder ="Search" data-ng-model = "ctrl.service_regSearch" data-ng-keyup = "ctrl.registerSearch(ctrl.service_regSearch)"/>
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
                                            <th><input type="checkbox" data-ng-click="ctrl.servSelectall()" data-ng-model = "selectall"></th>
                                         <!--    <th>S.No</th> -->
                                            <th data-ng-show = "setting_servicename"
                                             data-ng-click="serviceName=!serviceName;sortTable('serviceName',serviceName);">Service Name<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':serviceName,'fa fa-caret-down':!serviceName}"
														aria-hidden="true"></i></th>
                                              
                                            <th data-ng-show = "setting_servicecode"
                                             data-ng-click="serviceCode=!serviceCode;sortTable('serviceCode',serviceCode);">Service Code<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':serviceCode,'fa fa-caret-down':!serviceCode}"
														aria-hidden="true"></i></th>
                                            <th data-ng-show = "setting_servicestatus"
                                            data-ng-click="serviceStatus=!serviceStatus;sortTable('serviceStatus',serviceStatus);">Status<i
														data-ng-hide="disableSorting"
														data-ng-class=" {'fa fa-caret-up':serviceStatus,'fa fa-caret-down':!serviceStatus}"
														aria-hidden="true"></i></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat = "service in ctrl.Filterservices  |  limitTo:pageSize    "
                                        data-ng-dblclick = "ctrl.updateService(service)">
                                            <td><input type="checkbox" data-ng-change="ctrl.servSelect(service)" data-ng-model = "service.select"/></td>
                                        <!--     <td>{{$index+1}}</td> -->
                                            <td data-ng-show = "setting_servicename">{{service.service_name}}</td>
                                            <td data-ng-show = "setting_servicecode">{{service.service_code}}</td>
                                            <td data-ng-show = "setting_servicestatus" data-ng-class="{'makeGreen' : service.active=='Y', 'makeRed' : service.active=='N'}">{{service.active == 'Y' ? 'ACTIVE' : 'INACTIVE'}}</td>
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
		                             Service Register
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
     <script src="resources/custom/js/service_master/service_controller.js"></script>
     <script src="resources/custom/js/service_master/service_service.js"></script>
    <script src="resources/custom/js/confirmDialog.js"></script>   
    <script type="text/javascript" src="resources/custom/js/validation.js"></script>
<!--      <script type="resources/custom/js/ng-table.min.js"></script> --> 

    


  <script>
		$('[data-toggle="popover"]').popover();
		$('.regSettings').click(function(e) {
		    e.stopPropagation();
		});
	</script>
	<script type="text/javascript">
	$('input[type=text]').blur(function(){ 
	    $(this).val($.trim($(this).val()));
	});
	</script>


</body>

</html>