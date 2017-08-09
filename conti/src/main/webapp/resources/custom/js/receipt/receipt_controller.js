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
	self.Filterreceipts=[];
	self.branches=[];
	self.heading="Manster"
	self.message=null;
	self.print=print;
	
	fetchAllReceipt();
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
	
	function fetchAllBranches() {
		console.log("get all branches")
		BranchService.fetchAllBranches()
			.then(
					function (branches) {
						self.branches = branches;
//						pagination();
						console.log("get all branches "+self.branches)
					}, 
					function (errResponse) {
						console.log('Error while fetching branches');
					}
				);
	}
	
	//-------------------------- Fetch All Branch end ---------------------//
	
	//---------------------------Fetch All Receipt details start----------------------
	function fetchAllReceipt()
	{
		ReceiptService.fetchAllReceipt()
		.then(
				function(receipt)
				{
					self.receipts=receipt;
					self.Filterreceipts=self.receipts;
					console.log('fetching manifest '+self.Filterreceipts);
				},
				function(errResponse)
				{
					console.log('Error while fetching Receipt');
				}
			);
	}
	//--------------------------------------------------------------------
	
	
	}
]);