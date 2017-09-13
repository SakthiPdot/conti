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
	
	$("#screen_viewshipment").addClass("active-menu");

	var self = this;
	self.shipments = {};
	self.shipment = {}; // for individual view shipment
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
	
	$scope.shownoofrec = 10;
	self.selected_shipment = [];
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
		
		$scope.pageSize = $scope.shownoofrec;
		$scope.currentPage = 0;
		$scope.currentPage = 0;
		$scope.nextDisabled = false;
		$scope.previouseDisabled = true;
		self.FilterShipment = self.shipments;
		
		if(self.FilterShipment.length<=10){
			$scope.nextDisabled = true;			
		}

		if(self.FilterShipment.length<100){
			$scope.totalnof_records = self.FilterShipment.length;
		}else{
			findrecord_count();
		}
		
	}
	
	 $scope.paginate = function(nextPrevMultiplier) {
	    	$scope.selectall = false;
	    	$scope.currentPage += (nextPrevMultiplier * 1);
	    	self.FilterShipment = self.shipments.slice($scope.currentPage*$scope.pageSize);
	    	if(self.FilterShipment.length == 0) {
	    		ShipmentService.pagination_byPage($scope.currentPage)
	    		.then(
	    				function (filterShip) {
	    					if ( filterShip.length == 0 ) {
	    						$scope.nextDisabled = true;	    						
	    					} else if ( filterShip.length < 10 ) {
	    						self.FilterShipment = filterShip;
	    						$scope.nextDisabled = true;
	    					} else {
	    						self.FilterShipment = filterEmp;
	    					}
	    					
	    				}, 
	    				function (errResponse) {
	    					console.log('Error while pagination');
	    				}
	    			);
	    	} 
	    	
	    	$scope.disableSorting=  ($scope.currentPage > 0) ?true:false;
	    	
	    	/*if(self.Filteremployees.length < $scope.pageSize) {
	    		$scope.nextDisabled = true;
	    	}
	*/
	    	if($scope.currentPage == 0) {
	    		$scope.previouseDisabled = true;
	    	}
	    	if(nextPrevMultiplier == -1) {    		
	    		$scope.nextDisabled = false;
	    	} else {
	    		$scope.previouseDisabled = false;
	    	}
	    	
	    }
	 
	 
	 $scope.firstlastPaginate = function (page) {
	    	$scope.selectall = false;
	    	if( page == 1 ) { // first
	    		$scope.currentPage = 0;
	    		$scope.previouseDisabled = true;
	    		$scope.nextDisabled = false;
	    		self.FilterShipment = self.shipments.slice($scope.currentPage*$scope.pageSize);
	    	/*	fetchAllEmployees();*/
	    	} else { // last
	    		
	    		/*if(self.Filteremployees.length < $scope.pageSize) {
	        		$scope.currentPage = ( (Math.ceil(self.Filteremployees.length/$scope.pageSize)) );    			
	    		} else {
	    			$scope.currentPage = ( (Math.ceil(self.Filteremployees.length/$scope.pageSize)) - 1 );
	    		}*/
	    		$scope.currentPage = ( (Math.ceil(self.FilterShipment.length/$scope.pageSize)) - 1 );
	    		$scope.previouseDisabled = false;
	    		$scope.nextDisabled = true;
	    		
	    		self.FilterShipment = self.shipments.slice($scope.currentPage*$scope.pageSize);
	    		
	    		if(self.FilterShipment.length == 0) {
	    			ShipmentService.pagination_byPage(page)
	        		.then(
	        				function (filterShip) {
	        					self.FilterShipment = filterShip;
	        				}, 
	        				function (errResponse) {
	        					console.log('Error while fetching employees');
	        				}
	        			);
	    		}
	    		
	    	}
	    	
	    	$scope.disableSorting=  ($scope.currentPage > 0) ?true:false;
	    	
	    }
	 
	function no_data(){
		if(self.FilterShipment.length==0){
			self.tbl_nodata = true;			
		}else{
			self.tbl_nodata = false;
		}
	}
	 
    //===================================Total Record Count====================================
	function findrecord_count() {				
		ShipmentService.findrecord_count()
		.then(
				function (record_count) {
					$scope.totalnof_records  = record_count;
				}, 
				function (errResponse) {
					console.log('Error while fetching record count');
				});
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
						self.FilterShipment = shipment;
						no_data();
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
			no_data();
		} else if ( lrno.length > 3 ) {
			ShipmentService.searchShipment(lrno)
				.then(
						function (shipment) {
							self.FilterShipment = shipment;	
							no_data();
							
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
			self.tbl_nodata = false;
		} else {
			success= false;
			self.tbl_nodata = true;
		}
		return success;
	}
	//--------------------------- SEARCH BY LRNO END
	
	 //------------------------------------- VIEW SHIPEMNT INDUVIDUAL OPEN BEGIN
	 
	 self.view1Shipmet = function (shipment) {
		 self.shipment = shipment;
		 
		 viewShipment_Animate('.shipment_View', 'OPEN');
	 }
	 
	 //------------------------------------- VIEW SHIPEMNT INDUVIDUAL OPEN END
	 
	 //------------------------------------- VIEW SHIPEMNT INDUVIDUAL CLOSE BEGIN
	 
	 self.viewShipemntClose = function () {
		 viewShipment_Animate('.shipment_View', 'CLOSE');
	 }
	 
	 //------------------------------------- VIEW SHIPEMNT INDUVIDUAL CLOSE END
	 
	 //------------------------------------- SHIPEMNT CANCEL BEGIN
	 self.shipmentCancel = function (shipment) {
		
			self.confirm_title = 'Cancel';
			self.confirm_type = BootstrapDialog.TYPE_DANGER;
			self.confirm_msg = self.confirm_title+ ' the shipment?';
			self.confirm_btnclass = 'btn-danger';
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(
						function (res) {
							
							ShipmentService.shipment_delete(shipment.shipment_id)	
							.then(
									function (res) {
										
										if(res == null || res=='') {
											var index = self.shipments.indexOf(shipment);
											self.shipments.splice(index,1);
											self.message = "Selected shipment has been deleted scuccessfully..!";
					            			successAnimate('.success'); 
					            			self.lr_search = null;
					            			fetchAllShipmentforView();
					            			self.viewShipemntClose();
										} else {
											self.message = "Sorry..! Selected shipment referred in "+res;
											successAnimate('.failure');   
										}
										
				            			
									}, function(errRes) {
										self.message = "Error while deleting selected shipment..!";
										successAnimate('.failure');   
				            			self.viewShipemntClose();
									}
								);
							
						}
					);
		 
	 }
	 //------------------------------------- SHIPEMNT CANCEL END
	 
	 //------------------------------------- SHIPEMNT PRINT BEGIN
	 self.shipmentPrint = function (shipment) {
		 bill_open(shipment.shipment_id);
	 }
	 //------------------------------------- SHIPEMNT PRINT END
	 
	 //------------------------------------ REGISTER SELECT BEGIN
	 self.shipmentSelect = function (shipment) {
		 var index = self.selected_shipment.indexOf(shipment);
		 if(shipment.select) {
			 self.selected_shipment.push(shipment);
		 } else {
			 $scope.selectall=false;
			 self.selected_shipment.splice(index, 1);
		 }
	 }
	 //------------------------------------ REGISTER SELECT END
	 
	 //------------------------------------- REGISTER SELECT ALL BEGIN
	 self.shipmentSelectall = function () {
		 self.selected_shipment = [];
		 for(var i=0; i<$scope.pageSize; i++) {
			 self.FilterShipment[i].select = $scope.selectall;
			 if($scope.selectall) {
				 self.selected_shipment.push(self.FilterShipment[i]);
			 }
		}
	} 
	//------------------------------------- REGISTER SELECT ALL END
	 
	//------------------------------------- MAKE CANCEL BEGIN
	 self.makeCancel = function () {
		 
		
		 if(self.selected_shipment.length == 0) {
			 self.message = "Please select atleast one record..!";
			 successAnimate('.failure');
		 }else{
			 var cancel_flag = 0;
			 if($('#currentUserRole').val() != 'SUPER_ADMIN'){
				 
				 for(var i=0; i<self.selected_shipment.length; i++) {
					 if(self.viewShipment.from_branch != self.selected_shipment[i].sender_branch.branch_id) {
						 cancel_flag = 1;
					 } 
				 }
				 
			 }
			 
			 if(cancel_flag == 0) {
				 
				 self.confirm_title = 'Delete';
	 				self.confirm_type = BootstrapDialog.TYPE_DANGER;
	 				self.confirm_msg = self.confirm_title+ ' selected record(s)?';
	 				self.confirm_btnclass = 'btn-danger';
	 				ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
	 				.then(
	 						function (res) {
	 							var shipment_id = [];
	 							for(var i=0; i<self.selected_shipment.length; i++) {
	 								shipment_id[i] = self.selected_shipment[i].shipment_id; 								
	 							}
	 							ShipmentService.makeCancel(shipment_id)
	 								.then(
	 										function(res) {
	 											if(res.length == 0) {
	 												self.selected_shipment = [];
		 											self.message = "Selected record(s) has been deleted successfully..!"
		 											successAnimate('.success');
		 											fetchAllShipmentforView();
	 												self.lr_search = null;
	 											} else {
	 												self.message = "Sorry..! Selected shipment(s) "+res;
	 												successAnimate('.failure'); 
	 											}
	 												
	 										}, function (errRes) {
	 											self.message = "Sorry.. Error while deleting record(s)..!"
		 										successAnimate('.failure');	
	 										}
	 									);
	 						}
	 					);
				 	
			 } else {
				 self.message = "Sorry.. You don't have permission to delete other branch record(s)..!"
				 successAnimate('.failure');	
			 }
			 	
		 }
	 }
	//------------------------------------- MAKE CANCEL END
	 
    //-------------------------------- Show no of record begin ----------------------------------------//
    
    self.shownoofRecord = function() 
    {    
    	self.ship_regSearch = null;
    	$scope.pageSize = $scope.shownoofrec;
    	self.FilterShipment = self.shipments.slice($scope.currentPage*$scope.pageSize);
    	if( self.FilterShipment.length <= $scope.pageSize )
    	{
    		$scope.previouseDisabled = true;
    		$scope.nextDisabled = true;
    	}
    	else
    	{
    		//$scope.previouseDisabled=false;
    		$scope.nextDisabled=false;
    	}
    	fetchAllShipmentforView();
    }
    //-------------------------------- Show no of record end ----------------------------------------//  
    
    //------------------------------- Sorting begin
    function resetSorting() {
    	$scope.date = false;
    	$scope.lrno = false;
    	$scope.product = false;
    	$scope.origin = false;
    	$scope.destination = false;
    	$scope.sender = false;
    	$scope.consignee = false;
    	$scope.status = false;
    }
    
    $scope.sortTable = function (column, status) {
    	if(!$scope.disableSorting){
    		$scope.lastSorted = column;
    		resetSorting();
    		$scope[column]=status;
    		ShipmentService.sortBy(column, status?"ASC":"DESC")
    			.then(
    					function (shipment) {
    						self.shipments = shipment;
    						self.FilterShipment = shipment;
    					}
    				);
    	}
    }
    //------------------------------- Sorting end
}]);


