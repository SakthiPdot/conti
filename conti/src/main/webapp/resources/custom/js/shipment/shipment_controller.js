/**
 * @Project_Name conti
 * @Package_Name custom js shipment_control.js
 * @File_name shipment_control.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 27, 2017 03:12:17 PM
 * @Updated_date_time Jun 27, 2017 03:12:17 PM
 */


contiApp.controller('ShipmentController', ['$http', '$filter', '$scope','$q','$timeout', 'ShipmentService', 'priceSettingService', 'BranchService', 'CompanySettingService', 'ConfirmDialogService', function($http, $filter, $scope, $q, $timeout,  ShipmentService, priceSettingService, BranchService, CompanySettingService, ConfirmDialogService){
	
	$("#screen_addshipment").addClass("active-menu");
	var self = this;
	self.shipment = {
			
			"sender_customer" : {},
			"consignee_customer" : {},
			"sender_branch" : {},
			"consignee_branch" : {},
			"service" : {},
			"products" : [{
				"product" : {
					"hsns" : [{
						"hsn" : {'hsn_id':5}
					}]
				},
				
			}],
			/*"hsns" : [{
				"hsn" : null
			}]*/
			
	};
	

	/*self.shipment.hsns = {};*/
	
/*	self.shipment.sender_customer = {};
	self.shipment.consignee_customer = {};*/
	self.shipment.shipment_date = $filter("date")(Date.now(), 'yyyy-MM-dd HH:mm:ss');
	self.shipment.status = "Booked";
	
	
	self.changePaymentmode = changePaymentmode;
	
	
	//-------------------------------- Change Pament mode function begin 
	function changePaymentmode(payment_mode) {
		if( payment_mode == 'Credit' ) {
			self.shipment.bill_to = 'Sender';	
		} else {
			self.shipment.bill_to = '';
		}
	}
	//-------------------------------- Change Pament mode function end

//---------------------------------------------------- SENDER & CONSIGNEE PROCESS BEGIN ------------------------------------------------------------------------	
	//------------------------ Sender customer search by mobileno begin
    $scope.sender_search_mbl = function (sender_search_mbl) {
    	self.shipment.sender_customer.customer_id = sender_search_mbl.originalObject.customer_id;
    	self.shipment.sender_customer.customer_name = sender_search_mbl.originalObject.customer_name;
    	self.shipment.sender_customer.customer_mobileno = sender_search_mbl.originalObject.customer_mobileno;
    	self.shipment.sender_customer.customer_addressline1 = sender_search_mbl.originalObject.customer_addressline1;
    	self.shipment.sender_customer.customer_addressline2 = sender_search_mbl.originalObject.customer_addressline2;
    	
    	$("#sender_location_name_value").val(sender_search_mbl.originalObject.location.location_name);
    	self.shipment.sender_customer.location = sender_search_mbl.originalObject.location;
    	
    	$("#sender_city").val(sender_search_mbl.originalObject.location.address.city);
    	$("#sender_state").val(sender_search_mbl.originalObject.location.address.state);
    	$("#sender_country").val(sender_search_mbl.originalObject.location.address.country);
    	$("#sender_pincode").val(sender_search_mbl.originalObject.location.pincode);
    	
    	self.shipment.sender_customer.customer_email = sender_search_mbl.originalObject.customer_email;
    	self.shipment.sender_customer.gstin_number = sender_search_mbl.originalObject.gstin_number;
    	
	};	
	//------------------------ Sender customer search by mobileno end
	
	//------------------------ Sender address begin
    $scope.sender_location_name = function (sender_location_name) {
 	    
    	self.shipment.sender_customer.location = sender_location_name.originalObject.location;
    	
    	$("#sender_city").val(sender_location_name.originalObject.address.city);
    	$("#sender_state").val(sender_location_name.originalObject.address.state);
    	$("#sender_country").val(sender_location_name.originalObject.address.country);
    	$("#sender_pincode").val(sender_location_name.originalObject.pincode);
    	
	};	
	//------------------------ Sender address end
	
	//------------------------ Consignee customer search by mobileno begin
    $scope.consignee_search_mbl = function (consignee_search_mbl) {
    	self.shipment.consignee_customer.customer_id = consignee_search_mbl.originalObject.customer_id;
    	self.shipment.consignee_customer.customer_name = consignee_search_mbl.originalObject.customer_name;
    	self.shipment.consignee_customer.customer_mobileno = consignee_search_mbl.originalObject.customer_mobileno;
    	self.shipment.consignee_customer.customer_addressline1 = consignee_search_mbl.originalObject.customer_addressline1;
    	self.shipment.consignee_customer.customer_addressline2 = consignee_search_mbl.originalObject.customer_addressline2;
    	
    	
    	$("#consignee_city").val(consignee_search_mbl.originalObject.location.address.city);
    	$("#consignee_state").val(consignee_search_mbl.originalObject.location.address.state);
    	$("#consignee_country").val(consignee_search_mbl.originalObject.location.address.country);
    	$("#consignee_pincode").val(consignee_search_mbl.originalObject.location.pincode);
    	
    	self.shipment.consignee_customer.customer_email = consignee_search_mbl.originalObject.customer_email;
    	self.shipment.consignee_customer.gstin_number = consignee_search_mbl.originalObject.gstin_number;
    	
    	$("#consignee_location_name_value").val(consignee_search_mbl.originalObject.location.location_name);
    	self.shipment.consignee_customer.location = consignee_search_mbl.originalObject.location;

	};	
	//------------------------ Consignee customer search by mobileno end
	
	//------------------------ Consignee address begin
    $scope.consignee_location_name = function (consignee_location_name) {
 	    
    	self.shipment.consignee_customer.location = consignee_location_name.originalObject.location;
    	
    	$("#consignee_city").val(consignee_location_name.originalObject.address.city);
    	$("#consignee_state").val(consignee_location_name.originalObject.address.state);
    	$("#consignee_country").val(consignee_location_name.originalObject.address.country);
    	$("#consignee_pincode").val(consignee_location_name.originalObject.pincode);
    	
	};	
	//------------------------ Consignee address end
	
	
	//------------------------ Consignee branch begin
    $scope.consignee_branch_name = function (consignee_branch_name) {
 	    
/*    	self.shipment.consignee_branch.branch_name = consignee_branch_name.originalObject.branch_name;
    	self.shipment.consignee_branch.branch_id = consignee_branch_name.originalObject.branch_id;*/
    	self.shipment.consignee_branch = consignee_branch_name.originalObject;
    	
    	self.shipment.sender_branch.branch_id = $('#sender_branch_id').val();
    	self.shipment.sender_branch.branch_name = $('#sender_branch_name').val();
    	
    	console.log(self.shipment.consignee_branch);
    	console.log(self.shipment.sender_branch);
    	
	};	
	//------------------------ Consignee branch end
	//---------------------------------------------------- SENDER & CONSIGNEE PROCESS END ------------------------------------------------------------------------	
	
	
	//---------------------------------- Declare Product Detailed begin
	
	//------------------------------------------------------------- ADD SHIPMENT DETAILED TABLE BEGIN----------------------------------------
	self.shipment.products  = [];
	
	//--------------------------------------------- add Product begin
	self.disable_add_product = true;
	self.disable_save = true;
	self.addProduct = function (product) {
		self.shipment.products.push({
			/*'product_id' : 0,
			'product_name' : null,
			'product_type' : null,
			'max_height' : 0,
			'max_width' : 0,
			'max_length' : 0,
			'max_weight' : 0,
			'product_quantity' : 0,
			'product_unitprice' : 0,
			'product_totalprice' : 0*/

		});
		
	}

	self.addProduct();
	//--------------------------------------------- add Product end
	
	//---------------------------------------------- Select All begin
/*	self.product_selectAll = function() {
		for(var i=0; i<self.shipment.products.length; i++) {
			self.shipment.products[i].selected = self.selectAll_product;
		}
		
	}*/
	//---------------------------------------------- Select All end
	
	
	//--------------------------------------------- remove Product beging
	self.removeProduct = function () {
        var selectedProductList=[];
        $scope.selectedAll = false;
        angular.forEach(self.shipment.products, function(selected){
            if(!selected.selected){
            	selectedProductList.push(selected);
            }
        }); 
        self.shipment.products = selectedProductList;
        self.checkQuantity(-1); // Call CheckQuantity method for check whethere noofparcel == qunatity
	}
	//--------------------------------------------- remove Product end
	
	//----------------------------------------------------------------------- Declare Product Detailed end
	
	
	//---------------------------------------------- Search service begin
	$scope.service_name=function (selected){
		self.shipment.service = selected.originalObject;
	}
	//---------------------------------------------- Search service end
	
	
	//--------------------------------------------- Compare quantity and no of parcel beging
	self.checkQuantity = function (index) {
		self.disable_add_product = false;
		var quantity = 0;
		var selected_quantity = 0;
		for(var i = 0; i < self.shipment.products.length; i++) {
			
			selected_quantity = self.shipment.products[i].product_quantity;
			
			if(self.shipment.products[i].product_quantity == null || isNaN(self.shipment.products[i].product_quantity) ) {
				selected_quantity = 0;
			} 
						
			quantity = parseInt(selected_quantity) + parseInt(quantity);	
			
			if( quantity == self.shipment.numberof_parcel ) {
				self.disable_add_product = true;
				self.disable_save = false;
			} else if( quantity > self.shipment.numberof_parcel ) {
				self.disable_save = true;
				self.confirm_title = 'Change No.of Parcel';
				self.confirm_type = BootstrapDialog.TYPE_WARNING;
				self.confirm_msg = self.confirm_title+ '?';
				self.confirm_btnclass = 'btn-warning';
				ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
					.then(
							function (res) {
								self.shipment.numberof_parcel = quantity;
								self.disable_add_product = true;
								self.disable_save = false;
							}, function (reject) {
								self.shipment.products[i].product_quantity = null;
							}
						);
				break;
			} else {
				self.disable_save = true;
			}//  end else 
			
		} // end loop
		
		if(index != -1) {
			self.calc_totalprice(index);		//calculate totalprice in a row			
		}


	}
	//--------------------------------------------- Compare quantity and no of parcel end	

	//---------------------------------------------- Search Product name begin
	$scope.product_name=function (selected){
		
		var index = this.$parent.$index;
		
		//-- assign object
		self.shipment.products[index].product = selected.originalObject;
		
		//-- assign to dynamic table in product
		self.shipment.products[index].product_id = selected.originalObject.product_id;
		self.shipment.products[index].product_type = selected.originalObject.product_Type;
		self.shipment.products[index].max_height = selected.originalObject.max_height;
		self.shipment.products[index].max_width = selected.originalObject.max_width;
		self.shipment.products[index].max_length = selected.originalObject.max_length;
		self.shipment.products[index].max_weight = selected.originalObject.max_weight;
		
		
		
		fetch_price(index);		//----- fetch price from price settings
		
	}
	
	
	//---------------------------------------------- Search Product name end
	
	//---------------- Fetch product price from price setting begin
	
	function fetch_price(index) {
		self.shipment.forpricesetting = {
				"from_branch_id" : self.shipment.sender_branch.branch_id,
				"to_branch_id" : self.shipment.consignee_branch.branch_id,
				"product_id" : 	self.shipment.products[index].product_id,
				"service_id" : self.shipment.service.service_id,
				"max_weight" : self.shipment.products[index].max_weight
		};
		

		priceSettingService.fetch_priceforShipment(self.shipment.forpricesetting)
			.then(
					function(res) {
						self.shipment.handling_charge = res.handling_charges;
						self.shipment.products[index].product_unitprice = parseFloat(res.price);
						
						self.checkQuantity(index);
					}, function(errResponse) {
						console.log(errResponse);
					}
				);
		
	}
	
	//---------------- Fetch product price from price setting end
	
	//----------------------------- Price by product weight begin
	self.priceby_weight = function (index) {
		fetch_price(index);
	}
	//----------------------------- Price by product weight end
	
	//------------------------------ Calculate total price in a row begin
	
	self.calc_totalprice = function (index) {
		self.shipment.products[index].product_totalprice = 
			parseInt(self.shipment.products[index].product_quantity) * parseFloat(self.shipment.products[index].product_unitprice);	
		
		//calculate chargeable weight & Delivery charges
		var chargeabled_weight = 0, delivery_charges = 0;
		for(var i = 0; i < self.shipment.products.length; i++) {
			delivery_charges = delivery_charges + self.shipment.products[i].product_totalprice; 
			chargeabled_weight = chargeabled_weight + self.shipment.products[i].max_weight; 
		}
		
		
		self.shipment.delivery_charges = delivery_charges.toFixed(2);		
		self.shipment.chargeable_weight = chargeabled_weight.toFixed(2);	
		
		self.calc_discount(); // call discount
	}
	
	//------------------------------ Calculate total price in a row end
	
	//------------------------------ Calculate discout percentage & amount begin
	
	self.calc_discount = function() {
		var discount_percent = parseFloat(self.shipment.discount_percentage) / parseInt(100);
		self.shipment.discount_amount = ( parseFloat(self.shipment.delivery_charges) *  (parseFloat(discount_percent)) ).toFixed(2);
		
		if(isNaN(self.shipment.discount_amount)) {
			self.shipment.discount_amount = null;
		}
		if(isNaN(self.shipment.delivery_charges)) {
			self.shipment.delivery_charges = null;
		}
		if(isNaN(self.shipment.chargeable_weight)) {
			self.shipment.chargeable_weight = null;
		}
		
		if( self.shipment.discount_amount != null ) { // if discount is applicable
			self.shipment.total_amount = (parseFloat(self.shipment.delivery_charges) - parseFloat(self.shipment.discount_amount)) 
											+ parseFloat(self.shipment.handling_charge);			
		} else {// if discount is not applicable
			self.shipment.total_amount = parseFloat(self.shipment.delivery_charges) + parseFloat(self.shipment.handling_charge);			
		}
		
		
		fetch_gsts(); // calculate gsts (CGST / SGST / IGST)
	}
	
	//------------------------------ Calculate discout percentage & amount end
	
	//------------------------------ Fetch CGST SGST & IGST from Company setting
	function fetch_gsts() {
				
		CompanySettingService.fetchCompanySetting(1)
			.then(
					function (res) {
						self.shipment.cgst = ( parseFloat(self.shipment.total_amount) * (parseFloat(res.data.cgst) / 100) ).toFixed(2);
						self.shipment.sgst = ( parseFloat(self.shipment.total_amount) * (parseFloat(res.data.sgst) / 100) ).toFixed(2);
						self.shipment.igst = ( parseFloat(self.shipment.total_amount) * (parseFloat(res.data.igst) / 100) ).toFixed(2);
						
						self.shipment.tax = ( parseFloat(self.shipment.cgst) + parseFloat(self.shipment.sgst) + parseFloat(self.shipment.igst) ).toFixed(2);
						self.shipment.total_charges = ( parseFloat(self.shipment.tax) + parseFloat(self.shipment.tax) ).toFixed(2);
					}, function (errRes) {
						console.log(errRes);
					} 
				);
	}
	//------------------------------------------------------------- ADD SHIPMENT DETAILED TABLE END----------------------------------------
	
	//------------------------------------------------------------------------------HSN FUNCTIONS BEGIN
	
	//------------------------------------------------------------- ADD HSN BEGIN
	
	self.addHSN = function (index, hsn) {
		console.log(self.shipment);
		
		self.shipment.products[0].hsns.push({});
	}
	
	
	//------------------------------------------------------------- ADD HSN END
	
	//--------------------------------------------- remove Product beging
	self.removeHSN = function () {
        var selectedHSNList=[];
        $scope.HSNselectedAll = false;
        angular.forEach(self.shipment.hsns, function(selected){
            if(!selected.selected){
            	selectedHSNList.push(selected);
            }
        }); 
        self.shipment.hsns = selectedHSNList;
        
	}
	//--------------------------------------------- remove Product end	
	
	
	//---------------------------------------------- HSN CODE SEARCH begin
	$scope.hsn_code=function (selected){
		
		var index = this.$parent.$index;
		
		console.log(index);
		
		//-- assign object
		self.shipment.hsns[index].hsn = selected.originalObject;
		self.shipment.hsns[index].hsn_id = selected.originalObject.hsn_id;
		$('#hsn_description'+index+'_value').val(selected.originalObject.hsn_description);
	}
	//---------------------------------------------- HSN CODE SEARCH end
	
	//---------------------------------------------- HSN DESCRIPTION SEARCH begin
	$scope.hsn_description=function (selected){
		
		var index = this.$parent.$index;
		
		//-- assign object
		self.shipment.hsns[index].hsn = selected.originalObject;
		self.shipment.hsns[index].hsn_id = selected.originalObject.hsn_id;
		$('#hsn_code'+index+'_value').val(selected.originalObject.hsn_code);
	}
	//---------------------------------------------- HSN DESCRIPTION SEARCH end
	
	//------------------------------------------------------------------------------HSN FUNCTIONS END	
	
	//----------------------------------------------------------------- ADD SHIPMENT SUBMIT BEGIN------------------------------------
	
	self.submit = function () {
		console.log(self.shipment);
	}
	
	//----------------------------------------------------------------- ADD SHIPMENT SUBMIT END------------------------------------	
}]);
