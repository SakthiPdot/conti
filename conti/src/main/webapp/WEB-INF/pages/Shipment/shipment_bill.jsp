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
 	
    <div id="wrapper"> 
   	 
           <div class="row">
    		<div class="col-lg-12 col-md-12">
    			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style = "padding: 25px;">
    			
    				<table border = "1">
    					<tr>
    						<td rowspan = "2">image</td>
    						<td>CONTI CARGO SERVICES</td>
    						<td>
	    						No. 814, UMS Buildings,Avinashi Road
								Coimbatore - 641 018. Ph : 0422 - 2561799, 8754007783
								Email : contitravelscbe@gmail.com
    						</td>
    					</tr>
    					<tr>
    						<td>
    							GSTIN Number : 33AAIFC8447KlZ5
								Tax Is Payable On Reverse Charges: (Yes / No )
    						</td>
    						<td>
    							L.R. No :
								Date :
    						</td>
    					</tr>
    					<tr>
    						<td align="center" colspan = "2"> From </td>
    						<td align="center"> To </td>
    					</tr>
    					<tr>
							<td colspan = "2">
								Name : <br/>
								Address : <br/>
								State : <br/>
								State Code : <br/>
								GSTIN Number: <br/>
							</td>
							<td>
								Name : <br/>
								Address : <br/>
								State : <br/>
								State Code : <br/>
								GSTIN Number: <br/>
							</td>
    					</tr>
    					<tr>
    						<td>
	    						<table border = "1">
	    							<thead>
		    							<tr>
		    								<th> Sl.No </th>
		    								<th> Description of Goods </th>
		    								<th> Qty </th>
		    								<th> Rate </th>
		    								<th> Total </th>
		    								<th> CGST 2.5% </th>
		    								<th> SGST 2.5% </th>
		    								<th> IGST 5% </th>
		    								<th> Total Amount </th>
		    							</tr>
	    							</thead>
	    							<tbody>
	    								<tr>
	    								</tr>
	    							</tbody>
	    						</table>
    						</td>
    					</tr>
    				</table>
    				
    			</div>
    		
    		</div>
    		</div>
    	${lrno}       	  
	
	</div>	
   
</body>

</html>