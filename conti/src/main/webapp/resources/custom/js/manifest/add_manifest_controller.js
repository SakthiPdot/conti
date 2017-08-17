/**
 * @Project_Name conti
 * @Package_Name resources/custom/js
 * @File_name add_manifest.js
 * @author Monu.c
 * @Created_date_time aug 9, 2017 4:20:17 PM
 * @Updated_date_time aug 9, 2017 4:20:17 PM
 * 
 */
angular.module('contiApp').controller('addManifestController',['$scope','BranchService','addManifestService','ConfirmDialogService',
	function($scope,BranchService,addManifestService,ConfirmDialogService){

	
	var self=this;
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
								console.log('save success');
							}, 
							function (errResponse) {
								console.log('Error while saving record');
							});
		},function(errResponse){
			$('#myModal').css('z-index','1050');
		});
	}
	//===================================select all====================================
	function selectAll(){

		self.selectedManifest=[];
		var size=10;
		
		for(var i=0;i<size;i++){
			self.FilteredManifests[i].select=self.selectAllManifest;
			if(self.selectAllManifest){
				self.selectedManifest.push(self.FilteredManifests[i]);
			}
		}	
		
		console.log(self.selectedManifest);
	}
	
	//===================================ClearModalValue====================================
	function clearModalValue(){
		$scope.emp_name.originalObject=null;
		$scope.vehicle_type.originalObject=null;
		$scope.branch_name.originalObject=null;
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
				return String(item.lr_number).indexOf(searchString) > -1;
			});
		}
	}

	//===================================Total Record Count====================================
	fetchLastManifestNo();
	
	function fetchLastManifestNo() {				
		addManifestService.fetchLastManifestNo()
		.then(
				function (response) {					
					$scope.lastManifestNumber=pad(response,4);
					console.log($scope.lastManifestNumber);
				}, 
				function (errResponse) {
					console.log('Error while fetching record count');
				});
	}
	
	
	function pad(num, size) {
	    var s = num+"";
	    while (s.length < size) s = "0" + s;
	    return s;
	}
	
	
	//===================================fetch Address====================================	
	fetchAllBranches();	
	
	function fetchAllBranches() 
	{
		BranchService.fetchAllBranches()
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
	fetchAllShipment();
	
	function fetchAllShipment(){
		addManifestService.fetchAllShipment()
		.then(function(response){
			self.Manifests=response;
			self.FilteredManifests=response;
			// pagination();
			console.log(self.Manifests);
		},
		function(errResponse){
			console.log("error fetching all shipment");					
		});
	}
	
	//===================================fetch Address====================================

	
	function viewShipment(){
		
		if(self.manifest.branchModel1==null || typeof self.manifest.branchModel1== undefined)
		self.fromBranch="";
		if(self.manifest.branchModel2==null || typeof self.manifest.branchModel2 == undefined)
		self.toBranch="";
		if(self.manifest.manifest_status==null || typeof self.manifest.manifest_status == undefined)
		self.status="";
		
		var filter={
				"fromBranch":JSON.parse(self.manifest.branchModel1).branch_id,
				"toBranch":JSON.parse(self.manifest.branchModel2).branch_id,
				"fromDate":$(".datepicker1").val(),
				"toDate":$(".datepicker2").val(),
				"status":self.manifest.manifest_status
				}
		
		
		
		console.log(filter);
		
		addManifestService.filterManifest(filter)
		.then(
				function(response){
					self.FilteredManifests=response;
					console.log(response);
				},function(errResponse){
					console.log("error while fetching manifest in filter"+errResponse);
				});
		

		}
	
	
}]);