/**
 * @Project_Name conti
 * @Package_Name custom js user_control.js
 * @File_name user_control.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 21, 2017 8:24:17 PM
 * @Updated_date_time Jun 20, 2017 3:24:17 PM
 */
contiApp.controller('UserController', ['$scope', 'UserService', function($scope, UserService) {
    var self = this;
    self.user={user_id:null,username:''};
    self.users=[];
    self.message = null;
    self.resetBtn = false;
	self.checkPWD = true;
	/*    self.submit = submit;
    self.edit = edit;
    self.remove = remove;
    self.reset = reset;*/
 
    self.findUsername = findUsername;
	self.resetPassword = resetPassword;
	self.getPassword = getPassword; 
	self.checkPassword = checkPassword; 	
	self.findUserbyMbl = findUserbyMbl;
	self.forgot_animateClose = forgot_animateClose;
    /*fetchAllUsers();*/


    //----------------------  Fetch All users begin ----------------------------- //    
    function fetchAllUsers(){
        UserService.fetchAllUsers()
            .then(
            function(d) {
                self.users = d;
                
                console.log(d);
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


    
    function deleteUser(id) {
    	 UserService.deleteUser(id)
         .then(
         fetchAllUsers,
         function(errResponse){
             console.error('Error while deleting User');
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
    	var upperCase= new RegExp('[A-Z]');
    	var numbers = new RegExp('[0-9]');
    	var special_char = /^[a-zA-Z0-9- ]*$/;
    	
    	if( password == undefined ) {
    		
    		$('.minchar').removeClass('green');
			$('.minchar').addClass('red');
			
			$('.caps').removeClass('green');
			$('.caps').addClass('red');
			
			$('.num').removeClass('green');
			$('.num').addClass('red');
			
			$('.specialchar').removeClass('green');
			$('.specialchar').addClass('red');
			
    	}
    	
		if( password.length == 1 ) {
			$('.passward_validate').removeClass('hidden');
			animationOpenClick('.passward_validate','slideInLeft');
		}
		
		
		if ( password.length >= 8 ) {
			$('.minchar').removeClass('red');
			$('.minchar').addClass('green');
			minchar = true;

		} else {
			$('.minchar').removeClass('green');
			$('.minchar').addClass('red');
			
			minchar = false;
		}
    	
		if(password.match(upperCase)) {
						
			$('.caps').removeClass('red');
			$('.caps').addClass('green');
			
			caps = true;

		} else {
			
			console.log("inside else  match");
			$('.caps').removeClass('green');
			$('.caps').addClass('red');
			
		    caps = false;
		}
		
		if(password.match(numbers)) {
			
			$('.num').removeClass('red');
			$('.num').addClass('green');
			
			num = true;
			
		} else {
			
			$('.num').removeClass('green');
			$('.num').addClass('red');
			
			num = false;
		}
		
		if( special_char.test(password) == false ) {
			$('.specialchar').removeClass('red');
			$('.specialchar').addClass('green');
			
			specialchar = true;
		} else {
			$('.specialchar').removeClass('green');
			$('.specialchar').addClass('red');
			
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
    						self.message = "Sent username to your registered mobile number";
    						successforgot_AnimateOpen('.success-forgot');
    						
    					},
    					function (errResponse) {
    						self.message = "Sorry..! Mobile number is not valid..!";
	    					successAnimate('.failure');
	    					clear_mobileno();
	    					
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
}]);