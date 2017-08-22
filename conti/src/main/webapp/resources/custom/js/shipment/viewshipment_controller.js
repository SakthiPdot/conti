/**
 * @Project_Name conti
 * @Package_Name custom js viewshipment_control.js
 * @File_name shipment_control.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Aug 08, 2017 11:29:17 AM
 * @Updated_date_time Aug 08, 2017 11:29:17 AM
 */
contiApp.controller('ViewShipmentController', [
		'$http',
		'$filter',
		'$scope',
		'$q',
		'$timeout',
		'ShipmentService',
		'priceSettingService',
		'BranchService',
		'CompanySettingService',
		'ConfirmDialogService',
		'UserService',
		function($http, $filter, $scope, $q, $timeout, ShipmentService, priceSettingService, BranchService, CompanySettingService, ConfirmDialogService, UserService){
	
	$("#screen_addshipment").addClass("active-menu");
	var self = this;
	self.shipments = {};
	self.branches = {};
	self.fromBranch_disable = false;
	//---------------------------- FETCH ALL SHIPMENT BEGIN
	function fetchAllShipmentforView() {
		ShipmentService.fetchAllShipmentforView()
		.then(
				function (shipments) {
					self.shipments = shipments;		
					
					
				}, function (errResponse) {
					console.log(errResponse);
				}
			);	
	}
	fetchAllShipmentforView();
	//---------------------------- FETCH ALL SHIPMENT END
	
	//---------------------------- FETCH ALL BRANCH BEGIN
	
	function fetchAllBranch() {
		BranchService.fetchAllBranches()
			.then(
					function (branches) {
						self.branches = branches;
						
						if($('#currentUserRole').val() == "SUPER_ADMIN") {
							self.fromBranch_disable = false;
						} else {
							self.fromBranch_disable = true;
							
							self.from_branch = parseInt($('#branch_id').val());
						}
						
						
					}, function (errRes) {
						console.log(errRes);
					}
				)
				
				
	}
	fetchAllBranch();
	//---------------------------- FETCH ALL BRANCH END
	
	
	//--------------------------- PAGINATION BEGIN
	
	function pagination() {
		$scope.pageSize = $scope.shownoofrec;
		$scope.currentPage = 0;
		$scope.totalPages = 0;
		self.FilterShipment = self.shipments;
		
		$scope.nextDesabled = false;
		$scope.previouseDisabled = true;
		
		if( self.FilterShipment.lengh <= 10 ) {
			$scope.nextDisabled = true;
		}
		
		if( self.FilterShipment.length < 100 ) {
			$scope.totalnof_records = self.FilterShipment.length;
		} else {
			
		}
	}
	
	//--------------------------- PAGINATION END
}]);
