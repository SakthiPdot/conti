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
	self.receiptSelect=receiptSelect;
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
			.then(
					function(filterReceipt)
					{
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
	//------------------------------------------------------------------------------------
	
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
			//fetchAllReceipt_add();
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
		.then(
				function(receipt)
				{
					console.log(receipt);
					self.Filterreceipts=receipt;
				},
				function(errResponse)
				{
					console.log('Error while filtering receipt records');
				}
			);
	}
	
	}
]);