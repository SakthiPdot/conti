




angular.module('contiApp')
 		.controller('companyController'
		,['$scope','LocationService','CompanySettingService','AddressService','ConfirmDialogService'
			,function($scope,LocationService,CompanySettingService,AddressService,ConfirmDialogService){
		
		    $("#screen_company_settings").addClass("active-menu");
		    
		    
			var self=this;
		
	self.addresses=[];
	self.Locations=[];
	
	self.address={
			    "id": null,
			    "state": null,
			    "country": null,
			    "cityCode": null,
			    "city": null,
			    "stateCode": null,
			    "countryCode": null,
			    "active": null,
			    "obsolete": null
			}		
			
	self.company={
			    "company_id": null,
			    "expct_deliverydate":null ,
			    "company_apptimeout": null,
			    "company_landlineno": null,
			    "company_alternateno": null,
			    "updated_by": null,
			    "created_by": null,
			    "company_name": null,
			    "company_address1": null,
			    "company_address2": null,
			    "company_location": null,
			    "company_city": null,
			    "company_state": null,
			    "company_country": null,
			    "company_pincode": null,
			    "company_email": null,
			    "company_logo": null,
			    "created_datetime": null,
			    "updated_datetime": null,
			    "tin_number": null,
			    "gst_number": null,
			    "financial_year_from":null,
			    "financial_year_to":null,
			    "sgst": null,
			    "cgst": null,
			    "igst":null,
			    "hsn_code": null,
			    
			};
	
	
	$('#companyImageHide').hide();
    $('#companyImage').show();
	
  //===================================onchange of angucomplete====================================
    $scope.location_name = function (selected) {
	    console.log(selected); 
	    //value=JSON.parse(selected);
	    self.value=selected;	    
		$('#locationId').val(JSON.stringify( self.value.originalObject));
		$('#loccity').val( self.value.originalObject.address.city);
		$('#state').val( self.	value.originalObject.address.state);
		$('#country').val( self.value.originalObject.address.country);
		$('#pincode').val( self.value.originalObject.pincode);	
	};	
	
    
    
	$scope.setFile = function(element) {
		  $scope.currentFile = element.files[0];
		   var reader = new FileReader();

		  reader.onload = function(event) {
			$('#companyImageHide').show();
			$('#companyImage').hide();
		    $scope.image_source = event.target.result
		    $scope.$apply()

		  }
		  // when the file is read it triggers the onload event above.
		  reader.readAsDataURL(element.files[0]);
		}

	fetchCS();
	
	function fetchCS(){
		CompanySettingService.fetchCompanySetting(1)
	.then(
			function(d){
				console.log("fetching wit id success");
				console.log(d);
				if(d.status==200){
					console.log("fetched  wit id data"+d.data);
					self.company=d.data;					
					$('#locationId').val(JSON.stringify(self.company.location));
					$('#loccity').val(self.company.location.address.city);
					$('#state').val(self.company.location.address.state);
					$('#country').val(self.company.location.address.country);
					$('#pincode').val(self.company.location.pincode);	
					self.company.financial_year_from=self.company.financial_year_from.slice(0, -2);
					self.company.financial_year_to=self.company.financial_year_to.slice(0, -2);
					submitButtonText();	
				}else{
					console.log("no content for id");
					submitButtonText();
				}
				
			},
			function(errResponse){
				console.log("error while fetching company");
				submitButtonText();
			});
	}
	

	function submitButtonText(){
		if(self.company.company_id==null){
			$("#submitText").text("Save");
		}else{
			$("#submitText").text("Update");
		}
	}	

	
	self.submit=function ($event){
		
		

		console.log(self.company);
			  if ($('#locationId').val() == '' || $('#locationId').val() == null) {
				  $('#selectedAddress_value').focus();
				  console.log("inside if");
				  console.log($('#locationId').val());
				  console.log(JSON.parse($('#locationId').val()));
			  }else if ( $(".datepicker1").val() == "" || $(".datepicker1").val() == null ){		    		
		    		$(".datepicker1").focus(); 		    		
		    	} else if ( $(".datepicker2").val() == "" || $(".datepicker2").val() == null ){		    		
		    		$(".datepicker2").focus(); 		    		
		    	} 
				  else{
			 
					self.company.location=JSON.parse($('#locationId').val());
			 		self.company.financial_year_from=$(".datepicker1").val();
			 		self.company.financial_year_to= $(".datepicker2").val();
			 		
					if(self.company.company_id==null){
						console.log("Company New Record");

						ConfirmDialogService.confirmBox("Save",
			    				BootstrapDialog.TYPE_SUCCESS, "Save Company Details  ..?", 'btn-success')
			    		.then(function(response){
						
					    CompanySettingService.addCompanySetting(self.company, $scope.myFile,"companySave")
					    .then(
								function(d){	
									self.message = "Company Detail Created..!";
									successAnimate('.success');
									fetchCS();						
								},
								function(errResponse){
									console.log("error while fetching company");
									self.message = "Error While Creating Company Detail..!";
									successAnimate('.failure');
								});
			    		});
					}else{
						console.log("Company Record Update");
						
						 ConfirmDialogService.confirmBox("Update",
				    				BootstrapDialog.TYPE_SUCCESS, "Update Company Details  ..?", 'btn-success')
				    		.then(function(response){
						
				    		
					    CompanySettingService.addCompanySetting(self.company, $scope.myFile,"companySave")
					    .then(
								function(d){	
									self.message = "Company Details Updated..!";
									successAnimate('.success');
									fetchCS();					
								},
								function(errResponse){
									console.log("error while fetching company");
									self.message = "Error While Updating Company Detail..!";
									successAnimate('.failure');
								});
				    		});
					}	
		
			  }
	/*	
		  if($("#image").val().length){	
  			self.uploadFile();
  		}else{
  			console.log("file not available");
  		}
        */
		
		
	}
	

	//=============================fetch Address====================================	
	function fetchAddressDetail(){
		
		AddressService.fetchAddress()
		.then(function(response){
			self.addresses=response;
			console.log(self.addresses);
		
			},
			function(errRes){
				console.log("error Fetchng address");
			});
			
	}

	//===================================fetch Address====================================

	fetchAllLocation();
	
	function fetchAllLocation(){
		LocationService.fetchAllLocation()  
		.then(function(response){
			self.Locations=response;
			console.log(self.Locations);
		},
		function(errResponse){
			console.log("error fetching all location");					
		});
	}

	
}]);




