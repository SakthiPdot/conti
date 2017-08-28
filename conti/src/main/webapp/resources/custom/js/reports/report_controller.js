

contiApp.controller('ReportController',['$scope','$http','$q','$timeout','BranchService','ConfirmDialogService',function($scope,$http,$q,$timeout,BranchService,ConfirmDialogService)
	{
		var self = this;
		self.report = [];
		self.branches = [];
		
		fetchAllBranches();
		
		
		
		
	
	//============ Fetch All Branches Function Begin =======//	
		function fetchAllBranches() {
			
			BranchService.fetchAllBranches()
				.then(
							function (branches) {
								self.branches = branches;
							
							},
							function(errResponse) {
								console.log('Error while fetching branches');
							}
					  );
		}
	//=========== Fetch All Branches Function End ===========//
	}
	]);