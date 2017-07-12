



contiApp.controller('ServiceController',['$scope', '$timeout','ServiceService','ConfirmDialogService' , function($scope, $timeout, ServiceService,ConfirmDialogService){
	
	
	
	
	var self = this;
	self.services = [];	
	self.service = {};	
	self.heading = "Master";	
	self.message = null;
	self.submit = submit ;
	self.save = "saveclose";
	self.reset = reset;
	self.deleteService = deleteService;
	self.updateService = updateService;
	self.close = close;
	self.clear = clear;
	self.confirm_title ='save';
	self.confirm_type = 'TYPE_SUCCESS';
	self.confirm_msg = self.confirm_title + '' + self.service.service_name + 'service?'; 
	self.confirm_btnclass = 'btn-success';
	
	
	fetchAllServices();

	function reset(){
		self.service = {};	
	}
	
	//============= Close Function Begins ======================//
		
		function close(){
			self.confirm_title = 'Close';
			self.confirm_type = BootstrapDialog.TYPE_WARNING;
			self.confirm_msg = self.confirm_title + ' without Saving Data?';
			self.confirm_btnclass = 'btn-warning';
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(
						function (res) {
							reset();
							newOrClose();
						}
				    );
		}
	//============= Close Function End =========================//
	
	//============= Clear Function Begins =======================//
		function clear () {
			self.confirm_title = 'Clear';
			self.confirm_type = BootstrapDialog.TYPE_WARNING;
			self.confirm_msg = self.confirm_title + ' the Data?';
			self.confirm_btnclass = 'btn-warning';
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(
						function (res) {
							reset();
							newOrClose();
						}
				      );
		}
	//============= Clear Function End  ==========================//
	
	
	//================== Fetch All Services Begins ==============//
	function fetchAllServices() {
		ServiceService.fetchAllServices()
			.then(
					function (service) {
						self.services = service;
						console.log(self.services);
					},
					function (errResponse) {
						console.log('Error while fetching services')
					}
				  );
	}
	
	//================== Fetch All Services End ===============//
	
	
	$scope.save = function(event){
		self.save= event.target.id;
	}
	
	function newOrClose() {
		console.log(self.save);
		if(self.save == "saveclose"){
			drawerClose('.drawer');
		}
		reset();
	}
	
	
	//=================== Create New Service Begin =============//
	
	function createService(service){
		ServiceService.createService(service)
			.then(
				   function () {
					   fetchAllServices();					  
					   self.message = service.service_name + "service created..!";
					   successAnimate('.success');
				   },
				   
				   function(errResponse){
					   console.error('Error while creating service' + service.service_name);
				   }
			     );
	}
	//=================== Create New Service End ===============//
	
	//=================== Submit for New Service and Update Service Begin =================//
	function submit() {
		
		if(self.service.service_id == null ) {
			
			self.confirm_title = 'save';
			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
			self.confirm_msg = self.confirm_title + ' ' + self.service.service_name + ' service?';
			self.confirm_btnclass = 'btn-success';
			
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type,self.confirm_msg,self.confirm_btnclass)
				.then(
						function (res) {
							console.log(self.service);
							createService(self.service);
							reset();
							window.setTimeout( function(){
								newOrClose();
							},5000);
						}
				      );
		  } else {
			  
			  self.confirm_title = 'update';
			  self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
			  self.confirm_msg = self.confirm_title + ' ' + self.service.service_name + ' service?';
			  self.confirm_btnclass='btn-warning';
			  ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg,self.confirm_btnclass)
			  	.then(
			  			function (res) {
			  				editService(self.service);
			  				reset();
			  				window.setTimeout(function(){
			  					newOrClose();
			  				},5000);
			  			}
			  	     );
		  }
	}
	//=================== Submit for New Service and Update Service End =================//

			
			function editService(service) {
				ServiceService.createService(service)
				.then(
						function () {
							fetchAllServices();
							
							self.message = service.service_name + " service updated...!";
							successAnimate('.success');
						},
						
						function(errResponse){
							console.error('Error while creating service' + service.service_name);
						}
					  );
			}
	
	//=========== Update Service Begin ===============//
			function updateService(service) {
				self.service = service;
				
				self.heading = self.service.service_name;
				drawerOpen('.drawer');
				
			}
	//=========== Update Service End ================//
			function deleteService () {
				self.confirm_title = 'Delete';
				self.confirm_type = Bootstrap.TYPE_DANGER;
				self.confirm_msg = self.confirm_title+ ' ' + self.service.service_name + ' service?';
				self.confirm_btnclass = 'btn-danger';
				ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_msg, self.confirm_btnclass)
					.then(
							function (res) {
								ServiceService.deleteService(self.service.servcie_id)
								.then(
										function (service) {
											self.message = service.service_name+ " service Deleted..!";
											successAnimate('.success');
											newOrClose();
											self.services.splice(service,1);
											console.log(service);
											console.log(self.services);											
										},
										function (errResponse) {
											console.error('Error while Delete service' + errResponse);
										}
								      );
							}
					     );
			}
}]);