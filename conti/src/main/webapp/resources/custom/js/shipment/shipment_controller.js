/**
 * @Project_Name conti
 * @Package_Name custom js shipment_control.js
 * @File_name shipment_control.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 27, 2017 03:12:17 PM
 * @Updated_date_time Jun 27, 2017 03:12:17 PM
 */


contiApp.controller('ShipmentController', ['$http', '$filter', '$scope','$q','$timeout', 'ShipmentService', 'BranchService', 'ConfirmDialogService', function($http, $filter, $scope, $q, $timeout,  ShipmentService, BranchService, ConfirmDialogService){
	
	$("#screen_addshipment").addClass("active-menu");
	var self = this;
	self.shipment = {};
	self.shipment.sender_customer = {};
	self.shipment.consignee_customer = {};
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
 	    
    	self.shipment.consignee_customer.branch_name = consignee_branch_name.originalObject.branch_name;
    	self.shipment.consignee_customer.branch_id = consignee_branch_name.originalObject.branch_id;
    	self.shipment.consignee_customer.branchModel = consignee_branch_name.originalObject;
    	
	};	
	//------------------------ Consignee branch end
	//---------------------------------------------------- SENDER & CONSIGNEE PROCESS END ------------------------------------------------------------------------	
	
	
	//---------------------------------- Declare Product Detailed begin
	
	self.products = [];
	
	//--------------------------------------------- add Product begin
	self.addProduct = function (product) {
		self.products.push({
			'product_id' : 0,
			'product_type' : null,
			'product_length' : 0,
			'product_length' : 0,
			'product_weight' : 0,
			'product_quantity' : 0,
			'product_unitprice' : 0,
			'product_totalprice' : 0
		});
	}

	self.addProduct();
	//--------------------------------------------- add Product end
	
	//--------------------------------------------- remove Product beging
	self.removeProduct = function () {
        var selectedProductList=[];
        $scope.selectedAll = false;
        angular.forEach(self.products, function(selected){
            if(!selected.selected){
            	selectedProductList.push(selected);
            }
        }); 
        self.products = selectedProductList;
	}
	//--------------------------------------------- remove Product end
	
	//---------------------------------- Declare Product Detailed end
	
}]);