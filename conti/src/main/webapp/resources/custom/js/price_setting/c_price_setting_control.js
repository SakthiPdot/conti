/**
 * @Project_Name conti
 * @Package_Name resources/custom/js
 * @File_name c_price_setting_control.js
 * @author Monu.c
 * @Created_date_time Jul 20, 2017 4:20:17 PM
 * @Updated_date_time Jul 20, 2017 4:20:17 PM
 */

angular.module('contiApp').controller('priceSettingController',
		['$scope','$timeout','priceSettingService','ConfirmDialogService',
			function($scope,$timeout,priceSettingService,ConfirmDialogService){
	
	
	$("#screen_price_settings_register").addClass("active-menu");	
	$scope.defaultPrice=defaultPrice;
	$scope.defaultPriceCheckBox==false
	
	
	var self=this;
	self.addNew=addNew;//91
	self.removePriceDetails=removePriceDetails;
	self.submit=submit;
	self.deletePriceSetting=deletePriceSetting;
	self.formReset=formReset;
	
	
	function formReset(){
		console.log("Form reset done");
		
		$('#selectedBranch_value').val(null);
		$('#selectedService_value').val(null);
		$('#selectedProduct_value').val(null);

		$('#branch0_value').val(null);
		self.priceSetting.priceSettingDetail=[];
		self.priceSetting.priceSettingDetail.push({
		    "pricesettingdetail_id": null,
		    "ps_weightfrom": null,
		    "ps_weightto": null,
		    "ps_price": null,
		    "priceSetting":null,
		    "edit":true,
		    "branch":null
				});
		
		self.priceSetting={
			    "pricesetting_id": null,
			    "default_price": null,
			    "defaulthandling_charge": null,
			    "created_datetime": null,
			    "updated_datetime": null,
			    "updated_by": null,
			    "created_by":null,
			    "obsolete": null,
			    "active": null,
			    "product": null ,
			    "service": null,
			    "branch":null,
			    
			    "priceSettingDetail":  [			      
			        {
			            "pricesettingdetail_id": null,
			            "ps_weightfrom": null,
			            "ps_weightto": null,
			            "ps_price": null,
			            "priceSetting": null,
					    "edit":true,
			            "branch": null
			        }]
		
			}
	}
	
	
	function deletePriceSetting(){
		ConfirmDialogService.confirmBox("Delete",
				BootstrapDialog.TYPE_DANGER, "Delete Price Setting For  "+self.priceSetting.product.product_name+"  ..?", 'btn-danger')
		.then(function(response){
	
			
		priceSettingService.deletePriceSetting(
				self.priceSetting.pricesetting_id)
		.then(function(response){
			self.message = " Price Setting Deleted For ("+self.priceSetting.product.product_name+")..!";
			successAnimate('.success');	
			formReset();
		},function(errResponse){
			console.log(errResponse);
			self.message = "Error While Deleting Price Setting for ("+self.priceSetting.product.product_name+") ..!";
			successAnimate('.failure');
		})
		});
	}
	
	
	if($('#saveOrNew').val()!="NEW"){
		$scope.showEdit=true;		
		$('#saveButton').text(" Update")
		console.log($('#saveOrNew').val());		
		priceSettingService.fetchPSbyId($('#saveOrNew').val())
		.then(function(response){
			self.priceSetting=response;
			$scope.edit=true;
			if(self.priceSetting.default_price.toString().length>0 && self.priceSetting.default_price != 0){
				console.log(self.priceSetting.default_price);
	 			$scope.showTable=true,$scope.defaultPriceCheckBox=true;
			}
		},function(errResponse){
			console.log(errResponse);
		})
	}
	
	
	self.priceSetting={
	    "pricesetting_id": null,
	    "default_price": null,
	    "defaulthandling_charge": null,
	    "created_datetime": null,
	    "updated_datetime": null,
	    "updated_by": null,
	    "created_by":null,
	    "obsolete": null,
	    "active": null,
	    "product": null ,
	    "service": null,
	    "branch":null,
	    
	    "priceSettingDetail":  [
	      
	        {
	            "pricesettingdetail_id": null,
	            "ps_weightfrom": null,
	            "ps_weightto": null,
	            "ps_price": null,
	            "priceSetting": null,
			    "edit":true,
	            "branch": null
	        }]
	
	}
	
	self.priceSettingDetail={
	    "pricesettingdetail_id": null,
	    "ps_weightfrom": null,
	    "ps_weightto": null,
	    "ps_price": null,
	    "priceSetting":null,
	    "branch": {
	        "branch_id": null,
	        "branch_mobileno": null,
	        "updated_by": null,
	        "created_by": null,
	        "branch_name": null,
	        "branch_code": null,
	        "branch_addressline1": null,
	        "branch_addressline2": null,
	        "branch_contactperson": null,
	        "branch_email": null,
	        "lrno_prefix": null,
	        "receiptno_prefix": null,
	        "created_datetime": null,
	        "updated_datetime": null,
	        "obsolete": null,
	        "active": null,
	        "location": null
	    }
	}
	//===================================add price setting detail====================================
	function addNew(){
		
		self.priceSetting.priceSettingDetail.push({
		    "pricesettingdetail_id": null,
		    "ps_weightfrom": null,
		    "ps_weightto": null,
		    "ps_price": null,
		    "priceSetting":null,
		    "edit":true,
		    "branch":null
				});
	}
	
	function defaultPrice(val){
		if(val){
			ConfirmDialogService.confirmBox("Price",
	 				BootstrapDialog.TYPE_DANGER, "set default price ..?"  + "<br/>" +
	 						"NOTE :  Price set for all branches will be cleared.", 'btn-danger')
	 		.then(function(response){
	 				setDefaultValue();
	 			},function(errResponse){
		 			dontSetDefaultValue();
	 		});			
		}else{
			ConfirmDialogService.confirmBox("Price",
	 				BootstrapDialog.TYPE_WARNING, "set price for selected branches ..?"  + "<br/>" +
	 						"NOTE :  Default price will be cleared.", 'btn-warning')
	 		.then(function(response){
	 			dontSetDefaultValue();
	 		},function(errResponse){
 				setDefaultValue();
	 		});	
		}
	}
	
	function setDefaultValue(){
			$scope.showTable=true;
			$scope.defaultPriceCheckBox=true;
			self.priceSetting.priceSettingDetail=[];
			$('#branch0_value').val("");
			self.priceSetting.priceSettingDetail.push({
			    "pricesettingdetail_id": null,
			    "ps_weightfrom": null,
			    "ps_weightto": null,
			    "ps_price": null,
			    "priceSetting":null,
			    "edit":true,
			    "branch":null
					});		
	}
	

	function dontSetDefaultValue(){
			$scope.defaultPriceCheckBox=false;
			self.priceSetting.default_price=null;
			$scope.showTable=false;
	}
/*	$scope.toBranch = function(selected){
		console.log(selected);
		if(typeof selected!="undefined"){	
			self.priceSetting.branch=selected.originalObject;
		}else{
			self.priceSetting.branch=null;
		}
	}*/
	$scope.defaultHCPrice=function defaultHCPrice(val){
		if(!val){
			self.priceSetting.defaulthandling_charge=null;
		}
	}

	//===================================remove price setting detail====================================
	function removePriceDetails(index,id){
		
		if(self.priceSetting.priceSettingDetail.length>1){
			console.log(index,id);	
			self.priceSetting.priceSettingDetail.splice(index,1);
			console.log(self.priceSetting.priceSettingDetail[index]);
			
			for(var i=0;i<self.priceSetting.priceSettingDetail.length;i++){
				var detailIndex=self.priceSetting.priceSettingDetail.indexOf(self.priceSetting.priceSettingDetail[i]);
				$("#branch"+detailIndex+"_value").val(self.priceSetting.priceSettingDetail[detailIndex].branch.branch_name);
			}
		
		}else{

	   		self.message ="Cannot delete this Row..!";
			successAnimate('.failure');
		}
	}
	
	//======================================submit======================================
	function submit(){
		var tobranch=null;
		var breakSave=true;
		//======================================check empty======================================
		
		if(self.priceSetting.branch==null || self.priceSetting.branch.length==0){
			 $('#selectedBranch_value').focus();
		}else if(self.priceSetting.service==null || self.priceSetting.service.length==0){
			 $('#selectedService_value').focus();
		}else if(self.priceSetting.product==null || self.priceSetting.product.length==0){
			 $('#selectedProduct_value').focus();
		}else if($scope.defaultPriceCheckBox==true && (self.priceSetting.default_price==null ||self.priceSetting.default_price=="")){
			$('#defaultPrice').focus();
		}
		
	/*	else if(self.priceSetting.priceSettingDetail[0].branch==null || self.priceSetting.priceSettingDetail[0].branch.length==0
				|| self.priceSetting.priceSettingDetail[0].branch==undefined){
				$('#branch0_value').focus();
				 var breakSave=false;
		}*/
		
		else{

			console.log(self.priceSetting);
			
	
			if($scope.defaultPriceCheckBox!=true && (self.priceSetting.default_price!=null ||self.priceSetting.default_price!="") ){
			top:     
				for(var i = 0;i<self.priceSetting.priceSettingDetail.length;i++){
					console.log(self.priceSetting.priceSettingDetail[i].branch);				
				 if(self.priceSetting.priceSettingDetail[i].branch==null ){
					 		$('#branch'+i+'_value').val("");		
					 		$('#branch'+i+'_value').focus();
							throw new Error("Something went badly wrong!");
							console.log('#branch'+i+'_value');
							 var breakSave=false;
							break top;
						}
				}
			}
	
		
			
			
			//======================================New======================================
			if(breakSave){
			if(self.priceSetting.pricesetting_id==null){
				console.log('Saving user',self.priceSetting);	
				console.log(self.priceSetting.priceSettingDetail.length);
				
				for(var i = 0;i<self.priceSetting.priceSettingDetail.length;i++){
    				delete self.priceSetting.priceSettingDetail[i].edit;	
    				//self.priceSetting.priceSettingDetail[i].priceSetting=self.priceSetting;
    			};
    			
		
				ConfirmDialogService.confirmBox("Save",
	    				BootstrapDialog.TYPE_SUCCESS, "save price setting for Product ("+self.priceSetting.product.product_name+")  ..?", 'btn-success')
	    		.then(function(response){
	    			
	    			
	    		
	    			
	    			priceSettingService.savePS(self.priceSetting)
	    			.then(function(){
						self.message = " Price Setting For Product("+self.priceSetting.product.product_name +") created..!";
	    				successAnimate('.success');	
	    				formReset();
	    			},function(errResponse){
	    				console.log(errResponse);
						self.message ="Error While Creating Price Setting For Product("+self.priceSetting.product.product_name +")..!";
	    				successAnimate('.failure');	
	    			})
	    		});
			}
			//======================================Update======================================
			else{
				console.log('Updating user',self.priceSetting);
				
				 ConfirmDialogService.confirmBox("Update",
		    				BootstrapDialog.TYPE_SUCCESS, "price setting for Product ("+self.priceSetting.product.product_name+")  ..?", 'btn-success')
		    		.then(function(response){
		    			
		    			for(var i = 0;i<self.priceSetting.priceSettingDetail.length;i++){
	    					delete self.priceSetting.priceSettingDetail[i].edit;	
	    					//self.priceSetting.priceSettingDetail[i].priceSetting=self.priceSetting;
	    				};
	    				
		    			priceSettingService.updatePS(self.priceSetting,self.priceSetting.pricesetting_id)
		    			.then(function(){	
							self.message = " Price Setting For Product("+self.priceSetting.product.product_name +") Updated..!";
		    				successAnimate('.success');	
		    				formReset();
		    			},function(errResponse){
							self.message = "Error While Updating Price Setting For Product("+self.priceSetting.product.product_name +")..!";
		    				successAnimate('.failure');
		    			})
		    		});
			}
			}
		}
		
	}
		
	$scope.branch_name=function (selected){
		if(typeof selected!="undefined"){	
			self.priceSetting.branch=selected.originalObject;
		}else{
			self.priceSetting.branch=null;
		}
	}
	
	$scope.toBranch=function (selected){
		if(typeof selected!="undefined"){	
			self.priceSetting.branch=selected.originalObject;
		}else{
			self.priceSetting.branch=null;
		}
	}
	
	$scope.toBranchDetail=function (selected){
		if(typeof selected!="undefined"){
		self.priceSetting.priceSettingDetail[this.$parent.$index].branch=selected.originalObject;
		}else{
		self.priceSetting.priceSettingDetail[this.$parent.$index].branch=null;
		}
	}
	
	$scope.service_name=function (selected){
		if(typeof selected!="undefined"){
			self.priceSetting.service=selected.originalObject;
		}else{
			self.priceSetting.service=null;
		}
	}
	
	$scope.product_name=function (selected){
	if(typeof selected!="undefined"){
			self.priceSetting.product=selected.originalObject;
			self.priceSetting.product.product_Type=selected.originalObject.product_Type;
			$("#selectedProductType_value").val(selected.originalObject.product_Type);			
		}else{
			self.priceSetting.product=null;
			self.priceSetting.product.product_Type=null;
			$("#selectedProductType_value").val("");
		}
	}
	
}]);