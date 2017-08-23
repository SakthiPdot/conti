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
	self.FilterShipment = {};
	self.branches = {};
	self.viewShipment = {
			"fromdate" : "",
			"todate" : "",
			"from_branch" : "",
			"to_branch" : "",
			"status" : "",
			"product_id" : ""
	};
	self.fromBranch_disable = false;
	//---------------------------- FETCH ALL SHIPMENT BEGIN
	function fetchAllShipmentforView() {
		ShipmentService.fetchAllShipmentforView()
		.then(
				function (shipments) {
					self.shipments = shipments;		
					pagination();
					
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
						
					}, function (errRes) {
						console.log(errRes);
					}
				)
				
			if($('#currentUserRole').val() == "SUPER_ADMIN") {
					self.fromBranch_disable = false;
					self.viewShipment.from_branch = parseInt($('#branch_id').val());
				} else {
					self.fromBranch_disable = true;
					
					self.viewShipment.from_branch = parseInt($('#branch_id').val());
				}	
	}
	fetchAllBranch();
	//---------------------------- FETCH ALL BRANCH END
	
	
	//--------------------------- PAGINATION BEGIN
	
	function pagination() {
		/*$scope.pageSize = $scope.shownoofrec;
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
			
		}*/
		
		self.FilterShipment = self.shipments;
	}
	
	//--------------------------- PAGINATION END
	
	//--------------------------- ANGU COMPLETE FRO PRODUCT NAME BEGIN
	
	$scope.product_name = function (product) {
		if(product == null) {
			self.viewShipment.product_id = "";
		} else {
			self.viewShipment.product_id = product.originalObject.product_id;	
		}
					
	}
	
	//--------------------------- ANGU COMPLETE FRO PRODUCT NAME END
	
	//--------------------------- FILTER SHIPMENT BEGIN
	
	self.filterShipment = function() {
		
		if($('.datepicker1').val().length != 0) {
			self.viewShipment.fromdate = $('.datepicker1').val();	
		} 
		if($('.datepicker2').val().length != 0) {
			self.viewShipment.todate = $('.datepicker2').val();	
		} 
				
		ShipmentService.filterShipment(self.viewShipment)
			.then(
					function (shipment) {
						self.FilterShipment = shipment
					}, function (errRes) {
						console.log(errRes);
					}
				);
	}
	
	//--------------------------- FILTER SHIPMENT END
	
	//--------------------------- SEARCH BY LRNO BEGIN
	
	self.searchby_LR = function(lrno) {
		if ( lrno.length == 0 ) {
			self.FilterShipment = self.shipments;
		} else if ( lrno.length > 3 ) {
			ShipmentService.searchShipment(lrno)
				.then(
						function (shipemnt) {
							self.FilterShipment = shipment;
						}, function (errRes) {
							console.log(errRes);
						}
					);
		} else {
			self.FilterShipment = _.filter(self.shipments,
				function(item) {
					return searchLRUtil(item, lrno);
				});
		}
	}
	
	function searchLRUtil(item, toSearch) {
		var success = false;
		
		if( item.lrno_prefix.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ) {
			success = true;
		} else {
			success= false;
		}
		return success;
	}
	//--------------------------- SEARCH BY LRNO END
}]);
