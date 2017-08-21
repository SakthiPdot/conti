/**
 * @Project_Name conti
 * @Package_Name custom js viewshipment_control.js
 * @File_name shipment_control.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Aug 08, 2017 11:29:17 AM
 * @Updated_date_time Aug 08, 2017 11:29:17 AM
 */
contiApp.controller('ViewShipmentController', ['$http', '$filter', '$scope','$q','$timeout', 'ShipmentService', 'priceSettingService', 'BranchService', 'CompanySettingService', 'ConfirmDialogService', 'UserService', function($http, $filter, $scope, $q, $timeout,  ShipmentService, priceSettingService, BranchService, CompanySettingService, ConfirmDialogService, UserService){
	
	$("#screen_addshipment").addClass("active-menu");
	var self = this;
	self.shipment = {};
	
	ShipmentService.fetchAllShipmentforView()
		.then(
				function (shipment) {
					self.shipment = shipment;				
				}, function (errResponse) {
					console.log(errResponse);
				}
			);
	
}]);
