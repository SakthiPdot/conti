

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
		
		//========== Select Date Filter ========//
		 function dateformat()
		{
			 
			
						 		
			//====== If Select Today =====//
			 if($scope.datefilter == "Today") {
				
				//===== from today date ======// 
			    var fromtoday = new Date();
	   			var dd = fromtoday.getDate();
	   			var mm = fromtoday.getMonth()+1;
	   			var yyyy = fromtoday.getFullYear();
	   			
	   			if(dd < 10) {
	   				dd = '0' + dd
	   			}
	   			
	   			if (mm < 10) {
	   				mm = '0' + mm
	   			}
	   			
	   			$scope.fromtoday = yyyy + '-' + mm + '-' + dd;			
	   			
	   			
	   			//========== to date ========//
				var todate = new Date();
				var dd = todate.getDate();
				var mm = todate.getMonth()+1;
				var yyyy = todate.getFullYear();
				
				if(dd < 10 ) {
					dd = '0' + dd
				}
				
				if(mm < 10) {
					mm = '0' + mm
				}
				
				$scope.todate = yyyy + '-' + mm + '-' + dd;
				
				//======= if select this week ======//
			} else if ($scope.datefilter == "This Week") {
			
				
				//===== from date week ====//
				
				var fromtoday = new Date;	   			
	   			var first = fromtoday.getDate() - fromtoday.getDay(); 
	   			var mm = fromtoday.getMonth()+1;
	   			var yyyy = fromtoday.getFullYear();
	   			
	   			var last = first + 6;
	   		
	   			if(last < 10) {
	   				last = '0' +last
	   			}
	   			
	   			if(first < 10) {
	   				first = '0' + first
	   			} 
	   			
	   			if (mm < 10) {
	   				mm = '0' + mm
	   			}
	   			
	   			$scope.fromtoday = yyyy + '-' + mm + '-' + first;
	   			
	   			//======== to date week ===========//
	   			
	   			var todate = new Date;	   			
	   			var first = todate.getDate() - fromtoday.getDay(); 
	   			var mm = todate.getMonth()+1;
	   			var yyyy = todate.getFullYear();
	   			
	   			var last = first + 6;
	   		
	   			if(last < 10) {
	   				last = '0' +last
	   			}
	   			
	   			if(first < 10) {
	   				first = '0' + first
	   			} 
	   			
	   			if (mm < 10) {
	   				mm = '0' + mm
	   			}
	   			
	   			
	   			$scope.todate = yyyy + '-' + mm + '-' + last;  			
	   			$scope.todate1 = $scope.todate;
	   			console.log($scope.todate1)	;
	   			//===== if select this month =========//
	   			
				
			} else if ($scope.datefilter == "This Month") {
				
				//====== from date this month =======//
				 var date = new Date();
				 var d = "1";
				 var y = date.getFullYear();
				 var m = date.getMonth()+1;
				
				 if (m < 10 ) {
					 m = '0' + m
				 }
				 
				 if(d < 10) {
					 d = '0'+d
				 }
				 $scope.fromtoday = y + '-' + m + '-' + d;				 
	
				 
				 //===== to date this month =======//
				 $scope.todate1 = new Date(y, m, 0);				
				 
				 $scope.todate =  $scope.todate1.format('yyyy-MM-dd');
				 
				
				 
		   		   		
		   			
			} else if($scope.datefilter == "This Quater") {
			
				   var currentMonth=(new Date()).getMonth()
				   var yyyy=(new Date()).getFullYear()
				   var start= (Math.floor(currentMonth/3)*3)+1,
				   end= start+3;
				   $scope.from =new Date(start+'-01-'+ yyyy);
				   $scope.to= end>12?new Date('01-01-'+ (yyyy+1)):new Date(end+'-01-'+ (yyyy));
				   $scope.to=new Date(($scope.to.getTime())-1);
				   
				   $scope.fromtoday = $scope.from.format('yyyy-MM-dd');
				   $scope.todate = $scope.to.format('yyyy-MM-dd');				   
				   
				  
			} else {
				console.log("your select wrong");
			}
			
		}
		
		
	}
	]);