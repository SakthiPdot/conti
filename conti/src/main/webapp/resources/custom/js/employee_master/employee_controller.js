/**
 * @Project_Name conti
 * @Package_Name custom js employee_control.js
 * @File_name employee_control.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 26, 2017 12:59:17 PM
 * @Updated_date_time Jun 26, 2017 12:59:17 PM
 */

contiApp.controller('EmployeeController', ['$scope', 'EmployeeService', 'BranchService', 'LocationService', function($scope, EmployeeService, BranchService, LocationService){
	
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
	
	self.employeecategory = {};  
	self.message = null;
	self.submit = submit;
	self.save = null;
	self.reset = reset;
	self.updateEmployee = updateEmployee;
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
	}
	//-------------------------- Fetch All Employees begin ---------------------//
	 

	function fetchAllEmployees() {
		EmployeeService.fetchAllEmployees()
			.then(
					function (d) {
						self.employees = d;
						console.log(d);						
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
	
	$scope.save = function(event){
		self.save=event.target.id;
		
		console.log(self.save);
	}
	
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
    
    //------------------------- Submit for new employee / update employee begin ---------------------//
    function submit() {
    	var save_flag = 0;
    	if ( $("#branch_id").val() == "" || $("#branch_id").val() == null ){
    		
    		$("#branch_name_value").focus();
    		
    	} else if( $("#empcategory_value").val() == "" || $("#empcategory_value").val() == null ){
    		
    		$("#empcategory_value").focus(); 
    		
    	} else if ( $("#location_id").val() == "" || $("#location_id").val() == null ){
    		
    		$("#branch_name_value").focus(); 
    		
    		
    	} else {
    		
    		 BootstrapDialog.confirm({
	    	  		
	 				title: 'Create new employee',
	 				message: 'Do you want to save?',
	 				type: BootstrapDialog.TYPE_SUCCESS, // <-- Default value is BootstrapDialog.TYPE_PRIMARY
	 				closable: false, 
	 				draggable: false, 
	 				btnCancelLabel: 'No!', // <-- Default value is 'Cancel',
	 				btnOKLabel: 'Yes!', // <-- Default value is 'OK',
	 				btnOKClass: 'btn-success', // <-- If you didn't specify it, dialog type will be used,
	 				
	 				callback: function(result) {
	 			if(result)
	 			{
	 				self.employee.branch_id = $("#branch_id").val();
	 	    		self.employee.empcategory = $("#empcategory_value").val();  
	 	    		self.employee.location = JSON.parse($("#location_id").val());    	

	 	        	createEmployee(self.employee);  
	 	        	reset();
	 	        	window.setTimeout( function(){	 	        		
	 	        		newOrClose();
					},5000);
	 	        	
	  			}
	     			
	 	        },

	 		
	  		});
    		
    	} 

    }
    //------------------------- Submit for new employee / update employee end ---------------------//
    
    
    function updateEmployee(employee) {
    	self.employee = employee;
    	
    	$('#branch_id').val(JSON.stringify(self.employee.branch));
    	$('#location_id').val(JSON.stringify(self.employee.location));
    	$('#city').val(self.employee.location.address.city);
    	$('#country').val(self.employee.location.address.country);
    	$('#state').val(self.employee.location.address.state);
    	$('#pincode').val(self.employee.location.pincode);
    	drawerOpen('.drawer');
    }
}]);