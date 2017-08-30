

contiApp.controller('ReportController',['$scope','$http','$q','$timeout','BranchService','ShipmentService','ConfirmDialogService',function($scope,$http,$q,$timeout,BranchService,ShipmentService,ConfirmDialogService)
	{
		
		$("#screen_report").addClass("active-menu");
	
	    var self = this;
		self.report = [];
		self.branches = [];
		self.dateformat = dateformat;
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
							
						}, function (errResponse) {
							console.log(errResponse);
						}
				      );
		}
		
		 function dateformat()
		{
			/* $scope.today = new Date();*/
			 
			    var today = new Date();
	   			var dd = today.getDate();
	   			var mm = today.getMonth()+1;
	   			var yyyy = today.getFullYear();
	   			
	   			if(dd < 10) {
	   				dd = '0' + dd
	   			}
	   			
	   			if (mm < 10) {
	   				mm = '0' + mm
	   			}
	   			
	   			$scope.today = yyyy + '-' + mm + '-' + dd;
	   			
	   			
	   			/*var curr = new Date;	   			
	   			var first = curr.getDate() - curr.getDay(); 	   			
	   			var last = first + 6; 	   			
	   			$scope.firstday = new Date(curr.setDate(first)).toUTCString();
	   			var lastday = new Date(curr.setDate(last));
	   			
	   			console.log("start date======"+$scope.firstday)

			 
			      console.log("your select  "+$scope.datefilter);*/
			 $scope.t = "r";
			if($scope.datefilter == "Today") {
				console.log($scope.today)				
				
			} else if ($scope.datefilter == "This Week") {
				console.log($scope.t)
			} else if ($scope.datefilter == "This Month") {
				console.log("3");
			} else if($scope.datefilter == "This Quater") {
				console.log("4");
			} else {
				console.log("your select wrong");
			}
			
		}
		
		
	}
	]);