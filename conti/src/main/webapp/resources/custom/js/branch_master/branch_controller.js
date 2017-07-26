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
	
	 $("#screen_branch").addClass("active-menu");
	 $scope.branchnamewrong=false;
	var self=this;
	self.branches=[];
	self.Filterbranches=[];
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
	self.branchSelect=branchSelect;
	self.branchSelectall=branchSelectall;
	self.makeActive=makeActive;
	self.makeinActive=makeinActive;
	self.registerSearch=registerSearch;
	self.shownoofRecord=shownoofRecord;
	self.checkBranchName=checkBranchName;
	self.selected_branch=[];
	self.confirm_title = 'Save';
	self.confirm_type = 'TYPE_SUCCESS';
	self.confirm_msg = self.confirm_title+ ' ' + self.branch.branch_name + ' branch?';
	self.confirm_btnclass = 'btn-success';
	$scope.shownoofrec = 10;
	fetchAllLocations();
	fetchAllBranches();
	function reset () 
	{
		$scope.branchnamewrong=false;
		self.branch = {};
	    $('#location_name_value').val('');
	    $('.locations').val('');

        self.heading = "Master";
        fetchAllBranches();
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
	//----------------Branch Master drawer close begin---------------------
	
	
	//-------------------------Branch Name checking----------------------
	
	
	function checkBranchName(name)
	{
		console.log(self.branch.branch_name, self.UpdateNotCheckBranchName, self.branch.branch_id);
		if(self.branch.branch_id !=null && self.branch.branch_name == self.UpdateNotCheckBranchName)
		{
			console.log("edit success");
			$scope.branchnamewrong = false;
		}
		else
		{
			console.log("edit success2");
			BranchService.checkBranchName(name)
			.then(function (response)
			{
				if(response=="204")//if logger value set no content that error code is 204
				{
					
					$scope.branchnamewrong=true;
					self.branch.branch_name=null;
				}
				else
				{
					
					$scope.branchnamewrong=false;
					
				}
			},
			function(errResponse)
			{
				$scope.branchnamewrong=false;
				self.branch.branch_name=null;
			});
		}
	}
	
	
	
  //------------------------Branch Name checking End----------------------
	
	//---------------------Branch Master drawer close begin-----------
	
	
	function close(title){
		ConfirmDialogService.confirmBox(title,
				BootstrapDialog.TYPE_WARNING, title+" Without Save ..? ", 'btn-warning')
		.then(function(response){
			 drawerClose('.drawer');
				reset();
		});
	}
		
	
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
					function (branch) 
					{
						self.branches = branch;
						pagination();
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
		console.log("Controller create branch call ...")
		BranchService.createBranch(branch)
		.then(
				function()
				{
					fetchAllBranches();
					self.message=branch.branch_name +" Branch created.....!";
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
	function editBranch(branch)
	{
		
		BranchService.updateBranch(branch)
		.then(
				function()
				{
					fetchAllBranches();
					self.message=branch.branch_name+ " branch updated...!";
					successAnimate('.success');
					newOrClose();
				},
				function(errResponse)
				{
					console.error('Error while creating Branch '+branch.branch_name);
				}
			);
	}
	//-----------------Updated Exiting Branch function End ---------------
	
	function submit()
	{
		
//		if ( $("#branch_id").val() == "" || $("#branch_id").val() == null )
//		{
//    		$("#branch_name_value").focus();
//    	}
//		else if ( $("#location_id").val() == "" || $("#location_id").val() == null )
//		{
//    		$("#branch_name_value").focus(); 
//    	} 
//		else 
//    	{	
		

		if(self.branch.branch_id==null)
		{
			console.log("branch save call "+self.branch.branch_id)
			self.confirm_title='Save';
			self.confirm_type=BootstrapDialog.TYPE_SUCCESSSS;
			self.confirm_msg=self.confirm_title +' '+self.branch.branch_name+' branch?';
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
			console.log("branch Update function call"+self.branch.branch_id)
			self.confirm_title='Update';
			self.confirm_type=BootstrapDialog.TYPE_SUCCESS;
			self.confirm_msg=self.confirm_title +' '+self.branch.branch_name +' branch?';
			self.confirm_btnclass = 'btn-warning';
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(function(res)
			{
				//self.branch.branch_id=$("#branch_id").val();
				self.branch.location=JSON.parse($("#location_id").val());
				console.log(self.branch);
				editBranch(self.branch);
				reset();
				window.setTimeout(function()
				{
						newOrClose();
				},5000);
			});
		}
	}
	
	//}
	
	//------------------------- update branch begin ---------------------//
    function updateBranch(branch) {
    	self.branch = branch;
    	$scope.branchnamewrong=false;
    	self.UpdateNotCheckBranchName=self.branch.branch_name;
    	self.heading = self.branch.branch_name;
    	$('#branch_id').val(JSON.stringify(self.branch.branchModel));
    	$('#location_id').val(JSON.stringify(self.branch.location));
    	$('#city').val(self.branch.location.address.city);
    	$('#country').val(self.branch.location.address.country);
    	$('#state').val(self.branch.location.address.state);
    	$('#pincode').val(self.branch.location.pincode);
    	
    	$('#location_name_value').val(self.branch.location.location_name);
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
										var index = self.branches.indexOf(branch);
										self.branches.splice(index,1);
										self.message =branch.branch_name+ " branch Deleted..!";
										successAnimate('.success');
										newOrClose();
										
									}, 
									function (errResponse) {
						                console.error('Error while Delete branch' + errResponse );
									}
								);
						
					}
				);
		
    }
    
  //------------------------- delete branch end ---------------------//
    
    
    
    //------------------------- Register select begin ------------------//
    function branchSelect(branch){
    	var index = self.selected_branch.indexOf(branch);
    	/*(employee.select)? self.selected_employee.push(employee) : self.selected_employee.splice(index, 1);*/
    	
    	if (branch.select){
    		self.selected_branch.push(branch);
    	} else {
    		$scope.selectall = false;
    		self.selected_branch.splice(index, 1);
    	}
    	
    }
    //------------------------- Register select end ------------------//
    
  //------------------------- Register select all begin ------------------//   
    function branchSelectall() 
    {
    	console.log($scope.pageSize,"call selectall")
    	self.selected_branch=[];
    	
    	try {
			
			for(var i = 0; i < $scope.pageSize; i++) {
    			self.Filterbranches[i].select = $scope.selectallbranches;
    			if($scope.selectallbranches)
    			{
    				self.selected_branch.push(self.Filterbranches[i]);
    			}
    		}
			
    		
		} catch(e) 
		{
			
		}
    		
		
    }
    //------------------------- Register select all end ------------------//
    
    
    
    //-------------------------- Make Active begin ----------------------//
    function makeActive(){
   	if(self.selected_branch.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
    	} else {
    		var activate_flag = 0;
    		angular.forEach(self.selected_branch, function(branch){
    			if(branch.active == 'Y') {
    				activate_flag = 1;
    			} 
    			
    		});
    		if(activate_flag == 1) {
				self.message ="Selected record(s) already in active status..!";
				successAnimate('.failure');
    			
    		} else {
    			
    			self.confirm_title = 'Active';
    			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
    			self.confirm_msg = self.confirm_title+ ' selected record(s)?';
    			self.confirm_btnclass = 'btn-success';
    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
    			.then(
    					function (res) {
    						var active_id = [];
    		    			for(var i=0; i<self.selected_branch.length; i++) {
    		    				active_id[i] = self.selected_branch[i].branch_id;    				
    		    			}
    						BranchService.makeActive(active_id)
    							.then(
    									function(response) {
    										fetchAllBranches();
    										self.selected_branch = [];
    										self.message ="Selected record(s) has in active status..!";
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
    //-------------------------- Make Active end ----------------------//    
    
    
  //-------------------------- Make inActive begin ----------------------//
    function makeinActive(){
    	
    	console.log("inside inactive");
   	if(self.selected_branch.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
    	} else {
    		var inactivate_flag = 0;
    		angular.forEach(self.selected_branch, function(branch){
    			if(branch.active == 'N') {
    				inactivate_flag = 1;
    			} 
    			
    		});
    		if(inactivate_flag == 1) {
				self.message ="Selected record(s) already in inactive status..!";
				successAnimate('.failure');
    			
    		} else {
    			
    			self.confirm_title = 'In-Active';
    			self.confirm_type = BootstrapDialog.TYPE_DANGER;
    			self.confirm_msg = self.confirm_title+ ' selected record(s)?';
    			self.confirm_btnclass = 'btn-danger';
    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
    			.then(
    						function (res) {
    							var inactive_id = [];
    			    			for(var i=0; i<self.selected_branch.length; i++) {
    			    				inactive_id[i] = self.selected_branch[i].branch_id;        				
    			    			}
    							BranchService.makeinActive(inactive_id)
    								.then(
    										function(response) {
    											fetchAllBranches();
    											self.selected_branch = [];
    											self.message ="Selected record(s) has in inactive status..!";
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
    //-------------------------- Make inActive end ----------------------//   
   
 //-------------------------- Pagnation begin -----------------------//
    
    function pagination() {
        
    	$scope.pageSize = $scope.shownoofrec;
    	console.log($scope.pageSize);
		$scope.currentPage = 0;
		$scope.totalPages = 0;
		//$scope.totalItems = Math.ceil(self.Filterbranches.length/$scope.pageSize);
		self.Filterbranches = self.branches;
		
		$scope.nextDisabled = false;
		$scope.previouseDisabled = true;
					
    }
    
    $scope.paginate = function(nextPrevMultiplier) {

    	$scope.currentPage += (nextPrevMultiplier * 1);
    	self.Filterbranches = self.branches.slice($scope.currentPage*$scope.pageSize);
    	
    	console.log(self.Filterbranches.length);
    	
    	if(self.Filterbranches.length == 0) {
    		BranchService.pagination_byPage($scope.currentPage)
    		.then(
    				function (filterBranch) {
    					
    					if ( filterBranch.length == 0 ) {
    						$scope.nextDisabled = true;
    					} else if ( filterBranch.length < 10 ) {
    						self.Filterbranches = filterBranch;
    						$scope.nextDisabled = true;
    					} else {
    						self.Filterbranches = filterBranch;
    					}
    					
    				}, 
    				function (errResponse) {
    					console.log('Error while pagination');
    				}
    			);
    	} 
    	
    	if(self.Filterbranches.length < $scope.pageSize) {
    		$scope.nextDisabled = true;
    	}
    	
    	console.log(nextPrevMultiplier);
    	if($scope.currentPage == 0) {
    		$scope.previouseDisabled = true;
    	}
    	if(nextPrevMultiplier == -1) {    		
    		$scope.nextDisabled = false;
    	} else {
    		$scope.previouseDisabled = false;
    	}
    	
    }

  
    //-------------------------- Pagnation end -----------------------//	

    
 //---------------------------- Pagination begin ---------------------------------------//
    
    $scope.firstlastPaginate = function (page) {
    	 
    	BranchService.pagination_byPage(page)
		.then(
				function (filterBranch) {
					
					console.log(filterBranch);
					
					self.Filterbranches = filterBranch;
				}, 
				function (errResponse) {
					console.log('Error while fetching branches');
				}
			);
    	
    	if( page == 1 ) {
    		$scope.currentPage = 0;
    		$scope.previouseDisabled = true;
    		$scope.nextDisabled = false;
    	} else {
    		$scope.previouseDisabled = false;
    		$scope.nextDisabled = true;
    		
    	}
    }
    

  //---------------------------- Pagination end ---------------------------------------//
    
 //-------------------------------- Show no of record begin ----------------------------------------//
    
    function shownoofRecord() {    
    	$scope.pageSize = $scope.shownoofrec;
    }
    //-------------------------------- Show no of record end ----------------------------------------//  
    
   
    
    //---------------------------- Register search begin ---------------------------------------//
    function registerSearch(searchkey) {
    	if ( searchkey.length == 0 ) {
    		self.Filterbranches = self.branches;
    	}else if( searchkey.length > 3 ) {
    		BranchService.registerSearch(searchkey)
	    		.then(
						function (filterBranch) {
							self.Filterbranches = filterBranch;
						}, 
						function (errResponse) {
							console.log('Error while fetching branches');
						}
					);
    	} else {
    		
    		self.Filterbranches = _.filter(self.branches,
					 function(item){  
						 return searchUtil(item,searchkey); 
					 });
				
    		}
    	
    }
    
    function searchUtil(item,toSearch)
	{
		var success = false;
		
		if ( (item.branch_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.branch_code.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
		//      || (item.empcategory.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.branchModel.branch_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
		//		|| (item.emp_address1.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.emp_address2.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
				|| (item.location.location_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.location.address.city.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
				|| (item.location.address.district.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.location.address.state.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)
				|| (item.branch_contactperson.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
				|| ((String(item.branch_mobileno)).indexOf(toSearch) > -1 ) ||  (item.branch_email.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)  
				|| (item.lrno_prefix.toLowerCase().indexOf(toSearch.toLowerCase())) ||(item.receiptno_prefix.toLowerCase().indexOf(toSearch.toLowerCase()))) 
		{
			success = true;
		} else {
			success = false;
		}
		
		return success;
	}
    //---------------------------- Register search end ---------------------------------------//
     


}]);