<!DOCTYPE html>
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
   
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}">
    
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
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css"> 
	
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	<link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	<link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	 <link href="resources/built-in/assets/Drawer/animate.css" rel="stylesheet" />
	 <link href="resources/custom/css/custom.css" rel="stylesheet">
    
     <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">
	 
    <script src="resources/built-in/assets/js/jquery-1.10.2.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script> 
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script>    
    <script src="resources/custom/js/app.js"></script>
    
</head>


<body style="overflow-x:hidden;" data-ng-app = "contiApp" data-ng-controller = "ServiceController as ctrl">
 
 <!-- ---------------------  Overlay for message begin  -------------------- -->
 		<div class="overlay hideme"></div>
 <!-- ---------------------  Overlay for message end ---------------------- -->	
 
 <!-- ----------------------  Success message begin -------------------------- -->
 		<div class="success hideme">
 			<i class="fa fa-check-circle"  aria-hidden="true"></i>{{ctrl.message}}
 			<span class="close" data-ng-click = "ctrl.forgot_animateClose()"><i class="fa fa-times" aria-hidden="true"></i></span>
 		</div>	
 <!-- ----------------------  Success message end  --------------------------- -->
 
 <!-- ----------------------  Failure message begin  ------------------------- -->
 		<div class="failure hideme">
 			<i class="fa fa-times-circle" aria-hidden="true"></i>{{ctrl.message}}
 		</div>
 
 <!-- ----------------------  Failure message end ----------------------------- -->
 		
 		
 		<div class="drawer hideme">
 		  <form data-ng-submit="ctrl.submit()" name="serviceForm" class="form-horizontal">
 			<div class="row">
 			<div class="col-lg-12 trowserHeader">
 				 
                   <div class="col-lg-6 col-md-8 col-sm-10 headerLeft">
                   		 <b class="model-title">Service {{ctrl.heading}}</b>
                   </div>
                   
                   <div class="col-lg-6 col-md-4 col-sm-2 headerRight">
                   		<i class="fa fa-times fa-2x drawerClose pull-right iconLeft" data-ng-click = "ctrl.close()"></i>
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
		                 	 
		                 	  <span>Service Name</span>
			                  <input type="text" class="form-control" maxlength="50" onKeypress = "return CheckIsCharacterWithspace(event,this.value)" 
			                  data-ng-model = "ctrl.service.service_name" data-trigger = "focus" data-toggle ="popover" data-placement="top" data-content ="Please Enter Service Name" required/>
			                  
			                   <span>Service Code</span>
			                  <input type="text" class="form-control" maxlength="6" onKeyPress = "return CheckIsAlphaNumeric(event)" data-ng-model = "ctrl.service.service_code" data-trigger = "focus"
			                  data-toggle="popover" data-placement="top" data-content = "Please Enter Service Code" required>
			               
			                </div>  
			             
			            </div>                
	                </div>
	                                
                 </div>
                 
                 <div class="modal-footer footerHeight">
				
				<div class="row">
					<div class="col-lg-12">
						<div class="col-lg-4 col-xs-4  footerLeft">
							<button type="button" class=" btn btn-danger drawerClose pull-left" data-ng-click = "ctrl.clear()" ><i class="fa fa-trash-o"></i> Clear</button>
						</div>
						
						 <div class="col-lg-4 col-xs-4" style="text-align:center; !important;">
							<!-- <a id="" class="btnPadding btn btn-warning" data-ng-click = "ctrl.deleteService" data-ng-show="ctrl.service.service_id! = null"><i class="fa fa-trash"  aria-hidden="true"></i> &nbsp;Delete</a> --> 
							
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
 
	
	<jsp:include page="../Dashboard/nav.jsp"/>
	
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
									<li><a href="#">Active</a></li>
									<li><a href="#">InActive</a></li>
									
								</ul>
								
							</div>
							

						</div> 
                                </div>
                              
                                <div class="col-xs-6 icons-button">
                                   <div class="pull-right">
                                     <button type="button" class="btn btn-primary"><i class="fa fa-cog fa-lg"></i></button>
                                      <button type="button" class="btn btn-primary"><i class="fa fa-file-excel-o fa-lg"></i></button>
                                      <button type="button" class="btn btn-primary"><i class="fa fa-print fa-lg"></i></button>
                                	</div>
                                </div>
                              </div>
                            </div>
                          
                            
                            
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox"></th>
                                            <th>S.No</th>
                                            <th>Service Name</th>
                                            <th>Service Code</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat = "service in ctrl.services | orderBy : 'service_name' "
                                        data-ng-dblclick = "ctrl.updateService(service)">
                                            <td><input type="checkbox"></td>
                                            <td>{{$index+1}}</td>
                                            <td>{{service.service_name}}</td>
                                            <td>{{service.service_code}}</td>
                                       </tr>
                                    </tbody>
                                </table>
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
     <script src="resources/custom/js/service_master/service_controller.js"></script>
     <script src="resources/custom/js/service_master/service_service.js"></script>
    <script src="resources/custom/js/confirmDialog.js"></script>   
    <script type="text/javascript" src="resources/custom/js/validation.js"></script>

    


  <script>$('[data-toggle="popover"]').popover();</script>

</body>

</html>