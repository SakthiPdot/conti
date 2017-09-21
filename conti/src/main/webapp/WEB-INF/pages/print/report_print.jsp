<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<title>Shipment print</title>
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


<h1>Shipment</h1>
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
				<div id="area">${company.company_address1} </div>
				<div id="street">${company.company_address2}</div>
				<div id="city">${company.location.location_name},${company.location.address.city}</div>
				<div id="phoneno">${company.company_landlineno}</div>
				<%-- <c:set var = "shipment_date" value="${shipmentList[0].shipment_date}" />
				<div id="title">${fn:substring(shipment_date, 0, 8)}</div> --%>
				<div id="filter_branch">From : <c:out value="${shipmentList[0].filter_frmBranch}"/>  To :  <c:out value="${shipmentList[0].filter_toBranch}"/></div>
				<div id="filter_username">User : <c:out value="${shipmentList[0].filter_user}"/> </div>
				<div id="title">Date : <c:if test="${shipmentList[0].filter_pay == 'Paid' }"><c:out value="${shipmentList[0].shipment_date}"/></c:if>
				<c:if test="${shipmentList[0].filter_pay == 'Report' }"><c:out value="${shipmentList[0].receipt_date}"/></c:if></div>
				<div id="logo">${image}</div>
			

	<!--====================================================== Shipment table START=========================================-->
				<table id="basic-table" border="2">
					<thead>
						<tr>
							<th>S.No</th>
							<th>LR Number</th>
							<th>Paid</th>
							<th>To Pay</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="paid_total" value="${0}"/>
						<c:set var="topay_total" value="${0}"/>
						<c:forEach var="Shipment" items="${shipmentList}" varStatus="loop">
							<tr>
								<td><c:out value="${loop.count}" />
								<td>${Shipment.lrno_prefix}</td>
								<td align="right">
									<c:choose>
										<c:when test="${Shipment.bill_to == 'Paid'}">
											${Shipment.total_charges}
											<c:set var="paid_total" value="${paid_total + Shipment.total_charges}"/>	
										</c:when>
										<c:otherwise>
											-
										</c:otherwise>
									</c:choose>
									
								</td>
								<td align="right"> 
									<c:choose>
										<c:when test="${Shipment.bill_to == 'To Pay'}">
											${Shipment.total_charges}
											<c:set var="topay_total" value="${topay_total + Shipment.total_charges}"/>
										</c:when>
										<c:otherwise>
											-
										</c:otherwise>
									</c:choose>
									
								</td>											
							</tr>
							
						</c:forEach>
							<tr>
								<td></td><td>Total</td>
								<td align="right">
									<fmt:formatNumber type="number" maxFractionDigits="2" value = "${paid_total}" />
								</td>
								<td align="right">
									<fmt:formatNumber type="number" maxFractionDigits="2" value = "${topay_total}" />
									<%-- <c:out value="${tot}" /> --%>
								</td>
							</tr>
					</tbody>
				</table>

	<!--====================================================== Shipment table END=========================================-->


<!--====================================================== SCRIPTS START=========================================-->
						<!-- Print  js -->
	<script src="resources/built-in/pdf_print/jspdf.min.js"></script>
	<script src="resources/built-in/pdf_print/jspdf.plugin.autotable.src.js"></script>
	<script src="resources/built-in/pdf_print/reportJSPDF.js"></script>
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
            title: 'Conti: Shipment',
            subject: 'Conti Master (' + funcStr + ')'
        });

        if (shouldDownload) {
            doc.save('conti_Location.pdf');
        } else {
            document.getElementById("output").src = doc.output('datauristring');
        }
    }
	
	</script>
<!--====================================================== SCRIPTS END =========================================-->

</body>
</html>			