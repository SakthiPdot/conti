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
		//self.selected_manifestdetailed[];
		self.manifest={};
		self.manifest1={};
		self.heading="Master";
		self.message=null;
		self.print = print;
		self.manifestSelectAll=manifestSelectAll;
		self.manifestDetailedSelectAll=manifestDetailedSelectAll;
		self.manifestSelect=manifestSelect;
		self.manifestDetailedSelect=manifestDetailedSelect;
		self.save='saveclose'
		self.close=close;
		self.deleteManifest=deleteManifest;
		self.manifestFilter=manifestFilter;
		self.inwardManifest=inwardManifest;
		self.outwardManifest=outwardManifest;
		self.manifestSearch=manifestSearch;
		self.shownoofRecord=shownoofRecord;
		self.manifestDetailed=manifestDetailed;
		$scope.shownoofrec=10;
		
		var manifest_id=$("#manifest_id").val();
		//--call detailed manifest
		if(manifest_id!=null)
		{
			console.log("call detailed manifest and id: " +manifest_id);
			manifestDetailed(manifest_id);
		}
		fetchAllManifest();
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
		
		//---------------------Customer Master drawer close end-----------
		
		
		//-------------------------- Fetch All Branch begin ---------------------//	
		
		function fetchAllBranches() {
			console.log("get all branches")
			BranchService.fetchAllBranches()
				.then(
						function (branches) {
							self.branches = branches;
							pagination();
							console.log("get all branches "+self.branches)
						}, 
						function (errResponse) {
							console.log('Error while fetching branches');
						}
					);
		}
		
		//-------------------------- Fetch All Branch end ---------------------//	
		
		//-------------------------- Fetch All Manifest records Start ---------------------//
		function fetchAllManifest() 
		{
			ManifestService.fetchAllManifest()
				.then(
						function (manifest) 
						{
							self.manifests = manifest;
							self.Filtermanifests=self.manifests;
							console.log('fetching manifest '+self.Filtermanifests);
						}, 
						function (errResponse) {
							console.log('Error while fetching manifest');
						}
					);
		}
		//-------------------------- Fetch All Manifest records end  ---------------------//
		
		
	//--------------------------------Manifest delete function -----------------------------------
			
	function deleteManifest()
	{
		console.log('selected manifest length :'+self.selected_manifest.length);
		if(self.selected_manifest.length == 0 ) 
		{
	   		self.message ="Please select atleast one record for delete..!";
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
					for(var i=0; i<self.selected_manifest.length; i++)
					{
						deleted_id[i]=self.selected_manifest[i].manifest_id;
						console.log(' for delete :    '+self.selected_manifest[i].manifest_id);
					}
					console.log('Number of manifest id for delete :    '+deleted_id);
					ManifestService.deleteManifest(deleted_id)
					.then(function (manifest) 
					{
						var index = self.manifests.indexOf(manifest);
						self.manifests.splice(index,1);
						self.message =manifest.manifest_number+ " Manifest Deleted...!";
						successAnimate('.success');
						newOrClose();
						
					}, 
					function (errResponse) 
					{
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
	    function manifestFilter(manifest) 
	    {
	    	manifest.fromdate = $('.datepicker1').val();
	    	manifest.todate = $('.datepicker2').val();
	    	manifest.frombranch=manifest.frombranch.branch_id;
	    	manifest.tobranch=manifest.tobranch.branch_id;
	    	console.log(manifest);
	    	ManifestService.manifestFilter(manifest)
	    	.then(
	    			function(manifest)
	    			{
	    				console.log(manifest);
	    				self.Filtermanifests=manifest;
	    			},
	    			function(errResponse)
	    			{ 
	    				console.log('Error while filtering manifest records');
	    			}
	    		);
	    }
	    //------------------------------------------------------------------------------//       
	    
	    
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
	  //-----------------------To get inward manifest list function End--------------------------
	    
	  
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
	  //-----------------------To get Outward manifest list function End--------------------------
	    
	    
	 //------------------------------Register Manifest Search start-------------------------------------------
	    
	  function manifestSearch(searchkey)
	  {
		  if(searchkey.length==0)
		  {
		  	  self.Filtermanifests=self.manifests;
		  }
		  else if(searchkey.length>3)
		  {
		  	ManifestService.manifestSearch(searchkey)
		  	.then(
		  			function(filtermanifest)
		  			{
		  				self.Filtermanifests=filtermanifest;
		  				console.log(filtermanifest);
		  			},
		  			function(errResponse)
		  			{
		  				console.log('Error while Searching Manifest number')
		  			}
		  		);
		  }
		  
	  }
	//---------------------------------------------------------------------------------------------------

	  
	
	  
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
		  console.log('Call Manifest select function ......')
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
		  if(self.Filtermanifests.length<$scope.pageSize)
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
	  function pagination() 
	    {
	        $scope.pageSize = $scope.shownoofrec;
	    	console.log($scope.pageSize);
			$scope.currentPage = 0;
			$scope.totalPages = 0;
			//$scope.totalItems = Math.ceil(self.Filterbranches.length/$scope.pageSize);
			self.Filtermanifests = self.manifests;
			
			$scope.nextDisabled = false;
			$scope.previouseDisabled = true;
			if( self.Filtermanifests.length <= 10 )
			{
				$scope.nextDisabled = true;
			} 
			if( self.Filtermanifests.length < 100 ) 
			{
				$scope.totalnof_records  = self.Filtermanifests.length;
				//findrecord_count();
			} else {
				findrecord_count();
			}
						
	    }
	  
	//---------------------------------------------------------------------------------------------------
	  
 //---------------------------------Pagination function start------------------------------------------
	  
	  $scope.paginate = function(nextPrevMultiplier) 
	    {
	    	$scope.selectallmanifests=false;
	    	$scope.currentPage += (nextPrevMultiplier * 1);
	    	self.Filtermanifests = self.manifests.slice($scope.currentPage*$scope.pageSize);
	    	
	    	console.log(self.Filtermanifests.length);
	    	
	    	if(self.Filtermanifests.length == 0) {
	    		BranchService.pagination_byPage($scope.currentPage)
	    		.then(
	    				function (filterManifest) {
	    					
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
	    	
	    	if(self.Filtermanifests.length < $scope.pageSize) {
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

//----------------------------------------------------------------------------------------------------
	  
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
	    
	//----------------------------------------------------------------------------------  
	
	
	  
 //=================================MANIFEST DETAILED PAGE ALL FUNCTION START===============================

	  
  //--------------------------------------Open Manifest Detailed view Start----------------------------
  
  function manifestDetailed(manifest_id)
  {
	  console.log('Contoller: Manifest detailed call !')
	  ManifestService.manifestDetailed(manifest_id)
	  .then(
			  function(manifestdetailed)
			  {
				  self.FilterManifestdetailed=manifestdetailed;
				  console.log(self.FilterManifestdetailed)
			  },
			  function(errResponse)
			  {
				  console.log('Error while Manifest detailed get')
			  }
		 );

  }
 //--------------------------------------------------------------------------------------------------
	  
//--------------------------Manifest Detailed Select All check box function start------------------
	  
	  function manifestDetailedSelectAll()
	  {
		  console.log('Call select all Manifest Detailed'+$scope.pageSize)
		  self.selected_manifestdetailed=[];
		  for(var i=0; i<$scope.pageSize; i++)
		  {
			  self.FilterManifestdetailed[i].select=$scope.selectallmanifestdetailed;
			  if($scope.selectallmanifestdetailed)
				  {
				  	 self.selected_manifestdetailed.push(self.FilterManifestdetailed[i]);
				  }
		  }
	  }
	  //--------------------------------------------------------------------------------------------
	  
	  //---------------------Manifest Detailed Record select on Register start-----------------------
	  
	  function manifestDetailedSelect(manifestdetailed)
	  {
		  console.log('Call Manifest Detailed select all function')
		  var index=self.selected_manifestdetailed.indexOf(manifestdetailed);
		  if(manifestdetailed.select)
			  {
			  	self.selected_manifestdetailed.push(manifestdetailed);
			  }
		  else
			  {
			  	//$scope.selectallmanifests=false;
			  	self.selected_manifestdetailed.splice(index,1);
			  }
	  }
	  
	  //--------------------------------------------------------------------------------------------
	  
	 
	  
	  
	  
	  //=================================MANIFEST DETAILED PAGE ALL FUNCTION END===============================
	}
	]);