/**
 * @Project_Name conti
 * @Package_Name resources/custom/js
 * @File_name add_manifest.js
 * @author Monu.c
 * @Created_date_time aug 9, 2017 4:20:17 PM
 * @Updated_date_time aug 9, 2017 4:20:17 PM
 * 
 */
angular.module('contiApp').controller('addManifestController',['$scope','addManifestService','ConfirmDialogService',
	function($scope,addManifestService,ConfirmDialogService){

	//===================================Total Record Count====================================
	fetchLastManifestNo();
	
	function fetchLastManifestNo() {				
		addManifestService.fetchLastManifestNo()
		.then(
				function (response) {					
					$scope.lastManifestNumber=pad(response,4);
					console.log($scope.lastManifestNumber);
				}, 
				function (errResponse) {
					console.log('Error while fetching record count');
				});
	}
	
	
	function pad(num, size) {
	    var s = num+"";
	    while (s.length < size) s = "0" + s;
	    return s;
	}
	
	
}]);