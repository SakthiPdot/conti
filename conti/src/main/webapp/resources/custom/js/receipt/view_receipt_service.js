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
			
			fetchAllReceipt_view:fetchAllReceipt_view,
			receiptFilter:receiptFilter,
			receiptSearch:receiptSearch,
			makePending:makePending,
			makeReturn:makeReturn,
			makeDelete:makeDelete
	};
	
	return factory;
	
	
	//--------------------------Fetch All view_receipt_preload-------------------------
	function fetchAllReceipt_view()
	{
		var def=$q.defer();
		$http.get('view_receipt_preload')
		.then(
				function(response)
				{
					def.resolve(response.data);
					console.log(response.data);
				},function(errResponse)
				{
					console.log('Error while fetching Receipt....');
				}
			);
		return def.promise;
	}
	//----------------------------------------------------------------------
	
	//--------------------Filter All Receipt by filter condition------------------
	function receiptFilter(receipt)
	{
		console.log("Service Receipt filter function call");
		var def=$q.defer();
		var headers=getCsrfHeader();
		$http({
			method:"POST",
			url:'view_receipt_filter',
			data:receipt,
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
	
	
	//------------------------Receipt Register search service function----------------------------------
	
	function receiptSearch(key){
		console.log('Receipt Search service function call successfully');
		var def=$q.defer();
		$http({
			method:'POST',
			url:'receipt_search',
			data:key,
			headers:getCsrfHeader()
		})
		.then(function(response){
			console.log(response);
			def.resolve(response.data);
		},
		function(errResponse){
			def.reject(errResponse);
		});
		return def.promise;
	}
	
	
	//------------------------------Make Pending Service start -----------------------------
	function makePending(id) {
    	console.log('Make Pending Service call---')
    	var deferred = $q.defer();
    	$http({
    		method : 'POST',
    		url : 'make_Pending',
    		data : id,
    		headers : getCsrfHeader()
    	})
    	.then (
    		function (response){
    			deferred.resolve(response.data);
    		},
    		function (errResponse){
    			deferred.reject(errResponse);
    		}
    	);
    	return deferred.promise;
    }
	
//------------------------------Make Return function start--------------	
	function makeReturn(id) {
    	console.log('Make Return Service call---')
    	var deferred = $q.defer();
    	$http({
    		method : 'POST',
    		url : 'make_Return',
    		data : id,
    		headers : getCsrfHeader()
    	})
    	.then (
    		function (response){
    			deferred.resolve(response.data);
    		},
    		function (errResponse){
    			deferred.reject(errResponse);
    		}
    	);
    	return deferred.promise;
    }
	
	//--------------------------Make Delete function start--------------	
	function makeDelete(id) {
    	console.log('Make Delete Service call---')
    	var deferred = $q.defer();
    	$http({
    		method : 'POST',
    		url : 'make_Delete',
    		data : id,
    		headers : getCsrfHeader()
    	})
    	.then (
    		function (response){
    			deferred.resolve(response.data);
    		},
    		function (errResponse){
    			deferred.reject(errResponse);
    		}
    	);
    	return deferred.promise;
    }
	//===========================================================================================
	

}]);