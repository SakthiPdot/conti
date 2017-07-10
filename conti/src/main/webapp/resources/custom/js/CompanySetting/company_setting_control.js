




angular.module('contiApp')
 		.controller('companyController'
		,['$scope','LocationService','CompanySettingService','AddressService'
			,function($scope,LocationService,CompanySettingService,AddressService){
			
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
			    "tax_GST": null
			    
			};
	
	
	$('#companyImageHide').hide();
    $('#companyImage').show();
	 
    $scope.location_name = function (selected) {
	    console.log(selected); 
	    //value=JSON.parse(selected);
	    self.value=selected;

		$('#locationId').val(JSON.stringify( self.value.originalObject));
		$('#loccity').val( self.value.originalObject.address.city);
		$('#state').val( self.value.originalObject.address.state);
		$('#country').val( self.value.originalObject.address.country);
		$('#pincode').val( self.value.originalObject.pincode);	
	};	
	
    self.onAnguCompleteChange=function onAnguCompleteChange(val){
    	console.log("123"+val);
    }
    
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
		
		console.log(JSON.parse($('#locationId').val()));
	
			  if ($('#locationId').val() == '' || $('#locationId').val() == null) {
				  console.log("inside if");
				  $('#selectedAddress_value').focus();
			  }else{
				  
					self.company.location=JSON.parse($('#locationId').val());
					
					if(self.company.company_id==null){
						console.log("Company New Record");
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
					}else{
						console.log("Company Record Update");
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




