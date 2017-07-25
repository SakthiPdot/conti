/**
 * @Project_Name conti
 * @Package_Name custom js user_control.js
 * @File_name user_control.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 21, 2017 8:24:17 PM
 * @Updated_date_time Jun 20, 2017 3:24:17 PM
 */
contiApp.controller('UserController', ['$scope', 'UserService', 'EmployeeService', 'BranchService', 'ConfirmDialogService', function($scope, UserService, EmployeeService, BranchService, ConfirmDialogService) {
  
	$("#screen_user").addClass("active-menu");
	var self = this;
    self.user={user_id:null,username:''};
    self.user.role = {};
    self.users=[];
    self.selected_user = [];
    self.FilterUsers = [];
    self.save = "saveclose";
    
    self.message = null;
    self.resetBtn = false;
	self.checkPWD = true;
	self.errorUsername = false;
	self.submit = submit;
	self.updateUser = updateUser;
	self.reset = reset;
	self.close = close;
	self.clear = clear;
	
	self.heading = "Master";
 
    self.findUsername = findUsername;
	self.resetPassword = resetPassword;
	self.getPassword = getPassword; 
	self.checkPassword = checkPassword; 	
	self.findUserbyMbl = findUserbyMbl;
	self.forgot_animateClose = forgot_animateClose;
	self.checkUsername = checkUsername;
	self.deleteUser = deleteUser;
	self.userSelect = userSelect;
	self.makeActive = makeActive;
	self.makeinActive = makeinActive;
	self.print = print;
	self.shownoofRecord = shownoofRecord;
	self.userSelectall = userSelectall;
	self.registerSearch = registerSearch;
	$scope.shownoofrec = 10;
    fetchAllRoles();
    
    fetchAllUsers();
    fetchAllBranches();

    /*var currentUserRole = $('#currentUserRole').val();*/

	function reset () {
		   self.user = {};
		   $('#employee_name_value').val('');
		   $('#branch_name_value').val('');
		  
	    	self.heading = "Master";
		   /*$scope.$broadcast('angucomplete-alt:clearInput');*/

	    	animationOpenClick('.passward_validate','slideOutLeft');
	    	$('.passward_validate').addClass('hidden');
			
	}
	
	function close(oper) {
		
		console.log(oper);
		self.confirm_title = oper;
		self.confirm_type = BootstrapDialog.TYPE_WARNING;
		self.confirm_msg = self.confirm_title+ ' without saving data?';
		self.confirm_btnclass = 'btn-warning';
		ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(
					function (res) {
		 	        	self.save="saveclose"; 
		 	        	newOrClose();
		 	        	reset();
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

    //----------------------  Fetch All users begin ----------------------------- //    
    function fetchAllUsers(){
        UserService.fetchAllUsers()
            .then(
            function(users) {
                self.users = users;
                pagination();
            },
            function(errResponse){
                console.error('Error while fetching Users');
            }
        );
    }
    //----------------------  Fetch All users end ----------------------------- //    

    //----------------------  Find user by user id begin ----------------------------- //    
    function findUser(user, id){
        UserService.findUser(user, id)
            .then(
            fetchAllUsers,
            function(errResponse){
                console.error('Error while updating User');
            }
        );
    }
    //----------------------  Find user by user end ----------------------------- //
    
    //----------------------  Find user by user name begin ----------------------------- //    
    function findUsername() {
    	UserService.findUserbyName(self.user.username)
    		.then(
	    			function (response) {
	    				console.log(response.status);
	    				if(response.status == 200) {
	    					
	    					if(response.data != "") {
		    					if(response.data.obsolete == "SUPER_ADMIN") {
		    						self.message = "Kindly contact your technical person..!";
		    						successforgot_AnimateOpen('.success-forgot');
	    				    		
		    					} else if (response.data.obsolete == "MANGAER") {
		    						self.message = "Password reset link sent to your E-mail : " + response.data.employeeMaster.emp_email;
		    						successforgot_AnimateOpen('.success-forgot');
		    					} else {
		    						self.message = "Kindly contact your manager..! Manager contact no is "+ response.data.active;
		    						successforgot_AnimateOpen('.success-forgot');
		    					}
		    				} else {
		    					self.message = "User name does not match..!";
		    				}
	    					
	    					
	    				} else if(response.status == 226) {
	    					
	    					self.message = "Link already sent to your registered E-mail id..!";
	    					successforgot_AnimateOpen('.failure-forgot');
	    				} else {
	    					self.message = "Invalid username..!";
	    					successAnimate('.failure');
	    					clear_username();
	    				}
	    				
	    				
	    			},
	    			function(errResponse) {
	    				console.log(errResponse);
	    			}
    			);
    }

    //----------------------  Delete user by user id begin ----------------------------- //
    
    function deleteUser() {
    	
    	self.confirm_title = 'Delete';
		self.confirm_type = BootstrapDialog.TYPE_DANGER;
		self.confirm_msg = self.confirm_title+ ' ' + self.user.username + ' user?';
		self.confirm_btnclass = 'btn-danger';
		ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(
					function (res) {
												
						UserService.deleteUser(self.user.user_id)
						.then(
								function (user) {
									var index = self.users.indexOf(user);
									self.users.splice(index,1);
									self.message =user.username+ " username Deleted..!";
									successAnimate('.success');
									window.setTimeout( function(){	 	        		
										newOrClose();
	    							},5000);
									
								}, 
								function (errResponse) {
					                console.error('Error while Delete user' + errResponse );
								}
							);
						
					}
				);
		
    }
    
    //----------------------  Delete user by user id end ----------------------------- //
    
  //----------------------  get password begin ----------------------------- //
    var minchar = false;
    var caps = false;  
    var num = false;    
    var specialchar = false;    
    function getPassword(password) {
    	
    	console.log(password);
    	var upperCase= new RegExp('[A-Z]');
    	var numbers = new RegExp('[0-9]');
    	var special_char = /^[a-zA-Z0-9- ]*$/;
    	
    	if( password == undefined ) {
    		
    		$('.minchar').removeClass('makeGreen');
			$('.minchar').addClass('makeRed');
			
			$('.caps').removeClass('makeGreen');
			$('.caps').addClass('makeRed');
			
			$('.num').removeClass('makeGreen');
			$('.num').addClass('makeRed');
			
			$('.specialchar').removeClass('makeGreen');
			$('.specialchar').addClass('makeRed');
			
    	}
    	
		if( password.length == 1 ) {
			$('.passward_validate').removeClass('hidden');
			animationOpenClick('.passward_validate','slideInLeft');
		}
		
		
		if ( password.length >= 8 ) {
			$('.minchar').removeClass('makeRed');
			$('.minchar').addClass('makeGreen');
			minchar = true;

		} else {
			$('.minchar').removeClass('makeGreen');
			$('.minchar').addClass('makeRed');
			
			minchar = false;
		}
    	
		if(password.match(upperCase)) {
						
			$('.caps').removeClass('makeRed');
			$('.caps').addClass('makeGreen');
			
			caps = true;

		} else {
			
			console.log("inside else  match");
			$('.caps').removeClass('makeGreen');
			$('.caps').addClass('makeRed');
			
		    caps = false;
		}
		
		if(password.match(numbers)) {
			
			$('.num').removeClass('makeRed');
			$('.num').addClass('makeGreen');
			
			num = true;
			
		} else {
			
			$('.num').removeClass('makeGreen');
			$('.num').addClass('makeRed');
			
			num = false;
		}
		
		if( special_char.test(password) == false ) {
			$('.specialchar').removeClass('makeRed');
			$('.specialchar').addClass('makeGreen');
			
			specialchar = true;
		} else {
			$('.specialchar').removeClass('makeGreen');
			$('.specialchar').addClass('makeRed');
			
			specialchar = false;
		}
		
		if ( minchar == true && caps == true && num == true && specialchar == true) {
			self.resetBtn = true;
		} else {
			self.resetBtn = false;
		}
		checkPassword(self.password, self.confpassword);
    }
    
    function checkPassword(password, confirm_password) {
    	console.log(password + " " + confirm_password);
    	if( password == confirm_password ) {
    		self.checkPWD = true;
    	} else {
    		self.checkPWD = false;    		
    	}
    }
  //----------------------  get password end ----------------------------- //    
    
    //----------------------- Reset Password ADMIN / MANAGER begin -------------------------------------//
    
    function resetPassword() {
    	console.log("Inside reset password");
    	//self.user.userpassword = self.user.password;
    	self.user.user_id = $("#id").val();
    	self.user.obsolete = $("#link").val();
    	delete self.user.confpassword;
    	UserService.changePassword(self.user)
    		.then(
    				function (response) {
    					if(response.status == 200) {
    						self.message = "Password changed successfully..!";
    						successAnimate('.success');
    						
    						window.setTimeout( function(){
    							window.location.replace('/Conti/login');
    				    	}, 5000);
    						
    					} else {
    						self.message = "Password is not changed..!";
    						successAnimate('.failure');
    					}
    					
    				},
    				function (errResponse) {
    					console.log(errResponse);
    				}
    			);
    }
    
    
    //----------------------- Reset Password ADMIN / MANAGER begin -------------------------------------//
    
    
    
    //----------------------- Find user by mobile begin ------------------------------------------------//
    
    	function findUserbyMbl(mobileno) {
   		
    		UserService.findUserbyMbl(mobileno)
    			.then(
    					
    					function(response) {
    						console.log(response);
    						if( response.status == 208 ) {
    							self.message = "Please check after 2 hrs.";
    	    					successAnimate('.failure');
    	    					clear_mobileno();
    						} else if( response.status == 226 ) {
    							self.message = "Please check after 2 hrs.";
    	    					successAnimate('.failure');
    	    					clear_mobileno();
    						} else {
    							self.message = "Sent username to your registered mobile number";
        						successforgot_AnimateOpen('.success-forgot');	
    						}
							    						
    					},
    					function (errResponse) {
    						console.log(errResponse);
    						if( errResponse.status == 503 ) {
    							self.message = "Please try again later..!";
    	    					successAnimate('.failure');
    	    					clear_mobileno();
    						} else {
    							
    							self.message = "Sorry..! Mobile number is not valid..!";
    	    					successAnimate('.failure');
    	    					clear_mobileno();
    							
    						}
    						
    							
    					}
    				);
    	}
    
    //----------------------- Find user by mobile end ------------------------------------------------//
    	
    //----------------------- Success / Failure animate Close for forgot begin ---------------------//
    	function forgot_animateClose() {
    		console.log("Inside animateclose");
    		successforgot_AnimateClose('.success-forgot');
    		successforgot_AnimateClose('.failure-forgot');
    		window.setTimeout( function(){
				window.location.replace('/Conti/login');
	    	}, 3000);
    	}
    //----------------------- Success / Failure animate Close for forgot end ---------------------//    
    	
    //----------------------  Find user by user name begin ----------------------------- //
    function clear_username() {
    	self.user.username = '';
    }
    //----------------------  Delete user by user id begin ----------------------------- //
    //----------------------  Find user by user name begin ----------------------------- //
    function clear_mobileno() {
    	self.user.mobileno = '';
    }
    //----------------------  Delete user by user id begin ----------------------------- //
    
    
    //======================== Print Function Begin =================//
    		
    	function print() {
    		if(self.selected_user.length == 0){
    			self.message = "Please select atleast one record..!";
    			successAnimate('.failure');
    		} else{
    			$http.get('http://localhost:8080/Conti/listprint');
    		}
    	}
    
    //======================== Print Function End =================//
    	
    //======================== Make Active Begin =================//
    	
    	function makeActive(){
    		
    		if(self.selected_user.length == 0 ) {
    			self.message = " Please select atleast one record..!";
    			successAnimate('.failure');
    		} else {
    			var activate_flag = 0;
    			angular.forEach (self.selected_user, function(user) {
    				if(user.active == 'Y') {
    					activate_flag = 1;
    				}
    			});
    			
    			if(activate_flag == 1) {
    				self.message = " Selected record(s) already in active status..!";
    				successAnimate('.failure');
    			} else {
    				
    				self.confirm_title = 'Active';
    				self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
    				self.confirm_msg = self.confirm_title + ' selected record(s)?';
    				self.confirm_btnclass = 'btn-success';
					ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
						.then(
								function(res) {
									var active_id = [];
									for(var i=0; i<self.selected_user.length;i++) {
										active_id[i] = self.selected_user[i].user_id;
									}
									UserService.makeActive(active_id)
										.then(
												function(response) {
													fetchAllUsers();
													self.selected_user = [];
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
    	
    //======================== Make Active End ================//
    	
    	//============== Make InActive Begin ====================//
    	
		function makeinActive() {
			if(self.selected_user.length == 0) {
				self.message = "Please select atleast one record..!";
				successAnimate('.failure');
			} else {
				var inactivate_flag = 0 ;
				angular.forEach(self.selected_user, function(user){
					if(user.active == 'N') {
						inactivate_flag = 1;
					}
				});
				
				if(inactivate_flag == 1) {
					self.message = "Selected record(s) already in active status..!";
					successAnimate('.failure')
				} else {
					
					self.confirm_title = 'In-Active';
					self.confirm_type = BootstrapDialog.TYPE_DANGER;
					self.confirm_msg = self.confirm_title+ ' selected record(s)?';
					self.confirm_btnclass = 'btn-danger';
					ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
						.then(
								function(res) {
									var inactive_id = [];
									for(var i=0; i<self.selected_user.length; i++) {
										inactive_id[i] = self.selected_user[i].user_id;
									}
								
								UserService.makeinActive(inactive_id)
									.then(
											function(response) {
												fetchAllUsers();
												self.selected_user = [];
												self.message = " Selected record(s) has in inactive status..!";
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
		
//============== Make InActive End =======================//
		
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
		
		//------------------------ Branch block changes begin ----------------------//
	    $scope.branch_name = function (branch_selected) {
	    	
	    	$('#branch_id').val(JSON.stringify(branch_selected.originalObject));

	    	fetchEmployeebyBranchid(branch_selected.originalObject.branch_id);	    
		};	
		//------------------------ Branch block changes end ----------------------//

		
		//-------------------------- Fetch All Branch begin ---------------------//	
		
		function fetchEmployeebyBranchid(branch_id) {

			EmployeeService.fetchEmployeebyBranchid(branch_id)
				.then(
						function (employees) {
							self.employeesforname = employees;	
							
							console.log(employees);
						}, 
						function (errResponse) {
							console.log('Error while fetching branches');
						}
					);
		}
		
		//-------------------------- Fetch All Branch end ---------------------//
		
		//------------------------ Branch block changes begin ----------------------//
	    $scope.emp_name = function (emp_selected) {
	    	
	    	$('#emp_id').val(JSON.stringify(emp_selected.originalObject));
	    
		};	
		//------------------------ Branch block changes end ----------------------//
		
		//-------------------------- Fetch All Branch begin ---------------------//	
		
		function fetchAllRoles() {
			UserService.fetchAllRoles()
				.then(
						function (roles) {
							/*
							if ( currentUserRole == "MANAGER") {
								for(var i =0; i< roles.length; i++) {
									if( roles[i].role_Name == "SUPER_ADMIN" ) {
										console.log(roles.indexOf(roles[i]));
										roles.splice(roles.indexOf(roles[i]),1);
									}
								}
							}
							*/
							self.roles = roles;
							
						}, 
						function (errResponse) {
							console.log('Error while fetching branches');
						}
					);
		}
		
		//-------------------------- Fetch All Branch end ---------------------//
		
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
		
		//------------------------- Submit for new User / update user begin --------//
		function submit() {
			if( $("#branch_id").val() == "" || $("#branch_id").val() == null 
					|| $("#branch_name_value").val() == "" || $("#branch_name_value").val() == null ) {
				$("#branch_name_value").focus();
			} else if( $("#emp_id").val() == "" || $("#emp_id").val() == null 
					|| $("#employee_name_value").val() == "" || $("#employee_name_value").val() == null ) {
				$("#employee_name_value").focus();
			} else {
				
				if( self.user.user_id == null ) {
					
					self.confirm_title = 'Save';
	    			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
	    			self.confirm_msg = self.confirm_title+ ' ' + self.user.username + ' user?';
	    			self.confirm_btnclass = 'btn-success';
	    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
	    				.then(
	    						function (res) {
	    							self.user.branchModel = JSON.parse($("#branch_id").val());
	    			 	    		self.user.employeeMaster = JSON.parse($("#emp_id").val()); 
	    			 	    		self.user.role.role_Id = self.user.role_id;
	    			 	    		delete self.user.role_id;
	    			 	    		delete self.user.confpassword;
	    			 	    		createUser(self.user);  
	    			 	        	reset();
	    			 	        	window.setTimeout( function(){	 	        		
	    			 	        		newOrClose();
	    							},5000);
	    						}
	    					);
	    			
				} else {
					
					
					self.confirm_title = 'Update';
	    			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
	    			self.confirm_msg = self.confirm_title+ ' ' + self.user.username + ' user?';
	    			self.confirm_btnclass = 'btn-success';
	    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
	    				.then(
	    						function (res) {
	    							self.user.branchModel = JSON.parse($("#branch_id").val());
	    			 	    		self.user.employeeMaster = JSON.parse($("#emp_id").val()); 
	    			 	    		self.user.role.role_Id = self.user.role_id;
	    			 	    		delete self.user.role_id;
	    			 	    		delete self.user.confpassword;	    			 	    		
	    			 	    		editUser(self.user);  
	    			 	        	reset();
	    			 	        	window.setTimeout( function(){	 	        		
	    			 	        		newOrClose();
	    							},5000);
	    						}
	    					);
					
				}
				
			}
		}
		
		//------------------------- Submit for new User / update user end --------//
		
		
		
		//------------------------- Create new User begin ------------------//
	    function createUser(user){
	    	
	    	UserService.createUser(user)
	            .then(
	            		function () {
	                        fetchAllUsers();
	                        
	            			self.message = user.username+" user created..!";
	            			successAnimate('.success');            			
	            		},
	           
	            function(errResponse){
	                console.error('Error while creating user' + user.username );
	            }
	        );
	    } 
		//------------------------- Create new User end ----------------------------------------------//   
		
	    //------------------------- update User begin ---------------------//
	    function updateUser(user) {
	    	self.user = user;
	    	self.usernameupdateCheck = user.username;
	    	self.heading = self.user.username;
	    	$('#branch_id').val(JSON.stringify(self.user.branchModel));
	    	$('#branch_name_value').val(self.user.branchModel.branch_name);
	    	$('#employee_name_value').val(self.user.employeeMaster.emp_name);
	    	$('#emp_id').val(JSON.stringify(self.user.employeeMaster));
			 
	    	self.user.role_id = user.role.role_Id;
	    	self.user.confpassword = user.userpassword;
	    	drawerOpen('.drawer');
	    }
	    //------------------------- update User end ---------------------//
	    
	  //------------------------- Update existing employee begin ------------------//
	    function editUser(user){
	 
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
	    	
	    	
		    	UserService.updateUser(user)
		        .then(
		        		function (user) {
		        			console.log(user);
		                    /*fetchAllUsers();*/
		                    self.message = user.username+" user updated..!";
		        			successAnimate('.success');            			
		        		},
		       
		        function(errResponse){
		            console.error('Error while update user' + user.username );
		        }
		    );
	    } 
		//------------------------- Update existing employee end ----------------------------------------------//  
	    
		//------------------------- Check username begin -------------------------------------//
		
		function checkUsername(username){
			
			var user_check  = 0;
			if (self.user.user_id != null) {
				
				if(username == self.usernameupdateCheck) {
					user_check = 1;
					
					self.errorUsername = false;
				}
				
			}
			
			if ( user_check == 0 ) {
				
				UserService.checkUsername(username)
				.then(
						function(response) {
							if( response.status == 200 ) {
								self.errorUsername = true;
								
							} else {
								self.errorUsername = false;
								console.log(response.status);
							}

						}, function (errResponse) {
							console.log(errResponse);
						}
					);
				
			}
			
			
		}
		
		//------------------------- Check username end -------------------------------------//
		
		//-------------------------- Record Count begin -----------------------//
		
		function findrecord_count() {
			
			UserService.findrecord_count()
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
			self.FilterUsers = self.users;
			$scope.nextDisabled = false;
			$scope.previouseDisabled = true;
			if(self.FilterUsers.length <= 10 ) {
				$scope.nextDisabled = true;
			}
			
			if( self.FilterUsers.length < 100 ) {
				//$scope.totalnof_records  = self.FilterUsers.length;
				findrecord_count();
			} else {
				findrecord_count();
			}
			
	    }
	    
	    // --------------------------- Next page begin ------------------------  
	    $scope.paginate = function(nextPrevMultiplier) {

	    	$scope.currentPage += (nextPrevMultiplier * 1);
	    	self.FilterUsers = self.users.slice($scope.currentPage*$scope.pageSize);
	    	
	    	if(self.FilterUsers.length == 0) {
	    		UserService.pagination_byPage($scope.currentPage)
	    		.then(
	    				function (filterUser) {
	    					
	    					if ( filterUser.length == 0 ) {
	    						$scope.nextDisabled = true;
	    					} else if ( filterUser.length < 10 ) {
	    						self.FilterUsers = filterUser;
	    						$scope.nextDisabled = true;
	    					} else {
	    						self.FilterUsers = filterUser;
	    					}
	    					
	    				}, 
	    				function (errResponse) {
	    					console.log('Error while pagination');
	    				}
	    			);
	    	} 
	    	
	    	if(self.FilterUsers.length < $scope.pageSize) {
	    		
	    		$scope.nextDisabled = true;
	    	}
	    	
	    	if($scope.currentPage == 0) {
	    		$scope.previouseDisabled = true;
	    	}
	    	if(nextPrevMultiplier == -1) {    		
	    		$scope.nextDisabled = false;
	    	} else {
	    		$scope.previouseDisabled = false;
	    	}
	    	
	    }
	    // --------------------------- Next page end ------------------------
	    
	  // --------------------------- First & Last page begin ------------------------  
	    $scope.firstlastPaginate = function (page) {
	    	
	    	if( page == 1 ) { // first
	    		
	    		$scope.currentPage = 0;
	    		$scope.previouseDisabled = true;
	    		$scope.nextDisabled = false;
	    		fetchAllUsers();
	    		self.FilterUsers = self.users.slice($scope.currentPage*$scope.pageSize);
	    	} else { // last
	    		
	    		$scope.currentPage = ( (Math.round(self.FilterUsers.length/$scope.pageSize)) - 1 );	    		
	    		$scope.previouseDisabled = false;
	    		$scope.nextDisabled = true;
	    		
	    		self.FilterUsers = self.users.slice($scope.currentPage*$scope.pageSize);
		    			    	
		    	if(self.FilterUsers.length == 0) {
		    		
		    		UserService.pagination_byPage(page)
					.then(
							function (filterUser) {
								self.FilterUsers = filterUser;
								
							}, 
							function (errResponse) {
								console.log('Error while fetching users');
							}
						);
		    	} 
	    		
	    	}
	    
	    }
	    
	    // --------------------------- First & Last page end ------------------------
	    
	  //-------------------------- Pagnation end -----------------------//
	    
	    //------------------------- Register select begin ------------------//
	    function userSelect(user){
	    	
	    	var index = self.selected_user.indexOf(user);
	    	if (user.select){
	    		self.selected_user.push(user);
	    	} else {
	    		$scope.selectall = false;
	    		self.selected_user.splice(index, 1);
	    	}
	    	
	    }
	    //------------------------- Register select end ------------------//
	    
	    //------------------------- Register select all begin ------------------//   
	    function userSelectall() {
	 		self.selected_user=[];
			for(var i = 0; i < $scope.pageSize; i++) {
				self.FilterUsers[i].select = $scope.selectall;
				if($scope.selectall){
					self.selected_user.push(self.FilterUsers[i]);
				}
			}	
	    }
	    //------------------------- Register select all end ------------------// 
		
	    //-------------------------------- Show no of record begin ----------------------------------------//
	    
	    function shownoofRecord() {    
	    	
	    	$scope.pageSize = $scope.shownoofrec;
	    	
	    	self.FilterUsers = self.users.slice($scope.currentPage*$scope.pageSize);
	    	
	    	console.log(self.FilterUsers.length);
	    	
	    	if( self.FilterUsers.length < $scope.pageSize ) {
	    		$scope.previouseDisabled = true;
	    		$scope.nextDisabled = true;
	    	}
	    	
	    }
	    //-------------------------------- Show no of record end ----------------------------------------//  
	    
	    //---------------------------- Register search begin ---------------------------------------//
	    function registerSearch(searchkey) {
	    	
	    	console.log(searchkey);
	    	if ( searchkey.length == 0 ) {
	    		self.FilterUsers = self.users;
	    	}else if( searchkey.length > 3 ) {
	    		UserService.registerSearch(searchkey)
		    		.then(
							function (filterUser) {
								self.FilterUsers = filterUser;
							}, 
							function (errResponse) {
								console.log('Error while fetching Users');
							}
						);
	    	} else {
	    		
	    		self.FilterUsers = _.filter(self.users,
						 function(item){  
							 return searchUtil(item,searchkey); 
						 });
					
	    		}
	    	
	    }
	    
	    function searchUtil(item,toSearch)
		{
			var success = false;
			
			if ( (item.employeeMaster.emp_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (String(item.employeeMaster.emp_code).indexOf(toSearch) > -1) 
					|| (String(item.username).indexOf(toSearch) > -1) || (item.branchModel.branch_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)  
					|| (item.role.role_Name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) ) {
				success = true;
			} else {
				success = false;
			}
			
			return success;
		}
	    //---------------------------- Register search end ---------------------------------------//
}]);