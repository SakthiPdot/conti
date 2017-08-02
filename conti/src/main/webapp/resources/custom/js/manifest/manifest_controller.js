/**
 * @Project_Name conti
 * @Package_Name custom js Manifest
 * @File_name manifest_controller.js
 * @author Suresh
 * @Updated_user Suresh
  @Created_date_time July 24, 2017 3:31:53 PM
 * @Updated_date_time July 24, 2017 3:31:53 PM
 */
contiApp.controller('ManifestController',['$scope','$http','$q','$timeout','ManifestService','BranchService','ConfirmDialogService',function($scope,$http,$q,$timeout,ManifestService,BranchService,ConfirmDialogService)
	{
		var self=this;
		self.manifests=[];
		self.Filtermanifests=[];
		self.branches=[];
		self.manifest={};
		self.manifest1={};
		self.heading="Master";
		self.message=null;
		self.print = print;
		//self.submit=submit;
		self.save='saveclose'
		self.close=close;
		self.manifestFilter=manifestFilter;
		self.inwardManifest=inwardManifest;
		self.outwardManifest=outwardManifest;
		self.manifestSearch=manifestSearch;
		self.FilterManifestdetailed=FilterManifestDetailed;
		self.manifestDetailed=manifestDetailed;
		
		fetchAllManifest();
		fetchAllBranches();
		function reset()
		{
			self.manifest={};
			self.heading='Master';
			fetchAllManifest();
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
		
		//---------------------Customer Master drawer close end-----------
		
		
		//-------------------------- Fetch All Branch begin ---------------------//	
		
		function fetchAllBranches() {
			console.log("get all branches")
			BranchService.fetchAllBranches()
				.then(
						function (branches) {
							self.branches = branches;
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
							//pagination();
						}, 
						function (errResponse) {
							console.log('Error while fetching manifest');
						}
					);
		}
		//-------------------------- Fetch All Manifest records end  ---------------------//
		
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
	    
	    //-------------------------------------- Print end -----------------------------//
	    
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
	    //------------------------- View Manifest Filter function start ------------------//       
	    
	    
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
	  
	//-------------------------------------Register Manifest Search End-------------------------------------------

	  
	//--------------------------------------Open Manifest Detailed view Start----------------------------
	  
	  function manifestDetailed(manifest_id)
	  {
		  console.log('Contoller: Manifest detailed call')
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
	  
	}
	]);