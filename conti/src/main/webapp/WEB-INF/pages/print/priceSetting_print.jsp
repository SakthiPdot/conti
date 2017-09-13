<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %> 
<%@page session="true"%>

<html>
  		 <!-- Print  css -->
  		<meta name="viewport" content="width=device-width">	
	    <link rel="stylesheet" href="resources/built-in/pdf_print/pure-min.css">	
	    <link rel="stylesheet" href="resources/built-in/pdf_print/grids-responsive-min.css">
	    <link href="resources/custom/css/print.css" rel="stylesheet">
	 


<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="icon" type="image/gif/png" href="resources/Image/conti_logo.png">
<title>Price Setting Print</title>
</head>
<body>


<!--====================================================== Page=========================================-->
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
<!--====================================================== page end=========================================-->		


<h1>Price Setting Master</h1>
<h5>(Print Preview)</h5>

	<div class="col-lg-12">
		<div class="col-lg-6 col-lg-offset-3">
			<div class="row">
				<div class="col-lg-12">
					<div class="col-lg-4">
						<c:set var="companydetail" value="company detail" />
						<c:set var="image" value="${image}" />
						<img src="data:image/png;base64,${image}" id="logoimg"
							style="width: 120px; height: 100px;" />

					</div>
					<div class="col-lg-8">
						<h2 style="color: blue; font-family: verdana; font-weight: bold;"
							align="center">comapny name</h2>
						<h4 align="center">area</h4>
						<h4 align="center">city. &nbsp; phoneno.</h4>
						<h4 align="center">title Details</h4>
					</div>
				</div>
			</div>
		</div>
	</div>




				<div id="companyname">${company.company_name}</div>
				<div id="area">${company.company_address1}</div>
				<c:if test="${not empty company.company_address2 }"><div id="street">${company.company_address2}</div></c:if>
				<div id="city">${company.location.location_name},${company.location.address.city},${company.location.address.state},${company.location.pincode}</div>
				<div id="phoneno">${company.company_landlineno}</div>
				<div id="title">${title}</div>
				<div id="logo">${image}</div>
			

	<!--====================================================== Product table START=========================================-->
        			<table id="basic-table">
	               		<thead>	    
	        				 <tr>
	                            <th>S.No</th>
	                            <th>From Branch</th>
	                            <th>Service</th>	                                 
	                            <th>Product</th>
	                            <th>Product Type</th>
	                            <th>Default Price</th>	 
	                            <th>Default Handling Charges</th>
	                        </tr>	                        
	                    </thead>
	                    <tbody>	                    
	                    <c:forEach var="priceSetting" items="${priceSettingList}" varStatus="loop">	                    
	                        <tr>
                              	<td><c:out value="${loop.count}" />
                                <td>${priceSetting.branch.branch_name}</td>                   
                               <td>${priceSetting.service.service_name}</td> 
                               <td>${priceSetting.product.product_name}</td> 
                               <td>${priceSetting.product.product_Type}</td>                   
                               <td>${priceSetting.default_price }</td>                                 
                               <td>${priceSetting.defaulthandling_charge}</td>                      
                            </tr>                           
	                      </c:forEach> 	                      
	                    </tbody>
	                </table>
	                
<!--====================================================== Product table END=========================================-->


<!--====================================================== SCRIPTS START=========================================-->
	<!-- Print  js -->
	<script src="resources/built-in/pdf_print/jspdf.min.js"></script>
	<script src="resources/built-in/pdf_print/jspdf.plugin.autotable.src.js"></script>
	<script src="resources/built-in/pdf_print/examples.js"></script>
	<script>

	//====== Back Function=====//
   document.getElementById('clearback').onclick = function(){		    	
    	history.go(-1);
    };
    
	
	//========= download Function====//
    document.getElementById('download-btn').onclick = function () {
        update(true);

    };
    
	//========= Update Function====//
    update();
	
	function update(shouldDownload) {
        var funcStr = window.location.hash.replace(/#/g, '') || 'broman';
        var doc = examples[funcStr]();

        doc.setProperties({
            title: 'Conti: Price Setting',
            subject: 'Conti Master (' + funcStr + ')'
        });

        if (shouldDownload) {
            doc.save('Conti - PriceSetting.pdf');
        } else {
            document.getElementById("output").src = doc.output('datauristring');
        }
    }
	
	</script>
<!--====================================================== SCRIPTS END =========================================-->
</body>
</html>