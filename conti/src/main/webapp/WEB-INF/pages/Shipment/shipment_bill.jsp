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
	
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	 <link href="resources/built-in/assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
	 
	 <link href="resources/built-in/assets/Drawer/trouserDrawer.css" rel="stylesheet" />
	 <link href="resources/custom/css/success_failure_msg.css" rel="stylesheet">
	 <link href="resources/custom/css/custom.css" rel="stylesheet">
	 <link href="resources/custom/css/angucomplete-alt.css" rel="stylesheet">
	 
	 <link href="resources/custom/css/demo.css" rel="stylesheet">

	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	<script type="text/javascript" src="resources/built-in/js/lodash.js"></script> 
	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
    <script src="resources/custom/js/app.js"></script>
    
    <style>
    	@page {
		  size: A4;
		  margin: 0;
		}
		@media print {
		  #wrapper{
		    width: 210mm;
		    height: 297mm;
		  }
		  .non-print {
		  	display: none;
		  }
		  
    	.tbl_header {
    		margin : 0 auto;
    		table-layout: fixed; 
    		/* width: 50%; */
    		
    	}
    	.tbl_header tr td {
    		padding : 15px;
    		word-wrap: break-word;
    	}
    	.tbl_detailed {
    		margin : 0 auto;
    		table-layout: fixed; 
    		/* width : 50%; */
    		
    	}
    	.tbl_detailed tr th {
    		padding : 15px;
    		word-wrap: break-word;
    		
    	}
    	.tbl_detailed tr td {
    		padding : 15px;
    		word-wrap: break-word;
    	}
    	
    	
    	
    	.tbl_customer {
    		margin : 0 auto;
    		table-layout: fixed; 
    		/* width : 50%; */
    		
    	}
    	.tbl_customer tr th {
    		padding : 15px;
    		word-wrap: break-word;
    		
    	}
    	.tbl_customer tr td {
    		padding : 15px;
    		word-wrap: break-word;
    	}
    	
    	.th_background {
    		background-color : #8f8f8f;
    	}
    	
    </style>
</head>


<body style="overflow-x:hidden;">
 	
    <div id="wrapper"> 
   	 <div id="editor"></div>
           <div class="row">
    		<div class="col-lg-12 col-md-12">
    			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style = "padding: 25px;">
    			
    				<table border = "1" class="tbl_header table table-striped table-bordered table-hover">
    					<tr>
    						<td rowspan = "2" align = "center"><img src="data:image/png;base64,${image}" id="logoimg" style="width:120px;" /></td>
    						<th class = "text-center">${company.company_name}</th>
    						<td>
    							${branch.branch_name},
    							${branch.branch_addressline1},
    							${branch.branch_addressline2},
    							${branch.location.location_name},
    							${branch.location.address.city},<br/>
    							${branch.location.address.state} - 
    							${branch.location.pincode}<br/>
    							Ph : ${branch.branch_mobileno},
    							Email : ${branch.branch_email}
	    						<!-- No. 814, UMS Buildings,Avinashi Road
								Coimbatore - 641 018. Ph : 0422 - 2561799, 8754007783
								Email : contitravelscbe@gmail.com -->
    						</td>
    					</tr>
    					<tr>
    						<td>
    							GSTIN Number : ${company.GST_number} <br/>
								Tax Is Payable On Reverse Charges: ${shipment.taxin_payable}
    						</td>
    						<td>
    							L.R. No : ${shipment.lr_number}<br/>
								Date : ${shipment.shipment_date}
    						</td>
    					</tr>
    				</table>
    				<table border = "1" class="tbl_customer table table-striped table-bordered table-hover">
    					<tr>
    						<th class = "text-center th_background"> From </th>
    						<th class = "text-center th_background"> To </th>
    					</tr>
    					<tr>
							<td>
								Name : ${shipment.sender_customer.customer_name} <br/>
								Address : ${shipment.sender_customer.customer_addressline1},
											${shipment.sender_customer.customer_addressline2},
											${shipment.sender_customer.location.location_name}, 
											${shipment.sender_customer.location.address.city},<br/>
											Ph : ${shipment.sender_customer.customer_mobileno},
    										Email : ${shipment.sender_customer.customer_email}
											<br/>
								State : ${shipment.sender_customer.location.address.state}<br/>
								State Code : ${shipment.sender_customer.location.pincode}<br/>
								GSTIN Number: ${shipment.sender_customer.gstin_number}<br/>
							</td>
							<td>
								Name : ${shipment.consignee_customer.customer_name} <br/>
								Address : ${shipment.consignee_customer.customer_addressline1},
											${shipment.consignee_customer.customer_addressline2},
											${shipment.consignee_customer.location.location_name}, 
											${shipment.consignee_customer.location.address.city},<br/>
											Ph : ${shipment.consignee_customer.customer_mobileno},
    										Email : ${shipment.consignee_customer.customer_email}
											<br/>
								State : ${shipment.consignee_customer.location.address.state}<br/>
								State Code : ${shipment.consignee_customer.location.pincode}<br/>
								GSTIN Number: ${shipment.consignee_customer.gstin_number}<br/>
							</td>
    					</tr>
    					
    				</table>
    				<table border = "1" class = "tbl_detailed table table-striped table-bordered table-hover">
	    							<thead>
		    							<tr>
		    								<th class = "text-center"> S.No </th>
		    								<th class = "text-center"> Description of Goods </th>
		    								<th class = "text-center"> Qty </th>
		    								<th class = "text-center"> Rate </th>
		    								<th class = "text-center"> Discount % </th>
		    								<th class = "text-center"> Total </th>
		    								
		    								<th class = "text-center"> CGST ${company.CGST} % Rs.</th>
		    								<th class = "text-center"> SGST ${company.SGST} % Rs.</th>
		    								<th class = "text-center"> IGST ${company.IGST} % Rs.</th>
		    								<th class = "text-center"> Total Amount </th>
		    							</tr>
	    							</thead>
	    							<tbody>
	    								<c:forEach var="shipmentdet" items="${shipment.shipmentDetail}" varStatus="loop">
		    								<tr>
		    									<td> <c:out value="${loop.count}" /> </td>
		    									<td> ${shipmentdet.product.product_name} </td>
		    									<td> ${shipmentdet.quantity} </td>
		    									<td> ${shipmentdet.unit_price} </td>
		    									
		    									<td>		    										
		    										 <c:if test="${shipment.discount_percentage != 0}">	
		    											<c:set var = "discount_amount" value = "${shipmentdet.total_price * (shipment.discount_percentage / 100)}" />
		    											<c:out value="${shipment.discount_percentage}" />		    									
			    									</c:if>	
			    									<c:if test="${shipment.discount_percentage == 0}">
			    										<c:set var = "discount_amount" value = "${shipment.discount_percentage}" />
			    										<c:out value="${shipment.discount_percentage}" />
			    									</c:if>	
		    									</td>
		    									
		    									<td> ${shipmentdet.total_price} </td>
		    									
		    									<td>
		    										<c:if test="${shipment.cgst != 0}">	
		    											<c:set var = "cgst" value = "${shipmentdet.total_price * company.CGST / 100}" />
		    											<c:out value="${cgst}" />		    									
			    									</c:if>	
			    									<c:if test="${shipment.cgst == 0}">
			    										<c:set var = "cgst" value = "${shipment.cgst}" />
			    										<c:out value="${cgst}" />
			    									</c:if>		    									 
		    									</td>
		    									 <td>
		    									 	<c:if test="${shipment.sgst != 0}">
		    									 		<c:set var = "sgst" value = "${shipmentdet.total_price * company.SGST / 100}" />
		    									 		<c:out value="${sgst}" />
			    									</c:if>	
			    									<c:if test="${shipment.sgst == 0}">
			    										<c:set var = "sgst" value = "${shipment.sgst}" />
			    										<c:out value="${sgst}" />
			    									</c:if>		    									 
		    									</td>
		    									<td>
			    									<c:if test="${shipment.igst != 0}">
			    										<c:set var = "igst" value = "${shipmentdet.total_price * company.IGST / 100}" />
			    										<c:out value="${igst}" />
			    									</c:if>	
			    									<c:if test="${shipment.igst == 0}">
			    										<c:set var = "igst" value = "${shipment.igst}" />
			    										<c:out value="${igst}" />
			    									</c:if>	 	    									 
		    									</td>
		    									<td>
		    										<c:set var = "total_amount" value = "${shipmentdet.total_price + cgst + sgst + igst - discount_amount}" />
		    										<c:out value="${total_amount}" />
		    									</td> 
		    								</tr>
		    							</c:forEach>
	    							</tbody>
	    							<tfoot>
	    								<tr>
	    									<th colspan = "8">
	    										Amount in words : ${currency}
	    									</th>
	    									<th>
	    										Total :
	    									</th>
	    									<th>
	    										${shipment.total_charges}
	    									</th>
	    								</tr>
	    								<tr>
	    									<th colspan = "6">
	    										For Conti Cargo Services <br/><br/>
	    										Signature
	    									</th>
	    									<th colspan = "2" class = "text-center">
	    										<c:if test="${shipment.bill_to == 'Sender'}">
	    											Paid
	    										</c:if>
	    										<c:if test="${shipment.bill_to == 'Consignee'}">
	    											To Pay
	    										</c:if>
	    									</th>
	    									<th colspan = "2" class = "text-center">
	    										${shipment.pay_mode}
	    									</th>
	    								</tr>
	    								
	    								
	    							</tfoot>
	    						</table>
    			</div>
    		
    		</div>
    		</div>
    	 	  
		
	</div>	
	
	<div class = "row non-print">
		<div class = "col-md-12">
			<div class ="col-md-6"></div>
			<div class ="col-md-6">
				
					<button type="button" class="btn btn-success pull-right" onClick = "window.print()"><i class="fa fa-print" aria-hidden="true"></i></button>
								
					<button type="button" id="pdf" class="btn btn-success pull-right"><i class="fa fa-file-pdf-o" aria-hidden="true"></i></button>
					

			</div>
		</div>
	</div>
	
    <!-- jQuery Js -->
    <script src="resources/built-in/assets/js/jquery-1.10.2.js"></script>

    <!-- Bootstrap Js -->
     <script src="resources/built-in/assets/js/bootstrap.min.js"></script> 
     <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.2.61/jspdf.min.js"></script>
	<script src=" resources/custom/js/date-time-picker.min.js" ></script>
    <!-- Metis Menu Js -->
    <script src="resources/built-in/assets/js/jquery.metisMenu.js"></script>
    
    <!-- Morris Chart Js -->
    <script src="resources/built-in/assets/js/morris/raphael-2.1.0.min.js"></script>
    <script src="resources/built-in/assets/js/morris/morris.js"></script>
	
	
	<script src="resources/built-in/assets/js/easypiechart.js"></script>
	<script src="resources/built-in/assets/js/easypiechart-data.js"></script>
	
	 <script src="resources/built-in/assets/js/Lightweight-Chart/jquery.chart.js"></script>
	
    <!-- Custom Js -->
    <script src="resources/built-in/assets/js/custom-scripts.js"></script>
	<script src="resources/custom/js/session.js"></script>

	<script type="text/javascript" src="resources/built-in/js/bootstrap-dialog.min.js"></script>
     <script src="resources/custom/js/shipment/shipment_controller.js"></script>
  <script src="resources/custom/js/shipment/shipment_service.js"></script>
  <script src="resources/custom/js/branch_master/branch_service.js"></script>
  <script src="resources/custom/js/price_setting/s_price_setting_service.js"></script>
  <script src="resources/custom/js/CompanySetting/company_setting_service.js"></script>
  <script src="resources/custom/js/custom.js"></script>
  <script src="resources/custom/js/confirmDialog.js"></script>   
  <script type="text/javascript" src="resources/custom/js/validation.js"></script>
  
  
</body>

</html>