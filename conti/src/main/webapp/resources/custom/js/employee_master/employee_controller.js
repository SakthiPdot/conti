/**
 * @Project_Name conti
 * @Package_Name custom js employee_control.js
 * @File_name employee_control.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 26, 2017 12:59:17 PM
 * @Updated_date_time Jun 26, 2017 12:59:17 PM
 */


contiApp.controller('EmployeeController', ['$scope','$q','$timeout', '$window','EmployeeService', 'BranchService', 'LocationService', 'ConfirmDialogService', function($scope, $q, $timeout,  $window, EmployeeService, BranchService, LocationService, ConfirmDialogService){
	

	
	var self = this;
	self.employees = [];

	self.employee = {
				
/*			   emp_id : null,
			   branch_id : null,
			   update_by : null,
			   created_by : null,
			   branch_id : null,
			   emp_name : null,
			   emp_code : null,
			   empcategory : null,
			   emp_phoneno : null,
			   emp_address : null,
			   location_id : null,
			   emp_email : null,
*/			   dob : '2017-06-26 17:34:54',
			   doj : '2017-06-26 17:34:54',
/*			   created_datetime : null,
			   updated_datetime : null,
			   obsolete : "N",
			   active : "Y"
*/			};
	self.heading = "Master";
	self.employeecategory = {};  
	self.message = null;
	self.submit = submit;
	self.save = "saveclose";
	self.reset = reset;
	self.deleteEmployee = deleteEmployee;
	self.updateEmployee = updateEmployee;
	self.close = close;
	self.clear = clear;
	self.empSelect = empSelect;
	self.empSelectall = empSelectall;
	self.makeActive = makeActive;
	self.makeinActive = makeinActive;
	self.print = print;
	
	self.selected_employee = [];
	self.confirm_title = 'Save';
	self.confirm_type = 'TYPE_SUCCESS';
	self.confirm_msg = self.confirm_title+ ' ' + self.employee.emp_name + ' employee?';
	self.confirm_btnclass = 'btn-success';
	//self.selectedBranch = selectedBranch;

	fetchAllEmployees();
	fetchEmpCat();
	fetchAllBranches();
	fetchAllLocations();

	
	console.log($scope.$root.printEmp);
	function reset () {
		   self.employee = {};
		   $('#empcategory_value').val('');
		   $('#branch_name_value').val('');
		   $('#location_name_value').val('');
		   $('.locations').val('');

	    	self.heading = "Master";
		   /*$scope.$broadcast('angucomplete-alt:clearInput');*/


	}
	//-------------------------- Fetch All Employees begin ---------------------//
	 
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
	
	function fetchAllEmployees() {
		EmployeeService.fetchAllEmployees()
			.then(
					function (employee) {
						self.employees = employee;
						/*fetchAllBranches();
						fetchAllLocations();	*/	
						pagination();
					}, 
					function (errResponse) {
						console.log('Error while fetching employees');
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
	
	//-------------------------- Fetch All Employees begin ---------------------//
	

	function fetchEmpCat() {
		EmployeeService.fetchEmpCat()
			.then(
					function (d) {
						self.employeecategory = d;			
					}, 
					function (errResponse) {
						console.log('Error while fetching employees');
					}
				);
	}
	//-------------------------- Fetch All Employees end ---------------------//

	//-------------------------- Selected branch details begin ---------------------//
	/*function selectedBranch() {
		console.log("Inside branch "+$("#branch_name_value").val());
	}*/
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
	
	//------------------------- Create new employee begin ------------------//
    function createEmployee(employee){
    	EmployeeService.createEmployee(employee)
            .then(
            		function () {
                        fetchAllEmployees();
                      
            			self.message = employee.emp_name+" employee created..!";
            			successAnimate('.success');            			
            		},
           
            function(errResponse){
                console.error('Error while creating employee' + employee.emp_name );
            }
        );
    } 
	//------------------------- Create new employee end ----------------------------------------------//    
    
	//------------------------- Update existing employee begin ------------------//
    function editEmployee(employee){
 
    	/*EmployeeService.updateEmployee(employee,employee.emp_id)
            .then(
            		function () {
                        fetchAllEmployees();

                        self.message = employee.emp_name+" employee updated..!";
            			successAnimate('.success');              			
            		},
           
            function(errResponse){
                console.error('Error while updating employee' + employee.emp_name );
                console.error(employee);
            }
        );*/
    	
    	
	    	EmployeeService.createEmployee(employee)
	        .then(
	        		function () {
	                    fetchAllEmployees();
	                  
	        			self.message = employee.emp_name+" employee updated..!";
	        			successAnimate('.success');            			
	        		},
	       
	        function(errResponse){
	            console.error('Error while creating employee' + employee.emp_name );
	        }
	    );
    } 
	//------------------------- Update existing employee end ----------------------------------------------//  
    
    //------------------------- Submit for new employee / update employee begin ---------------------//
    function submit() {
    	

    	
    	if ( $("#branch_id").val() == "" || $("#branch_id").val() == null ){
    		
    		$("#branch_name_value").focus();
    		
    	} else if( $("#empcategory_value").val() == "" || $("#empcategory_value").val() == null ){
    		
    		$("#empcategory_value").focus(); 
    		
    	} else if ( $("#location_id").val() == "" || $("#location_id").val() == null ){
    		
    		$("#branch_name_value").focus(); 
    		
    		
    	} else {
    		
    		if( self.employee.emp_id == null ) {
    			
    			self.confirm_title = 'Save';
    			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
    			self.confirm_msg = self.confirm_title+ ' ' + self.employee.emp_name + ' employee?';
    			self.confirm_btnclass = 'btn-success';
    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
    				.then(
    						function (res) {
    							self.employee.branch_id = $("#branch_id").val();
    			 	    		self.employee.empcategory = $("#empcategory_value").val();  
    			 	    		self.employee.location = JSON.parse($("#location_id").val());    	
    			 	        	createEmployee(self.employee);  
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
    			self.confirm_msg = self.confirm_title+ ' ' + self.employee.emp_name + ' employee?';
    			self.confirm_btnclass = 'btn-success';
    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
    				.then(
    						function (res) {
    							self.employee.branch_id = $("#branch_id").val();
    			 	    		self.employee.empcategory = $("#empcategory_value").val();  
    			 	    		self.employee.location = JSON.parse($("#location_id").val());    	

    			 	    		editEmployee(self.employee);  
    			 	        	reset();
    			 	        	window.setTimeout( function(){	 	        		
    			 	        		newOrClose();
    							},5000);
    						}
    					);
    		}
    		
    		
    		
    	} 

    }
    //------------------------- Submit for new employee / update employee end ---------------------//
    
  //------------------------- update employee begin ---------------------//
    function updateEmployee(employee) {
    	self.employee = employee;
  
    	self.heading = self.employee.emp_name;
    	$('#branch_id').val(JSON.stringify(self.employee.branchModel));
    	$('#location_id').val(JSON.stringify(self.employee.location));
    	$('#city').val(self.employee.location.address.city);
    	$('#country').val(self.employee.location.address.country);
    	$('#state').val(self.employee.location.address.state);
    	$('#pincode').val(self.employee.location.pincode);
    	
    	$('#empcategory_value').val(self.employee.empcategory);
    	
    	 $('#branch_name_value').val(self.employee.branchModel.branch_name);
		 $('#location_name_value').val(self.employee.location.location_name);
		 
    	drawerOpen('.drawer');
    }
    //------------------------- update employee end ---------------------//    
    
  //------------------------- delete employee begin ---------------------//
    
    function deleteEmployee() {
    	
    	self.confirm_title = 'Delete';
		self.confirm_type = BootstrapDialog.TYPE_DANGER;
		self.confirm_msg = self.confirm_title+ ' ' + self.employee.emp_name + ' employee?';
		self.confirm_btnclass = 'btn-danger';
		ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(
					function (res) {
												
						EmployeeService.deleteEmployee(self.employee.emp_id)
						.then(
								function (employee) {
									self.employees.splice(employee,1);
									self.message =employee.emp_name+ " employee Deleted..!";
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
    function empSelect(employee){
    	(employee.select)? self.selected_employee.push(employee) : self.selected_employee.splice(employee, 1);    		  	

    }
    //------------------------- Register select end ------------------//
    //------------------------- Register select all begin ------------------//   
    function empSelectall() {

    		angular.forEach(self.employees, function(employee){
        		employee.select = $scope.selectall;
        	});
        	
        	self.selected_employee = self.employees;
        
    }
    //------------------------- Register select all end ------------------//       
    
    //-------------------------- Make Active begin ----------------------//
    function makeActive(){
   	if(self.selected_employee.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
    	} else {
    		var activate_flag = 0;
    		angular.forEach(self.selected_employee, function(employee){
    			if(employee.active == 'Y') {
    				activate_flag = 1;
    			} 
    			
    		});
    		if(activate_flag == 1) {
				self.message ="Selected record(s) already in active status..!";
				successAnimate('.failure');
    			
    		} else {
    			var active_id = [];
    			for(var i=0; i<self.selected_employee.length; i++) {
    				active_id[i] = self.selected_employee[i].emp_id;    				
    			}
				EmployeeService.makeActive(active_id)
					.then(
							function(response) {
								fetchAllEmployees();
								self.selected_employee = [];
								self.message ="Selected record(s) has in activat status..!";
								successAnimate('.success');
							}, function(errResponse) {
								console.log(errResponse);    								
							}
						);
    		}


    	}
    	
    }
    //-------------------------- Make Active end ----------------------//    
    
    
  //-------------------------- Make inActive begin ----------------------//
    function makeinActive(){
   	if(self.selected_employee.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
    	} else {
    		var inactivate_flag = 0;
    		angular.forEach(self.selected_employee, function(employee){
    			if(employee.active == 'N') {
    				inactivate_flag = 1;
    			} 
    			
    		});
    		if(inactivate_flag == 1) {
				self.message ="Selected record(s) already in inactive status..!";
				successAnimate('.failure');
    			
    		} else {
    			var inactive_id = [];
    			for(var i=0; i<self.selected_employee.length; i++) {
    				inactive_id[i] = self.selected_employee[i].emp_id;        				
    			}
				EmployeeService.makeinActive(inactive_id)
					.then(
							function(response) {
								fetchAllEmployees();
								self.selected_employee = [];
								self.message ="Selected record(s) has in inactive status..!";
								successAnimate('.success');
							}, function(errResponse) {
								console.log(errResponse);    								
							}
						);
    		}


    	}
    	
    }
    //-------------------------- Make inActive end ----------------------//   
    
    //-------------------------- Pagnation begin -----------------------//
    
    function pagination() {
        
    	$scope.viewby = 10;
		$scope.totalItems = self.employees.length;
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

   /* $scope.$watch('currentPage', function(){
    	console.log($scope.currentPage);
    });*/
/*	$timeout(function() { 
		fetchAllEmployees();		
	}, 2, false);	
	
	$timeout(function(){
		pagination();
		console.log($scope.totalItems);
	},150, false);*/
    //-------------------------- Pagnation end -----------------------//	
    
    //-------------------------------------- Print begin -----------------------------//
    function print() {
    	if(self.selected_employee.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
    	} else {
    			/*var print_id = [];
    			for(var i=0; i<self.selected_employee.length; i++) {
    				print_id[i] = self.selected_employee[i].emp_id;        				
    			}
				EmployeeService.print(print_id)
					.then(
							function(response) {
								fetchAllEmployees();
								self.selected_employee = response;	
								console.log(response);
							}, function(errResponse) {
								console.log(errResponse);    								
							}
						);*/
    			$scope.$root.printEmp = self.selected_employee;
    			console.log("inside print");
    			console.log($scope.$root.printEmp);
    			/*$window.location.href = 'listprint'; */
    	}
    }
    
    //-------------------------------------- Print end -----------------------------//
	
}]);