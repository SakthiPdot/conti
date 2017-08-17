/**
 * @Project_Name conti
 * @Package_Name custom js employee_control.js
 * @File_name employee_control.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 26, 2017 12:59:17 PM
 * @Updated_date_time Jun 26, 2017 12:59:17 PM
 */


contiApp.controller('EmployeeController', ['$http', '$scope','$q','$timeout', '$window','EmployeeService', 'BranchService', 'LocationService', 'ConfirmDialogService', function($http, $scope, $q, $timeout,  $window, EmployeeService, BranchService, LocationService, ConfirmDialogService){
	

	$("#screen_employee").addClass("active-menu");
	
	var self = this;
	self.employees = [];
	self.Filteremployees = [];
	self.employee = {};
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
/*	self.print = print;*/
	self.registerSearch = registerSearch;
	self.shownoofRecord = shownoofRecord;
	
	self.selected_employee = [];
	self.confirm_title = 'Save';
	self.confirm_type = 'TYPE_SUCCESS';
	self.confirm_msg = self.confirm_title+ ' ' + self.employee.emp_name + ' employee?';
	self.confirm_btnclass = 'btn-success';
	//self.selectedBranch = selectedBranch;

	$scope.shownoofrec = 10;
	
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
		   $(".datepicker1").val('');
		   $(".datepicker2").val('');
		   
		   fetchAllEmployees();
	    	self.heading = "Master";
		   /*$scope.$broadcast('angucomplete-alt:clearInput');*/


	}
	//-------------------------- Fetch All Employees begin ---------------------//
	 
	function close(oper) {
		self.confirm_title = oper;
		self.confirm_type = BootstrapDialog.TYPE_WARNING;
		self.confirm_msg = self.confirm_title+ ' without saving data?';
		self.confirm_btnclass = 'btn-warning';
		ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(
					function (res) {
						fetchAllEmployees();
						self.save = "saveclose";
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
					function (res)
					{
		 	        	reset();
		 	        }
				);
	}
	
	function fetchAllEmployees() {
		EmployeeService.fetchAllEmployees()
			.then(
					function (employee) 
					{
						self.employees = employee;
						
						console.log(self.employees);
						pagination();
					}, 
					function (errResponse) {
						console.log('Error while fetching employees');
					}
				);
	}
	//-------------------------- ----------------------------------------------------------//


	function resetSorting(){
	$scope.empName = false;
	$scope.empCode  = false;
	$scope.empCategory  = false;
	$scope.empBN  = false;
	$scope.empAdress1  = false;
	$scope.empMobileNo  = false;
	$scope.empEmail  = false;
	$scope.empDOB  = false;
	$scope.empDOJ  = false;
	$scope.empStatus= false;
	}
	// ===================================sort table====================================
	$scope.sortTable=function(x,status){
		console.log("filer by---"+x,"status---"+status);
		if(!$scope.disableSorting){
			$scope.lastSorted = x;	
			resetSorting();
			$scope[x]=status;
			EmployeeService.sortBy(x,status?"ASC":"DESC")
			.then(
					function (response) {
						self.employees = response;
						self.Filteremployees=response;
					}, 	
					function (errResponse) {
						console.log('Error while fetching employees');
					}
				);
		}
	}
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
					function (category) {
						self.employeecategory = category;			
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
	
	//------------------------ Branch block changes begin ----------------------//
    $scope.branch_name = function (branch_selected) {
    	
    	$('#branch_id').val(JSON.stringify(branch_selected.originalObject));

	    	    
	};	
	//------------------------ Branch block changes end ----------------------//
	
	
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
    			self.message = "Error while creating employee "+employee.emp_name+"";
    			successAnimate('.failure');                  
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
    	
    	
	    	EmployeeService.updateEmployee(employee)
	        .then(
	        		function () {
	                    fetchAllEmployees();
	                  
	        			self.message = employee.emp_name+" employee updated..!";
	        			successAnimate('.success');            			
	        		},
	       
	        function(errResponse){
    			self.message = "Error while updating employee "+employee.emp_name+"";
    			successAnimate('.failure'); 	            
	        }
	    );
    } 
	//------------------------- Update existing employee end ----------------------------------------------//  
    
    //------------------------- Submit for new employee / update employee begin ---------------------//
    function submit() {
    	
    	if(self.employee.emp_code == null) {
    		self.employee.emp_code = "";
    	}
    	if(self.employee.emp_address2 == null) {
    		self.employee.emp_address2 = "";
    	}
    	
    	if ( $("#branch_id").val() == "" || $("#branch_id").val() == null || $("#branch_name_value").val() == "" || $("#branch_name_value").val() == null ){
    		
    		$("#branch_name_value").focus();
    		
    	} else if( $("#empcategory_value").val() == "" || $("#empcategory_value").val() == null ){
    		
    		$("#empcategory_value").focus(); 
    		
    	} else if ( $("#location_id").val() == "" || $("#location_id").val() == null || $("#location_name_value").val() == "" || $("#location_name_value").val() == null ){
    		
    		$("#location_name_value").focus(); 
    		
    	} /*else if ( $(".datepicker1").val() == "" || $(".datepicker1").val() == null ){
    		
    		$(".datepicker1").focus(); 
    		
    		
    	} else if ( $(".datepicker2").val() == "" || $(".datepicker2").val() == null ){
    
    		$(".datepicker2").focus(); 
    		
    		
    	}*/else {
    		
    		if( self.employee.emp_id == null ) {
    			
    			self.confirm_title = 'Save';
    			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
    			self.confirm_msg = self.confirm_title+ ' ' + self.employee.emp_name + ' employee?';
    			self.confirm_btnclass = 'btn-success';
    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
    				.then(
    						function (res) {
    							self.employee.branchModel = JSON.parse($("#branch_id").val());
    			 	    		self.employee.empcategory = $("#empcategory_value").val();  
    			 	    		self.employee.location = JSON.parse($("#location_id").val()); 
    			 	    		
    			 	    		if($(".datepicker1").val().length == 0) {
    			 	    			self.employee.dob = null;
    			 	    		} else {
    			 	    			self.employee.dob = $(".datepicker1").val();
    			 	    		}
    			 	    		
    			 	    		if($(".datepicker2").val().length == 0) {
    			 	    			self.employee.doj = null;
    			 	    		} else {
    			 	    			self.employee.doj = $(".datepicker2").val();
    			 	    		}
    			 	    		
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
    							/*self.employee.branchModel = JSON.parse($("#branch_id").val());*/
    							self.employee.branchModel = JSON.parse($("#branch_id").val());
    			 	    		self.employee.empcategory = $("#empcategory_value").val();  
    			 	    		self.employee.location = JSON.parse($("#location_id").val());  	
    			 	    		if($(".datepicker1").val().length == 0) {
    			 	    			self.employee.dob = null;
    			 	    		} else {
    			 	    			self.employee.dob = $(".datepicker1").val();
    			 	    		}
    			 	    		
    			 	    		if($(".datepicker2").val().length == 0) {
    			 	    			self.employee.doj = null;
    			 	    		} else {
    			 	    			self.employee.doj = $(".datepicker2").val();
    			 	    		}
    			 	    		
    			 	    		editEmployee(self.employee);  
    			 	    		reset();
    			 	        	newOrClose();
    			 	        	
    						}
    					);
    		}
    		
    		
    		
    	} 

    }
    //------------------------- Submit for new employee / update employee end ---------------------//
    
  //------------------------- update employee begin ---------------------//
    function updateEmployee(employee) {
    	self.employee = employee;
    	(self.employee.emp_name).length> 15?
				self.heading="- "+(self.employee.emp_name).substr(0,14)+"..."
				:self.heading="- "+self.employee.emp_name ;
    	//self.heading = self.employee.emp_name;
    	$('#branch_id').val(JSON.stringify(self.employee.branchModel));
    	$('#location_id').val(JSON.stringify(self.employee.location));
    	$('#city').val(self.employee.location.address.city);
    	$('#country').val(self.employee.location.address.country);
    	$('#state').val(self.employee.location.address.state);
    	$('#pincode').val(self.employee.location.pincode);
    	$(".datepicker1").val(self.employee.dob);
 		$(".datepicker2").val(self.employee.doj);
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
									var index = self.employees.indexOf(employee);
									self.employees.splice(index,1);
									self.message =employee.emp_name+ " employee Deleted..!";
									successAnimate('.success');
									window.setTimeout( function(){	 	        		
	    			 	        		newOrClose();
	    							},5000);
									
								}, 
								function (errResponse) {									
									self.message = "Error while Deleting employee "+employee.emp_name+"";
					    			successAnimate('.failure'); 
								}
							);
						
					}
				);
		
    }
    
  //------------------------- delete employee end ---------------------//
    
    //------------------------- Register select begin ------------------//
    function empSelect(employee){
    	var index = self.selected_employee.indexOf(employee);
    	/*(employee.select)? self.selected_employee.push(employee) : self.selected_employee.splice(index, 1);*/
    	
    	if (employee.select){
    		self.selected_employee.push(employee);
    	} else {
    		$scope.selectall = false;
    		self.selected_employee.splice(index, 1);
    	}
    	
    }
    //------------------------- Register select end ------------------//
    //------------------------- Register select all begin ------------------//   
    function empSelectall() {
		self.selected_employee=[];
		
		for(var i = 0; i < $scope.pageSize; i++) {
			self.Filteremployees[i].select = $scope.selectall;
			if($scope.selectall){
				self.selected_employee.push(self.Filteremployees[i]);
			}
		}	
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
    			
    			self.confirm_title = 'Active';
    			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
    			self.confirm_msg = self.confirm_title+ ' selected record(s)?';
    			self.confirm_btnclass = 'btn-success';
    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
    			.then(
    					function (res) {
    						var active_id = [];
    		    			for(var i=0; i<self.selected_employee.length; i++) {
    		    				active_id[i] = self.selected_employee[i].emp_id;    				
    		    			}
    						EmployeeService.makeActive(active_id)
    							.then(
    									function(response) {
    										fetchAllEmployees();
    										self.selected_employee = [];
    										self.message ="Selected record(s) has in active status..!";
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
    					);
    			
    		}


    	}
    	
    }
    //-------------------------- Make inActive end ----------------------//   
    
    
	//-------------------------- Record Count begin -----------------------//
	
	function findrecord_count() {
		
		EmployeeService.findrecord_count()
		.then(
				function (record_count) {
					console.log(record_count);
					$scope.totalnof_records  = record_count;
				}, 
				function (errResponse) {
					console.log('Error while fetching record count');
				}
			);
		
	}
	
	//-------------------------- Record Count end -----------------------//
	
    //-------------------------- Pagnation begin -----------------------//
    
    function pagination() {
        
    	$scope.pageSize = $scope.shownoofrec;
		$scope.currentPage = 0;
		$scope.totalPages = 0;
		self.Filteremployees = self.employees;
		
		$scope.nextDisabled = false;
		$scope.previouseDisabled = true;
		
		if( self.Filteremployees.length <= 10 ) {
			$scope.nextDisabled = true;
		} 
		
		if( self.Filteremployees.length < 100 ) {
			$scope.totalnof_records  = self.Filteremployees.length;
			//findrecord_count();
		} else {
			findrecord_count();
		}
				
    }

    
  
  /*  function getNoofpages () {
    	if( Math.round(self.Filteremployees.length/$scope.pageSize) >= (self.Filteremployees.length/$scope.pageSize) ) {
			$scope.noofpages = ( Math.round(self.Filteremployees.length/$scope.pageSize) );
		} else {
			$scope.noofpages = ( Math.round(self.Filteremployees.length/$scope.pageSize) + 1 );
		}
    }*/
    
    $scope.paginate = function(nextPrevMultiplier) {
    	console.log($scope.currentPage);
    	$scope.selectall = false;
    	$scope.currentPage += (nextPrevMultiplier * 1);
    	self.Filteremployees = self.employees.slice($scope.currentPage*$scope.pageSize);
    	console.log(self.employees.length);
    	console.log(self.Filteremployees.length);
    	if(self.Filteremployees.length == 0) {
    		console.log("empty");
    		EmployeeService.pagination_byPage($scope.currentPage)
    		.then(
    				function (filterEmp) {
    					console.log(filterEmp);
    					if ( filterEmp.length == 0 ) {
    						$scope.nextDisabled = true;
    					} else if ( filterEmp.length < 10 ) {
    						self.Filteremployees = filterEmp;
    						$scope.nextDisabled = true;
    					} else {
    						self.Filteremployees = filterEmp;
    					}
    					
    				}, 
    				function (errResponse) {
    					console.log('Error while pagination');
    				}
    			);
    	} 
    	
    	$scope.disableSorting=  ($scope.currentPage > 0) ?true:false;
    	
    	/*if(self.Filteremployees.length < $scope.pageSize) {
    		$scope.nextDisabled = true;
    	}
*/
    	if($scope.currentPage == 0) {
    		$scope.previouseDisabled = true;
    	}
    	if(nextPrevMultiplier == -1) {    		
    		$scope.nextDisabled = false;
    	} else {
    		$scope.previouseDisabled = false;
    	}
    	
    }


    //-------------------------- Pagnation end -----------------------//	
    
  //---------------------------- Pagination begin ---------------------------------------//
    
    $scope.firstlastPaginate = function (page) {
    	$scope.selectall = false;
    	if( page == 1 ) { // first
    		$scope.currentPage = 0;
    		$scope.previouseDisabled = true;
    		$scope.nextDisabled = false;
    		self.Filteremployees = self.employees.slice($scope.currentPage*$scope.pageSize);
    	/*	fetchAllEmployees();*/
    	} else { // last
    		
    		/*if(self.Filteremployees.length < $scope.pageSize) {
        		$scope.currentPage = ( (Math.ceil(self.Filteremployees.length/$scope.pageSize)) );    			
    		} else {
    			$scope.currentPage = ( (Math.ceil(self.Filteremployees.length/$scope.pageSize)) - 1 );
    		}*/
    		$scope.currentPage = ( (Math.ceil(self.Filteremployees.length/$scope.pageSize)) - 1 );
    		console.log($scope.currentPage);
    		$scope.previouseDisabled = false;
    		$scope.nextDisabled = true;
    		
    		self.Filteremployees = self.employees.slice($scope.currentPage*$scope.pageSize);
    		
    		if(self.Filteremployees.length == 0) {
    			EmployeeService.pagination_byPage(page)
        		.then(
        				function (filterEmp) {
        					self.Filteremployees = filterEmp;
        				}, 
        				function (errResponse) {
        					console.log('Error while fetching employees');
        				}
        			);
    		}
    		
    	}
    	
    	$scope.disableSorting=  ($scope.currentPage > 0) ?true:false;
    	
    	
    	
    	
    }
    

  //---------------------------- Pagination end ---------------------------------------//
   
    //-------------------------------- Show no of record begin ----------------------------------------//
    
    function shownoofRecord() 
    {    
    	
    	$scope.pageSize = $scope.shownoofrec;
    	self.Filteremployees = self.employees.slice($scope.currentPage*$scope.pageSize);
    	if( self.Filteremployees.length <= $scope.pageSize )
    	{
    		$scope.previouseDisabled = true;
    		$scope.nextDisabled = true;
    	}
    	else
    	{
    		//$scope.previouseDisabled=false;
    		$scope.nextDisabled=false;
    	}
    }
    //-------------------------------- Show no of record end ----------------------------------------//  
    
    //---------------------------- Register search begin ---------------------------------------//
    function registerSearch(searchkey) {
    	if ( searchkey.length == 0 ) {
    		self.Filteremployees = self.employees;
    	}else if( searchkey.length > 3 ) {
    		EmployeeService.registerSearch(searchkey)
	    		.then(
						function (filterEmp) {
							self.Filteremployees = filterEmp;
						}, 
						function (errResponse) {
							console.log('Error while fetching employees');
						}
					);
    	} else {
    		
    		self.Filteremployees = _.filter(self.employees,
					 function(item){  
						 return searchUtil(item,searchkey); 
					 });
				
    		}
    	
    }
    
    function searchUtil(item,toSearch)
	{
		var success = false;
		
		if ( (item.emp_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.emp_code.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
				|| (item.empcategory.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.branchModel.branch_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
				|| (item.emp_address1.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.emp_address2.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
				|| (item.location.location_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.location.address.city.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
				|| (item.location.address.district.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.location.address.state.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)
				|| ((String(item.emp_phoneno)).indexOf(toSearch) > -1 ) ||  (item.emp_email.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || ((String(item.dob)).indexOf(toSearch) > -1 ) 
				|| ((String(item.doj)).indexOf(toSearch) > -1 )) {
			success = true;
		} else {
			success = false;
		}
		
		return success;
	}
    //---------------------------- Register search end ---------------------------------------//
     

  
	
}]);