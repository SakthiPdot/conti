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
	self.selected_receipt=[];
	self.Filterreceipts=[];

	self.heading="Manster"
	self.message=null;
	self.print=print;
	self.currentBranch=[];
	self.viewShipment=viewShipment;
	self.receiptSelect=receiptSelect;
	self.registerSearch=registerSearch;
	self.receiptSelectAll=receiptSelectAll;
	self.shownoofRecord=shownoofRecord;

	$scope.shownoofrec=50;
	
	self.receiptSelectAll=receiptSelectAll;
	fetchAllReceipt_add();
	fetchAllBranches();
	var branch_id=$('#branchid').val();
	fetchCurrentBranch(branch_id);
		
	function reset()
	{
		self.receipt={};
		self.heading='Master';
		fetchAllReceipt();
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
				function(branches) 
				{
					self.branches = branches;
					pagination();
					//console.log("get all branches "+self.branches)
				}, 
				function (errResponse) 
				{
					console.log('Error while fetching branches');
				}
			);
	}
	
	//-------------------------- Fetch All Branch end -----------------------//
	
	//-----------------Get Current branch from branch Master-----------------//
	
	function fetchCurrentBranch(branch_id)
	{
		console.log("Current Branch location id : "+branch_id);
		BranchService.fetchbyBranchid(branch_id)
		.then(
				function(branch)
				{
					self.currentBranch=branch;
					console.log(self.currentBranch);
					pagination();
				},
				function(errResponse)
				{
					console.log('Error while fetching current branch.....');
				}
			);
	}
	//--------------------------------------------------------------------------//
	
	//---------------------------Fetch All Receipt details start----------------------
	function fetchAllReceipt_add()
	{
		ReceiptService.fetchAllReceipt_add()
		.then(
				function(receipt)
				{
					self.receipts=receipt;
					self.Filterreceipts=self.receipts;
					console.log('fetching receipt '+self.Filterreceipts);
				},
				function(errResponse)
				{
					console.log('Error while fetching Receipt');
				}
			);
	}
	//-------------------------------------------------------------------------------

	
	//--------------------View shipment filter condition-------------------------------
	
	function viewShipment(receipt)
	{
		receipt.fromdate=$('.datepicker1').val();
		receipt.todate=$('.datepicker2').val();
		receipt.frombranch=receipt.frombranch.branch_id;
		receipt.tobranch=receipt.tobranch.branch_id;
		receipt.paymode=receipt.paymode;
		receipt.service=receipt.service;
		console.log(receipt);
		ReceiptService.viewShipment(receipt)
		.then(
				function(receipt)
				{
					self.Filterreceipts=receipt;
					console.log('Filter shipments details '+self.Filterreceipts);
				},
				function(errResponse)
				{
					console.log('Error while fetching Receipt ....');
				}
			);
	}
	//---------------------------------------------------------------------------------
	
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
	//--------------------------------------------------------------------------------------------
	
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
	//-------------------------------------------------------------------------------------------------

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
		
	//-----------------------------Record count begin-------------------------------------
	
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
		if(nextPrevMultipier==-1)
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
			fetchAllReceipt_add();
			
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
	//-----------------------------------------------------------------------------------------------

	//------------------------------------Register LR number search start----------------------------
	
	function registerSearch(searchkey)
	{
		if(searchkey.length==0)
		{
			self.Filterreceipts=self.receipts;
		}
		else if(searchkey.length>3)
		{
			ReceiptService.registerSearch(searchkey)
			.then(
					function(filterReceipt)
					{
						console.log('Search function successfully call');
						self.Filterreceipts=filterReceipt;
						console.log(filterReceipt);
					},
					function(errResponse)
					{
						console.log('Error while fetching branches ');
					}
					
				);
		}
		else
		{
			self.Filterreceipts=_.filter(self.receipts,
					function(item)
					{
						return searchUtil(item,searchkey);
					});
		}
	}
	
	function searchUtil(item,toSearch)
	{
		var success=false;
		if(String(item.lr_number).indexOf(toSearch)>-1)
		{
			success=true;
		}
		else
		{
			success=false;
		}
		return success;
	}
	//--------------------------------------------------------------------------------------------//
	
	}
]);