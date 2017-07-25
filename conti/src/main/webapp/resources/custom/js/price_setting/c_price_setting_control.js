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
	
	var self=this;
	self.addNew=addNew;//91
	self.removePriceDetails=removePriceDetails;
	self.submit=submit;

/*	self.priceSetting.branch=$('#fromBranch').val();	
	self.priceSetting.priceSettingDetail=$('#toBatch').val();
	self.priceSetting.product=$('#product').val();
	self.priceSetting.service=$('#service').val();
	*/
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
		    "branch":null
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
	
	
	function submit(){
/*		self.priceSetting.branch=$('#fromBranch').val();
		self.priceSetting.product=$('#product').val();
		self.priceSetting.service=$('#product').val();*/
		console.log($('#fromBranch').val());
		console.log($('#product').val());
		console.log($('#product').val());
		console.log(self.priceSetting);
	}
		
	$scope.branch_name=function (selected){
		if(typeof selected!="undefined"){
			$('#fromBranch').val(selected.originalObject);	
			self.priceSetting.branch=selected.originalObject;
		}else{
			$("#fromBranch").val("");
			self.priceSetting.branch=null;
		}
	}
	
	$scope.branch_name_To=function (selected){
		if(typeof selected!="undefined"){
			$('#toBatch').val(selected.originalObject);		
		}else{
			$("#toBatch").val("");
		}
	}
	
	$scope.service_name=function (selected){
		if(typeof selected!="undefined"){
			$('#service').val(selected.originalObject);
			self.priceSetting.service=selected.originalObject;
		}else{
			$("#service").val("");
			self.priceSetting.service=null;
		}
	}
	
	$scope.product_name=function (selected){
	if(typeof selected!="undefined"){
			self.priceSetting.product=selected.originalObject;
			$("#product").val(selected.originalObject);
			$("#selectedProductType_value").val(selected.originalObject.product_Type);			
		}else{
			self.priceSetting.product=selected;
			$("#product").val("");
			$("#selectedProductType_value").val("");
			self.priceSetting.product=null;
		}
	}
	
}]);