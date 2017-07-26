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
	
	

	if($('#saveOrNew').val()!="NEW"){
		console.log($('#saveOrNew').val());		
		priceSettingService.fetchPSbyId($('#saveOrNew').val())
		.then(function(){
			console.log(response);
		},function(errResponse){
			console.log(errResponse);
		})
		
	}
	
	
	var self=this;
	self.addNew=addNew;//91
	self.removePriceDetails=removePriceDetails;
	self.submit=submit;

/*	self.priceSetting.branch=$('#fromBranch').val();	
	self.priceSetting.priceSettingDetail=$('#toBatch').val();
	self.priceSetting.product=$('#product').val();
	self.priceSetting.service=$('#service').val();
	*/
	
	$scope.updateClick=function(x){
		console.log($('#saveOrNew').val());		
		priceSettingService.fetchPSbyId(x)
		.then(function(response){
			self.priceSetting=response;
			console.log(response);
			
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
		    "branch":{
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
				});
	}
	
	$scope.defaultPrice=function defaultPrice(val){
		if(val){
			ConfirmDialogService.confirmBox("Price",
	 				BootstrapDialog.TYPE_DANGER, "set default price ..?"  + "<br/>" +
	 						"NOTE :  Price set for all branches will be cleared.", 'btn-danger')
	 		.then(function(response){
	 			$scope.showTable=true;
	 			self.priceSetting.priceSettingDetail=[];
	 			self.addNew();
	 		});			
		}else{
			ConfirmDialogService.confirmBox("Price",
	 				BootstrapDialog.TYPE_WARNING, "set price for selected branches ..?"  + "<br/>" +
	 						"NOTE :  Default price will be cleared.", 'btn-warning')
	 		.then(function(response){
	 			self.priceSetting.default_price=null;
	 			$scope.showTable=false;
	 		});	
		}
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
	function removePriceDetails(index,priceSettingDetail){
		console.log(index,priceSettingDetail);
		self.priceSetting.priceSettingDetail.splice(index,1);
	}
	
	//======================================submit======================================
	function submit(){
		var tobranch=null;
		console.log(self.priceSetting.branch);
		console.log(self.priceSetting.service);
		console.log(self.priceSetting.product);
		//======================================check empty======================================
		if(self.priceSetting.branch==null || self.priceSetting.branch.length==0){
			 $('#selectedBranch_value').focus();
		}else if(self.priceSetting.service==null || self.priceSetting.service.length==0){
			 $('#selectedService_value').focus();
		}else if(self.priceSetting.product==null || self.priceSetting.product.length==0){
			 $('#selectedProduct_value').focus();
		}else{
			console.log(self.priceSetting);
			//======================================New======================================
			if(self.priceSetting.pricesetting_id==null){
				console.log('Saving user',self.priceSetting);	
				console.log(self.priceSetting.priceSettingDetail.length);
				
			for(var i = 0;i<self.priceSetting.priceSettingDetail.length;i++){
					console.log(i,self.priceSetting.priceSettingDetail[i]);	
					tobranch=self.priceSetting.priceSettingDetail[i].branch.originalObject;
					self.priceSetting.priceSettingDetail[i].branch=tobranch;
					//self.priceSetting.priceSettingDetail[i].priceSetting=self.priceSetting;
				};
				
				ConfirmDialogService.confirmBox("Save",
	    				BootstrapDialog.TYPE_SUCCESS, "save price setting for Product ("+self.priceSetting.product.product_name+")  ..?", 'btn-success')
	    		.then(function(response){
	    			priceSettingService.savePS(self.priceSetting)
	    			.then(function(){
						self.message = " Price Setting For Product("+self.priceSetting.product.product_name +") created..!";
	    				successAnimate('.success');	
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
				
				for(var i = 0;i<self.priceSetting.priceSettingDetail.length;i++){
					self.priceSetting.priceSettingDetail[i].branch=self.priceSetting.priceSettingDetail[i].branch.originalObject;
				};
				
				
				 ConfirmDialogService.confirmBox("Update",
		    				BootstrapDialog.TYPE_SUCCESS, "price setting for Product ("+self.priceSetting.product.product_name+")  ..?", 'btn-success')
		    		.then(function(response){
		    			priceSettingService.updatePS(self.priceSetting,self.priceSetting.pricesetting_id)
		    			.then(function(){
							self.message = " Price Setting For Product("+self.priceSetting.product.product_name +") Updated..!";
		    				successAnimate('.success');	
		    			},function(errResponse){
							self.message =locationName+ "Error While Updating Price Setting For Product("+self.priceSetting.product.product_name +")..!";
		    				successAnimate('.failure');
		    			})
		    		});
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
	
/*	$scope.branch_name_To=function (selected){
		if(typeof selected!="undefined"){
			$('#toBatch').val(selected.originalObject);		
		}else{
			$("#toBatch").val("");
		}
	}*/
	
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