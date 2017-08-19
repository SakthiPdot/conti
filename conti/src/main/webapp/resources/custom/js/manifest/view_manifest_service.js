/**
 * @Project_Name conti
 * @Package_Name custom js Manifest
 * @File_name manifest_controller.js
 * @author Suresh
 * @Updated_user Suresh
  @Created_date_time July 24, 2017 3:31:53 PM
 * @Updated_date_time July 24, 2017 3:31:53 PM
 */

contiApp.factory('ManifestService',['$http','$q',function($http,$q)
{
	var factory=
	{
			fetchAllManifest:fetchAllManifest,
			manifestFilter:manifestFilter,
			inwardManifest:inwardManifest,
			outwardManifest:outwardManifest,
			manifestSearch:manifestSearch,
			manifestDetailed:manifestDetailed,
			deleteManifest:deleteManifest
	};
	
	return factory;
	
	//-------------------------- Fetch All Manifest begin ---------------------//	
	
	function fetchAllManifest()
	{
		console.log('Fetch all Service function call success....')
		var deferred = $q.defer();
		$http.get('manifest')
			.then(
					function (response) {
						deferred.resolve(response.data);
						console.log(response.data);
					},
					function (errResponse) {
						console.log("Error while fetching Manifetst");
						deferred.reject(errResponse);
					}
				);
		return deferred.promise;
	}
	//-------------------------- Fetch All Manifest end ---------------------//
	
	//-------------------------- Filter All Manifest based filter condition begin ---------------------//
	
	function manifestFilter(manifest) 
	{
		console.log("Service Manifest filter function call ");
		var deferred = $q.defer();
		var headers=getCsrfHeader();
		$http({
			method:'POST',
			url:'manifest_filter',
			data:manifest,
			headers:headers
		})
			.then(
					function (response) {
						deferred.resolve(response.data);
						console.log(response.data);
					},
					function (errResponse) {
						console.log("Error while fetching Manifetst by filter condition");
						deferred.reject(errResponse);
					}
				);
		return deferred.promise;
	}
	//------------------------------------------------------------------------------------------------//
	
	//-------------------Inward manifest function Service Start------------------------//
	
		function inwardManifest()
		{
			var deferred = $q.defer();
			$http.get('inward_manifest')
			.then(
					function(response)
					{
						deferred.resolve(response.data);
						console.log(response.data);
					},
					function(errResponse)
					{
						console.log('Error while inward manifest ');
					}
				);
			return deferred.promise;
		}
	//--------------------------------------------------------------------------------//
	
	
	//---------------------------Outward manifest function Service Start--------------------------------
	
		function outwardManifest()
		{
			var deferred = $q.defer();
			$http.get('outward_manifest')
			.then(
					function(response)
					{
						deferred.resolve(response.data);
						console.log(response.data);
					},
					function(errResponse)
					{
						console.log('Error while outward manifest ');
					}
				);
			return deferred.promise;
		}
	//-------------------------------------------------------------------------------------------------//
	
	
	//--------------------------------Manifest number Search function start-----------------------------//
	
		function manifestSearch(searchkey)
		{
			var deferred=$q.defer();
			$http({
				method:'POST',
				url:'manifest_search',
				data:searchkey,
				headers:getCsrfHeader()
			})
			.then(	function(response)
					{
						console.log(response.data);
						deferred.resolve(response.data);
					},
					function(errResponse)
					{
						deferred.reject(errResponse);
					}
				);
			return deferred.promise;
		}
		
	//-------------------------------------------------------------------------------------------------//
	
	//-------------------------------- Manifest Delete service start-----------------------------------//

	function deleteManifest(manifest_id)
	{
		var def=$q.defer();
		$http({
			method:'DELETE',
			url:'delete_manifest/'+manifest_id,
			headers:getCsrfHeader()
			}).then(
					function(response)
					{
						def.resolve(response.data);
					},
					function(errResponse)
					{
						def.reject(errResponse);
					}
				);
		return def.promise;
	}
	//---------------------------------------------------------------------------------------------------


//====================================Manifest detailed Service function Start================================
	
	//--------------------------Get Manifest detailed data begin---------------------------
	
		function manifestDetailed(manifestid)
		{
			console.log('Manifest id is :'+manifestid)
			var deferred=$q.defer();
			$http({
				method:'POST',
				url:'manifest_detailed',
				data:manifestid,
				headers:getCsrfHeader()
			})
			
			.then(
					function(response)
					{
						console.log(response.data);
						deferred.resolve(response.data);
					},
					function (errResponse)
					{
						deferred.reject(errResponse);
					}
				);
			return deferred.promise;
		}
	//------------------------------------------------------------------------------------
		
	//=========================================================================================
		
}]);