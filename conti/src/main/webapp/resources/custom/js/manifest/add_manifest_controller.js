/**
 * @Project_Name conti
 * @Package_Name resources/custom/js
 * @File_name add_manifest.js
 * @author Monu.c
 * @Created_date_time aug 9, 2017 4:20:17 PM
 * @Updated_date_time aug 9, 2017 4:20:17 PM
 * 
 */

//======================================function to do after save======================================
	function afterSave(id){
			valid = true;
			window.open("ManifestPdfPrint/"+id);
			//location.href="ManifestPdfPrint/"+id;
		}
	
	
	
angular.module('contiApp').controller('addManifestController',['$scope','BranchService','addManifestService','ConfirmDialogService',
	function($scope,BranchService,addManifestService,ConfirmDialogService){

	
	var self=this;
	$scope.shownoofrec = 10;
	self.branches = [];
	self.viewShipment=viewShipment;
	self.Manifests=[];
	self.FilteredManifests=[];
	self.selectedManifest=[];
	
	self.fromBranch="";
	self.toBranch="";
	self.status="";
	self.registerSearch=registerSearch;
	self.selectManifest=selectManifest;
	self.selectAll=selectAll;
	self.clearModalValue=clearModalValue;
	self.submitManifest=submitManifest;
	self.pad=pad;
	self.checkOriginAndDestination=checkOriginAndDestination;


	
	self.manifest={
		  "manifest_id": null,
		  "updated_by": null,
		  "created_by": null,
		  "manifest_number": null,
		  "vehicle_number": null,
		  "driver_name":null,
		  "manifest_status": null,
		  "obsolete": null,
		  "created_datetime": null,
		  "updated_datetime": null,
		  "manifestDetailModel":[{
			  "manifestdetailed_id":null,
			  "shipmentModel":null
		  }],
		  "branchModel1": null,
		  "branchModel2": null,
		  "vehicle_destination":null
		}
	
	self.manifestDetailModel= {
		  "manifestdetailed_id":null,
		  "shipmentModel":null
	  };
	

	
	
	
	function submitManifest(){
		console.log(self.manifest);
		$('#myModal').css('z-index','1039');
		
		
		ConfirmDialogService.confirmBox("Save",
				BootstrapDialog.TYPE_SUCCESS, "Save Manifest  ..?", 'btn-success')
		.then(
				function(response){

					for(var i=0;i<self.selectedManifest.length;i++){
						
						self.manifest.manifestDetailModel[i].shipmentModel=self.selectedManifest[i];
						console.log("lr",self.manifest.manifestDetailModel[i].shipmentModel.lr_number);
					
						if(i<self.selectedManifest.length-1){
							self.manifest.manifestDetailModel.push({
								  "manifestdetailed_id":null,
								  "shipmentModel":null
							  });
						}					
					}

					console.log("result",self.manifest);
					//self.manifest.manifestDetailModel.shipmentModel=self.selectedManifest;
					self.manifest.branchModel1=JSON.parse(self.manifest.branchModel1);
					self.manifest.branchModel2=JSON.parse(self.manifest.branchModel2);

					addManifestService.saveManifest(self.manifest)
					.then(	
							function (response) {	

								console.log(response);
								console.log('save success');
								self.message = "Manifest ( "+response.ManifestNo+" ) Created Successfully..! ";
								successAnimate('.success');	
								setTimeout(function(){afterSave(response.ManifestId);}, 3800);
								setTimeout(function(){ location.reload(); }, 4000);	
								//save and view manifest number
							}, 
							function (errResponse) {
								console.log('Error while saving record');
								self.message = "Error While Creating Manifest ..!";
								successAnimate('.failure');
								setTimeout(function(){ location.reload(); }, 4000);	
							});
					
		},function(errResponse){
			$('#myModal').css('z-index','1050');
		});
	}
	//===================================select all====================================
	function selectAll(){

		self.selectedManifest=[];
		
		var size;
		
		if($scope.pageSize>self.FilteredManifests.length){
			size=self.FilteredManifests.length;
		}else{
			size=$scope.pageSize;
		}
		
		
		for(var i=0;i<size;i++){
			self.FilteredManifests[i].select=self.selectAllManifest;
			if(self.selectAllManifest){
				self.selectedManifest.push(self.FilteredManifests[i]);
			}
		}		
		console.log(self.selectedManifest);
	}
	
	
	//===================================select all====================================
	function checkOriginAndDestination(){
		
		clearModalValue();
		
		var origin=true,destination=true;
		
		for(var i=0;i<self.selectedManifest.length;i++){
			if(self.selectedManifest[0].sender_branch.branch_name !=self.selectedManifest[i].sender_branch.branch_name){
				origin=false;
			}
			if(self.selectedManifest[0].consignee_branch.branch_name !=self.selectedManifest[i].consignee_branch.branch_name){
				destination=false;
			}
		}	
		showMessageOriginDestination(origin,destination,self.selectedManifest[0].sender_branch, self.selectedManifest[0].consignee_branch);	
	}
	
	function showMessageOriginDestination(x,y,origin_id,destination_id){
		var msg="";
		
		if(x==false && y==false){
			msg="Both Origin And Destination Are Different." + "<br/>" +"Please Select Same Origin And Destination."
		}else if(x==false ){
			msg="Please Select Same Origin."
		}else if(y==false){
			msg="Please Select Same  Destination."
		}else{	
			$('#myModal').modal('show');
			self.manifest.branchModel1=JSON.stringify(origin_id);
			self.manifest.branchModel2=JSON.stringify(destination_id);	
		}
		
		if(msg.trim().length!=0){
			BootstrapDialog.alert({	
				title:' Manifest Alert',
				message: msg,
				type: BootstrapDialog.TYPE_DANGER, // <-- Default value is BootstrapDialog.TYPE_PRIMARY
				closable: false, 
				draggable: false});
			self.selectAllManifest=false;
			selectAll();
		}	
	}
	
	function resetSorting(){
		$scope.lrno = false;
		$scope.origin = false;
		$scope.destination = false;
		$scope.sender = false;
		$scope.consignee = false;
		$scope.totalParcel = false;
		$scope.weight = false;
		$scope.service = false;
		$scope.date = false;
		$scope.status = false;
	}
	// ===================================sort table====================================
	$scope.sortTable=function(x,status){
		console.log("filer by---"+x,"status---"+status);
		if(!$scope.disableSorting){
			$scope.lastSorted = x;	
			resetSorting();
			$scope[x]=status;
			addManifestService.sortBy(x,status?"ASC":"DESC")
			.then(
					function(response){
						self.Manifests=response;
						self.FilteredManifests=response;
					},function(errRespone){
						console.log("error while fetching shipment in search"+errRespone);
					});	
		}

	}
	//===================================ClearModalValue====================================
	function clearModalValue(){
		/*$scope.emp_name.originalObject=null;
		$scope.vehicle_type.originalObject=null;
		$scope.branch_name.originalObject=null;*/
		
		/*$scope.emp_name=null;
		$scope.vehicle_type=null;
		$scope.branch_name=null;*/


		self.manifest.driver_name=null;
		self.manifest.vehicle_number=null;
		self.manifest.vehicle_destination=null;


		$scope.$broadcast('angucomplete-alt:clearInput','vehicleDestinationBranch');
		$scope.$broadcast('angucomplete-alt:clearInput','vehicle_type');
		$scope.$broadcast('angucomplete-alt:clearInput','driver_name');


		$('#driver_name_value').val("");
		$('#vehicle_type_value').val("");
		$('#vehicleDestinationBranch_value').val("");
		
	}
	
	//===================================select Manifest====================================
	function selectManifest(x){
		console.log(x);
		if(x.select){
			self.selectedManifest.push(x);	
		}else{
			self.selectAllManifest=x.select;
			var index=self.selectedManifest.indexOf(x);
			self.selectedManifest.splice(index,1);
		}
		console.log(self.selectedManifest);
	}
	//===================================SEARCH REGISTER====================================
	function registerSearch(searchString){	
		//console.log(searchString);
		if(searchString.length==0){			
			self.FilteredManifests=self.Manifests;
		}else if(searchString.length>3){
			addManifestService.searchLRShipment(searchString)
			.then(
					function (response) {	
						self.FilteredManifests=response;
					}, 
					function (errResponse) {
						console.log('Error while fetching record  using lr');
					});
		
		}else{
			self.FilteredManifests=_.filter(self.Manifests,function(item){
				return String(item.lrno_prefix).indexOf(searchString) > -1;
			});
		}
	}
	
	//===================================first last login page====================================
	$scope.firstlastPaginate = function (page) {
		
		
		self.selectAllManifest=false;
		
		if(page==1){	
    		$scope.currentPage = 0;
    		$scope.previouseDisabled = true;
    		$scope.nextDisabled = false;
    		self.FilteredManifests=self.Manifests.slice($scope.currentPage*$scope.pageSize);
		}else{	
/*    		$scope.currentPage = ((Math.ceil(self.FilteredManifests.length/$scope.pageSize)) - 1);
    		$scope.previouseDisabled = false;	
    		$scope.nextDisabled = true;
			self.FilteredManifests=self.Manifests.slice($scope.currentPage*$scope.pageSize);
			console.log(self.FilteredManifests.length);
		if(self.FilteredManifests.length==0){
*/
			
			
			addManifestService.paginateFirstOrLast(page)
			.then(
					function(response){
						self.FilteredManifests=response;
			    		$scope.nextDisabled = true;
			    		$scope.previouseDisabled = false;			    		
			    		$scope.currentPage = ((Math.ceil($scope.totalnof_records/$scope.pageSize)) - 1);
						console.log(response);
					},function(errRespone){
						console.log("error while fetching Manifest in search"+errRespone);
					});
		/*}*/
		
			$scope.disableSorting=  ($scope.currentPage > 0) ?true:false;
			
		}
	}
	
	  //===================================next and previous page====================================  
    $scope.paginate=function(nextPrevMultiplier){
    	self.selectAllManifest=false;
    	$scope.currentPage += (nextPrevMultiplier * 1);
    	self.FilteredManifests=self.Manifests.slice($scope.currentPage*$scope.pageSize);
    	
    	
    	if(self.FilteredManifests.length==0){
    		addManifestService.paginateFirstOrLast($scope.currentPage)
			.then(
					function(response){
						if(response.length == 0){
						    $scope.paginate(-1);
							$scope.nextDisabled = true;
						}else if(response.length < 10 ){
							self.FilteredManifests = response;
							$scope.nextDisabled = true;
						}else{
							self.FilteredManifests = response;							
						}
					},function(errRespone){
						console.log("error while fetching Manifest in search"+errRespone);
					});
    	}
    	
    	if(self.FilteredManifests.length<$scope.pageSize)
		{
			$scope.nextDisabled=true;
		}
    	
    	$scope.disableSorting=  ($scope.currentPage > 0) ?true:false;
    	
    	if($scope.currentPage == 0) {
    		$scope.previouseDisabled = true;
    	}
    	
    	if(nextPrevMultiplier == -1) {    		
    		$scope.nextDisabled = false;
    	} else {
    		$scope.previouseDisabled = false;
    	}
    	
    }
    
	//===================================GET USER BRANCH DETAILS====================================
	getUserBranchDetails();
	
	function getUserBranchDetails() {				
		addManifestService.getUserBranchDetails()
		.then(
				function (response) {					
					console.log(response);
					$scope.branch_name=response.branch_name;
					self.manifest.branchModel1=JSON.stringify(response);
					
				}, 
				function (errResponse) {
					console.log(errResponse);
					console.log('Error while fetching user branch');
				});
	}

	//===================================Total Record Count====================================
	fetchLastManifestNo();
	
	function fetchLastManifestNo() {				
		addManifestService.fetchLastManifestNo()
		.then(
				function (response) {					
					$scope.lastManifestNumber=response;
					console.log($scope.lastManifestNumber);
				}, 
				function (errResponse) {
					console.log(errResponse);
					console.log('Error while fetching last man no');
				});
	}
	
	
	function pad(num, size) {
	    var s = num+"";
	    while (s.length < size) s = "0" + s;
	    return s;
	}
	
	
	//===================================fetch ALL BRANCH====================================	
	fetchAllBranches();	
	
	function fetchAllBranches() 
	{
		BranchService.fetchAllBranchesForManifest()
			.then(
					function (response) 
					{
						console.log(response);
						self.branches = response;
					}, 
					function (errResponse) {
						console.log('Error while fetching branches');
					}
				);
	}
	
	//===================================fetch Address====================================
    self.shownoofRecord=function shownoofRecord() {    
    	
    	$scope.pageSize = $scope.shownoofrec;
    	
    	self.FilteredManifests=self.Manifests.slice($scope.currentPage*$scope.pageSize);
    	if( self.FilteredManifests.length < $scope.pageSize ) {
    		$scope.previouseDisabled = true;
    		$scope.nextDisabled = true;
    	}else{
    		$scope.nextDisabled=false;
    	}
    	fetchAllShipment();
    }
	
	
	//===================================fetch Address====================================
	fetchAllShipment();
	
	function fetchAllShipment(){
		addManifestService.fetchAllShipment()
		.then(function(response){
			self.Manifests=response;
			self.FilteredManifests=response;
			pagination();
			console.log(self.Manifests);
		},
		function(errResponse){
			console.log("error fetching all shipment");					
		});
	}
	
	//===================================fetch Address====================================

	//===================================pagination====================================
    function pagination() {
    	

    	$scope.pageSize = $scope.shownoofrec;
		$scope.currentPage = 0;
		$scope.totalPages = 0;	
		$scope.previouseDisabled = true;	
		$scope.nextDisabled = false;	
		
		if(self.FilteredManifests.length<=10){
			$scope.nextDisabled = true;			
		}

		if(self.FilteredManifests.length<100){
			$scope.totalnof_records = self.FilteredManifests.length;
		}else{
			findrecord_count();
		}
    }
    //===================================Total Record Count====================================
	function findrecord_count() {				
		addManifestService.findrecord_count()
		.then(
				function (record_count) {
					console.log(record_count);
					$scope.totalnof_records  = record_count;
				}, 
				function (errResponse) {
					console.log('Error while fetching record count');
				});
	}
	
    //===================================filter and view shipment====================================
	function viewShipment(){		
		if(self.manifest.branchModel1==null || typeof self.manifest.branchModel1== undefined)
		self.fromBranch="";
		if(self.manifest.branchModel2==null || typeof self.manifest.branchModel2 == undefined)
		self.toBranch="";
		console.log(self.manifest.manifest_status==null);
		if(self.manifest.manifest_status==null || typeof self.manifest.manifest_status == undefined)
		self.manifest.manifest_status="";

		
		var filter={
				"fromBranch":(self.manifest.branchModel1!=null && self.manifest.branchModel1.trim().length!=0 )? JSON.parse(self.manifest.branchModel1).branch_id:"",
				"toBranch":(self.manifest.branchModel2!=null && self.manifest.branchModel2.trim().length!=0)? JSON.parse(self.manifest.branchModel2).branch_id:"" ,
				"fromDate":$(".datepicker1").val(),
				"toDate":$(".datepicker2").val(),
				"status":self.manifest.manifest_status
				}
		
		
		

		console.log(filter);
		
		addManifestService.filterManifest(filter)
		.then(
				function(response){
					self.FilteredManifests=response;
					$scope.totalnof_records  =self.FilteredManifests.length;
					console.log(response);
				},function(errResponse){
					console.log("error while fetching manifest in filter"+errResponse);
				});
		}
	
	
}]);