

contiApp.controller('ReportController',['$scope','$http','$q','$timeout','BranchService','ReportService','ShipmentService','ConfirmDialogService',function($scope,$http,$q,$timeout,BranchService,ReportService,ShipmentService,ConfirmDialogService)
	{
		
		$("#screen_report").addClass("active-menu");
	
	    var self = this;
		self.report = [];
		self.branches = [];
		self.dateformat = dateformat;
		fetchAllBranches();
		fetchAllShipmentforView();
		
		
		self.report = {
				datecondition : 'AND',
				frombranch : '',
				tobranch : '',
				branchcondition : 'AND',
				from_lrno : '',
				to_lrno : '',
				lrcondition : 'AND',
				product_id : '',
				paymentmode : '',
				status : ''
				
		};
		
		
	self.filterReport = {};
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
	   			
	   			self.report.fromtoday = yyyy + '-' + mm + '-' + dd;			
	   			
	   			
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
				
				self.report.todate = yyyy + '-' + mm + '-' + dd;
				
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
	   			
	   			self.report.fromtoday = yyyy + '-' + mm + '-' + first;
	   			
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
	   			
	   			
	   			self.report.todate = yyyy + '-' + mm + '-' + last;  			
	   			
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
				 self.report.fromtoday = y + '-' + m + '-' + d;				 
	
				 
				 //===== to date this month =======//
				 self.report.todate = new Date(y, m, 0);				
				    		
		   			
			} else if($scope.datefilter == "This Quater") {
			
				   var currentMonth=(new Date()).getMonth()
				   var yyyy=(new Date()).getFullYear()
				   var start= (Math.floor(currentMonth/3)*3)+1,
				   end= start+3;
				   $scope.from =new Date(start+'-01-'+ yyyy);
				   $scope.to= end>12?new Date('01-01-'+ (yyyy+1)):new Date(end+'-01-'+ (yyyy));
				   $scope.to=new Date(($scope.to.getTime())-1);
				   
				   self.report.fromtoday = $scope.from.format('yyyy-MM-dd');
				   self.report.todate = $scope.to.format('yyyy-MM-dd');				   
				   
				  
			} else {
				console.log("your select wrong");
			}
			
		}
		 $scope.product_name = function (product) {
			 self.report.product_id = product.originalObject.product_id;
		 }
		//---- Report 
		 self.submit = function (){
			 self.report.fromtoday = $('.datepicker1').val();
			 self.report.todate = $('.datepicker2').val();
			 self.report.from_lrno = $('#from_lrno_value').val();
			 self.report.to_lrno = $('#to_lrno_value').val();
			 ReportService.fetch4All(self.report)
			 	.then(
			 			function(shipment){

			 				self.filterReport = shipment;

			 				console.log(shipment);

			 			},function(errResponse){
			 				console.log(errResponse);
			 			}
			 		);
			 console.log(self.report);
		 }
	}
	]);