/**
 * @Project_Name conti
 * @Package_Name custom js employee_control.js
 * @File_name employee_control.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 26, 2017 12:59:17 PM
 * @Updated_date_time Jun 26, 2017 12:59:17 PM
 */

contiApp.controller('EmployeeController', ['$scope', 'EmployeeService', 'BranchService', function($scope, EmployeeService, BranchService){
	
	var self = this;
	self.employees = [];
	
	self.employee = {
			   emp_id : null,
			   branch_id : null,
			   update_by : null,
			   created_by : null,
			   branch_id : null,
			   emp_name : "ss",
			   emp_code : "ds",
			   empcategory : "cd",
			   emp_phoneno : 2,
			   emp_address : "dddd",
			   location_id : 1,
			   emp_email : "rm",
			   dob : '2017-06-26 17:34:54',
			   doj : '2017-06-26 17:34:54',
			   created_datetime : "da",
			   updated_datetime : "da",
			   obsolete : "N",
			   active : "Y"
			};
	
	self.employeecategory = {};  
	
	self.submit = submit;
	self.selectedBranch = selectedBranch;
	
	fetchAllEmployees();
	fetchEmpCat();
	fetchAllBranches();
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
	
	//-------------------------- Fetch All Employees begin ---------------------//
	

	function fetchEmpCat() {
		EmployeeService.fetchEmpCat()
			.then(
					function (d) {
						self.employeecategory = d;
						console.log(d);						
					}, 
					function (errResponse) {
						console.log('Error while fetching employees');
					}
				);
	}
	//-------------------------- Fetch All Employees end ---------------------//

	//-------------------------- Selected branch details begin ---------------------//
	function selectedBranch() {
		console.log("Inside branch "+$("#branch_name_value").val());

	}
	//-------------------------- Selected branch details end ---------------------//	
    function createEmployee(employee){
    	EmployeeService.createEmployee(employee)
            .then(
            fetchAllEmployees,
            function(errResponse){
                console.error('Error while creating User');
            }
        );
    } 
    
    function submit() {
    	self.employee.branch_id = $("#branch_id").val();
    	createEmployee(self.employee);
    }
}]);