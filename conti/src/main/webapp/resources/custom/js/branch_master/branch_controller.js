/**
 * @Project_Name conti
 * @Package_Name custom js batch_controller.js
 * @File_name batch_controller.js
 * @author Suresh
 * @Updated_user Suresh
 * @Created_date_time July 11, 2017 12:59:17 PM
 * @Updated_date_time July 11, 2017 12:59:17 PM
 */

contiApp.controller('BranchController', ['$scope','$timeout','BranchService','LocationService','ConfirmDialogService', function($scope, $timeout, BranchService, LocationService, ConfirmDialogService)
{
	var self=this;
	self.branches=[];
	self.branch={};
	
	self.heading = "Master";
	self.message = null;
	self.submit = submit;
	self.save = "saveclose";
	self.reset = reset;
	self.deleteBranch = deleteBranch;
	self.updateBranch = updateBranch;
	self.close = close;
	self.clear = clear;
	self.confirm_title = 'Save';
	self.confirm_type = 'TYPE_SUCCESS';
	self.confirm_msg = self.confirm_title+ ' ' + self.branch.branch_name + ' branch?';
	self.confirm_btnclass = 'btn-success';
	fetchAllLocations();
	
	function reset () 
	{
		   self.branch = {};
		   

	    	self.heading = "Master";
		  
	}
	
//-------------------------- Fetch All Location begin ---------------------//	
	
	function fetchAllLocations() {
		LocationService.fetchAllLocation()
			.then(
					function (locations) {
						self.locations = locations;
						console.log(locations);						
					}, 
					function (errResponse) {
						console.log('Error while fetching locations');
					}
				);
	}
	//----------Branch Master drawer close begin-----------
	
	function close() 
	{
		self.confirm_title = 'Cancel';
		self.confirm_type = BootstrapDialog.TYPE_WARNING;
		self.confirm_msg = self.confirm_title+ ' without saving data?';
		self.confirm_btnclass = 'btn-warning';
		ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(function (res) 
					{
		 	        	reset();
		 	        	newOrClose();
					}
				);
	}
	//----------Branch Master drawer close begin-----------
	
	//----------Branch Master drawer field clear begin-----------
	
	function clear() 
	{
		self.confirm_title = 'Clear';
		self.confirm_type = BootstrapDialog.TYPE_WARNING;
		self.confirm_msg = self.confirm_title+ ' the data?';
		self.confirm_btnclass = 'btn-warning';
		ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(
					function (res) {
		 	        	reset();
		 	        	
					}
				);
	}
	//----------Branch Master drawer field clear End-----------
	
	//-------------------------- Fetch All Branches start ---------------------//
	
	function fetchAllBranches() 
	{
		BranchService.fetchAllBranches()
			.then(
					function (branch) {
						self.branches = branch;
											}, 
					function (errResponse) {
						console.log('Error while fetching branches');
					}
				);
	}
	//-------------------------- Fetch All Branches end ---------------------//
	
	
	//===========================on save button click set value as SAVEANDCLOSE or SAVEANDNEW begin============
	$scope.save = function(event){
		self.save=event.target.id;
	}
	//===========================on save button click set value as SAVEANDCLOSE or SAVEANDNEW end============	
	
	function newOrClose(){
		console.log(self.save);				
		if(self.save== "saveclose" ){
			 drawerClose('.drawer') ;
		}
		reset();
	}

	//------------------------ Location block changes begin ----------------------//
    $scope.location_name = function (loc_selected) 
    {
    	
    	$('#location_id').val(JSON.stringify(loc_selected.originalObject));
    	$('#city').val(loc_selected.originalObject.address.city);
    	$('#country').val(loc_selected.originalObject.address.country);
    	$('#state').val(loc_selected.originalObject.address.state);
    	$('#pincode').val(loc_selected.originalObject.pincode);
	    	    
	};	
	//------------------------ Location block changes end ----------------------//
	
	
	//----------------------Create new Branch begin---------------------
	function createBranch(branch)
	{
		BranchService.createBranch(branch)
		.then(
				function()
				{
					fetchAllBranches();
					self.message=branch.branch_name+" Branch created.....!";
					successAnimate('.success');
				},
				function(errResponse)
				{
					console.error('Error while creating Branch '+branch.branch_name);
				}
		);
	}
	//---------------------Create new Branch End---------------------
	
	
	
	//------------------Updated existing Branch details-------------------
	function editBranch(Branch)
	{
		BranchService.createBranch(branch)
		.then(
				function()
				{
					fetchAllBranch();
					self.message=branch.branch_name+"branch updated...!";
					successAnimate('success');
				},
				function(errResponse)
				{
					console.error('Error while creating Branch'+branch.branch_name);
				}
			);
	}
	//-----------------Updated Exiting Branch function End ---------------
	
	function submit()
	{
		console.log("branch save call")
		if(self.branch.branch_id==null)
		{
			self.confirm_title='Save';
			self.confirm_type=BootstrapDialog.TYPE_SUCCESSSS;
			self.confirm_msg=self.confirm_title +''+self.branch.branch_name+' branch?';
			self.confirm_btnclass = 'btn-success';
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(function(res)
			{
				self.branch.branch_id=$("#branch_id").val();
				self.branch.location = JSON.parse($("#location_id").val());   
				createBranch(self.branch);
				reset();	
				window.setTimeout(function()
				{
						newOrClose();
				},5000);
			});
		}		
		else
		{
			self.confirm_title='Update';
			self.confirm_type=BoostrapDialog.TYPE_SUCCESS;
			self.confirm_msg=self.confirm_title+''+self.branch.branch_name+'branch?';
			self.confirm_btnclass = 'btn-warning';
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(function(res)
			{
				self.branch.branch_id=$("#branch_id").val();
				self.branch.location=JSON.parse($("location_id").val());
				editBranch(self.branch);
				reset();
				window.setTimeout(function()
				{
						newOrClose();
				},5000);
			});
		}
	}
	
	
	//------------------------- update branch begin ---------------------//
    function updateBranch(branch) {
    	self.branch = branch;
  
    	self.heading = self.branch.branch_name;
    	
    	$('#location_id').val(JSON.stringify(self.branch.location));
    	$('#city').val(self.branch.location.address.city);
    	$('#country').val(self.branch.location.address.country);
    	$('#state').val(self.branch.location.address.state);
    	$('#pincode').val(self.branch.location.pincode);
    	
		 
    	drawerOpen('.drawer');
    }
    //------------------------- update branch end ---------------------//    
    
//------------------------- delete branch begin ---------------------//
    
    function deleteBranch() {
    	
    	self.confirm_title = 'Delete';
		self.confirm_type = BootstrapDialog.TYPE_DANGER;
		self.confirm_msg = self.confirm_title+ ' ' + self.branch.branch_name + ' branch?';
		self.confirm_btnclass = 'btn-danger';
		ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(
					function (res) {
												
							BranchService.deleteBranch(self.branch.branch_id)
						.then(
								function (branch) {
									self.message =branch.branch_name+ " Branch Deleted..!";
									successAnimate('.success');
									newOrClose();
									self.branches.splice(branch,1);
									console.log(branch);	
									console.log(self.branches);	
								}, 
								function (errResponse) {
					                console.error('Error while Delete branch' + errResponse );
								}
							);
						
					}
				);
		
    }
    
  //------------------------- delete branch end ---------------------//
}]);