<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
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


<body style="overflow-x:hidden;" data-ng-app="contiApp" data-ng-controller="ManifestController as ctrl">
 
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
 		
	
	<jsp:include page="../Dashboard/nav.jsp"/>
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      
      	    		
      		  <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default panelMarginBottom">                            
						<div class="panel-heading">							
						</div>
						<div class="panel-body customer-font">
						<b>Manifest Detailed</b>
						</div>
                        </div>
                    </div>
              </div>
              
<!--               <div class="row"> -->
<!--               <div class="col-md-12"> -->
              	  
<!--               	  <div class="GenLeftRight"> -->
<!-- 	              <div  class="subHead"> -->
<%-- 	              <b>${title}</b> --%>
<!-- 	              </div> -->
<!-- 	              </div> -->
	              
<!-- 	          </div> -->
<!--               </div> -->
              
<!--               <div class="row"> -->
<!--                 	<div class="col-lg-12"> -->
<!--                 		<div class="col-lg-12 ">                		 -->
<!--                 		<div class="panel panel-default"> -->
<!--                 			<div class="panel-body"> -->
<!--                 			     <div class="col-lg-12  branch-heading">                 			       	 -->
<!--                 			      	<input type="checkbox" data-ng-model="SearchBy" data-ng-changed="ctrl.fetchAllBranches()"> Search By<br>       	                                        -->
<!-- 								 </div> -->
                			     
<!--                 			     <div class="col-lg-12 noPaddingLeft" data-ng-show="SearchBy">                 			       	 -->
<!--         			      		    <label class="radio-inline"> -->
<!--                                         <input type="radio" name="optionsRadiosInline"  -->
<!--                                         data-ng-click="ctrl.inwardManifest()" ><b>Inward(Received Manifest)</b> -->
<!--                                     </label> -->
<!--                                     <label class="radio-inline"> -->
<!--                                         <input type="radio" name="optionsRadiosInline"  data-ng-checked="SearchBy" data-ng-true-value="ctrl.outwardManifest()" -->
<!--                                         data-ng-click="ctrl.outwardManifest()"><b>Outward(Sent Manifest)</b> -->
<!--                                     </label>        	                                        -->
<!-- 								</div> -->
                			    
<!--                 		   </div> -->
<!--                 		</div> -->
<!--                 	</div> -->
<!--                 </div> -->
<!--                 </div> -->
              
<!--               <div class="row"> -->
<!--                 <div class="col-lg-12"> -->
<!--                 	 <div class="col-lg-12 ">                		 -->
<!--                 		<div class="panel panel-default"> -->
<!--                 			<div class="panel-body"> -->
<!--                 			     <div class="branch-heading">Branch</div> -->
                			     
<!--                 			     <div class="col-lg-12 noPaddingLeft">  -->
<!--                 			      <div class="col-lg-3 branchclass"> -->
<!--                 			      		<span class="text-padding">From</span> -->
<!--                 			      		<select class="form-control" data-ng-options ="branch.branch_name for branch in ctrl.branches" -->
<!--                 			      		 data-ng-model="ctrl.manifest.frombranch" data-ng-init="ctrl.branches[0].branch_id"> -->
<!--                 			      			<option value="">--Select--</option> -->
<!--                 			      		</select> -->
<!--                 			      </div> -->
                			      
<!--                 			       <div class="col-lg-3 branchclass"> -->
<!--                 			      		<span class="text-padding">To</span> -->
<!--                 			      		<select class="form-control" data-ng-options ="branch.branch_name for branch in ctrl.branches"  -->
<!--                 			      		data-ng-model="ctrl.manifest.tobranch"> -->
<!--                 			      			<option value=''>--Select--</option> -->
                			      			
<!--                 			      		</select> -->
<!--                 			      </div> -->
<!--                 			      </div> -->
                			      
<!--                 			      <div class="col-lg-12 noPaddingLeft">  -->
<!--                 			        <div class="sec-padding">Specific Period</div> -->
                			         
<!--                 			         <div class="col-lg-3 branchclass"> -->
<!-- 	                			      	<span class="paddingtop">From  </span>   	                                        -->
<!-- 	                                         <div class="form-group input-group marginleftrightspace"> -->
<!-- 					                                <input type="text" class="form-control datepicker1" data-ng-model="ctrl.fromdate" -->
<!-- 					                           			   data-trigger= "focus"data-toggle="popover" data-placement="top" -->
<!-- 					                            		   data-content="Please select from date"/> -->
<!-- 					                            	 <span class="input-group-addon"><i class="fa fa-calendar"></i></span> -->
<!-- 		                                     </div> -->
<!-- 	                                  </div> -->
                			      
<!--                 			         <div class="col-lg-3 branchclass"> -->
<!--                 			      		<span class="paddingtop">To</span> -->
<!--                 			      		  <div class="form-group input-group marginleftrightspace"> -->
<!-- 				                                <input type="text" class="form-control datepicker2" data-ng-model="ctrl.todate" -->
<!-- 													  data-trigger= "focus"data-toggle="popover" data-placement="top" -->
<!-- 					                            		data-content="Please select to date"/> -->
<!-- 	                                            <span class="input-group-addon"><i class="fa fa-calendar"></i> -->
<!-- 	                                            </span> -->
	                                          
<!-- 	                                     </div> -->
<!--                 			         </div> -->
                			      
<!--                 			      <div class="col-lg-2"> -->
<!--                 			      </div> -->
<!--                 			      <div class="col-lg-4 branchclass"> -->
<!--                 			      		 <button class="btn btn-primary" data-ng-click="ctrl.manifestFilter(ctrl.manifest)"> View Manifest</button> -->
<!--                                   </div> -->
                			        
                			        
<!--                 			      </div> -->
                			       
                			                      			      
<!--                 			</div> -->
<!--                 		</div> -->
<!--                 		</div> -->
<!--                 	</div> -->
<!--                 </div> -->
                
<!--                 <div class="row"> -->
<!--                 	<div class="col-lg-12"> -->
<!--                 		<div class="col-lg-12 ">                		 -->
<!--                 		<div class="panel panel-default"> -->
<!--                 			<div class="panel-body"> -->
<!--                 			     <div class="col-lg-12 noPaddingLeft">  -->
<!--                 			       		<div class="col-lg-3 branchclass"> -->
<!--                 			      		 <span class="text-padding boldletter">Search</span>	                	                                        -->
<!--                                             <input type="text" class="form-control searchbar" placeholder="Manifest/LR No" -->
<!--                                             data-ng-model="ctrl.manifest_regSearch" data-ng-keyup="ctrl.manifestSearch(ctrl.manifest_regSearch)">                                            -->
<!--                                         </div> -->
<!--                 			      </div> -->
<!--                 			</div> -->
<!--                 		</div> -->
<!--                 		</div> -->
<!--                 	</div> -->
<!--                 </div> -->
                
                
                
                <div class="row">
                <div class="col-md-12">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                             View Manifest Register
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
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
											<li><a href="#">Missing</a></li>
											<li><a href="#">Received</a></li>
										</ul>
										</div>
									</div> 
                                </div>
                              
                                <div class="col-xs-6 icons-button">
                                   <div class="pull-right">
                                   
                                   <form name="manifestPrint" method="POST" action="manifest_print" class="padding-button">
                                     <a type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog fa-lg"></i></a>
                                     	<div class="dropdown-menu regSettings pull-right" style="padding-right: 5px;">
                                     	
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_sltnumber == true, 'fa-times': setting_sltnumber == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_sltnumber=true" data-ng-model="setting_sltnumber" /> SL No
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_date == true, 'fa-times': setting_date == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_date=true" data-ng-model="setting_date" /> Date
											</label>
										</div>
										
											
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_lrnumber == true, 'fa-times': setting_lrnumber == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_lrnumber=true" data-ng-model="setting_lrnumber" /> LR Number
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_product == true, 'fa-times': setting_product == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_product=true" data-ng-model="setting_product" />Product
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_origin == true, 'fa-times': setting_origin == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_origin=true" data-ng-model="setting_origin" />Origin
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check': setting_destination == true, 'fa-times': setting_destination == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_destination=true" data-ng-model="setting_destination" />Destination
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check':setting_sender == true, 'fa-times': setting_sender == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_sender=true" data-ng-model="setting_sender" />Sender
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check':setting_consignee == true, 'fa-times': setting_consignee == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_consignee=true" data-ng-model="setting_consignee" />Consignee
											</label>
										</div>
										
										<div class ="checkbox">
											<label>
												<i class = "fa" data-ng-class="{'fa-check':setting_shipmentstatus == true, 'fa-times':setting_shipmentstatus == false}"></i>										
												<input type="checkbox" data-ng-init = "setting_shipmentstatus=true" data-ng-model="setting_shipmentstatus" />Status
											</label>
										</div>
										
									</div>
										<a type="button" class="btn btn-primary" onclick="location.href='downloadExcelManifest';valid = true;"><i class="fa fa-file-excel-o fa-lg"></i></a>
                                      	  <button type="submit" class="btn btn-primary" data-ng-disabled = "ctrl.selected_manifest.length == 0" ><i class="fa fa-print fa-lg"></i></button>
	                                      <input type = "hidden" name = "cust" value = "{{ctrl.selected_manifest}}" />
	                                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</form>
                                	</div>
                                </div>
                              </div>
                            </div>
                          	
                            
                            <input type="hidden" id="manifest_id" value="${m_id}" >
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox" data-ng-click="ctrl.manifestSelectall()" 
                                            data-ng-model="selectallmanifestdetailed"></th>
                                            
                                            <th data-ng-show="setting_sltnumber">SL no</th>
                                            <th data-ng-show="setting_date">Date</th>
                                            <th data-ng-show="setting_lrnumber">LR Number</th>
                                            <th data-ng-show="setting_product">Product</th>
                                            <th data-ng-show="setting_origin">Origin</th>
                                            <th data-ng-show="setting_destination">Destination</th>
                                            <th data-ng-show="setting_sender">Sender</th>
                                            <th data-ng-show="setting_consignee">Consignee</th>
                                            <th data-ng-show="setting_shipmentstatus">Status</th>
                                         
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat = "manifestdetailed in ctrl.FilterManifestdetailed">
                                        	<td><input type="checkbox" data-ng-click="ctrl.manifestDetailedSelect(manifestdetailed)"
                                        	 data-ng-model="manifestdetailed.select"></td>
                                            <td data-ng-show="setting_sltnumber" >{{$index+1}}</td>
                                            <td data-ng-show="setting_date">{{manifestdetailed.shipmentModel.created_datetime}}</td>
                                            <td data-ng-show="setting_lrnumber">{{manifestdetailed.shipmentModel.lrno_prefix}}</td>
                                            
                                            <td data-ng-show="setting_product">
                                          
                                           		<div data-ng-repeat = "shipmentdet in manifestdetailed.shipmentModel.shipmentDetail">
                                           			{{shipmentdet.product.product_name}}<span data-ng-if = !($last)>,</span>
                                           		</div>
                                            </td>
                                            
                                            <td data-ng-show="setting_origin">{{manifestdetailed.shipmentModel.sender_branch.branch_name}}</td>
                                            <td data-ng-show="setting_destination">{{manifestdetailed.shipmentModel.consignee_branch.branch_name}}</td>
                                            <td data-ng-show="setting_sender">{{manifestdetailed.shipmentModel.sender_customer.customer_name}}</td>
                                            <td data-ng-show="setting_consignee">{{manifestdetailed.shipmentModel.consignee_customer.customer_name}}</td>
                                            <td data-ng-show="setting_shipmentstatus">{{manifestdetailed.shipmentModel.status}}</td>
                                           
                                        </tr>
                                      </tbody>
                                </table>
                            </div>
                            
                            	<div class ="col-lg-6">
                                	<div class="pull-left">
                               			 Showing {{(currentPage*pageSize)+1}} to 
                               			 {{ (totalnof_records - (((currentPage+1)*pageSize))) > 0 ? (currentPage+1)*pageSize : totalnof_records }}
                               			 of {{totalnof_records}} entries
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

  
    <script src="resources/custom/js/custom.js"></script>
    <script src="resources/custom/js/manifest/view_manifest_controller.js"></script>
    <script src="resources/custom/js/manifest/view_manifest_service.js"></script>
    <script src="resources/custom/js/branch_master/branch_service.js"></script>

  <script src="resources/custom/js/confirmDialog.js"></script>   
  <script type="text/javascript" src="resources/custom/js/validation.js"></script>
    <script>
		$('[data-toggle="popover"]').popover();
		$('.regSettings').click(function(e) {
		    e.stopPropagation();
		});

   </script>

    <script type="text/javascript">

    function getDate(){
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1; //January is 0!
        var yyyy = today.getFullYear();

        if(dd<10) {
            dd = '0'+dd
        } 

        if(mm<10) {
            mm = '0'+mm
        } 

        today =  yyyy+'-'+mm+ '-'+ dd;
        return today;
    }
	    $('.datepicker1').dateTimePicker({
	        limitMax: getDate()
	    });
	    
	    $('.datepicker2').dateTimePicker({
	        limitMax: getDate()
	    });
        </script>

</body>

</html>