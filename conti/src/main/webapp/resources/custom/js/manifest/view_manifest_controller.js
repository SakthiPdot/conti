/**
 * @Project_Name conti
 * @Package_Name custom js Manifest
 * @File_name manifest_controller.js
 * @author Suresh
 * @Updated_user Suresh
  @Created_date_time July 24, 2017 3:31:53 PM
 * @Updated_date_time July 24, 2017 3:31:53 PM
 */
function test(ele){
	var id  = $(ele).data("id");
	valid = true;
	window.location.href = "detailed_manifest?id="+id;
}

contiApp.controller('ManifestController',['$scope','$http','$q','$timeout','ManifestService','BranchService','ConfirmDialogService',function($scope,$http,$q,$timeout,ManifestService,BranchService,ConfirmDialogService)
	{
		var self=this;
		self.manifests=[];
		self.Filtermanifests=[];//Store all manifest detailed
		self.FilterManifestdetailed=[];//for store detailed manifest based on manifest id
		self.branches=[];
		self.selected_manifest=[];
		self.manifest={
				"frombranch" : "",
				"tobranch" : "",
				"fromdate" : "",
				"todate" : "",
		};
		self.manifest1={};
		self.heading="Master";
		self.message=null;
		self.print = print;
		self.manifestSelectAll=manifestSelectAll;
		self.manifestSelect=manifestSelect;
		self.save='saveclose'
		self.close=close;
		self.deleteManifest=deleteManifest;
		self.manifestFilter=manifestFilter;
		self.inwardManifest=inwardManifest;	
		self.outwardManifest=outwardManifest;
		self.manifestSearch=manifestSearch;	
		self.shownoofRecord=shownoofRecord;
		$scope.shownoofrec=10;
		fetchAllManifest();
		var manifest_id=$("#manifest_id").val();
		//self.manifest.tobranch= $('#branch_id').val();
		self.manifest.tobranch = parseInt($('#branch_id').val());
		//--call detailed manifest
		if(manifest_id!=null)
		{
			console.log("call detailed manifest and id: " +manifest_id);
			manifestDetailed(manifest_id);
		}
		
		
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
	
	
	//---------------------Customer Master drawer close begin-----------
		
	function close(title)
	{
		ConfirmDialogService.confirmBox(title,
				BootstrapDialog.TYPE_WARNING, title+" Without Save ..? ", 'btn-warning')
		.then(function(response){
			 drawerClose('.drawer');
				reset();
		});
	}
		
	//-------------------------- Fetch All Branch begin ---------------------//	
	
	function fetchAllBranches() {
		console.log("get all branches")
		BranchService.fetchAllBranches()
			.then(
					function (branches) {
						self.branches = branches;
						
						//console.log("get all branches "+self.branches)
					}, 
					function (errResponse) {
						console.log('Error while fetching branches');
					}
				);
//		if($('#currentUserRole').val() == "SUPER_ADMIN") {
//			self.fromBranch_disable = false;
//			self.manifest.frombranch = parseInt($('#branch_id').val());
//		} else {
//			self.fromBranch_disable = true;
//			
//			self.manifest.frombranch = parseInt($('#branch_id').val());
//		}	
	}
	fetchAllBranches();
		
	//-------------------------- Fetch All Manifest records Start ---------------------//
	function fetchAllManifest() 
	{
		console.log('Fetch all manifest call successfully........');
		ManifestService.fetchAllManifest()
			.then(
					function (manifest) 
					{
						self.manifests = manifest;
						self.Filtermanifests=self.manifests;
						pagination();
						console.log('fetching manifest '+self.Filtermanifests.length);
					}, 
					function (errResponse) 
					{
						console.log('Error while fetching manifest');
					}
				);
	}
		
	//--------------------------------Manifest delete function -----------------------------------
			
	function deleteManifest()
	{
		console.log(self.Filtermanifests);
		var branch=$('#branch_id').val();
		var currentRole=$('#currentUserRole').val();
		currentroleflag=0;
		console.log(branch);
		if (currentRole=='SUPER_ADMIN'){
			currentroleflag=1;
			}
		var deleteflag=0;
		var branchflag=0;
		for(var i=0; i<self.selected_manifest.length; i++)
		{
			if(self.selected_manifest[i].manifest_status =='Intransit')
				{deleteflag=1;}
			
			if(self.selected_manifest[i].branchModel2.branch_id!=parseInt(branch))
				{branchflag=1;}	
			
			console.log(self.selected_manifest[i].branchModel1.branch_id);
			console.log('******************deleteflag '+deleteflag+' &&&&&&&&&&&&&&&&&&branchflag '+branchflag);
		}
		if(self.selected_manifest.length == 0 ) 
		{
	   		self.message ="Please select atleast one record for Delete..!";
			successAnimate('.failure');
    	} 
		else if(branchflag=='1' && currentroleflag==0)
		{
			self.message ="Origin branch user only can allow to Delete...!";
			successAnimate('.failure');
		}
		else if(deleteflag=='0')
		{
			self.message ="Receipt already created for selected record(s) so can not make Delele...!";
			successAnimate('.failure');
		}
		else
		{
			self.confirm_title='Delete';
			self.confirm_type=BootstrapDialog.TYPE_DANGER;
			self.confirm_msg=self.confirm_title+' '+' Manifest?';
			self.confirm_btnclass='btn-danger';
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(function (res) 
				{	
					var deleted_id=[];
					for(var i=0; i<self.selected_manifest.length; i++){
						deleted_id[i]=self.selected_manifest[i].manifest_id;
					}
					ManifestService.deleteManifest(deleted_id)
					.then(function (manifest) 
					{
						var index = self.manifests.indexOf(manifest);
						self.manifests.splice(index,1);
						self.message = " Manifest Deleted...!";
						self.selected_manifest=[];
						successAnimate('.success');
						newOrClose();
					}, 
					function (errResponse){
		                console.error('Error while Delete Manifest' + errResponse );
					}
				);
			}
		);
		}
	}
	//-------------------------------------------------------------------------------------------------------------------
	
	//-------------------------------------- Print begin -----------------------------//
	function print() {
	    	if(self.selected_manifest.length == 0 ) {
		   		self.message ="Please select atleast one record..!";
				successAnimate('.failure');
	    	} else {
	    		console.log(self.selected_manifest);
	    		$http.get('http://localhost:8080/Conti/listprint');
	    	}
	    }
	    
	//-------------------------------------------------------------------------------//
	    
	  //------------------------- View Manifest Filter function start ------------------//   
	    function manifestFilter() 
	    {
//	    	manifest.fromdate = $('.datepicker1').val();
//	    	manifest.todate = $('.datepicker2').val();
	   // 	self.manifest.frombranch= $('#branch_id').val();
	    	//manifest.tobranch=manifest.tobranch.branch_id;
	    	if($('.datepicker1').val().length != 0) {
				self.manifest.fromdate = $('.datepicker1').val();	
			} 
			if($('.datepicker2').val().length != 0) {
				self.manifest.todate = $('.datepicker2').val();	
			} 
	    	
	    	console.log(self.manifest);
	    	ManifestService.manifestFilter(self.manifest)
	    	.then(
	    			function(manifest)
	    			{
	    				console.log(manifest);
	    				self.manifests=manifest
	    				self.Filtermanifests=self.manifests;
	    				pagination();
	    			},
	    			function(errResponse)
	    			{ 
	    				console.log('Error while filtering manifest records');
	    			}
	    		);
	    }
	  //-----------------------To get inward manifest list function Start--------------------------
	    
	    function inwardManifest()
	    {
	    	ManifestService.inwardManifest()
	    	.then(
	    			function(manifest)
	    			{
	    				console.log(manifest);
	    				self.Filtermanifests=manifest;
	    			},
	    			function(errResponse)
	    			{
	    				console.log('Error while getting inward manifest list');
	    			}
	    		);
	    }
	  
	  //-----------------------To get Outward manifest list function Start--------------------------
	    
	    function outwardManifest()
	    {
	    	ManifestService.outwardManifest()
	    	.then(
	    			function(manifest)
	    			{
	    				console.log(manifest);
	    				self.Filtermanifests=manifest;
	    			},
	    			function(errResponse)
	    			{
	    				console.log('Error while getting outward manifest list');
	    			}
	    		);
	    }
	    
	 //------------------------------Register Manifest Search start-------------------------------------------
	    
	  function manifestSearch(searchkey) {
		  console.log(searchkey);
		  if(self.search.manifest_regSearch.length==0)
		  {
		  	  self.Filtermanifests=self.manifests;
		  }
		  if(self.search.manifest_regSearch.length>3)
		  {
		  	ManifestService.manifestSearch(searchkey)
		  	.then(function(filtermanifest){
		  				self.Filtermanifests=filtermanifest;
		  				console.log(filtermanifest);
		  			},
		  			function(errResponse)
		  			{
		  				console.log('Error while Searching Manifest number')
		  			}
		  		);
		  }else{
				self.Filtermanifests=_.filter(self.manifests,function(item){
					return String((item.manifest_prefix.toLowerCase()).indexOf(toString(searchkey).toLowerCase()) > -1);
				});
			}
	  }
	
  //--------------------------Manifest Select All check box function start------------------
	  
	  function manifestSelectAll()
	  {
		  console.log('Call select all Manifest '+ $scope.pageSize);
		  self.selected_manifest=[];
		  for(var i=0; i<$scope.pageSize; i++)
		  {
			  self.Filtermanifests[i].select=$scope.selectallmanifests;
			  if($scope.selectallmanifests)
			  {
			  	 self.selected_manifest.push(self.Filtermanifests[i]);
			  }
		  }
	  }
	  //--------------------------------------------------------------------------------------
	  
	  //---------------------Manifest Record select on Register start-----------------------
	  
	  function manifestSelect(manifest)
	  {
		  console.log('Call Manifest select all function')
		  var index=self.selected_manifest.indexOf(manifest);
		  if(manifest.select)
			  {
			  	self.selected_manifest.push(manifest);
			  }
		  else
			  {
			  	//$scope.selectallmanifests=false;
			  	self.selected_manifest.splice(index,1);
			  }
	  }
	  
	  //----------------------------------------------------------------------------------------
	  
	  
	//---------------------Show no of record in Manifest Register---------------------------
	
	  function shownoofRecord()
	  {
		  $scope.pageSize=$scope.shownoofrec;
		  self.Filtermanifests=self.manifests.slice($scope.currentPage*$scope.pageSize);
		  if(self.Filtermanifests.length<=$scope.pageSize)
		  {
			  $scope.previousDisabled=true;
			  $scope.nextDisabled=true;
		  }
		  else
		  {
			  $scope.nextDisabled=false;
		  }
	  }
	  //----------------------------------------------------------------------------------------
	  
	//----------------------------------- Record Count begin -----------------------------//
		
		function findrecord_count()
		{
			BranchService.findrecord_count()
			.then(
					function (record_count) {
						console.log(record_count);
						$scope.totalnof_records  = record_count;
					}, 
					function (errResponse) {
						console.log('Error while fetching record count');
					}
				);
		}
		
	//------------------------------------------------------------------------------------//  
	   
	//-------------------------------------Manifest Pagination---------------------------------  
	  function pagination() {
		  console.log('Pagination function call successfully..........');
	        $scope.pageSize = $scope.shownoofrec;
	    	console.log($scope.pageSize);
			$scope.currentPage = 0;
			$scope.totalPages = 0;
			//$scope.totalItems = Math.ceil(self.Filterbranches.length/$scope.pageSize);
			self.Filtermanifests = self.manifests;
			$scope.nextDisabled = false;
			$scope.previouseDisabled = true;
			if( self.Filtermanifests.length <= 10 ){
				$scope.nextDisabled = true;
			} 
			if( self.Filtermanifests.length < 100 ){
				$scope.totalnof_records  = self.Filtermanifests.length;
				console.log(self.Filtermanifests.length);
				
			} else {
				findrecord_count();
			}
						
	    }
	  
		  
	  $scope.paginate = function(nextPrevMultiplier){
	    	$scope.selectallmanifests=false;
	    	$scope.currentPage += (nextPrevMultiplier * 1);
	    	self.Filtermanifests = self.manifests.slice($scope.currentPage*$scope.pageSize);
	    	
	    	console.log(self.Filtermanifests.length);
	    	
	    	if(self.Filtermanifests.length == 0) {
	    		BranchService.pagination_byPage($scope.currentPage)
	    		.then(function (filterManifest) {
	    					
	    					if ( filterManifest.length == 0 ) {
	    						$scope.nextDisabled = true;
	    					} else if ( filterManifest.length < 10 ) {
	    						self.Filtermanifests = filterManifest;
	    						$scope.nextDisabled = true;
	    					} else {
	    						self.Filtermanifests = filterManifest;
	    					}
	    					
	    				}, 
	    				function (errResponse) {
	    					console.log('Error while pagination');
	    				}
	    			);
	    	} 
	    	
	    	if(self.Filtermanifests.length <=$scope.pageSize) {
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
	  
//------------------------------------First last pagination--------------------------------------------
	  
	  $scope.firstlastPaginate = function (page) 
	    {
	    	 $scope.selectallmanifests=false;
	    	if( page == 1 ) { // first
	    		$scope.currentPage = 0;
	    		$scope.previouseDisabled = true;
	    		$scope.nextDisabled = false;
	    		self.Filtermanifests = self.manifests.slice($scope.currentPage*$scope.pageSize);
	    		fetchAllManifest();
	    	} else { // last
	    		
	    		$scope.currentPage = ((Math.ceil(self.Filtermanifests.length/$scope.pageSize)) - 1 );
	    		$scope.previouseDisabled = false;
	    		$scope.nextDisabled = true;
	    		
	    		self.Filtermanifests = self.manifests.slice($scope.currentPage*$scope.pageSize);
	    		console.log(self.Filtermanifests.length);
	    		if(self.Filtermanifests.length == 0) 
	    		{
	    			BranchService.pagination_byPage(page)
	        		.then(
	        				function (filterManifest) {
	        					self.Filtermanifests = filterManifest;
	        				}, 
	        				function (errResponse) {
	        					console.log('Error while fetching Branch');
	        				}
	        			);
	    		}
	    	}
	    }

	}
	]);