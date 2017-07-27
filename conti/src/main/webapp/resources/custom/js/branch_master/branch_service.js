/**
 * @Project_Name conti
 * @Package_Name custom js branch_service.js
 * @File_name branch_service.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jul 7, 2017 12:38:17 PM
 * @Updated_date_time Jul 7, 2017 12:38:17 PM
 */

contiApp.factory('BranchService', ['$http', '$q', function ($http, $q){
	
	
	var factory = {
			fetchAllBranches : fetchAllBranches,
			createBranch:createBranch,
			updateBranch:updateBranch,
			deleteBranch:deleteBranch,
			makeActive : makeActive,
			makeinActive : makeinActive,
			registerSearch : registerSearch,
			pagination_byPage : pagination_byPage,
			fetchBranchbyBranchid : fetchBranchbyBranchid,
			checkBranchName:checkBranchName,
			findrecord_count : findrecord_count
			};
	
	return factory;
	
	//----------------Check branch name already exist-------------
	function checkBranchName(name)
	{
		var deferred=$q.defer();
		$http({
			method:'POST',
			url:'checkBranchName',
			data:name,
			headers:getCsrfHeader()
		})
		.then(function(response)
		{
			deferred.resolve(response.status);
		},
		function (errResponse)
		{
			deferred.reject(errResponse);
		});
		return deferred.promise;
	}
	
	
	//----------------Check branch name already exist process End-------------	
	
	//-------------------------- Fetch All Branches begin ---------------------//	
	function fetchAllBranches() {
		var deferred = $q.defer();
		$http.get('branches')
			.then(
					function (response) {
						deferred.resolve(response.data);
					},
					function (errResponse) {
						console.log("Error while fetching branches"); 
						deferred.reject(errResponse);
					}
				);
		return deferred.promise;
	}
	//-------------------------- Fetch All Branches end ---------------------//	
	
	
	//-------------------------- Fetch All Branches begin ---------------------//	
	function fetchBranchbyBranchid(id) {
		var deferred = $q.defer();
		$http.get('branches/branch/'+id)
			.then(
					function (response) {
						deferred.resolve(response.data);
					},
					function (errResponse) {
						console.log("Error while fetching Branches by branch id");
						deferred.reject(errResponse);
					}
				);
		return deferred.promise;
	}
	//-------------------------- Fetch All Branches end ---------------------//
	
	
	
	
	//-----------Fetch Create branch--------------
	
	function createBranch(branch)
	{
		var deferred=$q.defer();
		var headers=getCsrfHeader();
		$http({
			method:'POST',
			url:'create_branch',
			data:branch,
			headers:headers
		})
		.then(function(response)
				{
					deferred.resolve(response.data);
				},
				function (errResponse)
				{
					//console.log("save error");
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}
		//-----------Fetch Create branch End--------------
		
		//-----------------Delete Branch begin Start----------------
		
		function deleteBranch(id)
		{
			var deferred=$q.defer();
			$http({
				method:'DELETE',
				url:'delete_branch/'+id,
				headers:getCsrfHeader()
			}).then(
				function (response)
				{
					deferred.resolve(response.data);
				},
				function(errResponse)
				{
					deferred.reject(errResponse);
				}
			);
			return deferred.promise;
		}
    
		//-----------------Delete Branch begin End----------------
		
		//------------------Update Branch begin start --------------
		
		function updateBranch(branch) {
	        var deferred = $q.defer();
	        var headers = getCsrfHeader();
	        console.log("update service call " +branch)
	    	$http({
	    		method : 'POST',
	    		url : 'update_branch',
	    		data : branch,
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
		
		
		//------------------Update Branch begin End--------------
		
		
		//------------------------------- make active Customer begin -----------------------------//
	    function makeActive(id) {
	    	var deferred = $q.defer();
	    	
	    	$http({
	    		method : 'POST',
	    		url : 'make_active_branch',
	    		data : id,
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
	    //------------------------------- make active Customer end -----------------------------//
	    
	    
	    
	    //------------------------------- make inactive Customer begin -----------------------------//
	    function makeinActive(id) {
	    	var deferred = $q.defer();
	    	
	    	$http({
	    		method : 'POST',
	    		url : 'make_inactive_branch',
	    		data : id,
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
	    //------------------------------- make inactive Customer end -----------------------------//
  

	  //--------------------------- Register search begin -----------------------------//
	    function registerSearch(searchkey) {
	    	var deferred = $q.defer();
	    	
	    	$http({
	    		method : 'POST',
	    		url : 'register_search_branch',
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
	    
	    
	    
	 // --------------------------- Pagination begin ------------------------------//
	    function pagination_byPage(page) {
	    	var deferred = $q.defer();
	    	
	    	$http({
	    		method : 'POST',
	    		url : 'pagination_branch',
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
	      
	    
	    //----------------------  Recourd count users begin ----------------------------- //
	    function findrecord_count() {
	    	
	        var deferred = $q.defer();
	        $http.get('branch_record_count/')
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