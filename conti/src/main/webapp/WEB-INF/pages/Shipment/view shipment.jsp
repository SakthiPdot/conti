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
	 <link href="resources/custom/css/demo.css" rel="stylesheet">
	  <link href="resources/custom/css/custom.css" rel="stylesheet">
</head>


<body style="overflow-x:hidden;">
 
	
	<jsp:include page="../Dashboard/nav.jsp"/>
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      
      	    		
      		  <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default panelMarginBottom">                            
						
						<div class="panel-body customer-font">
						<b>Shipment</b>
						</div>
                        </div>
                    </div>
              </div>
                
              <div class="row">
              <div class="col-lg-12">
              	  <div class="GenLeftRight">
	              <div  class="subHead">
	              <b>${title}</b>
	              </div>
	              </div>
              </div>
              </div> 
                
                <div class="row">
                	<div class="col-lg-12">
                		<div class="col-lg-12 ">                		
                		<div class="panel panel-default">
                			<div class="panel-body">
                			     <div class="branch-heading">Branch</div>
                			     
                			     <div class="col-lg-12 noPaddingLeft"> 
                			      <div class="col-lg-3 branchclass">
                			      		<span class="text-padding">From</span>
                			      		<select class="form-control">
                			      			<option>Coimbatore</option>
                			      			<option>Chennai</option>
                			      			<option>Bangalore</option>
                			      		</select>
                			      </div>
                			      
                			       <div class="col-lg-3 branchclass">
                			      		<span class="text-padding">To</span>
                			      		<select class="form-control">
                			      			<option>--Select--</option>
                			      			<option>Coimbatore</option>
                			      			<option>Chennai</option>
                			      			<option>Bangalore</option>
                			      		</select>
                			      </div>
                			      </div>
                			      
                			      
                			     
                			      
                			      <div class="col-lg-12 noPaddingLeft"> 
                			        <div class="sec-padding">Specific Period</div>
                			      
                			     
                			      <div class="col-lg-3 branchclass">
                			      		      <span class="paddingtop">From  </span>   	                                       
                                          <div class="form-group input-group marginleftrightspace">
				                  
				                  
				                               <input type="text" class="form-control datepicker"/>
	                                            <span class="input-group-addon"><i class="fa fa-calendar"></i>
	                                            </span>
	                                          
	                                     </div>
                                           
                			      </div>
                			      
                			       <div class="col-lg-3 branchclass">
                			      		<span class="paddingtop">To</span>
                			      		  <div class="form-group input-group spacemarginleftright">
				                  
				                  
				                               <input type="text" class="form-control datepicker"/>
	                                            <span class="input-group-addon"><i class="fa fa-calendar"></i>
	                                            </span>
	                                          
	                                     </div>
                			      </div>
                			      </div>
                			       
                			       <div class="col-lg-12 noPaddingLeft subhead-padding"> 
                			       		<div class="col-lg-3 branchclass">
                			      		 <span class="text-padding">Status</span>	                	                                       
                                            <select class="form-control">
                                            	<option>--Select--</option>
                                            	<option>Booked</option>                                            	
                                            </select>
                                           
                			            </div>
                			            
                			            <div class="col-lg-3 branchclass">
                			      		 <span class="text-padding">Product</span>	                	                                       
                                            <select class="form-control">
                                            	<option>--Select--</option>
                                            	<option>Box</option>   
                                            	<option>Cover</option>                                            	
                                            </select>
                                           
                			            </div>
                			            
                			            <div class="col-lg-3 branchclass">
                			      		   <button class="btn btn-primary"> View Shipment</button>                                         
                			            </div>
                			            
                			        </div>
                			      
                			</div>
                		</div>
                		</div>
                	</div>
                </div>
                
                
                <div class="row">
                	<div class="col-lg-12">
                		<div class="col-lg-12 ">                		
                		<div class="panel panel-default">
                			<div class="panel-body">
                			     <div class="col-lg-12 noPaddingLeft"> 
                			       		<div class="col-lg-3 branchclass">
                			      		 <span class="text-padding boldletter">Search</span>	                	                                       
                                            <input type="text" class="form-control searchbar" placeholder="Manifest/LR No/Receipt No">                                           
                                        </div>
                			      </div>
                			</div>
                		</div>
                		</div>
                	</div>
                </div>
                                
                
                <div class="row">
                <div class="col-md-12">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                             View Shipment Register
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
								<!-- <ul class="dropdown-menu">
									<li><a href="#">Active</a></li>
									<li><a href="#">InActive</a></li>
									<li><a href="#">Archive</a></li>

								</ul> -->
								
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
                                            <th>Date</th>
                                            <th>LR No</th>
                                            <th>Product</th>
                                            <th>Origin</th>
                                            <th>Destination</th>
                                            <th>Sender</th>
                                            <th>Consignee</th>
                                            <th>Status</th>
                                            <th>Receipt</th>
                                            <th>Actions</th>
                                   
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><input type="checkbox"></td>
                                            <td>1</td>
                                            <td>15-09-2013</td>
                                            <td>LR7230</td>
                                            <td>Box</td>
                                            <td>Coimbatore</td>
                                            <td>Chennai</td>
                                            <td>Velu</td>
                                            <td>Tamil</td>
                                            <td>Status</td>
                                            <td>RE84267</td>
                                            <td>Actions</td>
                                        
                                       </tr>
                                    <tbody>
                                </table>
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
    
   <!--  <script src="resources/built-in/assets/js/jquery-1.10.2.js"></script>  -->
    <script src=" resources/custom/js/date-time-picker.min.js" ></script>
    
    <script> $('.datepicker').dateTimePicker();</script>

</body>

</html>