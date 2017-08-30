
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %> 
<%@page session="true"%>

<html lang="en">

	    <meta name="viewport" content="width=device-width">	
	    <link rel="stylesheet" href="resources/built-in/pdf_print/pure-min.css">	
	    <link rel="stylesheet" href="resources/built-in/pdf_print/grids-responsive-min.css">
	    <link href="resources/custom/css/print.css" rel="stylesheet">
	 

    <!-- Bootstrap Js -->
    <script src="resources/built-in/assets/js/bootstrap.min.js"></script>

   
    <!-- Custom Js -->
    <script src="resources/built-in/assets/js/custom-scripts.js"></script>
	<script src="resources/custom/js/session.js"></script>

	<script type="text/javascript" src="resources/built-in/js/bootstrap-dialog.min.js"></script>
	
	   <!--  <script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script>  -->
	<script type="text/javascript" src="resources/built-in/js/angular.min.js"></script>
	   	<script type="text/javascript" src="resources/built-in/js/angucomplete-alt.js"></script> 
	

	   
  	<script src="resources/built-in/js/uibootstrap/ui-bootstrap.js"></script>
    <script src="resources/built-in/js/uibootstrap/ui-bootstrap-tpls-0.11.0.js"></script>
  	<script src="resources/custom/js/custom.js"></script>
	<script src="resources/custom/js/app.js"></script>
    <title>Conti - ${title} - PDF</title>
	    <style>
       
    </style>
	    
    </head>
    <body>
    	<div class="pure-g" style="height: 100%;">
			    <div id="panel" class="pure-u-1 pure-u-md-1-5">
			        <ul class="menu" >
			            <li style="color:white;">Conti</li>
			        </ul>
			        <button id="download-btn" class="pure-button">Download PDF</button>
			        <button id="clearback" class="pure-button">Back</button>
			    </div>
			    <div id="wrapper" class="pure-u-1 pure-u-md-4-5">
			        <iframe id="output"></iframe>
			    </div>
			</div>				  
		     	 
	        <h1>title Master</h1>
	       	<h5>(Print Preview)</h5> 
	
	       <!--===============heading ==============      -->	
         	
				<div class="col-lg-12">
					<div class="col-lg-6 col-lg-offset-3">
						<div class="row">
						<div class="col-lg-12"> 
							<div class="col-lg-4" >
								<c:set var="companydetail"  value="company detail"/>	  
							     <c:set var="image"  value="${image}"/>
								<img src="data:image/png;base64,${image}" id="logoimg" style="width:120px;height:100px;" /> 
								
							</div>
							<div class="col-lg-8">					
								<h2 style="color:blue; font-family: verdana;font-weight:bold;" align="center">comapny name</h2>
								<h4 align="center">area, &nbsp;street,</h4>
								<h4 align="center">city. &nbsp; phoneno.</h4>
								<h4 align="center">title Details</h4>
							</div>
						</div>
						
						
						</div>
					
					
						</div>
					</div>
				
				
				
				Company master<div id="companyname">${company.company_name}</div>
				<div id="area">${company.company_address1}, ${company.company_address2}</div>
				<div id="street">street</div>
				<div id="city">${company.location.address.city}</div>
				<div id="phoneno">${company.company_landlineno}</div>
				<div id="title">${title} Master</div>
				<div id="logo">${image}</div>
			
			
	            
	            
	            
	            
	                <!-- - Item Category Print -->
	         		<%-- <c:if test="${title == 'Item Category' }"> --%>
	        	<table id="basic-table">
	        	 

	               <thead>	    
	        				 <tr>
	                            <th>S.No</th>
	                            <th>Date</th>
	                            <th>LR Number</th>	                                 
	                            <th>Receipt</th>
	                            <td>Product </td>
	                            <td>Origin </td>
	                            <td>Destination </td>
	                            <td>Sender </td>
	                            <td>Consignee </td>
	                            <td>Manifest </td>    
	                            <td>Status </td> 
<!-- 	                            <th>Branch Name</th> -->
	                            <th>Company Name</th>
	                        </tr>	                        
	                    </thead>
	                    <tbody>
	                    
	                    <c:forEach var="receipt" items="${listReceipt}" varStatus="loop">	                    
	                        <tr>
                              	<td><c:out value="${loop.count}" />
                                <td>${receipt.created_datetime}</td>                   
                               <td>${receipt.shipmentModel.lr_number}</td> 
                               <td>${receipt.receipt_number}</td> 
                               <td>${receipt.shipmentModel.shipmentDetail[0].product.product_name}</td> 
                               <td>${receipt.manifestModel.branchModel1.branch_name}</td> 
                               <td>${receipt.manifestModel.branchModel2.branch_name}</td> 
                               <td>${receipt.shipmentModel.sender_customer.customer_name}</td> 
                               <td>${receipt.shipmentModel.consignee_customer.customer_name}</td> 
                               <td>${receipt.manifestModel.manifest_number}</td> 
                               <td>${receipt.shipmentModel.status}</td> 
                                 
<%--                                <td>${cust.customer_type}</td> --%>
                               <td>${cust.company_name}</td>                      
                            </tr>                           
	                      </c:forEach> 
	                      
	                    </tbody>
	                </table>
	            <%-- </c:if> --%>
	         <!-- - Item Category Print -->
	            
	
	  <script src="resources/custom/js/receipt/view_receipt_controller.js"></script>
	  <script src="resources/custom/js/receipt/view_receipt_service.js"></script>
	  <script src="resources/custom/js/branch_master/branch_service.js"></script>
	  <script src="resources/custom/js/Location/location_service.js"></script>
	  <script src="resources/custom/js/confirmDialog.js"></script>   
	    
		<script src="resources/built-in/pdf_print/jspdf.min.js"></script>
		<script src="resources/built-in/pdf_print/jspdf.plugin.autotable.src.js"></script>		
		<script src="resources/built-in/pdf_print/examples.js"></script>


		<script>
// 		    window.onhashchange = function () {
// 		        update();
// 		    };
		//====== Back Function=====//
		   document.getElementById('clearback').onclick = function(){		    	
		    	history.go(-1);
		    };
		    
		 //========= Back Function====//
		    document.getElementById('download-btn').onclick = function () {
		        update(true);

		    };
		
		    function update(shouldDownload) {
		        var funcStr = window.location.hash.replace(/#/g, '') || 'broman';
		        var doc = examples[funcStr]();
		
		        doc.setProperties({
		            title: 'Conti: Coustomer',
		            subject: 'Conti Master (' + funcStr + ')'
		        });
		
		        if (shouldDownload) {
		            doc.save('conti_customer.pdf');
		        } else {
		            document.getElementById("output").src = doc.output('datauristring');
		        }
		    }
		
		    update();
		</script> 
    </body>
</html>
