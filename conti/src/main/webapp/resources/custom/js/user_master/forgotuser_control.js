/**
 * @Project_Name conti
 * @Package_Name custom js user_control.js
 * @File_name user_control.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 21, 2017 8:24:17 PM
 * @Updated_date_time Jun 20, 2017 3:24:17 PM
 */
contiApp.controller('ForgotUserController', ['$scope', 'UserService', function($scope, UserService) {

	var self = this;
    self.user={user_id:null,username:''};
    self.user.role = {};
    self.users=[];
    
    self.message = null;
    self.resetBtn = false;
	self.checkPWD = true;
	self.errorUsername = false;
	
    self.findUsername = findUsername;
	self.resetPassword = resetPassword;
	self.getPassword = getPassword; 
	self.checkPassword = checkPassword; 	
	self.findUserbyMbl = findUserbyMbl;
	self.forgot_animateClose = forgot_animateClose;
	self.checkUsername = checkUsername;
	
    /*fetchAllUsers();*/
    
    //----------------------  Fetch All users begin ----------------------------- //    
   /* function fetchAllUsers(){
        UserService.fetchAllUsers()
            .then(
            function(users) {
                self.users = users;               
            },
            function(errResponse){
                console.error('Error while fetching Users');
            }
        );
    }*/
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
		    						if(response.data.active != 'Y') {
		    							self.message = "Kindly contact your manager..! Manager contact no is "+ response.data.active;
			    						successforgot_AnimateOpen('.success-forgot');		
		    						} else {
		    							self.message = "Kindly contact your manager..!";
			    						successforgot_AnimateOpen('.success-forgot');
		    						}
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

	    

}]);