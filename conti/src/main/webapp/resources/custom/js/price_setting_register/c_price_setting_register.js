/**
 * @Project_Name conti
 * @Package_Name resources/custom/js
 * @File_name c_price_setting_register.js
 * @author Monu.c
 * @Created_date_time Jul 28, 2017 9:20:17 PM
 * @Updated_date_time Jul 28, 2017 9:20:17 PM
 */

	function editPS(id){
				window.location.href="price_settings?id="+id;
				valid = true;	
			}
			
angular.module('contiApp').controller('priceSettingRegisterController',
		['$scope','$timeout','priceSettingRegisterService','ConfirmDialogService',
			function($scope,$timeout,priceSettingRegisterService,ConfirmDialogService){
			
			
			$scope.shownoofrec = 10;
			
			var self=this;
			self.fetchAllPriceSetting=fetchAllPriceSetting;
			self.selectPriceSetting=selectPriceSetting;
			self.selectAll=selectAll;
			self.makeActive=makeActive;
			self.makeInActive=makeInActive;
			self.editPS=editPS;
			self.registerSearch=registerSearch;
			
			self.filteredPriceSetting=[];
			self.selectedPriceSetting=[];
			self.priceSettingBackUp=[];
			
			
			
			function resetSorting(){
				$scope.FromBranch  = false;
				$scope.serviceName  = false;
				$scope.productName  = false;
				$scope.productType  = false;
				$scope.defaultPrice  = false;
				$scope.defaultHandlingCharges  = false;
				$scope.psActive= false;
			}
			// ===================================sort table====================================
			$scope.sortTable=function(x,status){
				console.log("filer by---"+x,"status---"+status);
				if(!$scope.disableSorting){
					$scope.lastSorted = x;	
					resetSorting();
					$scope[x]=status;
					priceSettingRegisterService.sortBy(x,status?"ASC":"DESC")
					.then(
							function(response){
								self.filteredPriceSetting=response;
								self.priceSettingBackUp=response;
							},function(errRespone){
								console.log("error while fetching price Setting in search"+errResponse);
							});
				}
			}
			//===================================edit price setting====================================
			$scope.editPS=function(x){
				 editPS(x)
			}
			
		/*	function editPS(id){
				window.location.href="price_settings?id="+id;
			}*/
			//===================================next and previous page====================================  
		    $scope.paginate=function(nextPrevMultiplier){
		    	self.selectAllPriceSetting=false;	
		    	$scope.currentPage += (nextPrevMultiplier * 1);		    	
		    	self.filteredPriceSetting = self.priceSettingBackUp.slice($scope.currentPage*$scope.pageSize);
		    	
		    	if(self.filteredPriceSetting.length == 0) {
		    		priceSettingRegisterService.paginateFirstOrLast($scope.currentPage)	
		    		.then(function (response) {
						console.log(response);
						if ( response.length == 0 ) {
							$scope.nextDisabled = true;
						} else if ( response.length < 10 ) {
							self.filteredPriceSetting = response;
							$scope.nextDisabled = true;
						} else {
							self.filteredPriceSetting = response;
						}
		    		}, 
					function (errResponse) {
						console.log('Error while pagination');
					}
				);
		    	}
		    	
		    	$scope.disableSorting=  ($scope.currentPage > 0) ?true:false;
		    	
		    	/*if(self.filteredPriceSetting.length < $scope.pageSize) {
		    		$scope.nextDisabled = true;
		    	}*/
		    	
		    	if($scope.currentPage == 0) {
		    		$scope.previouseDisabled = true;
		    	}
		    	
		    	if(nextPrevMultiplier == -1) {    		
		    		$scope.nextDisabled = false;
		    	} else {
		    		$scope.previouseDisabled = false;
		    	}
		    	
		    }
			//===================================first last login page====================================
			$scope.firstlastPaginate = function (page) {
				
				self.selectAllPriceSetting=false;
				

				
				if( page == 1 ) {
		    		$scope.currentPage = 0;
		    		$scope.previouseDisabled = true;
		    		$scope.nextDisabled = false;
			    	self.filteredPriceSetting=self.priceSettingBackUp.slice($scope.currentPage*$scope.pageSize);
		    	} else {
		    		$scope.currentPage = ((Math.ceil(self.filteredPriceSetting.length/$scope.pageSize)) - 1);		    		
		    		console.log($scope.currentPage);
		    		$scope.previouseDisabled = false;
		    		$scope.nextDisabled = true;

			    	self.filteredPriceSetting=self.priceSettingBackUp.slice($scope.currentPage*$scope.pageSize);
		    		
			    	if(self.filteredPriceSetting.length==0){						
						priceSettingRegisterService.paginateFirstOrLast(page)
						.then(
								function(response){
									self.filteredPriceSetting=response;
									console.log(response);
								},function(errRespone){
									console.log("error while fetching price Setting in search"+errResponse);
								});
						
			    	}
		    	}
				$scope.disableSorting=  ($scope.currentPage > 0) ?true:false;
			}

			//===================================SEARCH REGISTER====================================
			function registerSearch(searchString){
				if(searchString.length==0){
					self.filteredPriceSetting=self.priceSettingBackUp;
				}else if(searchString.length>3){
						priceSettingRegisterService.searchPriceSetting(searchString)
					.then(
							function(response){
								self.filteredPriceSetting=response;
							},function(errRespone){
								console.log("error while fetching Location in search"+errResponse);
							});
				}else{
					self.filteredPriceSetting=_.filter(self.priceSettingBackUp,function(item){
						return searchProduct(item,searchString);
					});
				}
				
			}
			
			
			
			function searchProduct(item,toSearch){
				var success=false;
				
				try{
					if(		
							item.branch.branch_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ||
							item.service.service_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ||
							item.product.product_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ||
							item.product.product_Type.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ||
							String(item.default_price).indexOf(toSearch) > -1	||
							String(item.defaulthandling_charge).indexOf(toSearch) > -1	
					){
						success = true;
					} else {
						success = false;
					}
				}catch(e){
					console.log(e);
					success = false;
				}
				
				return success;	
			}
			//===================================fetch all price setting====================================
			fetchAllPriceSetting();
			
			function fetchAllPriceSetting(){
				console.log("inside fetch all Price Setting");
				priceSettingRegisterService.fetchAllPriceSetting()
				.then(function(response){
					self.filteredPriceSetting=response;
					self.priceSettingBackUp=response;
					pagination();
					console.log(response);
				},
				function(errResponse){
					console.log("error fetching all price setting");					
				});
			}
			
			//===================================select price setting====================================
			function selectPriceSetting(x){
				if(x.select){
					self.selectedPriceSetting.push(x);
				}else{
					self.selectAllPriceSetting=x.select;
					var index=self.selectedPriceSetting.indexOf(x);
					self.selectedPriceSetting.splice(index,1);
				}
				console.log(self.selectedPriceSetting);
			}			
			
			//===================================select all price setting====================================
			function selectAll(){
				self.selectedPriceSetting=[];
				var size;
				
				if($scope.pageSize>self.filteredPriceSetting.length){
					size=self.filteredPriceSetting.length;
				}else{
					size=$scope.pageSize;
				}
				
				for(var i=0;i<size;i++){
					self.filteredPriceSetting[i].select=self.selectAllPriceSetting;
					if(self.selectAllPriceSetting){
						self.selectedPriceSetting.push(self.filteredPriceSetting[i]);
					}
				}
				console.log(self.selectedPriceSetting);
			}
			
			
			//===================================Functions for Active inactive====================================
			function selectOneRecord(){
		   		self.message ="Please select atleast one record..!";
				successAnimate('.failure');
			}
			
			function showStatus(status){
				self.message ="Selected record(s) already in "+status+" status..!";
				successAnimate('.failure');
			}
				
			function showStatusAfterSave(status){
				fetchAllPriceSetting();
				self.message ="Selected record(s) has been made  "+status+"..!";
				successAnimate('.success');
				 self.selectedPriceSetting=[];
				 self.selectAllPriceSetting=false;
			}
			

			//===================================Make Active ====================================
			function makeActive(){
				
				var hitController=true;
				var active_id=[];
				
				if(self.selectedPriceSetting.length==0){
					selectOneRecord();
				    hitController=false;
				}else{
					var loop=true;	
					for(var i=0;i<self.selectedPriceSetting.length;i++){
						if(loop){
							if(self.selectedPriceSetting[i].active=="Y"){
								loop=false;
							    hitController=false;
								showStatus("Active");
							}
		    				active_id[i] = self.selectedPriceSetting[i].pricesetting_id; 
						}						
					}
				}
				
				if(hitController){					
					console.log(active_id);
					ConfirmDialogService.confirmBox("Active",
		    				BootstrapDialog.TYPE_SUCCESS, "Make Records Active  ..?", 'btn-success')
		    		.then(function(response){
		    			priceSettingRegisterService.changeActive(active_id,"Active")
						.then(
								function(response){
									showStatusAfterSave("Active");
								},function(errRespone){
									console.log("error making price setting active"+errResponse);
								});
		    		});
				}	
			}
			
			
			//===================================Make inactive====================================
			function makeInActive(){
				
				var hitController=true;
				var In_active_id=[];
				

				if(self.selectedPriceSetting.length==0){
					selectOneRecord();
				    hitController=false;
				}else{
					var loop=true;	
					for(var i=0;i<self.selectedPriceSetting.length;i++){
						if(loop){
							if(self.selectedPriceSetting[i].active=="N"){
								loop=false;
							    hitController=false;
								showStatus("InActive");
							}

							In_active_id[i] = self.selectedPriceSetting[i].pricesetting_id; 
						}
					}
				}
				
				
				if(hitController){
					console.log(In_active_id);
					ConfirmDialogService.confirmBox("InActive",
		    				BootstrapDialog.TYPE_DANGER, "Make Records InActive  ..?", 'btn-danger')
		    		.then(function(response){
		    			
		    			priceSettingRegisterService.changeActive(In_active_id,"InActive")
						.then(
								function(response){
									showStatusAfterSave("InActive");
								},function(errResponse){
									console.log("error making price setting InActive",errResponse);
								});
		    		});
		    		}
				
			}
			//===================================change no of page to view in register====================================
		    self.shownoofRecord=function shownoofRecord() {    
		    	$scope.pageSize = $scope.shownoofrec;
		    	
		    	self.filteredPriceSetting=self.priceSettingBackUp.slice($scope.currentPage*$scope.pageSize);
		    	
		    	if( self.filteredPriceSetting.length < $scope.pageSize ) {
		    		$scope.previouseDisabled = true;
		    		$scope.nextDisabled = true;
		    	}
		    }
		    
		    
			//===================================pagination====================================
		    function pagination() {
		    	$scope.pageSize = $scope.shownoofrec;
				$scope.currentPage = 0;
				$scope.totalPages = 0;	
				$scope.previouseDisabled = true;	
				$scope.nextDisabled = false;	
				
				if(self.filteredPriceSetting.length <= 10 ) {
					$scope.nextDisabled = true;
				}
				
				if( self.filteredPriceSetting.length < 100 ) {
					$scope.totalnof_records  = self.filteredPriceSetting.length;
				} else {
					findrecord_count();
				}
		    }
			
		  //===================================Total Record Count====================================
			function findrecord_count() {				
				priceSettingRegisterService.findrecord_count()
				.then(
						function (record_count) {
							console.log(record_count);
							$scope.totalnof_records  = record_count;
						}, 
						function (errResponse) {
							console.log('Error while fetching record count');
						});
			}
			
			
		}]);

