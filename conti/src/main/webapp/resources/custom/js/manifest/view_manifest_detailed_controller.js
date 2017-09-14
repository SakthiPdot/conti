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
		self.selected_manifest=[];
		self.manifest={};
		self.manifest1={};
		self.heading="Master";
		self.message=null;
		self.print = print;
		self.manifestDetailedSelectAll=manifestDetailedSelectAll;
		self.manifestSelect=manifestSelect;
		self.save='saveclose'
		self.close=close;
		self.shownoofRecord=shownoofRecord;
		self.manifestDetailed=manifestDetailed;
		self.registerSearch=registerSearch;
		self.makeMissing=makeMissing;
		self.makeReceived=makeReceived;
		self.shipment = {}; // for individual view shipment
		$scope.shownoofrec=10;
		
		self.manifestId=$('#manifest_id').val(); 
		var manifest_id=$('#manifest_id').val();
		var branch_flag=$('#branch_flag').val();
		var authen_flag=$('#authen_flag').val();//for identify the Manager and Staff role
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
		
		
		 //------------------------------------- VIEW SHIPEMNT INDUVIDUAL OPEN BEGIN
		 
		 self.view1Shipmet = function (shipment) {
			self.shipment = shipment;
			
			 viewShipment_Animate('.shipment_View', 'OPEN');
		 }
		 
		 //------------------------------------- VIEW SHIPEMNT INDUVIDUAL OPEN END
		//------------------------------------- VIEW SHIPEMNT INDUVIDUAL CLOSE BEGIN
		 
		 self.viewShipemntClose = function () {
			 viewShipment_Animate('.shipment_View', 'CLOSE');
		 }
		 
		 //------------------------------------- VIEW SHIPEMNT INDUVIDUAL CLOSE END
		 
		//------------------------------------- SHIPEMNT PRINT BEGIN
		 self.shipmentPrint = function (shipment) {
			 bill_open(shipment.shipment_id);
		 }
		 //------------------------------------- SHIPEMNT PRINT END
		
		//------------------------------------- Manifest PRINT BEGIN
		 self.manifestPrint = function (manifest_id) {
			 afterManifestSave(manifest_id);
		 }
		 //------------------------------------- Manifest PRINT END
		 
		//------------------------------------- Manifest(LR Print) PRINT BEGIN
		 self.shipmentPrint = function (manifest_id) {
			 afterManifestSave(manifest_id);
		 }
		 //------------------------------------- 
		 
		//---------------------Branch Master drawer close begin-----------
		
		function close(title){
			ConfirmDialogService.confirmBox(title,
					BootstrapDialog.TYPE_WARNING, title+" Without Save ..? ", 'btn-warning')
			.then(function(response){
				 drawerClose('.drawer');
					reset();
			});
		}
		
	//------------------------------------------------------------------------------------------	
		
		function newOrClose(){
			console.log(self.save);				
			if(self.save== "saveclose" ){
				 drawerClose('.drawer') ;
			}
			reset();
		}
		
	//------------------------Branch Master drawer field clear begin--------------------------------
		function clear() 
		{
			self.confirm_title = 'Clear';
			self.confirm_type = BootstrapDialog.TYPE_WARNING;
			self.confirm_msg = self.confirm_title+ ' the data?';
			self.confirm_btnclass = 'btn-warning';
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(function (res) {
			 	        	reset();
			 	        }
				);
		}
	//---------------------Customer Master drawer close begin-----------
	function manifestDetailed(manifest_id){
		  console.log('Detailed Contoller: Manifest detailed call....!')
		  ManifestService.manifestDetailed(manifest_id)
		  .then( function(manifestdetailed) {
			  		self.manifests = manifestdetailed;
					  self.Filtermanifests=self.manifests;
					  console.log(self.Filtermanifests)
					 pagination();
				  },
				  function(errResponse){
					  console.log('Error while Manifest detailed get')
				  });
	  }
		  

	 //--------------------------Manifest Select All check box function start------------------
	  
	  function manifestDetailedSelectAll(){
		  console.log('Call select all Manifest '+ $scope.pageSize);
		  self.selected_manifest=[];
		  for(var i=0; i<$scope.pageSize; i++){
			  self.Filtermanifests[i].select=$scope.selectallmanifests;
			  if($scope.selectallmanifests)
			  {
			  	 self.selected_manifest.push(self.Filtermanifests[i]);
			  }
		  }
	  }
	   
	  //---------------------Manifest Record select on Register start-----------------------
	  
	  function manifestSelect(manifest){
		  console.log('Call Manifest select all function')
		  var index=self.selected_manifest.indexOf(manifest);
		  if(manifest.select){
			  	self.selected_manifest.push(manifest);
		  }else{
			  	self.selected_manifest.splice(index,1);
		  }
	  }
	  
	//---------------------Show no of record in Manifest Register---------------------------
	
	  function shownoofRecord(){
		  $scope.pageSize=$scope.shownoofrec;
		  console.log("Page size : "+ $scope.pageSize+ " length :"+self.Filtermanifests.length);
		  self.Filtermanifests=self.manifests.slice($scope.currentPage*$scope.pageSize);
		  console.log("Page size : "+ $scope.pageSize+ " length :"+self.Filtermanifests.length);
		  if(self.Filtermanifests.length<=$scope.pageSize){
			  $scope.previousDisabled=true;
			  $scope.nextDisabled=true;
		  }else{
			  $scope.nextDisabled=false;
		  }
	  }
	  
	//----------------------------------- Record Count begin -----------------------------//
		
		function findrecord_count(){
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
	   
	//-------------------------------------Manifest Pagination---------------------------------  
	  function pagination(){
		  console.log('Pagination function call successfully..........');
	        $scope.pageSize = $scope.shownoofrec;
	    	//console.log($scope.pageSize);
	    	console.log('Pagination function call successfully..........'+$scope.pageSize);
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
				console.log(self.Filtermanifests.length);
			
			} else {
				findrecord_count();
			}
						
	    }
	  
		  
	  $scope.paginate = function(nextPrevMultiplier)  {
	    	$scope.selectallmanifests=false;
	    	$scope.currentPage += (nextPrevMultiplier * 1);
	    	self.Filtermanifests = self.manifests.slice($scope.currentPage*$scope.pageSize);
	    	if(self.Filtermanifests.length == 0) {
	    		BranchService.pagination_byPage($scope.currentPage)
	    		.then(function (filterManifest) {
	    					if ( filterManifest.length == 0 ) {
	    						$scope.nextDisabled = true;
	    					} else if ( filterManifest.length < 5 ) {
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
	    	
	    	if(self.Filtermanifests.length <= $scope.pageSize) {
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
	  
	  $scope.firstlastPaginate = function (page){
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
	    		{BranchService.pagination_byPage(page)
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
	  
  //------------------------------------Manifest Detailed Search LR Number---------------------------//
  
	  function registerSearch(searchkey){
		  console.log(searchkey);
		  if(searchkey.length==0){
			  self.Filtermanifests=self.manifests;
		  }else if(searchkey.length>3){
			  ManifestService.registerSearch(searchkey)
			  .then(function(filtermanifest){
					  self.Filtermanifests=filtermanifest;
					  console.log(filtermanifest);
					  //pagination();
			  },
			  function (errRes){
				  console.log('Error while Searching LR Number....');
			  }
			  );
			  
		  }else{
			  self.Filtermanifests=_.filter(self.manifests,
			  function(item){
			  return searchUtil(item,searchkey);
			  
			  });
		  }
	  }
	 
	  function searchUtil(item,toSearch)
		{
			var success = false;
			
			if ( (item.shipmentModel.created_datetime.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.shipmentModel.sender_branch.branch_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
			      || (item.shipmentModel.consignee_branch.branch_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.shipmentModel.sender_customer.customer_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
				  || (item.shipmentModel.consignee_customer.customer_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) || (item.shipmentModel.status.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
				  || (item.shipmentModel.lrno_prefix.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) )
					
			{
				success = true;
			} else {
				success = false;
			}
			
			return success;
		}
	


//-------------------------- Batch action Missing Process begin ----------------------//
 function makeMissing(){
	 console.log('call makeMissing function....' +authen_flag);
	 console.log(self.selected_manifest);
	if(self.selected_manifest.length == 0 ) {
   		self.message ="Please select atleast one record..!";
		successAnimate('.failure');
	} else {
		var activate_flag = 0;
		var Missing_flag=0;
		angular.forEach(self.selected_manifest, function(manifest){
			if(manifest.shipmentModel.status== 'Missing') {
				activate_flag = 1;
			} 
			if(manifest.shipmentModel.status=='Intransit' || manifest.shipmentModel.status=='Missing'){
				Missing_flag=1;
			}
		});
		if(branch_flag=='false' && authen_flag=='MANAGER_OR_STAFF')
		{
			self.message ="Origin branch only perform Missing action..!";
			successAnimate('.failure');
		}
		else if(activate_flag == 1) {
			self.message ="Selected record(s) already in Missing status..!";
			successAnimate('.failure');
		} 
		else if(Missing_flag == 0) {
			self.message ="Allowed only Intransit or Missing status LR(s)...!";
			successAnimate('.failure');
		}else {
			self.confirm_title = 'Missing';
			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
			self.confirm_msg = ' make selected record(s) status as '+self.confirm_title+ '?';
			self.confirm_btnclass = 'btn-success';
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(function (res) {
						var active_id = [];
		    			for(var i=0; i<self.selected_manifest.length; i++) {
		    				active_id[i] = self.selected_manifest[i].manifestdetailed_id; 
		    				console.log(active_id[i] );
		    			}
						ManifestService.makeMissing(active_id)
						.then(function(response) 
							{
								manifestDetailed(manifest_id);
								self.selected_manifest = [];
								self.message ="Selected record(s) has in Missing status..!";
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


//-------------------------- Make Received begin ----------------------//
function makeReceived(){
	//var authen_flag=$('#authen_flag').val();
	if(self.selected_manifest.length == 0 ) {
   		self.message ="Please select atleast one record..!";
		successAnimate('.failure');
	} else {
		var inactivate_flag = 0;
		var received_flag=0;
		angular.forEach(self.selected_manifest, function(manifest){
			if(manifest.shipmentModel.status== 'Received') {
				inactivate_flag = 1;
			} 
			if(manifest.shipmentModel.status=='Intransit' || manifest.shipmentModel.status=='Missing'){
				received_flag=1;
			}
		});
		
		if(branch_flag=='false' && authen_flag=='MANAGER_OR_STAFF')
		{
			self.message ="Origin branch only perform Received action..!";
			successAnimate('.failure');
		}
		else if(inactivate_flag == 1) {
			self.message ="Selected record(s) already in Received status..!";
			successAnimate('.failure');
		}
		else if(received_flag==0) {
			self.message ="Allowed only Intransit or Missing status LR(s)...!";
			successAnimate('.failure');
		}
		else {
			
			self.confirm_title = 'Received';
			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
			self.confirm_msg = ' make selected record(s) status as '+self.confirm_title+ '?';
			self.confirm_btnclass = 'btn-success';
			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(
				function (res) {
					var inactive_id = [];
	    			for(var i=0; i<self.selected_manifest.length; i++) {
	    				inactive_id[i] = self.selected_manifest[i].manifestdetailed_id;        				
	    			}
					ManifestService.makeReceived(inactive_id)
					.then(
							function(response) {
								manifestDetailed(manifest_id);
								self.selected_manifest = [];
								self.message ="Selected record(s) has in Received status..!";
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
//-----------------------------------------------------------------------------------------------------//   
}
	]);