/**
 * @Project_Name conti
 * @Package_Name custom js shipment_control.js
 * @File_name shipment_control.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 27, 2017 03:12:17 PM
 * @Updated_date_time Jun 27, 2017 03:12:17 PM
 */

function bill_open(lrno){
	valid = true;
	window.open("shipment_bill?lrno="+lrno, '_blank');
	
	/*window.location.href = "shipment_bill?lrno="+lrno;*/
}

/*var doc = new jsPDF();
var specialElementHandlers = {
    '#editor': function (element, renderer) {
        return true;
    }
};*/

$('#pdf').click(function () {
	console.log("pdf details");
/*    doc.fromHTML($('#wrapper').html(), 15, 15, {
        'width': 170,
            'elementHandlers': specialElementHandlers
    });
    doc.save('sample-file.pdf');*/
	
	   var pdf = new jsPDF('p', 'pt', 'letter');
	    // source can be HTML-formatted string, or a reference
	    // to an actual DOM element from which the text will be scraped.
	    source = $('#wrapper')[0];

	    // we support special element handlers. Register them with jQuery-style 
	    // ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
	    // There is no support for any other type of selectors 
	    // (class, of compound) at this time.
	    specialElementHandlers = {
	        // element with id of "bypass" - jQuery style selector
	        '#bypassme': function (element, renderer) {
	            // true = "handled elsewhere, bypass text extraction"
	            return true
	        }
	    };
	    
	   
	    margins = {
	        top: 80,
	        bottom: 60,
	        left: 10,
	        width: 700
	    };
	    // all coords and widths are in jsPDF instance's declared units
	    // 'inches' in this case
	    pdf.fromHTML(
	    source, // HTML string or DOM elem ref.
	    margins.left, // x coord
	    margins.top, { // y coord
	        'width': margins.width, // max width of content on PDF
	        'elementHandlers': specialElementHandlers
	    },

	    function (dispose) {
	        pdf.save('shipment.pdf');
	    }, margins);
	    
	    
	    

});



contiApp.controller('ShipmentController', ['$http', '$filter', '$scope','$q','$timeout','$interval', 'ShipmentService', 'priceSettingService', 'BranchService', 'CompanySettingService', 'ConfirmDialogService', function($http, $filter, $scope, $q, $timeout,$interval,  ShipmentService, priceSettingService, BranchService, CompanySettingService, ConfirmDialogService){
	
	$("#screen_addshipment").addClass("active-menu");
	var self = this;
	self.shipment = {
			
			"sender_customer" : {},
			"consignee_customer" : {},
			"sender_branch" : {},
			"consignee_branch" : {},
			"service" : {},
			"shipmentDetail" : []
			
	};
	
	$scope.newHSN = [];
	
	var sender_taxin_payable = null;
	var consignee_taxin_payable = null;
	/*self.shipment.hsns = {};*/
	
/*	self.shipment.sender_customer = {};
	self.shipment.consignee_customer = {};*/
	//------------------------ time 
	  var tick = function() {
		  self.shipment.shipment_date = $filter("date")(Date.now(), 'yyyy-MM-dd HH:mm:ss');
		  }
		  tick();
		  $interval(tick, 1000);
		  
	/*self.shipment.shipment_date = $filter("date")(Date.now(), 'yyyy-MM-dd HH:mm:ss');*/
	self.shipment.status = "Booked";
	
	self.changePaymentmode = changePaymentmode;
	
	

	
	//-------------------------------- Change Pament mode function begin 
	function changePaymentmode(payment_mode) {
		/*if( payment_mode == 'Credit' ) {
			self.shipment.bill_to = 'Sender';	
		} else {
			self.shipment.bill_to = '';
		}*/
		self.tax_payable(); // Tax payable on Reverse Charge 
	}
	//-------------------------------- Change Pament mode function end
	
	//------------------------------- Reset begin
	
	function reset() {
		self.shipment = {
				
				"sender_customer" : {},
				"consignee_customer" : {},
				"sender_branch" : {},
				"consignee_branch" : {},
				"service" : {},
				"shipmentDetail" : [{
					"product" : {},
					
				}]
				
		};
		
		self.shipment.shipment_date = $filter("date")(Date.now(), 'yyyy-MM-dd HH:mm:ss');
		self.shipment.status = "Booked";
		
		$('#sender_search_mbl_value').val('');
		$('#consignee_search_mbl_value').val('');
		$('#sender_location_name_value').val('');
		$('#consignee_branch_name_value').val('');
		$('#consignee_location_name_value').val('');
		$('#service_name_value').val('');
		$('#product_name_value').val('');
		
		var sender_taxin_payable = null;
		var consignee_taxin_payable = null;
		self.disable_save = true;
		fetchMAXLRno();
	}
	
	//------------------------------- Reset end

//---------------------------------------------------- SENDER & CONSIGNEE PROCESS BEGIN ------------------------------------------------------------------------
	
	//------------------------ Fetch current branch by branch id begin
	
	/*function fetch_branch() {
		BranchService.fetchbyBranchid($('#sender_branch_id').val())
			.then(
					function (branch) {
						self.branch = branch;
					}, function (error) {
						console.log(error)
					}
				);
	}
	fetch_branch();*/
	
	
	//------------------------ Fetch current branch by branch id end
	
	//------------------------ FETCH MAX LR NO BEGIN
	$scope.maxlrno = null;
	function fetchMAXLRno() {
		console.log("inside fetchmaxlrno");
		ShipmentService.fetchMAXLRno($('#sender_branch_id').val())
			.then(
					function (maxlrno) {
						console.log(maxlrno);
						
						$scope.maxlrno = maxlrno;
					}, function (errRes) {
						$scope.maxlrno = null;
						console.log(errRes);
					}
				);
		
	}
	fetchMAXLRno();
	//------------------------ FETCH MAX LR NO END
	
	//------------------------ Sender customer search by mobileno begin
    $scope.sender_search_mbl = function (sender_search_mbl) {
    	self.shipment.sender_customer.customer_id = sender_search_mbl.originalObject.customer_id;
    	self.shipment.sender_customer.customer_name = sender_search_mbl.originalObject.customer_name;
    	self.shipment.sender_customer.company_name = sender_search_mbl.originalObject.company_name;
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
    	
    	sender_taxin_payable = sender_search_mbl.originalObject.taxin_payable;
    	self.tax_payable(); // Tax payable on Reverse Charge
	};	
	//------------------------ Sender customer search by mobileno end
	
	//------------------------ Sender address begin
    $scope.sender_location_name = function (sender_location_name) {
 	    
    	self.shipment.sender_customer.location = sender_location_name.originalObject;
    	
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
    	self.shipment.consignee_customer.company_name = consignee_search_mbl.originalObject.company_name;
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

    	consignee_taxin_payable = consignee_search_mbl.originalObject.taxin_payable;
    	self.tax_payable(); // Tax payable on Reverse Charge
	};	
	//------------------------ Consignee customer search by mobileno end
	
	//------------------------ Consignee address begin
    $scope.consignee_location_name = function (consignee_location_name) {
 	    
    	self.shipment.consignee_customer.location = consignee_location_name.originalObject;
    	
    	console.log(consignee_location_name);
    	
    	$("#consignee_city").val(consignee_location_name.originalObject.address.city);
    	$("#consignee_state").val(consignee_location_name.originalObject.address.state);
    	$("#consignee_country").val(consignee_location_name.originalObject.address.country);
    	$("#consignee_pincode").val(consignee_location_name.originalObject.pincode);
    	
	};	
	//------------------------ Consignee address end

	
	//------------------------ Consignee branch begin
    $scope.consignee_branch_name = function (consignee_branch_name) {
    	makeenable_shipmentDetail_add();  // make enable shipment detail 
    	self.shipment.consignee_branch = consignee_branch_name.originalObject;
    	sender_branch($('#sender_branch_id').val());
	};	
	//------------------------ Consignee branch end
	
	function sender_branch(sender_branch_id) {
		BranchService.fetchbyBranchid(sender_branch_id)
			.then(
					function(branch) {
						self.shipment.sender_branch = branch;
						console.log(self.shipment.sender_branch);
					}, function (errres) {
						console.log(errres);
					}
			)
			
			
	}
	
	//---------------------------------------------------- SENDER & CONSIGNEE PROCESS END ------------------------------------------------------------------------	
	
	
	//---------------------------------- Declare Product Detailed begin
	
	//------------------------------------------------------------- ADD SHIPMENT DETAILED TABLE BEGIN----------------------------------------
	/*self.shipment.shipmentDetail  = [];*/
	
	//--------------------------------------------- add Product begin
	self.disable_add_product = true;
	self.disable_save = true;
	self.addProduct = function (product) {
		self.shipment.shipmentDetail.push({
			/*'product_id' : 0,
			'product_name' : null,
			'product_type' : null,
			'height' : 0,
			'max_width' : 0,
			'max_length' : 0,
			'max_weight' : 0,
			'product_quantity' : 0,
			'product_unitprice' : 0,
			'product_totalprice' : 0*/
			
			"product" : {}

		});
		
	}

	//--------------------------------------------- add Product end
	
	//---------------------------------------------- Select All begin
/*	self.product_selectAll = function() {
		for(var i=0; i<self.shipment.shipmentDetail.length; i++) {
			self.shipment.shipmentDetail[i].selected = self.selectAll_product;
		}
		
	}*/
	//---------------------------------------------- Select All end
	
	
	//--------------------------------------------- remove Product beging
	self.removeProduct = function () {
        var selectedProductList=[];
        $scope.selectedAll = false;
        angular.forEach(self.shipment.shipmentDetail, function(selected){
            if(!selected.selected){
            	selectedProductList.push(selected);
            }
        }); 
        self.shipment.shipmentDetail = selectedProductList;
        self.checkQuantity(-1); // Call CheckQuantity method for check whethere noofparcel == qunatity
	}
	//--------------------------------------------- remove Product end
	
	//----------------------------------------------------------------------- Declare Product Detailed end
	
	
	//---------------------------------------------- Search service begin
	$scope.service_name=function (selected){
		
		makeenable_shipmentDetail_add();  // make enable shipment detail 
		self.shipment.service = selected.originalObject;
		
	}
	//---------------------------------------------- Search service end
	
	//------------------------ MAKE SAVE ENABLE BEGIN
	
	function make_enable_save(index) {
		
		
		if(index != -1) {

			if (self.shipment.shipmentDetail[index].shipmentHsnDetail[0].hsn == null ) {
				console.log(index);
				self.disable_save = true;
			} else {
				var quantity = 0;
				for(var i=0; i<self.shipment.shipmentDetail.length; i++) {
					selected_quantity = self.shipment.shipmentDetail[i].quantity;
					quantity = parseInt(selected_quantity) + parseInt(quantity);	
					
				}
				
				if(quantity == self.shipment.numberof_parcel) {
					self.disable_save = false;
				} else {
					self.disable_save = true;
				}
				
			}
		} 
			
	}
	
	//------------------------ MAKE SAVE ENABLE END
	
	//------------------------ CHECK shipment detail if consignee branch, service and no of parcel != 0 begin
	function makeenable_shipmentDetail_add() {
		
		if( self.shipment.numberof_parcel == null 
				||  $('#service_name_value').val().length == 0 
				|| $('#consignee_branch_name_value').val().length == 0 ) {
			self.disable_add_product = true;
		} else {
			self.disable_add_product = false;
		}
	}
	//------------------------ CHECK shipment detail if consignee branch, service and no of parcel != 0 end
	
	//--------------------------------------------- Compare quantity and no of parcel beging
	self.checkQuantity = function (index) {
		/*self.disable_add_product = false;*/
		makeenable_shipmentDetail_add();  // make enable shipment detail 
		
		var quantity = 0;
		var selected_quantity = 0;
		for(var i = 0; i < self.shipment.shipmentDetail.length; i++) {
			
			selected_quantity = self.shipment.shipmentDetail[i].quantity;
			
			if(self.shipment.shipmentDetail[i].quantity == null || isNaN(self.shipment.shipmentDetail[i].quantity) ) {
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
								self.shipment.shipmentDetail[i].quantity = null;
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

		
		make_enable_save(index) // make enable save
	}
	//--------------------------------------------- Compare quantity and no of parcel end	

	//---------------------------------------------- Search Product name begin
	$scope.product_name=function (selected){
		
		var index = this.$parent.$index;
		
		//-- assign object
		self.shipment.shipmentDetail[index].product = selected.originalObject;
		
		self.shipment.shipmentDetail[index].shipmentHsnDetail = [{"hsn" : null, "product" : null}];
		//self.shipment.shipmentDetail[index].shipmentHsnDetail = [];
		//-- assign to dynamic table in product
		/*self.shipment.shipmentDetail[index].product_id = selected.originalObject.product_id;*/
		self.shipment.shipmentDetail[index].product_type = selected.originalObject.product_Type;
		self.shipment.shipmentDetail[index].height = selected.originalObject.max_height;
		self.shipment.shipmentDetail[index].width = selected.originalObject.max_width;
		self.shipment.shipmentDetail[index].length = selected.originalObject.max_length;
		self.shipment.shipmentDetail[index].weight = selected.originalObject.max_weight;
		
		
		
		fetch_price(index);		//----- fetch price from price settings
		
		make_enable_save(index) // make enable save
	}
	
	
	//---------------------------------------------- Search Product name end
	
	//---------------- Fetch product price from price setting begin
	
	function fetch_price(index) {
		self.shipment.forpricesetting = {
				"from_branch_id" : self.shipment.sender_branch.branch_id,
				"to_branch_id" : self.shipment.consignee_branch.branch_id,
				"product_id" : 	self.shipment.shipmentDetail[index].product.product_id,
				"service_id" : self.shipment.service.service_id,
				"max_weight" : self.shipment.shipmentDetail[index].weight
		};
	
		console.log(self.shipment);
		
		priceSettingService.fetch_priceforShipment(self.shipment.forpricesetting)
			.then(
					function(res) {
						
						//self.shipment.handling_charge = res.handling_charges;
						self.shipment.handling_charge = 0;
						self.shipment.shipmentDetail[index].unit_price = parseFloat(res.price);
						
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
	
	//----------------------------- TAX PAYABLE ON REVERSE CHARGE begin
	
	self.tax_payable = function() {
		if( self.shipment.bill_to == "Paid" ) {
			self.shipment.taxin_payable = sender_taxin_payable;
		} else if( self.shipment.bill_to == "To Pay" ) {
			self.shipment.taxin_payable = consignee_taxin_payable;
		} else {
			self.shipment.taxin_payable = null;
		}
		self.calc_discount();
	}
	
	//----------------------------- TAX PAYABLE ON REVERSE CHARGE end
	
	
	//------------------------------ Calculate total price in a row begin
	
	self.calc_totalprice = function (index) {
		self.shipment.shipmentDetail[index].total_price = 
			parseInt(self.shipment.shipmentDetail[index].quantity) * parseFloat(self.shipment.shipmentDetail[index].unit_price);	
		
		//calculate chargeable weight & Delivery charges
		var chargeabled_weight = 0, delivery_charge = 0;
		for(var i = 0; i < self.shipment.shipmentDetail.length; i++) {
			delivery_charge = delivery_charge + self.shipment.shipmentDetail[i].total_price; 
			chargeabled_weight = chargeabled_weight + self.shipment.shipmentDetail[i].weight; 
		}
		
		
		self.shipment.delivery_charge = delivery_charge.toFixed(2);		
		self.shipment.chargeable_weight = chargeabled_weight.toFixed(2);	
		
		self.calc_discount(); // call discount
	}
	
	//------------------------------ Calculate total price in a row end
	
	//------------------------------ Calculate discout percentage & amount begin
	
	self.calc_discount = function() {
		var discount_percent = parseFloat(self.shipment.discount_percentage) / parseInt(100);
		self.shipment.discount_amount = ( parseFloat(self.shipment.delivery_charge) *  (parseFloat(discount_percent)) ).toFixed(2);
		
		if(isNaN(self.shipment.discount_amount)) {
			self.shipment.discount_amount = null;
		}
		if(isNaN(self.shipment.delivery_charge)) {
			self.shipment.delivery_charge = null;
		}
		if(isNaN(self.shipment.chargeable_weight)) {
			self.shipment.chargeable_weight = null;
		}
		
		if( self.shipment.discount_amount != null ) { // if discount is applicable
			self.shipment.total_amount = (parseFloat(self.shipment.delivery_charge) - parseFloat(self.shipment.discount_amount)) 
											+ parseFloat(self.shipment.handling_charge);			
		} else {// if discount is not applicable
			self.shipment.total_amount = parseFloat(self.shipment.delivery_charge) + parseFloat(self.shipment.handling_charge);			
		}
		
		
		fetch_gsts(); // calculate gsts (CGST / SGST / IGST)
	}
	
	//------------------------------ Calculate discout percentage & amount end
	
	//------------------------------ Fetch CGST SGST & IGST from Company setting
	function fetch_gsts() {
				
		CompanySettingService.fetchCompanySetting(1)
			.then(
					function (res) {
						
						if ( self.shipment.taxin_payable == "Yes" ) { // if taxin_payable reverse charge == Yes
							
							if( self.shipment.total_amount >= res.data.gst_slab_amount ) { // if total amt greater or equat to slab amount 
								
								if( self.shipment.sender_branch.location.address.state == self.shipment.consignee_branch.location.address.state ) {
									self.shipment.cgst = ( parseFloat(self.shipment.total_amount) * (parseFloat(res.data.cgst) / 100) ).toFixed(2);
									self.shipment.sgst = ( parseFloat(self.shipment.total_amount) * (parseFloat(res.data.sgst) / 100) ).toFixed(2);
									self.shipment.igst = ( parseFloat(0) );
								} else {
									self.shipment.cgst = ( parseFloat(0) );
									self.shipment.sgst = ( parseFloat(0) );
									self.shipment.igst = ( parseFloat(self.shipment.total_amount) * (parseFloat(res.data.igst) / 100) ).toFixed(2);
								}
								
								
								/*self.shipment.cgst = ( parseFloat(self.shipment.total_amount) * (parseFloat(res.data.cgst) / 100) ).toFixed(2);
								self.shipment.sgst = ( parseFloat(self.shipment.total_amount) * (parseFloat(res.data.sgst) / 100) ).toFixed(2);
								self.shipment.igst = ( parseFloat(self.shipment.total_amount) * (parseFloat(res.data.igst) / 100) ).toFixed(2);*/
								
								self.shipment.tax = ( parseFloat(self.shipment.cgst) + parseFloat(self.shipment.sgst) + parseFloat(self.shipment.igst) ).toFixed(2);
								self.shipment.total_charges = ( parseFloat(self.shipment.total_amount) + parseFloat(self.shipment.tax) ).toFixed(2);
								
							} else {// if total amt less than slab amount
								
								console.log("inside else");
								self.shipment.cgst = ( parseFloat(0) );
								self.shipment.sgst = ( parseFloat(0) );
								self.shipment.tax = ( parseFloat(0) );
								self.shipment.total_charges = parseFloat(self.shipment.total_amount);
							}
						} else {
							self.shipment.cgst = ( parseFloat(0) );
							self.shipment.sgst = ( parseFloat(0) );
							self.shipment.tax = ( parseFloat(0) );
							self.shipment.total_charges = parseFloat(self.shipment.total_amount);
						}
						
					}, function (errRes) {
						console.log(errRes);
					} 
				);
	}
	//------------------------------------------------------------- ADD SHIPMENT DETAILED TABLE END----------------------------------------
	
	//------------------------------------------------------------------------------HSN FUNCTIONS BEGIN
	
	//------------------------------------------------------------- ADD HSN BEGIN
	
	self.addHSN = function (index, hsn) {
		self.shipment.shipmentDetail[index].shipmentHsnDetail.push({});
	}
	
	
	//------------------------------------------------------------- ADD HSN END
	
	//--------------------------------------------- remove Product beging
	self.removeHSN = function (index) {

        var selectedHSNList=[];
        $scope.HSNselectedAll = false;
        angular.forEach(self.shipment.shipmentDetail[index].shipmentHsnDetail, function(selected){
            if(!selected.selected){
            	selectedHSNList.push(selected);
            }
        }); 
        self.shipment.shipmentDetail[index].shipmentHsnDetail = selectedHSNList;
        
	}
	//--------------------------------------------- remove Product end	
	
	
	//---------------------------------------------- HSN CODE SEARCH begin
	$scope.hsn_code=function (selected){
		var index = this.$parent.$index;
		var products_index = this.$parent.$parent.$index;
		hsncode_desc_proc(selected, index, products_index);
	}
	//---------------------------------------------- HSN CODE SEARCH end
	
	//---------------------------------------------- HSN DESCRIPTION SEARCH begin
	$scope.hsn_description=function (selected){
		var index = this.$parent.$index;
		var products_index = this.$parent.$parent.$index;
		hsncode_desc_proc(selected, index, products_index);
		
	}
	//---------------------------------------------- HSN DESCRIPTION SEARCH end

	function hsncode_desc_proc(selected, index, products_index) {
		

		//-- assign object
		
		self.shipment.shipmentDetail[products_index].shipmentHsnDetail[index].hsn = selected.originalObject;
		$('#product'+ products_index +'_hsn_description'+index+'_value').val(selected.originalObject.hsn_description);
		
		$('#product'+ products_index +'_hsn_code'+index+'_value').val(selected.originalObject.hsn_code);
		
		self.shipment.shipmentDetail[products_index].shipmentHsnDetail[index].product = self.shipment.shipmentDetail[products_index].product;
		
		self.shipment.shipmentDetail[products_index].viewHSNDetail_link = true; //for HSN detail link
		//for view hsn_code
		var hsn_code = [];
		for ( var i =0; i<self.shipment.shipmentDetail[products_index].shipmentHsnDetail.length; i++ ) {
			hsn_code[i] = self.shipment.shipmentDetail[products_index].shipmentHsnDetail[i].hsn.hsn_code;			
		}
		$('#HSNmodal_a'+products_index).attr("title", hsn_code);
		$('#product'+ products_index +'_hsn_description'+index+'_value')
			.attr("title", $('#product'+ products_index +'_hsn_description'+index+'_value').val());
		$scope.newHSN.push( selected.originalObject );
		make_enable_save(products_index); // make enable save
	}
	
	//------------------------------------------------------------------------------HSN FUNCTIONS END	
	
	//----------------------------------------------------------------- ADD SHIPMENT SUBMIT BEGIN------------------------------------
	
	//------------------------- Create new shipment begin --------------------------------------------//
    function createShipment(shipment){
    	ShipmentService.createShipment(shipment)
            .then(
            		function (lr_details) {
            			
                        self.message = " shipment created..! Shipment LR No. is "+lr_details.lrno_prefix;
            			successAnimate('.success');  
            			reset();
            			
            			bill_open(lr_details.lrno);
            			
            		},
           
            function(errResponse){
            			
    			self.message = "Error while creating shipment..! ";
    			successAnimate('.failure');                  
            }
        );
    } 
	//------------------------- Create new shipment end ----------------------------------------------//  
    
	self.submit = function () {
		
		
		if ( $('#sender_location_name_value').val().length == 0 ) {
			$("#sender_location_name_value").focus();
		} else if ( $('#consignee_branch_name_value').val().length == 0 ) {
			$("#consignee_branch_name_value").focus();
		} else if ( $("#consignee_location_name_value").val().length == 0 ) {
			$("#consignee_location_name_value").focus();
		} else if ( $("#service_name_value").val().length == 0 ) {
			$("#service_name_value").focus();
		} else {
			self.shipment.lr_number = $('#lr_number').val();
			delete self.shipment.forpricesetting;
			for(var i=0; i<self.shipment.shipmentDetail.length; i++ ) {
				delete self.shipment.shipmentDetail[i].product_type;	
				delete self.shipment.shipmentDetail[i].viewHSNDetail_link;
			}
			self.shipment.sendercustomer_address1 = self.shipment.sender_customer.customer_addressline1;
			self.shipment.sendercustomer_address2 = self.shipment.sender_customer.customer_addressline2;
			self.shipment.consigneecustomer_address1 = self.shipment.consignee_customer.customer_addressline1;
			self.shipment.consigneecustomer_address2 = self.shipment.consignee_customer.customer_addressline2;
			self.shipment.sender_location = self.shipment.sender_customer.location;
			self.shipment.consignee_location = self.shipment.consignee_customer.location;
			
			
			if( self.shipment.shipment_id == null ) {
				
				self.confirm_title = 'Save';
				self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
				self.confirm_msg = self.confirm_title+ ' shipment?';
				self.confirm_btnclass = 'btn-success';
				ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
					.then(
							function (res) {
										 	    		
								createShipment(self.shipment);  
								
							}
						);
				
			}
		}
				
	}
	

	//----------------------------------------------------------------- ADD SHIPMENT SUBMIT END------------------------------------
	
	 
	

	
}]);
