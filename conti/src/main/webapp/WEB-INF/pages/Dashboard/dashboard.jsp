<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib
    prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
<%@ page isELIgnored="false" %> 
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib  prefix="c"
    uri="http://java.sun.com/jsp/jstl/core" 
%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<%@ page isELIgnored="false" %> 
<%@page session="true"%>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   <link rel="icon" type="image/gif/png" href="resources/Image/conti_logo.png">
    <title>Conti</title>
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
</head>


<body style="overflow:hidden;">
 
	
	<jsp:include page="nav.jsp"/>
	
    <div id="wrapper"> 
       	  
		<div id="page-wrapper" class="background-image" style="background-image:url(resources/Image/1.png);background-repeat:no-repeat;background-size:contain;">	 
    
      		 <div class="page-header header-size" >
      		<b>Dashboard</b>
      		</div> 
            <!-- <img alt="hi" src="resources/Image/dashboard.png" style="background-repeat:no-repeat;width: 100%;height: -webkit-fill-available;"> -->    
          <div id="page-inner">  
             <div class="row">
             	<div class="col-md-4 col-sm-12 col-xs-12">
             	  <div class="panel panel-primary text-center no-boder blue">
             		<div class="panel-left pull-left blue">
                           <i class="fa fa-shopping-cart fa-5x"></i>                                
                    </div>
                    <div class="">
						    <h3 class="dash_padding" style="font-size: xx-large;">
						    <a href="add_shipment" class="underline hover">Add Shipment</a></h3>
                             <!-- <strong>Short Links</strong> -->
                    </div>
                   </div>
             	</div>
             	
             	<div class="col-md-4 col-sm-12 col-xs-12">
                        <div class="panel panel-primary text-center no-boder blue">
                              <div class="panel-left pull-left blue">
                                <i class="fa fa-truck fa-5x"></i>
								</div>                                
                            <div class="">
							<h3 class="dash_padding" style="font-size: xx-large;"><a href="add_manifest" class="underline hover">Add Manifest</a></h3>
                               <!--  <strong>Short Links</strong>  -->
                            </div>
                        </div>
               </div>
               
               
               <div class="col-md-4 col-sm-12 col-xs-12">
                        <div class="panel panel-primary text-center no-boder blue">
                              <div class="panel-left pull-left blue">
                                <i class="fa fa-file-text-o fa-5x"></i>
								</div>                                
                            <div class="">
							<h3 class="dash_padding" style="font-size: xx-large;"><a href="receipt_generate" class="underline hover">Receipt Generation</a></h3>
                               <!-- <strong>Short Links</strong> -->
                            </div>
                        </div>
               </div>
             	
             </div>
             </div>
                     
        </div>
        <!-- /. PAGE WRAPPER  -->
		
		
    </div>
 <script>
 	$("#dashboard").addClass("active-menu");
 </script>
<script src="resources/custom/js/session.js"></script>
</body>

</html>