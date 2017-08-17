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
			registerSearch : registerSearch
	};
	
	return factory;
	
	//--------------------------Fetch All add_receipt_preload-------------------------
	function fetchAllReceipt_add()
	{
		var def=$q.defer();
		$http.get('add_receipt_preload')
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
	function viewShipment(receipt)
	{
		console.log("Service Receipt filter function call");
		var def=$q.defer();
		var headers=getCsrfHeader();
		$http({
			method:"POST",
			url:'add_receipt_filter',
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
	//-------------------------------------------------------------------------------
	
	
	//--------------------------Register Search--------------------------------
	
	function registerSearch(searchkey)
	{
		console.log("RECEIPT Service Register search function call success....")
		var def=$q.defer();
		$http({
			method:'POST',
			url:'search_lrnumber',
			data:searchkey,
			headers:getCsrfHeader()
		})
		.then(
				function(response)
				{
					def.resolve(response.data);
					console.log('Service success................');
					console.log(response.data);
				},
				function(errResponse)
				{
					def.reject(errResponse);
					console.log('Service ERROR................');
				}
			);
		return def.primise;
	}
	//-------------------------------------------------------------------------

}]);