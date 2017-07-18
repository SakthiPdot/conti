/**
 * @Project_Name conti
 * @Package_Name custom js customer_controller.js
 * @File_name customer_controller.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 26, 2017 12:59:17 PM
 * @Updated_date_time Jun 26, 2017 12:59:17 PM
 */

contiApp.controller('CustomerController', ['$http', '$scope','$q','$timeout', '$window','CustomerService', 'BranchService', 'LocationService', 'ConfirmDialogService', function($http, $scope, $q, $timeout,  $window, CustomerService, BranchService, LocationService, ConfirmDialogService)
{
	var self=this;
	self.customers=[];
	self.customer={};
	
	self.heading = "Master";
	
	self.message = null;
	self.submit = submit;
	self.save = "saveclose";
	self.reset = reset;
	self.deleteCustomer = deleteCustomer;
	self.updateCustomer = updateCustomer;
	self.close = close;
	self.clear = clear;
	self.customerSelect = customerSelect;
	self.customerSelectall = customerSelectall;
	self.makeActive = makeActive;
	self.makeinActive = makeinActive;
	self.print = print;
	
	self.selected_customer = [];
	self.confirm_title = 'Save';
	self.confirm_type = 'TYPE_SUCCESS';
	self.confirm_msg = self.confirm_title+ ' ' + self.customer.customer_name + ' customer?';
	self.confirm_btnclass = 'btn-success';
	//self.selectedBranch = selectedBranch;

	fetchAllCustomers();
	fetchAllBranches();
	fetchAllLocations();
	
	function reset () 
	{
		   self.customer = {};
		   $('#branch_name_value').val('');
		   $('#location_name_value').val('');
		   $('.locations').val('');

	    	self.heading = "Master";
		   /*$scope.$broadcast('angucomplete-alt:clearInput');*/


	}
	
	function close() {
		self.confirm_title = 'Cancel';
		self.confirm_type = BootstrapDialog.TYPE_WARNING;
		self.confirm_msg = self.confirm_title+ ' without saving data?';
		self.confirm_btnclass = 'btn-warning';
		ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(
					function (res) {
		 	        	reset();
		 	        	newOrClose();
					}
				);
	}

	function clear() {
		self.confirm_title = 'Clear';
		self.confirm_type = BootstrapDialog.TYPE_WARNING;
		self.confirm_msg = self.confirm_title+ ' the data?';
		self.confirm_btnclass = 'btn-warning';
		ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(
					function (res) {
		 	        	reset();
		 	        	
					}
				);
	}
	
	
	//-------------------------- Fetch All Employees Start ---------------------//
	function fetchAllCustomers() {
		CustomerService.fetchAllCustomers()
			.then(
					function (customer) {
						self.customers = customer;
						/*fetchAllBranches();
						fetchAllLocations();	*/	
						pagination();
					}, 
					function (errResponse) {
						console.log('Error while fetching customers');
					}
				);
	}
	//-------------------------- Fetch All Employees end ---------------------//
	
//-------------------------- Fetch All Branch begin ---------------------//	
	
	function fetchAllBranches() {
		BranchService.fetchAllBranches()
			.then(
					function (branches) {
						self.branches = branches;				
					}, 
					function (errResponse) {
						console.log('Error while fetching branches');
					}
				);
	}
	
	//-------------------------- Fetch All Branch end ---------------------//	
	
	//-------------------------- Fetch All Location begin ---------------------//	
	
	function fetchAllLocations() {
		LocationService.fetchAllLocation()
			.then(
					function (locations) {
						self.locations = locations;				
					}, 
					function (errResponse) {
						console.log('Error while fetching branches');
					}
				);
	}
	
	//-------------------------- Fetch All Location end ---------------------//	
	//===========================on save button click set value as SAVEANDCLOSE or SAVEANDNEW begin============
	$scope.save = function(event){
		self.save=event.target.id;
	}
	//===========================on save button click set value as SAVEANDCLOSE or SAVEANDNEW end============	
	
	function newOrClose(){
		
		if(self.save== "saveclose" ){
			 drawerClose('.drawer') ;
		}
		reset();
	}
	
	//-------------------------- Selected branch details end ---------------------//	
	
	//------------------------ Location block changes begin ----------------------//
    $scope.location_name = function (loc_selected) {
    	
    	$('#location_id').val(JSON.stringify(loc_selected.originalObject));
    	$('#city').val(loc_selected.originalObject.address.city);
    	$('#country').val(loc_selected.originalObject.address.country);
    	$('#state').val(loc_selected.originalObject.address.state);
    	$('#pincode').val(loc_selected.originalObject.pincode);
	    	    
	};	
	//------------------------ Location block changes end ----------------------//

	//------------------------- Create new Customer begin ------------------//
    function createCustomer(customer){
    	CustomerService.createCustomer(customer)
            .then(
            		function () {
                        fetchAllCustomers();
                      
            			self.message = customer.customer_name+" customer created..!";
            			successAnimate('.success');            			
            		},
           
            function(errResponse){
                console.error('Error while creating Customer' + customer.customer_name );
            }
        );
    } 
	//------------------------- Create new Customer end ----------------------------------------------//    
    
    
  //------------------------- Update existing Customer begin ------------------//
    function editCustomer(customer){
 
    	
	    	CustomerService.createCustomer(customer)
	        .then(
	        		function () {
	                    fetchAllCustomer();
	                  
	        			self.message = customer.customer_name+" Customer updated..!";
	        			successAnimate('.success');            			
	        		},
	       
	        function(errResponse){
	            console.error('Error while creating customer' + customer.customer_name );
	        }
	    );
    } 
	//------------------------- Update existing Customer end ----------------------------------------------//  
   
	
  //------------------------- Submit for new Customer / update Customer begin ---------------------//
    function submit() {
    	
		
    		if( self.customer.customer_id == null ) {
    			
    			self.confirm_title = 'Save';
    			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
    			self.confirm_msg = self.confirm_title+ ' ' + self.customer.customer_name + ' customer?';
    			self.confirm_btnclass = 'btn-success';
    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
    				.then(
    						function (res) {
    							self.customer.branch_id = $("#branch_id").val();
    			 	    		
    			 	    		self.customer.location = JSON.parse($("#location_id").val());    	
    			 	        	createCustomer(self.customer);  
    			 	        	reset();
    			 	        	window.setTimeout( function(){	 	        		
    			 	        		newOrClose();
    							},5000);
    						}
    					);
    			
    			

    		} else {
    			// update employeee
    					    			
    			self.confirm_title = 'Update';
    			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
    			self.confirm_msg = self.confirm_title+ ' ' + self.customer.customer_name + ' employee?';
    			self.confirm_btnclass = 'btn-success';
    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
    				.then(
    						function (res) {
    							self.customer.branch_id = $("#branch_id").val();
    			 	    		//self.employee.empcategory = $("#empcategory_value").val();  
    			 	    		self.customer.location = JSON.parse($("#location_id").val());    	

    			 	    		editCustomer(self.customer);  
    			 	        	reset();
    			 	        	window.setTimeout( function(){	 	        		
    			 	        		newOrClose();
    							},5000);
    						}
    					);
    		}
    	} 

    
    //------------------------- Submit for new employee / update employee end ---------------------//
   
    
  //------------------------- update employee begin ---------------------//
    function updateCustomer(customer) {
    	self.customer = customer;
  
    	self.heading = self.customer.customer_name;
    	$('#branch_id').val(JSON.stringify(self.customer.branchModel));
    	$('#location_id').val(JSON.stringify(self.customer.location));
    	$('#city').val(self.customer.location.address.city);
    	$('#country').val(self.customer.location.address.country);
    	$('#state').val(self.customer.location.address.state);
    	$('#pincode').val(self.customer.location.pincode);
    	
    	//$('#empcategory_value').val(self.employee.empcategory);
    	
    	 $('#branch_name_value').val(self.customer.branchModel.branch_name);
		 $('#location_name_value').val(self.customer.location.location_name);
		 
    	drawerOpen('.drawer');
    }
    //------------------------- update employee end ---------------------//    
    

//------------------------- delete employee begin ---------------------//
    
    function deleteCustomer() {
    	
    	self.confirm_title = 'Delete';
		self.confirm_type = BootstrapDialog.TYPE_DANGER;
		self.confirm_msg = self.confirm_title+ ' ' + self.customer.customer_name + ' customer?';
		self.confirm_btnclass = 'btn-danger';
		ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(
					function (res) {
												
						CustomerService.deleteCustomer(self.customer.customer_id)
						.then(
								function (customer) {
									self.customers.splice(customer,1);
									self.message =customer.customer_name+ " customer Deleted..!";
									successAnimate('.success');
									newOrClose();
									
								}, 
								function (errResponse) {
					                console.error('Error while Delete employee' + errResponse );
								}
							);
						
					}
				);
		
    }
    
  //------------------------- delete employee end ---------------------//
    
    //------------------------- Register select begin ------------------//
    function customerSelect(customer){
    	var index = self.selected_customer.indexOf(customer);
    	(customer.select)? self.selected_customer.push(customer) : self.selected_customer.splice(index, 1);    		  	
    }
    //------------------------- Register select end ------------------//
    //------------------------- Register select all begin ------------------//   
    function customerSelectall() {

    		angular.forEach(self.customers, function(customer){
    			customer.select = $scope.selectall;
        	});
    		self.selected_customer=$scope.selectall?self.customers:[];
        
    }
    //------------------------- Register select all end ------------------//       
    
    //-------------------------- Make Active begin ----------------------//
    function makeActive(){
   	if(self.selected_customer.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
    	} else {
    		var activate_flag = 0;
    		angular.forEach(self.selected_customer, function(customer){
    			if(customer.active == 'Y') {
    				activate_flag = 1;
    			} 
    			
    		});
    		if(activate_flag == 1) {
				self.message ="Selected record(s) already in active status..!";
				successAnimate('.failure');
    			
    		} else {
    			
    			self.confirm_title = 'Active';
    			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
    			self.confirm_msg = self.confirm_title+ ' selected record(s)?';
    			self.confirm_btnclass = 'btn-success';
    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
    			.then(
    					function (res) {
    						var active_id = [];
    		    			for(var i=0; i<self.selected_customer.length; i++) {
    		    				active_id[i] = self.selected_customer[i].customer_id;    				
    		    			}
    		    			CustomerService.makeActive(active_id)
    							.then(
    									function(response) {
    										fetchAllCustomers();
    										self.selected_customer = [];
    										self.message ="Selected record(s) has in activat status..!";
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
    //-------------------------- Make Active end ----------------------//    
    
    
  //-------------------------- Make inActive begin ----------------------//
    function makeinActive(){
   	if(self.selected_customer.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
    	} else {
    		var inactivate_flag = 0;
    		angular.forEach(self.selected_customer, function(customer){
    			if(customer.active == 'N') {
    				inactivate_flag = 1;
    			} 
    			
    		});
    		if(inactivate_flag == 1) {
				self.message ="Selected record(s) already in inactive status..!";
				successAnimate('.failure');
    			
    		} else {
    			
    			self.confirm_title = 'In-Active';
    			self.confirm_type = BootstrapDialog.TYPE_DANGER;
    			self.confirm_msg = self.confirm_title+ ' selected record(s)?';
    			self.confirm_btnclass = 'btn-danger';
    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
    			.then(
    						function (res) {
    							var inactive_id = [];
    			    			for(var i=0; i<self.selected_employee.length; i++) {
    			    				inactive_id[i] = self.selected_employee[i].emp_id;        				
    			    			}
    			    			CustomerService.makeinActive(inactive_id)
    								.then(
    										function(response) {
    											fetchAllCustomers();
    											self.selected_employee = [];
    											self.message ="Selected record(s) has in inactive status..!";
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
    //-------------------------- Make inActive end ----------------------//   
    
    //-------------------------- Pagnation begin -----------------------//
    
    function pagination() {
        
    	$scope.viewby = 10;
		$scope.totalItems = self.customers.length;
		$scope.currentPage = 1;
		$scope.itemsPerPage = $scope.viewby;
		$scope.maxSize = 2; //Number of pager buttons to show
			
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		  };

		  $scope.pageChanged = function() {
			console.log('Page changed to: ' + $scope.currentPage);
		  };

		  $scope.setItemsPerPage = function(num) {
			  $scope.itemsPerPage = num;
			  $scope.currentPage = 1; //reset to first paghe
		}
		
    }

      //-------------------------- Pagnation end -----------------------//	
    
    //-------------------------------------- Print begin -----------------------------//
    function print() {
    	if(self.selected_employee.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
    	} else {
    			
    		console.log(self.selected_employee);
    		$http.get('http://localhost:8080/Conti/listprint');
    	}
    }
    
    //-------------------------------------- Print end -----------------------------//
	
}]);
	