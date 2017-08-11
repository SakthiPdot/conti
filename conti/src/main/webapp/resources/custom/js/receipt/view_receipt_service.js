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
			receiptFilter:receiptFilter
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
			url:'receipt_filter',
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
					deferred.reject(errResponse);
				}
			);
		return def.promise;
	}
	//-------------------------------------------------------------------------------
	
	
	//===========================================================================================
	

}]);