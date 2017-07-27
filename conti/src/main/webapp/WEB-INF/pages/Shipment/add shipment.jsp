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
	   <link href="resources/custom/css/demo.css" rel="stylesheet">
	  
	   <link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	   <style>
	   .modal-body{
	   height: 130px
	   }
	   </style>
		<style>
			
		</style>
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
              <div class="col-md-12 col-sm-12 col-xs-12">
              	  <div class="col-md-6 col-sm-6 col-xs-6 GenLeftRight">
	              <div  class="subHead">
	               <b>Branch Name : Coimbatore</b>            
	              </div>
	              
	              <div  class="subHead">               
	              <b>${title}</b>
	              </div>
	              </div>
	              
	              <div class="col-md-2">
	              </div>
	              
	              <div class="col-md-3 col-sm-4 col-xs-6">	              
	              <b>Last LR No : LRNO 19417</b>	              
	              </div>
	              
              </div>
              </div>
              
              <div class="row">
              
                <div class="col-md-12">
              		<div class="col-md-4">
              		</div>
              		<div class="col-md-4">
              		</div>
              		<div class="col-md-4 branchclass">              			 
                			 <span class="text-paddingwidth">LR No</span>	                	                                       
                             <input type="text" class="form-control" placeholder="New Hide/ Existing Dispaly" disabled>
                        
              		</div>
              	</div>
              	
              	<div class="col-md-12">
              		<div class="col-md-4">
              		</div>
              		<div class="col-md-4">
              		</div>
              		
              		<div class="col-md-1 branchclass paddingtop">
              			Shipment Date
              		</div>
              		
              		<div class="col-md-3 branchclass">            			 
                		                                        
                     
                      
                       		        <div class="form-group input-group">
				                  
				                  
				                               <input type="text" class="form-control datepicker marginLeftSpace " id="" data-ng-model="ctrl.employee.dob"
				                               data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of birth" required/>
	                                            <span class="input-group-addon" ><i class="fa fa-calendar" ></i>
	                                            </span>
	                                          
	                                          
	                               </div>
                        
              		</div>
              	</div>
              	
              	
              	
              	<div class="col-md-12">
              		<div class="col-md-4">
              		</div>
              		<div class="col-md-4">
              		</div>
              		<div class="col-md-4 branchclass">              			 
                			 <span class="text-paddingwidth">Payment Mode</span>	                	                                       
                             <select class="form-control">
                             	<option>--Select--</option>
                             	<option>Cash</option>
                             	<option>Credit</option>
                             </select>
                        
              		</div>
              	</div>
              	
              	
              </div>
         
              <div class="row">
              	
              	<div class="col-md-12">
              		<!-- <div class="col-md-12 GenLeftRight">
              			<div class="subhead">
              			<b>Coimbatore (Branch Name)</b>
              			</div>
              		</div> -->
              		
              		<div class="col-md-12 GenLeftRight">
              			<div class="subhead">
              			Sender &amp; Consignee Info
              			</div>
              		</div>
              	</div>
              	
              	
              	
              	
              	<div class="col-lg-12 col-md-12">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           Sender Info
                        </div>
                        <div class="panel-body">
                            		
                            			<div class="col-md-6">
                            			</div>
                            			<div class=" col-md-6 branchclass">
	                            			<span class="searchcls"> Search </span>
	                            		    <input type="text" class="form-control searchbar" placeholder="Mobile No">                            		    
                            		    </div>
                            		
                            
                            		<div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Name </span>
                            		    <input type="text" class="form-control">                            		    
                            		</div>
                            		
                           
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Mobile Number</span>
                            		    <input type="text" class="form-control" >                            		    
                            		    
                            		</div>
                            	
                            	
                           
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Branch Name</span>
                            		    <select  class="form-control" >  
                            		    	<option>-- Select --</option>
                            		    	<option>Chennai</option>
                            		    	<option>Bangalore</option>
                            		    	<option>Coimbatore</option>
                            		    </select>                          		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Address</span>
                            		    <input type="text" class="form-control">                            		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Location</span>
                            		    <select class="form-control" >
                            		    	<option> -- Select --</option>
                            		    	<option>Peelamedu</option>
                            		    	<option>Ukkadam</option>
                            		    	<option>TownHall</option> 
                            		    </select>                           		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">City</span> 
                            		    <input type="text" class="form-control">                            		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">State</span> 
                            		    <input type="text" class="form-control" >                            		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Country</span>
                            		    <input type="text" class="form-control" >                            		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Pincode</span>
                            		    <input type="text" class="form-control" >                             		    
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Email</span>
                            		    <input type="text" class="form-control" >                             		    
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">GSTIN Number</span>
                            		    <input type="text" class="form-control" >                             		    
                            		    
                            		</div>
                            		
                    		        <div class="col-md-12 col-sm-12 col-xs-12">
                    		        	<div class="col-md-6">
                    		        	
                    		        	</div>	
                    		        	
                    		        	<div class="col-md-6">
	                    		            <label class="checkbox-inline">
		                                        <input type="checkbox">Save Address
		                                    </label>
                    		        	</div>	
                    		        	                    		       
                                    </div>
                                    
                                    
                            	
                        </div>
                      
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                          Consignee Info
                        </div>
                        <div class="panel-body">
                        
                                        <div class="col-md-6">
                            			</div>
                            			<div class=" col-md-6 branchclass">
	                            			<span class="searchcls"> Search </span>
	                            		    <input type="text" class="form-control searchbar" placeholder="Mobile No">                            		    
                            		    </div>
                          	
                          	       <div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Name </span>
                            		    <input type="text" class="form-control">                            		    
                            		</div>
                            		
                           
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Mobile Number</span>
                            		    <input type="text" class="form-control" >                            		    
                            		    
                            		</div>
                            	
                            	
                           
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Branch Name</span>
                            		    <select  class="form-control" >  
                            		    	<option>-- Select --</option>
                            		    	<option>Chennai</option>
                            		    	<option>Bangalore</option>
                            		    	<option>Coimbatore</option>
                            		    </select>                          		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Address</span>
                            		    <input type="text" class="form-control">                            		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Location</span>
                            		    <select class="form-control" >
                            		    	<option> -- Select --</option>
                            		    	<option>Peelamedu</option>
                            		    	<option>Ukkadam</option>
                            		    	<option>TownHall</option> 
                            		    </select>                           		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">City</span> 
                            		    <input type="text" class="form-control">                            		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">State</span> 
                            		    <input type="text" class="form-control" >                            		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Country</span>
                            		    <input type="text" class="form-control" >                            		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Pincode</span>
                            		    <input type="text" class="form-control" >                             		    
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Email</span>
                            		    <input type="text" class="form-control" >                             		    
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">GSTIN Number</span>
                            		    <input type="text" class="form-control" >                             		    
                            		    
                            		</div>
                            		
                    		        <div class="col-md-12 col-sm-12 col-xs-12">
                    		        	<div class="col-md-6">
                    		        	
                    		        	</div>	
                    		        	
                    		        	<div class="col-md-6">
	                    		            <label class="checkbox-inline">
		                                        <input type="checkbox">Save Address
		                                    </label>
                    		        	</div>	
                    		        	                    		       
                                    </div>
                          	
                        </div>
                    
                    </div>
                </div>
                        
            </div>
            
            
            <div class="col-lg-12 col-md-12">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="panel panel-default">
                       
                        <div class="panel-body">
                            		
                            <div class="col-md-5">
                    		</div>
                    		
                    		<div class="col-md-4">
                    			<span class="spanclass"><b>Bill To</b></span>
                    			<label class="radio-inline">
                                                <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" value="option1" checked><b>Sender</b>
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" value="option2"><b>Consignee</b>
                                            </label>  
                    		     </div>
                    		
                    		<div class="col-md-3">
                    		</div>
                            	
                        </div>
                      
                    </div>
                </div>
                
           </div>
            
            
         
                    	
             </div>
      
                
                
              <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                                   
                                 Shipment Info
                        </div>
                        <div class="panel-body">
                        
                                    <div class="col-md-12">
                                    	<div class=" col-md-6 branchclass">
	                            			<span class="text-paddingwidth"> Status </span>
	                            		    <select class="form-control"> 
	                            		    	<option>-- Select --</option>
	                            		    	<option>Booked</option>
	                            		    </select>                           		    
                            		    </div>
	                            		<div class="col-md-6">
	                            		</div>
                                    </div>
                                    
                            		
                                    <div class="col-md-12">
                                    	<div class="col-md-6 branchclass">
	                            			<span class="text-paddingwidth">No.of Parcel</span>
	                            		    <input type="text" class="form-control" >                            		    
                            		    </div>
	                            		<div class="col-md-6">
	                            		</div>
                                    </div>
                                    
                                    
                                    <div class="col-md-12">
                  
                   
                       
                   
                          
                            <div class="col-md-12">
                            <div class="table-responsive">                    
                                
                                
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox"></th>
                                            <th>S.No</th>
                                            <th>Product</th>
                                            <th>Product Type</th>                                        
                                            <th colspan="3">Dimensions(cm)</th>
                                            <th>Weight(Kg)</th>
                                            <th>Quantity</th>
                                            <th>Unit Price</th>
                                            <th>Total Price</th>
                                        </tr>
                                        
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><input type="checkbox"></td>
                                            <td>1</td>
                                            <td>Box</td>
                                            <td>Small Box</td>
                                            <td>Length</td>
                                            <td>Width</td>
                                            <td>Height</td>
                                            <td>2</td>
                                            <td>3</td>
                                            <td>25</td>
                                            <td>75</td>
                                     
                                        </tr>
                                        <tr>
                                              <td></td>
                                              <td> <a href="" data-toggle="modal" data-target="#myModal" style="text-decoration: none !important;"> Add HSN Details</a></td>
                                        	
                                        </tr>
                                        
                                        <tr>
                                            <td><input type="checkbox"></td>
                                            <td>2</td>
                                            <td>Box</td>
                                            <td>Small Box</td>
                                            <td>Length</td>
                                            <td>Width</td>
                                            <td>Height</td>
                                            <td>2</td>
                                            <td>3</td>
                                            <td>25</td>
                                            <td>75</td>
                                     
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
            </div>  
                
                		
                 
              
              <div class="row">
              	
              	<div class="col-md-12">
              		              		
              		<div class="col-md-12 GenLeftRight">
              			<div class="subhead">
              			Service &amp;Payment Info
              			</div>
              		</div>
              	</div>
              	
              	
              	
              	
              	<div class="col-lg-12 col-md-12">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           Services
                        </div>
                        <div class="panel-body">
                            		
                            			
                            		<div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Service </span>
                            		    <input type="text" class="form-control">                            		    
                            		</div>
                            		
                           
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Shipment Value</span>
                            		    <input type="text" class="form-control" >                            		    
                            		    
                            		</div>
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Reference Invoice No</span>
                            		    <input type="text" class="form-control" >                            		    
                            		    
                            		</div>
                            
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Description</span>
                            		    <textarea class="form-control" rows="8"> </textarea>                           		    
                            		    
                            		</div>
                         </div>
                      
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                         Payment Details
                        </div>
                        <div class="panel-body">
                        
                          	
                          	       <div class=" col-md-12 branchclass">
                            			<span class="text-paddingwidth"> Chargeable Weight </span>
                            		    <input type="text" class="form-control">                            		    
                            		</div>
                            		
                           
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Delivery Charge</span>
                            		    <input type="text" class="form-control" >                            		    
                            		    
                            		</div>
                            		
                            		
                            	
                            		<div class="col-md-6 branchclass">
                            		
                            			<span class="text-paddingwidth discountspace ">Discount</span>
                            		      
                            		       <div class="form-group input-group discountval">
					                              <input type="text" class="form-control  marginLeftSpace " 
					                                 data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of birth" required/>
		                                            <span class="input-group-addon">%</span>
		                                          
		                                          
		                                   </div>                            		    
                            		
                            	   </div> 
                            		
                            		<div class="col-md-6 branchclass">
                            			<span class="text-paddingwidth">Discount.Amount</span>
                            		   
                            		   <div class="form-group input-group discountamount">
				                            
				                            <input type="text" class="form-control " data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of birth" disabled required/>
	                                            <span class="input-group-addon" ><i class="fa fa-inr"></i></span>
	                                          
	                                          
	                                    </div>                        		    
                            		    
                            		</div>                           		
                            		
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Handling Charge</span>
                            		    <input type="text" class="form-control">                            		    
                            		    
                            		</div>
                            	
                            	    <div class="col-md-6 branchclass">
                            			<span class="text-paddingwidth discountspace">CGST</span>                            		
                            		    
                            		       <div class="form-group input-group gstval">
				                                <input type="text" class="form-control" 
				                                     data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of birth" disabled required/>
	                                            <span class="input-group-addon" ><i class="fa fa-inr"></i></span>
	                                      </div>                         		    
                            		    
                            		</div>
                            		
                            		
                            		<div class="col-md-3 branchclass">
                            			<span class="text-paddingwidth">SGST</span>
                            		                         		    
	                            		    <div class="form-group input-group sgstval">
					                            <input type="text" class="form-control" 
					                               data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of birth" disabled required/>
		                                            <span class="input-group-addon" ><i class="fa fa-inr"></i></span>
		                                    </div>  
                            		</div>
                            		
                            		<div class="col-md-3 branchclass">
                            			<span class="text-paddingwidth ">IGST</span>
                            	
                            		       <div class="form-group input-group igstval">
				                             
				                              <input type="text" class="form-control" 
				                                data-trigger="focus" data-toggle="popover" data-placement="top" data-content="Please Enter Employee date of birth" disabled required/>
	                                            <span class="input-group-addon" ><i class="fa fa-inr"></i></span>
	                                    
	                                     </div>                         		    
                            		    
                            		</div>
                            	                        	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Tax</span> 
                            		    <input type="text" class="form-control">                            		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		<div class="col-md-12 branchclass">
                            			<span class="text-paddingwidth">Total Charges</span> 
                            		    <input type="text" class="form-control" >                            		    
                            		    
                            		</div>
                            	
                            	
                            	
                            		                        	
                        </div>
                    
                    </div>
                </div>
                
            </div>
            
                
             </div>
        
        
        
        
                      <div class="row">
                       <div class="col-lg-12">
                       
                       <div class="col-lg-6">
                       	<button type="button" class="btn btn-danger pull-right"><i class="fa fa-ban"></i>  Clear</button>
                       </div>
                       
                       <div class="col-lg-6">
                       	<button type="button" class="btn btn-success"><i class="fa fa-floppy-o"></i>  Save</button>
                       </div>
                       </div>
                       </div>
                       
                       
                       <div class="row">
                       		<div class="col-md-12">
                       		</div>
                       </div>
             
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                    
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">HSN Details</h4>
                                        </div>
                                        
                                        <div class="modal-body">
										 	<div class="col-lg-6">
										 		<span> HSN Code</span>
												<input type="text" class="form-control">
										 	</div>
										 	<div class="col-lg-6">
										 		<span> Description</span>
												<input type="text" class="form-control">
										 	</div>
										 	
										 	<div class="col-lg-6">
										 		
										 	</div>
										 	<div class="col-lg-6">
										 		<button class="btn btn-primary pull-right"><i class="fa fa-minus-circle fa-lg"></i></button>
										 		<button class="btn btn-primary pull-right"><i class="fa fa-plus-circle fa-lg"></i></button>
										 		
										 	</div>
										</div>
										
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-danger pull-left" data-dismiss="modal"> <i class="fa fa-times"></i> Cancel</button>
                                            <button type="button" class="btn btn-success"><i class="fa fa-floppy-o"></i> Save</button>
                                        </div>
                                        
                                    </div>
                                </div>
                            </div>
              
       
        </div>
        </div>
        <!-- /. PAGE WRAPPER  -->
		
		
    
    <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
  
  
	
  <!--   <script src="resources/built-in/assets/js/jquery-1.10.2.js"></script>  -->
    <script src=" resources/custom/js/date-time-picker.min.js" ></script>
    <script src="resources/built-in/assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="resources/built-in/assets/js/dataTables/dataTables.bootstrap.js"></script>

     <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
     
    </script>
    <script>
    $(".hide").hide();
    </script>
 <script>
            $('.datepicker').dateTimePicker();
        </script>
</body>

</html>