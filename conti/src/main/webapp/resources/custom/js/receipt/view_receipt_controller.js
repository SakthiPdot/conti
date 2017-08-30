/**
 * @Project_Name conti
 * @Package_Name custom js Receipt
 * @File_name Receipt_controller.js
 * @author Suresh
 * @Updated_user Suresh
  @Created_date_time August 09, 2017 11:31:53 AM
 * @Updated_date_time August 09, 2017 11:31:53 AM
 */

contiApp.controller('ReceiptController',['$scope','$http','$q','$timeout','ReceiptService','BranchService','ConfirmDialogService',function($scope,$http,$q,$timeout,ReceiptService,BranchService,ConfirmDialogService)
{
	var self=this;
	//self.search={};
	self.receipts=[];
	self.receipt={
			"frombranch" : "",
			"tobranch" : "",
			"fromdate" : "",
			"todate" : "",
			"status":"",
	};
	self.receiptFilter=receiptFilter;
	self.selected_receipt=[];
	self.Filterreceipts={};
	self.receipts=[];
	self.heading="Master"
	self.message=null;
	self.print=print;
	self.receiptSearch=receiptSearch;
	self.receiptSelect=receiptSelect;
	self.makeReturn=makeReturn;
	self.makePending=makePending;
	self.receiptSelectAll=receiptSelectAll;
	self.shownoofRecord=shownoofRecord;
	$scope.shownoofrec=10;
	
	self.receiptSelectAll=receiptSelectAll;
	
	fetchAllReceipt_view();
	fetchAllBranches();
		
	function reset()
	{
		self.manifest={};
		self.heading='Master';
		fetchAllManifest();
	}	

	//-----------------------------New and close function---------------------------	
	function newOrClose(){
		console.log(self.save);				
		if(self.save== "saveclose" ){
			 drawerClose('.drawer') ;
		}
		reset();
	}
	
	//-------------------------------------------------------------------------------
	
	
	function close(title)
	{
		ConfirmDialogService.confirmBox(title,
				BootstrapDialog.TYPE_WARNING, title+" Without Save ..? ", 'btn-warning')
		.then(function(response){
			 drawerClose('.drawer');
				reset();
		});
	}
	
	//----------------------------------------------------------------------------
	
	//-------------------------- Fetch All Branch begin ---------------------//	
	
	function fetchAllBranches() 
	{
		console.log("get all branches")
		BranchService.fetchAllBranches()
		.then(
				function (branches) 
				{
					self.branches = branches;
					
					//console.log("get all branches "+self.branches)
				}, 
				function (errResponse) 
				{
					console.log('Error while fetching branches');
				}
			);
//			if($('#currentUserRole').val() == "SUPER_ADMIN") {
//				self.fromBranch_disable = false;
//				//self.receipt.frombranch = parseInt($('#branch_id').val());
//			} else {
//				self.fromBranch_disable = false;
//				self.receipt.frombranch = self.receipt.frombranch;
//				//self.receipt.frombranch = parseInt($('#branch_id').val());
//			}	
	}
	 //fetchAllBranches(); 
	//-------------------------- Fetch All Branch end ---------------------//
	
	//---------------------------Fetch All Receipt details start----------------------
	function fetchAllReceipt_view()
	{
		ReceiptService.fetchAllReceipt_view()
		.then(
				function(receipt)
				{
					self.receipts=receipt;
					self.Filterreceipts=self.receipts;
					console.log(self.Filterreceipts);
					pagination();
				},
				function(errResponse)
				{
					console.log('Error while fetching Receipt');
				}
			);
	}
	//--------------------------------------------------------------------

	//-----------------------Receipt select all check box function start-------------------------
	
	function receiptSelectAll()
	{
		console.log('Call select all receipt '+$scope.pageSize);
		self.selected_receipt=[];
		for (var i=0; i<$scope.pageSize;i++)
		{
			self.Filterreceipts[i].select=$scope.selectallreceipts;
			if($scope.selectallreceipts)
			{
				self.selected_receipt.push(self.Filterreceipts[i]);
			}
		}
	}
	//---------------------------------------------------------------------------------------------
	
	//-----------------------------Receipt record select on Register------------------------------
	
	function receiptSelect(receipt)
	{
		console.log('Call Receipt select function ....');
		var index=self.selected_receipt.indexOf(receipt);
		if(receipt.select)
		{
			self.selected_receipt.push(receipt);
		}
		else
		{
			self.selected_receipt.splice(index,1);
		}
	}
	//---------------------------------------------------------------------------------------------

	//--------------------------------------Show number of records-------------------------------------
	
	function shownoofRecord()
	{
		$scope.pageSize=$scope.shownoofrec;
		self.Filterreceipts=self.receipts.slice($scope.currentPage*$scope.pageSize);
		if(self.Filterreceipts.length<=$scope.pageSize)
		{
			$scope.previousDisabled=true;
			$scope.nextDisabled=true;
		}
		else
		{
			$scope.nextDisabled=false;
		}
	}
	//------------------------------------------------------------------------------------------------
	
	//----------------------------------------Register Search-----------------------------------------
	
	function registerSearch(searchkey)
	{
		if(searchkey.length==0)
		{
			self.Filterreceipts=self.receipts;
		}
		else if(searchkey.length>3)
		{
			Branch
		}
	}
	//----------------------------------------------------------------------------------------------------
	
	//-----------------------Record count begin-------------------------------------
	
	function findrecord_count()
	{
		BranchService.findrecord_count()
		.then(
				function(record_count)
				{
					console.log(record_count);
					$scope.totalnof_record_count;
				},
				function(errResponse)
				{
					console.log('Error while fetching record count....');
				}
			);
	}
	//--------------------------------------------------------------------------------
	
	//------------------------Receipt Pagination--------------------------------------
	
	function pagination()
	{
		$scope.pageSize=$scope.shownoofrec;
		$scope.currentPage=0;
		$scope.totalPages=0;
		self.Filterreceipts=self.receipts;
		$scope.nextDisabled=false;
		$scope.previouseDisabled=true;
		if(self.Filterreceipts.length<=10)
		{
			$scope.nextDisabled=true;
		}
		if(self.Filterreceipts.length<100)
		{
			$scope.totalnof_records=self.Filterreceipts.length;
		}
		else
		{
			findrecord_count();
		}
	}
	//---------------------------------------------------------------------------------
	
	//-----------------------Paginate function start----------------------------------
	
	$scope.paginate=function(nextPrevMultiplier)
	{
		$scope.selectallreceipts=false;
		$scope.currentPage+=(nextPrevMultiplier*1);
		self.Filterreceipts=self.receipts.slice($scope.currentPage*$scope.pageSize);
		console.log(self.Filterreceipts.length);
		if(self.Filterreceipts.length==0)
		{
			BranchService.pagination_byPage($scope.currentPage)
			.then(function(filterReceipt){
					if(filterReceipt.length==0)
					{
						$scope.nextDisabled=true;
					}
					else if(filterReceipt.length<10)
					{
						self.Filterreceipts=filterReceipt;
						$scope.nextDisabled=true;
					}
					else
					{
						self.Filterreceipts=filterReceipt;
					}
				},
				function(errResponse)
				{
					console.log('Error while pagination...');
				}
			);
		}
		if(self.Filterreceipts.length<$scope.pageSize)
		{
			$scope.nextDisabled=true;
		}
		if($scope.currentPage==0)
		{
			$scope.previouseDisabled=true;
		}
		if(nextPrevMultiplier ==-1)
		{
			$scope.nextDisabled=false;
		}
		else
		{
			$scope.previouseDisabled=false;
		}
	}
	
	//-----------------------------First and Last Pagination------------------------------------
	
	$scope.firstlastPaginate=function(page)
	{
		$scope.selectallreceipts=false;
		if(page==1)
		{
			$scope.currentPage=0;
			$scope.previouseDisabled=true;
			$scope.nextDisabled=false;
			self.Filterreceipts=self.receipts.slice($scope.currentPage*$scope.pageSize);
			fetchAllReceipt_view();
		}
		else
		{
			$scope.currentPage=((Math.cell(self.Filterreceipts.length/$scope.pageSize))-1);
			$scope.previouseDisabled+false;
			$scope.nextDisabled=true;
			self.Filterreceipts=self.receipts.slice($scope.currentPage*$scope.pageSize)
			console.log(self.Filterreceipts.length);
			if(self.Filterreceipt.length==0)
			{
				BranchService.pagination_byPage(page)
				.then(
						function(filterReceipt)
						{
							self.Filterreceipts=filterReceipt;
						},
						function(errResponse)
						{
							console.log('Error while fetching Branch');
						}
					);
			}
		}
	}
	
	//-------------------------------View Receipt filter function----------------------------------
	
	function receiptFilter(){
		//	self.receipt.frombranch=$('#branch_id').val();
		if($('.datepicker1').val().length != 0) {
			self.receipt.fromdate = $('.datepicker1').val();	
		} 
		if($('.datepicker2').val().length != 0) {
			self.receipt.todate = $('.datepicker2').val();	
		} 
		console.log(self.receipt);
		ReceiptService.receiptFilter(self.receipt)
		.then(function(receipt){
					console.log(receipt);
					self.Filterreceipts=receipt;
				},
				function(errResponse){
					console.log('Error while filtering receipt records');
				}
			);
	}
	
	//-------------------------------Receipt register search-------------------------
	
	function receiptSearch(key){
		console.log('');
		if (self.search.length==0) {
			self.Filterreceipts = self.receipts;
    	}else if(self.search.length>3){
			ReceiptService.receiptSearch(key)
			.then(function(filterreceipt){
				self.Filterreceipts=filterreceipt;
				console.log(filterreceipt);
			},
			function(errResponse){
				console.log('Error while searching receipt');
			});
			
		}
			
	}
	
	//-------------------------------------- Print begin -----------------------------//
	function print() {
	    	if(self.selected_receipt.length == 0 ) {
		   		self.message ="Please select atleast one record..!";
				successAnimate('.failure');
	    	} else {
	    			
	    		console.log(self.selected_receipt);
	    		$http.get('http://localhost:8080/Conti/listprint');
	    	}
	    }
	    
//-------------------Make Pending function start---------------------------------//
	
	function makePending(){
		console.log(self.selected_receipt.length);
		if(self.selected_receipt.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
		} else {
			var activate_flag = 0;
			angular.forEach(self.selected_receipt, function(receipt){
				if(receipt.shipmentModel.status == 'Pending') {
					activate_flag = 1;
					
				} 
			});
			if(activate_flag == 1) {
				self.message ="Selected record(s) already in Pending status..!";
				successAnimate('.failure');
				
			} else {
				self.confirm_title = 'Pending';
				self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
				self.confirm_msg =' make selected record(s) status as '+self.confirm_title+' ?';
				self.confirm_btnclass = 'btn-success';
				ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(
						function (res) {
							var active_id = [];
			    			for(var i=0; i<self.selected_receipt.length; i++) {
			    				 console.log("id "+i);
			    				active_id[i] = self.selected_receipt[i].receiptdetailid; 
			    				console.log(active_id[i] );
			    			}
							ReceiptService.makePending(active_id)
							.then(
									function(response) {
										fetchAllReceipt_view();
										self.selected_receipt = [];
										self.message ="Selected record(s) has in Pending status..!";
										successAnimate('.success');
									}, function(errResponse) {
										console.log(errResponse);    								
									}
								);
						}
					);
				
			}


		}
		
	}
	
	
//--------------------- Make Return function start---------------------------------	
	function makeReturn(){
		 console.log('call make Return function....');
		 console.log(self.selected_receipt);
		if(self.selected_receipt.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
		} else {
			var activate_flag = 0;
			angular.forEach(self.selected_receipt, function(receipt){
				if(receipt.shipmentModel.status== 'Return') {
					activate_flag = 1;
				} 
			});
			if(activate_flag == 1) {
				self.message ="Selected record(s) already in Return status..!";
				successAnimate('.failure');
				
			} else {
				self.confirm_title = 'Return';
				self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
				self.confirm_msg =' make selected record(s) status as '+self.confirm_title+' ?';
				self.confirm_btnclass = 'btn-success';
				ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(
						function (res) {
							var active_id = [];
			    			for(var i=0; i<self.selected_receipt.length; i++) {
			    				//console.log('the id is: '+)
			    				active_id[i] = self.selected_receipt[i].receiptdetailid; 
			    				console.log(active_id[i] );
			    			}
							ReceiptService.makeReturn(active_id)
							.then(
									function(response) {
										fetchAllReceipt_view();
										self.selected_receipt = [];
										self.message ="Selected record(s) has in Return status..!";
										successAnimate('.success');
									}, function(errResponse) {
										console.log(errResponse);    								
									}
								);
						}
					);
				
			}


		}
		
	}
	
	}
]);