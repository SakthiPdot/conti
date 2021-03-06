/**
 * @Project_Name conti
 * @Package_Name custom js user_service.js
 * @File_name user_service.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 21, 2017 8:24:17 PM
 * @Updated_date_time Jun 20, 2017 3:24:17 PM
 */
contiApp.factory('UserService', ['$http', '$q', function($http, $q){

 
    var factory = {
        fetchAllUsers: fetchAllUsers,
        findUser: findUser,
        findUserbyName : findUserbyName,
        changePassword : changePassword,
        findUserbyMbl :findUserbyMbl,
        fetchUserbybranch:fetchUserbybranch,
        makeActive : makeActive,
        makeinActive : makeinActive,
        
        fetchAllRoles : fetchAllRoles,
        checkUsername : checkUsername,
        createUser : createUser,
        updateUser : updateUser,
        deleteUser : deleteUser,
        pagination_byPage : pagination_byPage,
        registerSearch : registerSearch,
        findrecord_count : findrecord_count,
        sortBy:sortBy
    };
 
    return factory;
    
	//=============================sort by name====================================
	function sortBy(name,status){	
		console.log(name,status);
		var deferred=$q.defer();
		$http({
			method:'POST',
			url:"sortByUser/"+name,
			data:status,
			headers:getCsrfHeader()
		}).then(
				function(response){
					deferred.resolve(response.data);
				},function(errResponse){
					console.log("status change failed");
					deferred.reject(errResponse);
				}
		);
		return deferred.promise;
	}
    //----------------------  Fetch All users begin ----------------------------- //
    function fetchAllUsers() {
    	
    	/*Service.get(REST_SERVICE_URI,"Fetch all user")
    		.then(
    				function(success) {
    					console.log(success);
    				},
    				function(error) {
    					console.log(error);
    				}
    			);*/
    	
        var deferred = $q.defer();
        $http.get('users/')
            .then(
            function (response) {
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while fetching Users');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    //----------------------  Fetch All users end ----------------------------- //
    
    //fetch user by branch
    
    function fetchUserbybranch() {
    	var deferred = $q.defer();
        $http.get('users/')
            .then(
            function (response) {
                deferred.resolve(response.data);
            },
            function(errResponse){
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    //----------------------  Find user by user id with PUT begin ----------------------------- //    
    function findUser(user, id) {
        var deferred = $q.defer();
        $http({
    		method : 'POST',
    		url : 'userbyBranch',
    		data : username,
    		headers : getCsrfHeader()
    	})
            .then(
            function (response) {
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while updating User');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    //----------------------  Find user by user id with PUT end ----------------------------- // 
    
  //----------------------  Find user by user name begin ----------------------------- //
/*    function findUserbyName(username) {
    	var deferred = $q.defer();
    	$http({
    		method : 'POST',
    		url : "dd",
    		data : username,
    		headers : getCsrfHeader()
    	})
    	.then(
    			function (response) {  
    				
    				console.log(response.data);
    				
    				deferred.resolve(response.data);
    			},
    			function (errResponse) {
    				deferred.reject(errResponse);
    			}
    		);
    		return deferred.promise;
    }*/
    
    function getCsrfHeader() {
		 
		 var csrfToken = $("input[name='_csrf']").val();
	
		 var headers = {}; 
		 headers["X-CSRF-TOKEN"] = csrfToken;
		 headers["_csrf"] = csrfToken;
		 
		 return headers;
	 };
	 
    function findUserbyName(username) {
    	console.log(username);
    	var deferred = $q.defer();
    	   console.log(getCsrfHeader()); 	
    	$http({
    		method : 'POST',
    		url : 'forgotPassword',
    		data : username,
    		headers : getCsrfHeader()
    	})
    	.then(
    			function (response) {    
    				deferred.resolve(response);
    			},
    			function (errResponse) {
    				deferred.reject(errResponse);
    			}
    		);
    		return deferred.promise;
    }
  //----------------------  Find user by user name begin ----------------------------- //    
 
  //----------------------  Delete user by user id begin ----------------------------- //  
       
    function deleteUser(id) {
    	var deferred = $q.defer();
    	$http({
    		method : 'DELETE',
    		url : 'delete_user/'+id,
    		headers : getCsrfHeader()
    	})
    	.then (
    		function (response) {
    			deferred.resolve(response.data);
    		},
    		function (errResponse) {
    			deferred.reject(errResponse);
    		}
    	);
    	return deferred.promise;
    }
    //----------------------  Delete user by user id end ----------------------------- //
    
 //----------------------- Reset Password for ADMIN / MANAGER begin -------------------------------------//
    
    function changePassword(user) {
    	console.log("Inside reset password service");
    	console.log(user);
    	var deferred = $q.defer();
    	$http({
    		method : 'POST',
    		url : '/Conti/changePassword',
    		data : user,
    		headers : getCsrfHeader()
    	})
    		.then(
    				function (response) {
    					deferred.resolve(response);
    				},
    				function (errResponse) {
    					deferred.reject(errResponse);
    				}
    			);
    	
    	return deferred.promise;
    }
    
    
    //----------------------- Reset Password for ADMIN / MANAGER begin -------------------------------------//
    
    //----------------------- Find user by mobileno bengin ----------------------------------------------//
    
    function findUserbyMbl(mobileno) {
    	var deferred = $q.defer();
    	$http({
    		method : 'POST',
    		url : 'forgotUsername',
    		data : mobileno,
    		headers : getCsrfHeader()
    	})
    		.then(
    				function(response) {
    					deferred.resolve(response);
    				},
    				function(errResponse) {
    					deferred.reject(errResponse);
    				}
    			);
    	return deferred.promise;
    }
    
    //----------------------- Find user by mobileno end ----------------------------------------------//  
    
	
	//============= Active Vehicle Begin ===========//
	
			function makeActive(id) {
	
				var deferred = $q.defer();
				
				$http({
					method : 'POST',
					url : 'make_Useractive',
					data : id,
					headers : getCsrfHeader()
				})
				.then(
						function (response) {
							deferred.resolve(response.data);
						},
						function(errResponse) {
							deferred.reject(errResponse);
						}
				     );
				return deferred.promise;
			}
			
	//============= Active Vehicle End ============//
	
			
	//========= InActive Vehicle Begin =============//
	
			function makeinActive(id) {
				
				console.log(id);
				var deferred = $q.defer();
				
				$http({
					method : 'POST',
					url : 'make_Userinactive',
					data : id,
					headers : getCsrfHeader()
				})
				.then(
						function (response) {
							deferred.resolve(response.data);
						},
						function(errResponse) {
							deferred.reject(errResponse);
						}
				     );
				return deferred.promise;
			}
			
	//========== InActive Vehicle End ===============//
			
	//-------------------- Fetch all Roles begin -------------------//		
		function fetchAllRoles() {
	        var deferred = $q.defer();
	        $http.get('roles/')
	            .then(
	            function (response) {
	                deferred.resolve(response.data);
	            },
	            function(errResponse){
	                console.error('Error while fetching Roles');
	                deferred.reject(errResponse);
	            }
	        );
	        return deferred.promise;
	    }
		
	//-------------------- Fetch all Roles end -------------------//
		
		
	//============= check Username Begin ===========//
		
		function checkUsername(username) {

			var deferred = $q.defer();
			
			$http({
				method : 'POST',
				url : 'check_username',
				data : username,
				headers : getCsrfHeader()
			})
			.then(
					function (response) {
						deferred.resolve(response);
					},
					function(errResponse) {
						deferred.reject(errResponse);
					}
			     );
			return deferred.promise;
		}
		
		//============= Active Vehicle End ============//
		
		//--------------------------------- Create new user begin --------------------------------//
		 function createUser(user) {
		        var deferred = $q.defer();
		        var headers = getCsrfHeader();
		        
		    	$http({
		    		method : 'POST',
		    		url : 'create_user',
		    		data : user,
		    		headers : headers
		    	})
		    	.then(
		    			function (response) {    				
		    				deferred.resolve(response.data);
		    			},
		    			function (errResponse) {
		    				deferred.reject(errResponse);
		    			}
		    		);
		    		return deferred.promise;

		    }
		 
			//--------------------------------- Create new user end --------------------------------//  
		 
		//--------------------------------- Update user begin --------------------------------//  
		    function updateUser(user) {
		
		        var deferred = $q.defer();
		        var headers = getCsrfHeader();
		        
		    	$http({
		    		method : 'POST',
		    		url : 'update_user',
		    		data : user,
		    		headers : headers
		    	})
		    	.then(
		    			function (response) {    				
		    				deferred.resolve(response.data);
		    			},
		    			function (errResponse) {
		    				deferred.reject(errResponse);
		    			}
		    		);
		    		return deferred.promise;
		    	
		    	/*var deferred = $q.defer();
		    	$http({
		    		method : 'PUT',
		    		url : 'users/'+id,
		    		headers : getCsrfHeader()
		    	})
		    	.then (
		    		function (response) {
		    			deferred.resolve(response.data);
		    		},
		    		function (errResponse) {
		    			deferred.reject(errResponse);
		    		}
		    	);
		    	return deferred.promise;*/
		    		
		    }
		//--------------------------------- Update user end --------------------------------//
		    
		    
		    // --------------------------- Pagination begin ------------------------------//
		    function pagination_byPage(page) {
		    	var deferred = $q.defer();
		    	
		    	$http({
		    		method : 'POST',
		    		url : 'pagination_user',
		    		data : page,
		    		headers : getCsrfHeader()
		    	})
		    	.then (
		    		function (response) {
		    			deferred.resolve(response.data);
		    		},
		    		function (errResponse) {
		    			deferred.reject(errResponse);
		    		}
		    	);
		    	return deferred.promise;
		    }
		    // --------------------------- Pagination end ------------------------------//  
		    
		    //--------------------------- Register search begin -----------------------------//
		    function registerSearch(searchkey) {
		    	var deferred = $q.defer();
		    	
		    	$http({
		    		method : 'POST',
		    		url : 'register_Usersearch',
		    		data : searchkey,
		    		headers : getCsrfHeader()
		    	})
		    	.then (
		    		function (response) {
		    			deferred.resolve(response.data);
		    		},
		    		function (errResponse) {
		    			deferred.reject(errResponse);
		    		}
		    	);
		    	return deferred.promise;
		    }
		    //--------------------------- Register search end -----------------------------//   
		    
		    //----------------------  Recourd count users begin ----------------------------- //
		    function findrecord_count() {
		    	
		        var deferred = $q.defer();
		        $http.get('record_count/')
		            .then(
		            function (response) {
		                deferred.resolve(response.data);
		            },
		            function(errResponse){
		                console.error('Error while fetching Users record count');
		                deferred.reject(errResponse);
		            }
		        );
		        return deferred.promise;
		    }
		    //----------------------  Record Count users end ----------------------------- //

}]);