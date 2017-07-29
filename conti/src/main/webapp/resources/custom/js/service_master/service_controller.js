



contiApp.controller('ServiceController',['$scope', '$timeout','ServiceService','ConfirmDialogService' , function($scope, $timeout, ServiceService,ConfirmDialogService){
	
	$("#screen_service").addClass("active-menu");
	
	$scope.nameWrong =false;
	
	var self = this;
	self.services = [];	
	self.Filterservices = [];
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
	
	
	self.servSelect = servSelect;
	self.servSelectall = servSelectall;
	self.makeActive = makeActive;
	self.makeinActive = makeinActive;
	self.registerSearch = registerSearch;
	self.shownoofRecord = shownoofRecord;

	
	
	self.selected_service = [];
	self.confirm_title ='save';
	self.confirm_type = 'TYPE_SUCCESS';
	self.confirm_msg = self.confirm_title + '' + self.service.service_name + 'service?'; 
	self.confirm_btnclass = 'btn-success';
	
	
	$scope.shownoofrec = 10;
	
	
	fetchAllServices();
	/*checkServiceName();*/

	function reset(){
		self.service = {};	
	}
	
	//============ Check Service Name Function Begin =================//
		
	self.checkServiceName = function checkServiceName(name) {
				
			
				if(self.service.service_id != null && self.service.service_name == self.UpdateNotCheckServiceName) {
					
					$scope.nameWrong=false;
				} else {
					ServiceService.checkServiceName(name)
						.then(function (response) {
							if(response=="204"){
								
								$scope.nameWrong = true;
								self.service.service_name = null;
							} else {
								$scope.nameWrong = false;
							}
						}, function(errResponse){
							$scope.nameWrong = false;
							self.service.service_name = null;
							console.log("error checking name");
						});
				}
			}
		
	
	//============ Check Service Name Function End ===================//
	
	
	//============= Close Function Begins ======================//
		
		function close(open){
			self.confirm_title = open;
			self.confirm_type = BootstrapDialog.TYPE_WARNING;
			self.confirm_msg = self.confirm_title + ' without Saving Data?';
			self.confirm_btnclass = 'btn-warning';
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(
						function (res) {
							fetchAllServices();
						    self.save = "saveclose";
							reset();
							newOrClose();
						}
				    );
		}
	//============= Close Function End =========================//
	
	//============= Clear Function Begins =======================//
		function clear (clearopen) {
			self.confirm_title = clearopen;
			self.confirm_type = BootstrapDialog.TYPE_WARNING;
			self.confirm_msg = self.confirm_title + ' the Data?';
			self.confirm_btnclass = 'btn-warning';
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(
						function (res) {
							self.save = "saveclose";
							reset();
							
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
						pagination();
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
					   self.message = service.service_name + " service created..!";
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
			
			self.confirm_title = 'Save';
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
			  
			  self.confirm_title = 'Update';
			  self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
			  self.confirm_msg = self.confirm_title + ' ' + self.service.service_name + ' service?';
			  self.confirm_btnclass='btn-success';
			  ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg,self.confirm_btnclass)
			  	.then(
			  			function (res) {
			  				editService(self.service);
			  				/*reset();*/
			  				window.setTimeout(function(){
			  					newOrClose();
			  				},5000);
			  			}
			  	     );
		  }
	}
	//=================== Submit for New Service and Update Service End =================//

	//================== Update Existing Service Function Begin ========================//		
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
	
			//================== Update Existing Service Function End ========================//
			
	//=========== Update Service Begin ===============//
			function updateService(service) {
				self.service = service;
				$scope.nameWrong=false;
				self.UpdateNotCheckServiceName = self.service.service_name;
				
				self.heading = self.service.service_name;
				drawerOpen('.drawer');
				
			}
	//=========== Update Service End ================//
			
	//============= Delete Function Begin ===========//		
			function deleteService() {
				
				self.confirm_title = 'Delete';
				self.confirm_type = BootstrapDialog.TYPE_DANGER;
				self.confirm_msg = self.confirm_title+ ' ' + self.service.service_name + ' service?';
				self.confirm_btnclass = 'btn-danger';
				ConfirmDialogService.confirmBox(self.confirm_title,self.confirm_type, self.confirm_msg, self.confirm_btnclass)
					.then(
							function (res) {
								
								ServiceService.deleteService(self.service.service_id)
								.then(
										function (service) {
											self.message = service.service_name+ " service Deleted..!";
											successAnimate('.success');
											newOrClose();
											var index=self.services.indexOf(service);
											self.services.splice(index,1);
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
			
			//============= Delete Function Begin ===========//	
					function servSelect(service) {
						var index = self.selected_service.indexOf(service);
						(service.select)? self.selected_service.push(service) : self.selected_service.splice(index, 1);
	
					} 
					
					
					
				
					function servSelectall() {
						self.selected_service = [];
						
						for(var i=0; i< $scope.pageSize; i++) {
							self.Filterservices[i].select = $scope.selectall;
							if($scope.selectall) {
								self.selected_service.push(self.Filterservices[i]);
							}
						}
					}
			
			//============== Make Active Begin ===================//
			
						function makeActive(){
								if(self.selected_service.length == 0 ) {
									self.message = " Please select atleast one record..!";
									successAnimate('.failure');
								} else {
									var activate_flag = 0;
									angular.forEach(self.selected_service, function(service){
										if(service.active == 'Y'){
											activate_flag = 1;
										}
									});
									
									if(activate_flag == 1) {
										self.message = " Selected record(s) already in active status..!";
										successAnimate('.failure');
									} else {
										
										self.confirm_title = 'Active';
										self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
										self.confirm_msg = self.confirm_title+ ' selected record(s)?';
										self.confirm_btnclass = 'btn-success';
										ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
											.then(
													function(res) {
														var active_id = [];
														for(var i=0;i<self.selected_service.length;i++) {
															active_id[i] = self.selected_service[i].service_id;
														}
														
														ServiceService.makeActive(active_id)
															.then(
																	function(response) {
																		fetchAllServices();
																		self.selected_service = [];
																		self.message = " Selected record(s) has in active status..!";
																		successAnimate('.success');
																	}, function (errResponse) {
																		console.log(errResponse);
																	}
																 );
													}
											      );
									}
								}
						}
			
			//============== Make Active End =====================//
						
			//============== Make InActive Begin ================//
						
						function makeinActive() {
							if(self.selected_service.length == 0) {
								self.message = "Please select atleast one record..!";
								successAnimate('.failure');
							} else {
								var inactivate_flag = 0 ;
								angular.forEach(self.selected_service, function(service){
									if(service.active == 'N') {
										inactivate_flag = 1;
									}
								});
								
								if(inactivate_flag == 1) {
									self.message = " Selected record(s) already in active status ..!";
									successAnimate('.failure');
								} else {
									
									self.confirm_title = 'In-Active';
									self.confirm_type = BootstrapDialog.TYPE_DANGER;
									self.confirm_msg = self.confirm_title+ ' selected record(s)?';
									self.confirm_btnclass = 'btn-danger';
									ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
										.then(
													function(res) {
														var inactive_id = [];
														for(var i=0; i<self.selected_service.length; i++) {
															inactive_id[i] = self.selected_service[i].service_id;
														}
														ServiceService.makeinActive(inactive_id)
														.then(
																function(response) {
																	fetchAllServices();
																	self.selected_service = [];
																	self.message = "Selected record(s) has in inactive status..!";
																	successAnimate('.success');													
																}, function(errResponse) {
																	console.log(errResponse);
																}
														     );
													}
											  );
					
								}
							}
						}
						
			//============== Make InActive End ==================//
						
			
			//================ Show no of Record Begin ============//
			
						function shownoofRecord(){
							$scope.pageSize = $scope.shownoofrec;
							self.Filterservices = self.Filterservices.slice($scope.currentPage*$scope.pageSize);
							
							if(self.Filterservices.length < $scope.pageSize) {
								$scope.previousDisabled = true;
								$scope.nextDisabled = true;
							}
						}
						
			//================ Show no of Record Begin ============//
			
						
			//============ Register Search Begin ================//
						
						function registerSearch(searchkey) {
							if(searchkey.length == 0 ){
								self.Filterservices = self.services;
							} else if( searchkey.length > 3 ) {
								ServiceService.registerSearch(searchkey)
									.then(
											function (filterService) {
												self.Filterservices = filterService;
											},
											function (errResponse) {
												console.log('Error while fetching services');
											}
									      );
							} else {
								
								self.Filterservices = _.filter(self.services, 
										function(item){									
										return searchUtil(item,searchkey);
									});
								}
							}
							
							
						function searchUtil(item,toSearch)
						{
								var success = false;
								
								
								if( (item.service_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.service_code.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)) {
									success = true;
								} else {
									success = false ;
								}
								
								return success;
						}
						
					
						
						
			//============ Register Search End ==================//
						
						
			//============= Record Count Begin =================//
						
						function findrecord_count() {
							ServiceService.findrecord_count()
								.then(
											function(record_count) {
												$scope.totalnoof_records = record_count;
											},
											function (errResponse) {
												console.log('Error while fetching record count');
											}
								      );
						}
						
			//============= Record Count End ===================//
						
			
			//============= Pagination Function Begin ==========//
						
						function pagination() {
							
							$scope.pageSize = $scope.shownoofrec;
							console.log($scope.pageSize);							
							$scope.currentPage = 0;
							$scope.totalPages = 0;							
							self.Filterservices = self.services;
							
							$scope.nextDisabled = false;
							$scope.previousDisabled = true;
							
							if(self.Filterservices.length <=10 ) {
								$scope.nextDisabled = true;
							}
							
							if(self.Filterservices.length < 100) {
								$scope.totalnoof_records = self.Filterservices.length;
							} else {
								findrecord_count();
							}
						}
						
						
						
						
						
						$scope.paginate = function(nextPrevMultiplier) {
							
							$scope.currentPage += (nextPrevMultiplier * 1);
							console.log($scope.currentPage);
							self.Filterservices = self.services.slice($scope.currentPage*$scope.pageSize);
							
							
							
							if(self.Filterservices.length == 0) {
								ServiceService.pagination_byPage($scope.currentPage)
								.then(
										function (filterService) {
											
											if(filterService.length == 0 ) {
												$scope.nextDisabled = true;
											} else if (filterService.length < 10 ) {
												self.Filterservices = filterService;
											} else {
												self.Filterservices = filterService;
											}
										},
										function (errResponse) {
											console.log('Error while pagination');
										}
								      );
							}
							
							if(self.Filterservices.length < $scope.pageSize) {
								$scope.nextDisabled = true;
							}
							
							console.log(nextPrevMultiplier);
							if($scope.currentPage == 0 ) {
								$scope.previousDisabled = true;
							}
							if(nextPrevMultiplier == -1) {
								$scope.nextDisabled = false;
							} else {
								$scope.previousDisabled =false;
							}
						}
						
						
						
						
						
						
						
						
						
						$scope.firstlastPaginate = function (page) {
							
							if(page == 1) {
								$scope.currentPage = 0;
								$scope.previousDisabled = true;
								$scope.nextDisabled = false;
								self.Filterservices = self.services.slice($scope.currentPage*$scope.pageSize);
							} else {
								$scope.currentPage = ((Math.ceil(self.Filterservices.length/$scope.pageSize)) - 1 );
								console.log($scope.currentPage);
								$scope.previousDisabled = false;
								$scope.nextDisabled = true;
								
								self.Filterservices = self.services.slice($scope.currentPage*$scope.pageSize);
								
								if(self.Filterservices.length == 0 ) {
										
									ServiceService.pagination_byPage(page)
									.then(
											function (filterService) {
												self.Filterservices = filterService;
											},
											function (errResponse) {
												console.log("Error while fetching services");
											}
									      );
								}
							}
							
							
						}
						
			//============= Pagination Function End =============//
						
			
			
}]);