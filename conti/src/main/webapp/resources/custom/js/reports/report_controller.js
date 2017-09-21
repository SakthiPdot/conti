
		 //fromdate chage
		 $('#datepicker1').click(function(){
			 angular.element(document.getElementById('datepicker1')).scope().fRest(); 
		 })
			 
contiApp.controller('ReportController',['$scope','$http','$q','$timeout','BranchService','UserService','ReportService','ShipmentService','ConfirmDialogService',function($scope,$http,$q,$timeout,BranchService,UserService,ReportService,ShipmentService,ConfirmDialogService)
	{
		
		$("#screen_report").addClass("active-menu");
	
	    var self = this;
		self.report = [];
		self.branches = [];
		self.dateformat = dateformat;
		fetchAllBranches();
		fetchAllShipmentforView();
		self.users=[];
		self.date_required = true;
		
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
		
	$scope.shownoofrec = 10;	
	self.filterReport = {};
	self.shipmentReport = {};
	self.excelFlag = true;
	$scope.nextDisabled = false;
	$scope.previouseDisabled = true;
	
	$scope.user_disable = false;
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
			 
			 self.filterReset();
						 		
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
		
		 //--- Prodcut change
		 $scope.product_name = function (product) {
			 if(product == null) {
				 self.report.product_id = "";
			 }else{
				 self.report.product_id = product.originalObject.product_id;
			}
			 self.filterReset();
		 }
		//--- fromlrno change
		 $scope.from_lrno = function (from_lrno) {
			 self.filterReset();
		 }
		//--- tolrno change
		 $scope.to_lrno = function (to_lrno) {
			 self.filterReset();
		 }
		 
		//---- Report 
		 self.submit = function (){
			 console.log($scope.filter_billto);
			 if($scope.filter_billto == 'filter_billto') {

				 self.report.fromtoday = $('.datepicker3').val();
				 self.report.todate = $('.datepicker3').val();
			 }else{

				 self.report.fromtoday = $('.datepicker1').val();
				 self.report.todate = $('.datepicker2').val();
				 self.report.from_lrno = $('#from_lrno_value').val();
				 self.report.to_lrno = $('#to_lrno_value').val();	 
			 }
			 
			 /*if(self.report.branch != null){
				 self.report.frombranch = self.report.branch;
				 self.report.tobranch = self.report.branch;
			 }*/
			 if(self.report.from_lrno==null){
				 self.report.from_lrno = "";
			 }
			 if(self.report.to_lrno==null){
				 self.report.to_lrno = "";
			 }
			 if(self.report.frombranch==null){
				 self.report.frombranch = "";
			 }
			 if(self.report.tobranch==null){
				 self.report.tobranch = "";
			 }
			 if(self.report.fromtoday==null){
				 self.report.fromtoday = "";
			 }
			 if(self.report.paymentmode==null){
				 self.report.paymentmode = "";
			 }
			 if(self.report.product_id==null){
				 self.report.product_id = "";
			 }
			 if(self.report.status==null){
				 self.report.status = "";
			 }
			 if(self.report.todate==null){
				 self.report.todate = "";
			 }
			 if(self.report.billto==null){
				 self.report.billto = "";
			 }
			 if(self.report.username==null){
				 self.report.username= "";
			 }
			 
			 ReportService.fetch4All(self.report)
			 	.then(
			 			function(shipment){
			 				console.log(shipment);
			 				if(shipment.length!=0) {
			 					self.filterReport = shipment;
			 					self.shipmentReport = shipment;
				 				self.excelFlag = false;	
				 				pagination();
				 			}
			 				no_data();
			 			},function(errResponse){
			 				console.log(errResponse);
			 			}
			 		);
		 }
		 
		 //--reset
		 self.filterReset = function(){
			 self.filterReport = {};
			 self.excelFlag = true;
			 self.tbl_nodata = false;
			 no_data();
			 if($scope.filter_billto == 'filter_billto') {
				 fetch_user(self.report.frombranch);
			 }
			 
		 }
		 $scope.fRest = function(){
			 self.filterReset();
		 }
		 //reset date
		 self.resetDate = function(){
			 $('.datepicker1').val('');
			 $('.datepicker2').val('');
			 no_data();
		 }
		 
		//---no data after filter
		 function no_data(){
			if(self.filterReport.length==undefined){
				self.tbl_nodata = true;		
				
				
				
				$scope.currentPage = null;
				$scope.nextDisabled = true;
				$scope.previouseDisabled = true;
				$scope.pageSize = null;
				$scope.totalnof_records = null;
			}else{
				self.tbl_nodata = false;
			}
			
		}
			//--------------------------- PAGINATION BEGIN
			
			function pagination() {
				
				$scope.pageSize = $scope.shownoofrec;
				$scope.currentPage = 0;
				$scope.nextDisabled = false;
				$scope.previouseDisabled = true;
			//	self.FilterShipment = self.shipmentReport;
				
				if(self.filterReport.length<=10){
					$scope.nextDisabled = true;			
				}

				if(self.filterReport.length<100){
					$scope.totalnof_records = self.filterReport.length;
				}/*else{
					findrecord_count();
				}*/
			}
			 $scope.firstlastPaginate = function (page) {
			    	$scope.selectall = false;
			    	if( page == 1 ) { // first
			    		$scope.currentPage = 0;
			    		$scope.previouseDisabled = true;
			    		$scope.nextDisabled = false;
			    		self.filterReport = self.shipmentReport.slice($scope.currentPage*$scope.pageSize);
			    	} else { // last
			    		
			    		$scope.currentPage = ( (Math.ceil(self.filterReport.length/$scope.pageSize)) - 1 );
			    		$scope.previouseDisabled = false;
			    		$scope.nextDisabled = true;
			    		
			    		self.filterReport = self.shipmentReport.slice($scope.currentPage*$scope.pageSize);
			    		
			    	}
			    	
			    }
			
			 $scope.paginate = function(nextPrevMultiplier) {
			    	$scope.currentPage += (nextPrevMultiplier * 1);
			    	self.filterReport = self.shipmentReport.slice($scope.currentPage*$scope.pageSize);
			    	
			    	if(self.filterReport.length < $scope.pageSize) {
			    		$scope.nextDisabled = true;
			    	}
			    	
			    	if($scope.currentPage == 0) {
			    		$scope.previouseDisabled = true;
			    	}
			    	if(nextPrevMultiplier == -1) {    		
			    		$scope.nextDisabled = false;
			    	} else {
			    		$scope.previouseDisabled = false;
			    	}
			    	
			    }
			    //-------------------------------- Show no of record begin ----------------------------------------//
			    
			    self.shownoofRecord = function() 
			    {    
			    	$scope.pageSize = $scope.shownoofrec;
			    	self.filterReport = self.shipmentReport.slice($scope.currentPage*$scope.pageSize);
			    	if( self.filterReport.length <= $scope.pageSize )
			    	{
			    		$scope.previouseDisabled = true;
			    		$scope.nextDisabled = true;
			    	}
			    	else
			    	{
			    		//$scope.previouseDisabled=false;
			    		$scope.nextDisabled=false;
			    	}
			    	
			    }
			    //-------------------------------- Show no of record end ----------------------------------------//  

			    //----fetch username
			    function fetch_user(from_branch){
			    	
			    	//for SA
			    	if($('#currentUserRole').val() == 'SUPER_ADMIN') {
			    		UserService.fetchAllUsers()
			    		.then(
			    				function(users){
			    					self.users = users;
			    				},function(errRes){
			    					console.log(errRes);
			    				}
			    			);
			    	}
			    	//for manager / user
			    	if($('#currentUserRole').val() == 'MANAGER' || $('#currentUserRole').val() == 'STAFF') {
			    		UserService.fetchUserbybranch()
			    		.then(
			    				function(users){
			    					self.users = users;
			    					if($('#currentUserRole').val() == 'STAFF'){
			    						self.report.user = parseInt($('#currentuserid').val());
			    						console.log($('#currentuserid').val());
			    						console.log(self.report.user);
			    						//$scope.user_disable = true;
			    					}
			    					
			    				},function(errRes){
			    					console.log(errRes);
			    				}
			    			);
			    	}
			    	
			    	
			    }
			    
	}
	]);