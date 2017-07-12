/**
 * @Project_Name conti
 * @Package_Name custom js employee_control.js
 * @File_name employee_control.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 26, 2017 12:59:17 PM
 * @Updated_date_time Jun 26, 2017 12:59:17 PM
 */

contiApp.controller('EmployeeController', ['$scope', '$timeout','LocationService', 'ConfirmDialogService', function($scope, $timeout, EmployeeService, BranchService, LocationService, ConfirmDialogService)
	{
	
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
	self.confirm_title = 'Save';
	self.confirm_type = 'TYPE_SUCCESS';
	self.confirm_msg = self.confirm_title+ ' ' + self.employee.emp_name + ' employee?';
	self.confirm_btnclass = 'btn-success';
	//self.selectedBranch = selectedBranch;
	
	fetchAllEmployees();
	fetchEmpCat();
	fetchAllBranches();
	fetchAllLocations();
	
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
						console.log(branches);						
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
						console.log(locations);						
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
		console.log(self.save);				
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
    			 	    		console.log(self.employee);
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
    			self.confirm_btnclass = 'btn-warning';
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
									self.message =employee.emp_name+ " employee Deleted..!";
									successAnimate('.success');
									newOrClose();
									self.employees.splice(employee,1);
									console.log(employee);	
									console.log(self.employees);	
								}, 
								function (errResponse) {
					                console.error('Error while Delete employee' + errResponse );
								}
							);
						
					}
				);
		
    }
    
  //------------------------- delete employee end ---------------------//
}]);