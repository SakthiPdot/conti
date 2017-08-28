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
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="resources/built-in/assets/js/Lightweight-Chart/cssCharts.css"> 
	
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	  <link href="resources/custom/css/custom.css" rel="stylesheet">
	  
	   <link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
</head>


<body style="overflow-x:hidden;">
 
	
	<jsp:include page="../Dashboard/nav.jsp"/>
	
    <div id="wrapper">        	  
		<div id="page-wrapper">	 
      
      	    		
   		   <div class="row">
                 <div class="col-lg-12">
                     <div class="panel panel-default">
                     <div class="panel-body customer-font">
						<b>${title}</b>
					 </div>
                     </div>
                 </div>
           </div>
                
                
                
           <div class="row">
               <div class="col-lg-12">
               
               		<div class="col-lg-4">
               		</div>
                
					<div class="col-lg-4">
						<div class="panel panel-default">                            
							<div class="panel-heading">
								 Filter by
							</div>
						
						<div class="panel-body customer-field">
                                   
                                   <label class="radio-inline">
                                       <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" value="option1"> Date Wise
                                   </label>
                                   <label class="radio-inline">
                                       <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" value="option2"> Branch Wise
                                   </label>
                                   <label class="radio-inline">
                                       <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline3" value="option3"> LR No Wise
                                   </label>
                                   <label class="radio-inline">
                                   	<input type="radio" name="optionsRadiosInline" id="optionsRadiosInline4" value="option4" checked> All
                                   </label>
							
						</div>
			            </div>  
			        </div>
		
                   <div class="col-lg-4">
                   </div>
                   
               </div>
           </div>
                
                
                
                
                
                <div class="row">
                <div class="col-lg-12">
                <div class="col-lg-12">
                <div class="panel panel-default">                            
						
				<div class="panel-body">
				<div class="branch-heading">Shipment</div>
				
				<div class="col-lg-12 noPaddingLeft">
					<div class="col-lg-3 report_class">
						<span>From</span>
					       <div class="form-group input-group">
                                  <input type="text" class="form-control">
                                  <span class="input-group-btn">
                                      <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i>
                                      </button>
                                  </span>
                            </div>
					</div>
					
					<div class="col-lg-3 report_class">
						<span>To</span>
					       <div class="form-group input-group">
                                  <input type="text" class="form-control">
                                  <span class="input-group-btn">
                                      <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i>
                                      </button>
                                  </span>
                            </div>
					</div>
					
					<div class="col-lg-3 report_class report_padding">
						<select class="form-control">
							<option>-- Select --</option>
							<option>And</option>
							<option>OR</option>
						</select>
					</div>
					
					<div class="col-lg-3 report_class">
						<span>Date Filter</span>
					       <select class="form-control">
					       		<option>-- Select --</option>
					       		<option>Today</option>
					       		<option>This Week</option>
					       		<option>This Month</option>
					       		<option>This Quater</option>
					       </select>
					</div>
				</div>
				
				<div class="col-lg-12 noPaddingLeft">
					<div class="sec-padding">Branch</div>
					<div class="col-lg-3 branchclass">
						<span class="text-padding">From </span>
						<select class="form-control">
							<option>-- Select --</option>
							<option>Chennai</option>
							<option>Coimbatore</option>
							<option>Bangalore</option>
						</select>
					</div>
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">To </span>
						<select class="form-control">
							<option>-- Select --</option>
							<option>Chennai</option>
							<option>Coimbatore</option>
							<option>Bangalore</option>
						</select>
					</div>
					
					<div class="col-lg-3 report_class">
						<select class="form-control">
							<option>-- Select --</option>
							<option>And</option>
							<option>OR</option>
						</select>
					</div>
					
				</div>
				
				
				<div class="col-lg-12 noPaddingLeft">
					<div class="sec-padding">LR No</div>
					<div class="col-lg-3 branchclass">
						<span class="text-padding">From </span>
						<select class="form-control">
							<option>-- Select --</option>
							<option>Chennai</option>
							<option>Coimbatore</option>
							<option>Bangalore</option>
						</select>
					</div>
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">To </span>
						<select class="form-control">
							<option>-- Select --</option>
							<option>Chennai</option>
							<option>Coimbatore</option>
							<option>Bangalore</option>
						</select>
					</div>
					
					<div class="col-lg-3 report_class">
						<select class="form-control">
							<option>-- Select --</option>
							<option>And</option>
							<option>OR</option>
						</select>
					</div>
					
				</div>
				
				
				<div class="col-lg-12 noPaddingLeft report_padding">
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">Product </span>
						<select class="form-control">
							<option>-- Select --</option>
							<option>Document</option>
							
						</select>
					</div>				
				</div>
				
				
				
				<div class="col-lg-12 noPaddingLeft report_padding">
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">Payment Type </span>
						<select class="form-control">
							<option>-- Select --</option>
							<option>Cash</option>
							<option>DD</option>
							
						</select>
					</div>				
				</div>
					
					<div class="col-lg-12 noPaddingLeft report_padding">
					
					<div class="col-lg-3 branchclass">
						<span class="text-padding">Status </span>
						<select class="form-control">
							<option>-- Select --</option>
							<option>Picked Up</option>
							
						</select>
					</div>				
				</div>
						
                </div>
                		
                </div>
                </div>
                </div>
                </div>
                
            
                <br>
                <div class="row">
                <div class="col-lg-12">
                	<div class="col-lg-4">
                		
                	</div>
                	
                	<div class="col-lg-4">
                		<button type="button" class="btn btn-primary">View Report</button>
                	</div>
                	
                	<div class="col-lg-4">
                		<button type="button" class="btn btn-primary">	<i class="fa fa-file-excel-o"></i> Excel Report</button>
                	</div>
                </div>
                </div>
                
             
             <br>
             <div class="row">
                <div class="col-lg-12">
                   <div class="col-lg-12">
                    <div class="panel panel-default">
                        <!-- <div class="panel-heading">
                        </div> -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>S.No</th>
                                            <th>LR No</th>
                                            <th>Product</th>
                                            <th>Origin</th>
                                            <th>Destination</th>
                                            <th>Sender</th>
                                            <th>Consignee</th>
                                            <th>Total Parcel</th>
                                            <th>Weight</th>
                                            <th>Service</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="odd gradeX">
                                            <td>1</td>
                                            <td>LR 0025</td>
                                            <td>Product</td>
                                            <td>Coimbatore</td>
                                            <td>Chennai</td>
                                            <td>Kali</td>
                                            <td>Durai</td>
                                            <td>2</td>
                                            <td>100Kg</td>
                                            <td>Parcel</td>
                                            <td>Delivered</td>
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
    

    <script src="resources/built-in/assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="resources/built-in/assets/js/dataTables/dataTables.bootstrap.js"></script>

     <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
    </script>

</body>

</html>