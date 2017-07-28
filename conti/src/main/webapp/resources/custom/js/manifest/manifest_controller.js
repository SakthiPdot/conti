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
		self.heading="Master";
		self.message=null;
//		self.submit=submit;
		self.save='saveclose'
		self.close=close;
		//self.clear=clear;
		
		
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

	}
	]);