/**
 * @Project_Name conti
 * @Package_Name custom js Receipt
 * @File_name Receipt_controller.js
 * @author Suresh
 * @Updated_user Suresh
   @Created_date_time August 09, 2017 11:31:53 AM
 * @Updated_date_time August 09, 2017 11:31:53 AM
 */
contiApp.factory('ReceiptService',['$http','$q',function($http,$q)
{
	var factory={
			fetchAllReceipt_add:fetchAllReceipt_add,
			viewShipment:viewShipment,	
			registerSearch : registerSearch,
			getContactNumber:getContactNumber,
			checkCourierStaffUnique:checkCourierStaffUnique,
			saveReceipt:saveReceipt
	};
	
	return factory;
	
	

	//=============================save receipt====================================
	function saveReceipt(receipt){
		var deferred=$q.defer();
		$http({
			method:'POST',
			url:'receiptSave',
			data:receipt,
			headers:getCsrfHeader()
		}).then(
				function(response){
					deferred.resolve(response.data);
				},function(errResponse){
					console.log("save failed");
					deferred.reject(errResponse);
				}
		);
		return deferred.promise;
	}
	
	//=============================save receipt====================================
	function getContactNumber(staff){
		var deferred = $q.defer();
	    	
	    	$http({
	    		method : 'POST',
	    		url : 'getContactNumber',
	    		data : staff,
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
	
	//--------------------------CHECK UNIQUE-------------------------
	function checkCourierStaffUnique(staffName){
		var deferred = $q.defer();
	    	
	    	$http({
	    		method : 'POST',
	    		url : 'checkCourierStaffUnique',
	    		data : staffName,
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
	//--------------------------Fetch All add_receipt_preload-------------------------
	function fetchAllReceipt_add()
	{
		var def=$q.defer();
		$http.get('add_receipt_preload')
		.then(
				function(response)
				{
					def.resolve(response.data);
				},function(errResponse)
				{
					console.log('Error while fetching Receipt....');
				}
			);
		return def.promise;
	}
	//----------------------------------------------------------------------
	
	//--------------------Filter All Receipt by filter condition------------------
	function viewShipment(filter)
	{
		console.log("Service Receipt filter function call");
		var def=$q.defer();
		var headers=getCsrfHeader();
		$http({
			method:"POST",
			url:'add_receipt_filter',
			data:filter,	
			headers:headers
		}).then(
				function(response)
				{
					def.resolve(response.data);
					console.log(response.data);
				},
				function(errResponse)
				{
					console.log('Error while fetching Receipt by filter')
					def.reject(errResponse);
				}
			);
		return def.promise;
	}
	//-------------------------------------------------------------------------------
	
	
	//--------------------------Register Search--------------------------------
	
	function registerSearch(searchkey){
	var deferred = $q.defer();
    	
    	$http({
    		method : 'POST',
    		url : 'search_lrnumber',
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
}]);