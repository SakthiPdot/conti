/**
 * @Project_Name conti
 * @Package_Name custom js Manifest
 * @File_name manifest_controller.js
 * @author Suresh
 * @Updated_user Suresh
  @Created_date_time July 24, 2017 3:31:53 PM
 * @Updated_date_time July 24, 2017 3:31:53 PM
 */
contiApp.controller('ManifestController',['$scope','$http','$q','$timeout','$window','ManifestService','ConfirmDialogService',function($scope,$http,$q,$timeout,$window,$ManifestService,ConfirmDialogService)
	{
		var self=thid;
		self.manifests=[];
		self.Filtermanifest=[];
		self.manifest={};
		self.heading="Master";
		self.message=null;
		self.submit=submit;
		self.save='saveclose'
		self.close=close;
		self.clear=clear;
		fetchAllManifest();
		
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
		
		
		
	}
	]);