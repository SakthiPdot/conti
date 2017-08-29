

contiApp.controller('ReportController',['$scope','$http','$q','$timeout','BranchService','ShipmentService','ConfirmDialogService',function($scope,$http,$q,$timeout,BranchService,ShipmentService,ConfirmDialogService)
	{
		
		$("#screen_report").addClass("active-menu");
	
	    var self = this;
		self.report = [];
		self.branches = [];
		
		fetchAllBranches();
		fetchAllShipmentforView();
		
		
		
		
	
	//============ Fetch All Branches Function Begin =======//	
		function fetchAllBranches() {
			
			BranchService.fetchAllBranches()
				.then(
							function (branches) {
								self.branches = branches;
							
							},
							function(errResponse) {
								console.log('Error while fetching branches');
							}
					  );
		}
	//=========== Fetch All Branches Function End ===========//
		
		function fetchAllShipmentforView() {
			ShipmentService.fetchAllShipmentforView()
				.then(
						function(shipments) {
							
							self.shipments = shipments;	
							console.log("hu"+self.shipments);
						}, function (errResponse) {
							console.log(errResponse);
						}
				      );
		}
	}
	]);