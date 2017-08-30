/**
 * @Project_Name conti
 * @Package_Name custom js Receipt
 * @File_name Receipt_controller.js
 * @author Suresh
 * @Updated_user Suresh
  @Created_date_time August 09, 2017 11:31:53 AM
 * @Updated_date_time August 09, 2017 11:31:53 AM
 */


//======================================function to do after save======================================
	function afterSave(receipt_no){
			valid = true;
			/*location.href='view_receipt';*/
			window.open("Receipt_print/"+receipt_no, '_blank');
		}
	
	

contiApp.controller('ReceiptController',['$scope','$http','$q','$timeout','ReceiptService','BranchService','ConfirmDialogService','addManifestService',
	function($scope,$http,$q,$timeout,ReceiptService,BranchService,ConfirmDialogService,addManifestService)
{
	var self=this;
	$scope.shownoofrec = 10;
	self.receipts=[];
	self.selected_receipt=[];
	self.Filterreceipts=[];

	self.heading="Manster"
	self.message=null;
	self.print=print;
	self.currentBranch=[];
	self.viewShipment=viewShipment;
	self.receiptSelect=receiptSelect;
	self.registerSearch=registerSearch;
	self.receiptSelectAll=receiptSelectAll;
	self.receiptSubmit=receiptSubmit;
	self.getLastReceiptNo=getLastReceiptNo;
	

	fetchAllReceipt_add();
		
	function reset()
	{
		self.receipt={};
		self.heading='Master';
		fetchAllReceipt();
	}	

	//===================================fetch Address====================================
    self.shownoofRecord=function shownoofRecord() {    
    	
    	$scope.pageSize = $scope.shownoofrec;
    	
    	self.Filterreceipts=self.receipts.slice($scope.currentPage*$scope.pageSize);
    	if( self.Filterreceipts.length < $scope.pageSize ) {
    		$scope.previouseDisabled = true;
    		$scope.nextDisabled = true;
    	}else{
    		$scope.nextDisabled=false;
    	}
    	fetchAllReceipt_add();
    }
    
	//-----------------------------New and close function---------------------------	
	function newOrClose(){
		console.log(self.save);				
		if(self.save== "saveclose" ){
			 drawerClose('.drawer') ;
		}
		reset();
	}

self.receipt={
			    "receipt_id": null,
			    "updated_by": null,
			    "created_by": null,
			    "receipt_number": null,
			    "contact_number": null,
			    "paymode": null,
			    "courier_staff": null,
			    "obsolete": null,
			    "created_datetime": null,
			    "updated_datetime": null,
			    "local_transport": null,
			    "receipt_total": null,
			    "receiptDetailList": [
			        {
			            "receiptdetailid": null,
			            "handling_charge": null,
			            "net_freight_charges": null,
			            "shipmentModel":null,
			            "manifestModel": null
			        }
			    ]
			};


function resetSorting(){
	$scope.lrno = false;
	$scope.origin = false;
	$scope.destination = false;
	$scope.sender = false;
	$scope.consignee = false;
	$scope.totalParcel = false;
	$scope.weight = false;
	$scope.service = false;
	$scope.date = false;
	$scope.status = false;
	$scope.pm = false;
}

	// ===================================sort table====================================
$scope.sortTable=function(x,status){
	console.log("filer by---"+x,"status---"+status);
	if(!$scope.disableSorting){
		$scope.lastSorted = x;	
		resetSorting();
		$scope[x]=status;
		ReceiptService.sortBy(x,status?"ASC":"DESC")
		.then(
				function(response){
					self.receipts=response;
					self.Filterreceipts=response;
				},function(errRespone){
					console.log("error while filtering shipment in sort"+errRespone);
				});	
	}

}


// ===================================get Last Receipt No====================================

		getLastReceiptNo();
		
		function getLastReceiptNo(){
			ReceiptService.getLastReceiptNo()
			.then(
					function (response) {					
						$scope.lastReceiptNumber=response;
						console.log($scope.lastReceiptNumber);
					}, 
					function (errResponse) {
						console.log(errResponse);
						console.log('Error while fetching last man no');
					});	
		}

		function receiptSubmit(){
			console.log(self.receipt);
			
			$('#myModal').css('z-index','1039');
			
			
			ConfirmDialogService.confirmBox("Save",
					BootstrapDialog.TYPE_SUCCESS, "Save Receipt  ..?", 'btn-success')
			.then(
					function(response){

						
						
						for(var i=0;i<self.selected_receipt.length;i++){
							
							self.receipt.receiptDetailList[i].shipmentModel=self.selected_receipt[i];
							self.receipt.receiptDetailList[i].handling_charge=self.selected_receipt[i].h_charge;
							console.log("handlingcharge",self.receipt.receiptDetailList[i].shipmentModel.h_charge);
						
							if(i<self.selected_receipt.length-1){
								self.receipt.receiptDetailList.push({
						            "receiptdetailid": null,
						            "handling_charge": null,
						            "net_freight_charges": null,
						            "shipmentModel":null,
						            "manifestModel": null
						        });
							}
						}
						

						ReceiptService.saveReceipt(self.receipt)
						.then(
								function(receipt){
										console.log(receipt);
										console.log('save success');
										self.message = "Receipt ( "+receipt.Receipt_NO+" ) Created Successfully..! ";
										successAnimate('.success');	
										setTimeout(function(){afterSave(receipt.Receipt_id);}, 4000);
								},
								function(errResponse){
									console.log('Error while saving Receipt.');
									self.message = "Error While Creating Receipt ..!";
									successAnimate('.failure');
									setTimeout(function(){ location.reload(); }, 4000);	
								}
							);
						
						},function(errResponse){
							$('#myModal').css('z-index','1050');
						});
			
			
		}

// ===================================onchange of angucomplete====================================
$scope.staff_name = function(selected) {
	
	

	$('#contact_number').empty();
	self.receipt.contact_number=null;
	if (typeof selected != 'undefined' ) {	
		console.log(selected);
		
		
		if(typeof(selected.originalObject.courier_staff) == "undefined"){
			self.receipt.courier_staff=selected.originalObject;
		}else{
			self.receipt.courier_staff=selected.originalObject.courier_staff;
		}
		
	/*	ReceiptService.checkCourierStaffUnique(self.receipt.courier_staff)
		.then(
				function(response){
					console.log(response)
				},
				function(errResponse){
					console.log('Error while checking unique.');
					$('#contact_number').empty();
					self.receipt.contact_number=null;
				}
			);
		*/
		
		ReceiptService.getContactNumber(selected.originalObject.courier_staff)
		.then(
				function(receipt){
					for(var i=0;i<receipt.length;i++){
						$('#contact_number').append("<option value='"+receipt[i].contact_number+"'>");
					}
				},
				function(errResponse){
					console.log('Error while fetching Receipt.');
					$('#contact_number').empty();
					self.receipt.contact_number=null;
				}
			);

		console.log(self.receipt.courier_staff);
	} else {
		self.receipt.contact_number=null;
		$('#contact_number').empty();
	}
}
	//===================================on modal open calculate freight charge====================================	

	
$scope.checkSenderConsignee =function (){
		
		var sender=true,consignee=true;

		for(var i=0;i<self.selected_receipt.length;i++){
			
			if(self.selected_receipt[0].sender_customer.customer_id !=self.selected_receipt[i].sender_customer.customer_id){
				sender=false;
			}
			
			
			if(self.selected_receipt[0].consignee_customer.customer_id !=self.selected_receipt[i].consignee_customer.customer_id){
				consignee=false;
			}			
		}	
		showMessageSenderConsignee(sender,consignee,self.selected_receipt[0].sender_customer.customer_id ,self.selected_receipt[0].consignee_customer.customer_id);
	}
	
		function showMessageSenderConsignee(x,y,origin_id,destination_id){
			var msg="";
			
			if(x==false && y==false){
				msg="Both Sender And Customer Are Different." + "<br/>" +"Please Select Same Sender And Customer."
			}else if(x==false ){
				msg="Please Select Same Sender."
			}else if(y==false){
				msg="Please Select Same  Customer."
			}else{	
				$('#myModal').modal('show');
				
				$("#myModal").on('shown.bs.modal', function(){
					
					$timeout(function(){
						
						$scope.showDoorDelivery=false;	
						var total=0;
						
						for(var i=0;i<self.selected_receipt.length;i++){
							console.log(self.selected_receipt[i].bill_to.trim());
							if(self.selected_receipt[i].bill_to.trim()==$("#to_pay").val().trim()){
								total = parseInt(total)+parseInt(self.selected_receipt[i].total_charges);
							}
							if(self.selected_receipt[i].service.service_name=="Door Delivery"){
								$scope.showDoorDelivery=true;	
							}
							$scope.allLR_freight_charge=total;
							
						}
					 })
				});
				
			}
			
			if(msg.trim().length!=0){
				BootstrapDialog.alert({	
					title:' Receipt Alert',
					message: msg,
					type: BootstrapDialog.TYPE_DANGER, // <-- Default value is BootstrapDialog.TYPE_PRIMARY
					closable: false, 
					draggable: false});
				
				self.selectallreceipts=false;
				self.receiptSelectAll()
				
			}
		}
	
	$scope.showDoorDelivery=true;
	
	function close(title)
	{
		ConfirmDialogService.confirmBox(title,
				BootstrapDialog.TYPE_WARNING, title+" Without Save ..? ", 'btn-warning')
		.then(function(response){
			 drawerClose('.drawer');
				reset();
		});
	}
	
	//===================================fetch ALL BRANCH====================================	
	fetchAllBranches();	
	
	function fetchAllBranches() 
	{
		BranchService.fetchAllBranchesForManifest()
			.then(
			function(response) {
				self.branches = response;
			},
			function(errResponse) {
				console.log('Error while fetching branches');
					}
				);
	}
	
	
	//===================================GET USER BRANCH DETAILS====================================
	getUserBranchDetails();
	
	function getUserBranchDetails() {				
		addManifestService.getUserBranchDetails()
		.then(
				function (response) {		
					$scope.current_branch=response;	
					$scope.tobranch_filter=String(response.branch_id);
					$scope.tobranch_sample=response.branch_name;
				}, 
				function (errResponse) {
					console.log(errResponse);
					console.log('Error while fetching user branch');
				});
	}


	
	//---------------------------Fetch All Receipt details start----------------------
	function fetchAllReceipt_add()
	{
		ReceiptService.fetchAllReceipt_add()
		.then(
				function(receipt){
					self.receipts=receipt;
					self.Filterreceipts=self.receipts;
					pagination();
				},
				function(errResponse){
					console.log('Error while fetching Receipt');
				}
			);
	}
	//-------------------------------------------------------------------------------
	$scope.frombranch_filter=null;
	$scope.tobranch_filter=null;
	$scope.fromdate_filter=null;
	$scope.todate_filter=null;
	$scope.service_filter=null;
	$scope.paymode_filter=null;
	
	//--------------------View shipment filter condition-------------------------------
	
	function viewShipment()
	{
		
		var filter={
				"fromBranch":$scope.frombranch_filter,
				"toBranch":$scope.tobranch_filter,
				"fromDate":$(".datepicker1").val(),
				"toDate":$(".datepicker2").val(),
				"service":$scope.service_filter,
				"paymentMode":$scope.paymode_filter	
		}
		console.log(filter);
		ReceiptService.viewShipment(filter)
		.then(
				function(receipt){
					self.Filterreceipts=receipt;
					console.log('Filter shipments details '+self.Filterreceipts);
				},
				function(errResponse){
					console.log('Error while fetching Receipt.');
				}
			);
	}
	//---------------------------------------------------------------------------------
	
	//-----------------------Receipt select all check box function start-------------------------
	function receiptSelectAll(){
		
		
		self.selected_receipt=[];
		
		var size;
		
		console.log($scope.pageSize);
		
		if($scope.pageSize>self.Filterreceipts.length){
			size=self.Filterreceipts.length;
		}else{
			size=$scope.pageSize;
		}
	
		
		
		for (var i=0; i<size;i++){
			console.log($scope.selectallreceipts);
				self.Filterreceipts[i].select=$scope.selectallreceipts;
				if($scope.selectallreceipts){
						self.selected_receipt.push(self.Filterreceipts[i]);
					}
			}
		
		console.log(self.selected_receipt);
	}
	
	//-----------------------------Receipt record select on Register-----------------------------
	function receiptSelect(receipt){
		if (receipt.select) {
			self.selected_receipt.push(receipt);
		} else {
			$scope.selectallreceipts=receipt.select;
			var index = self.selected_receipt.indexOf(receipt);
			self.selected_receipt.splice(index, 1);
		}
		console.log(self.selected_receipt);
	}

	//------------------------------------------------------------------------------------------------
		
	//-----------------------------Record count begin-------------------------------------
	
	//=============================find record count====================================
	
	   
	function findrecord_count()
	{
		ReceiptService.findrecord_count()
		.then(
				function(record_count)
				{
					console.log(record_count);
					$scope.totalnof_records  = record_count;
				},
				function(errResponse)
				{
					console.log('Error while fetching record count....');
				}
			);
	}
	//--------------------------------------------------------------------------------
	
	//------------------------Receipt Pagination--------------------------------------
	
	function pagination()
	{
		$scope.pageSize=$scope.shownoofrec;
		$scope.currentPage=0;
		$scope.totalPages=0;
		self.Filterreceipts=self.receipts;
		$scope.nextDisabled=false;
		$scope.previouseDisabled=true;
		if(self.Filterreceipts.length<=10)
		{
			$scope.nextDisabled=true;
		}
		if(self.Filterreceipts.length<100)
		{
			$scope.totalnof_records=self.Filterreceipts.length;
		}
		else
		{
			findrecord_count();
		}
	}
	//---------------------------------------------------------------------------------
	
	//-----------------------Paginate function start----------------------------------
	
	$scope.paginate=function(nextPrevMultiplier)
	{
		$scope.selectallreceipts=false;
		$scope.currentPage+=(nextPrevMultiplier*1);
		self.Filterreceipts=self.receipts.slice($scope.currentPage*$scope.pageSize);
		
		if(self.Filterreceipts.length==0)
		{
			ReceiptService.paginateFirstOrLast($scope.currentPage)
			.then(
					function(filterReceipt)
					{
						if(filterReceipt.length==0){
							$scope.nextDisabled=true;
						}
						else if(filterReceipt.length<10)
						{
							self.Filterreceipts=filterReceipt;
							$scope.nextDisabled=true;
						}
						else
						{
							self.Filterreceipts=filterReceipt;
						}
					},
					function(errResponse)
					{
						console.log('Error while pagination...');
					}
				);
		}
		if(self.Filterreceipts.length<$scope.pageSize)
		{
			$scope.nextDisabled=true;
		}
		
	 	
    	$scope.disableSorting=  ($scope.currentPage > 0) ?true:false;
    	
    	if($scope.currentPage == 0) {
    		$scope.previouseDisabled = true;
    	}
    	
    	if(nextPrevMultiplier == -1) {    		
    		$scope.nextDisabled = false;
    	} else {
    		$scope.previouseDisabled = false;
    	}
	}
	//------------------------------------------------------------------------------------
	
	//-----------------------------First and Last Pagination------------------------------------
	
	$scope.firstlastPaginate=function(page)
	{
		$scope.selectallreceipts=false;
		if(page==1)
		{
			$scope.currentPage=0;
			$scope.previouseDisabled=true;
			$scope.nextDisabled=false;
			self.Filterreceipts=self.receipts.slice($scope.currentPage*$scope.pageSize);
			fetchAllReceipt_add();
		}
		else
		{
			$scope.currentPage=((Math.ceil(self.Filterreceipts.length/$scope.pageSize))-1);
			$scope.previouseDisabled=false;
			$scope.nextDisabled=true;
			self.Filterreceipts=self.receipts.slice($scope.currentPage*$scope.pageSize)
			console.log(self.Filterreceipts.length);
			if(self.Filterreceipts.length==0)
			{
				ReceiptService.paginateFirstOrLast(page)
				.then(
						function(filterReceipt)
						{
							self.Filterreceipts=filterReceipt;
						},
						function(errResponse)
						{
							console.log('Error while fetching Branch');
						}
					);
			}
		}
		
		$scope.disableSorting=  ($scope.currentPage > 0) ?true:false;
	}
	//-----------------------------------------------------------------------------------------------

	//------------------------------------Register LR number search start----------------------------
	
	function registerSearch(searchkey)
	{
		if(searchkey.length==0)
		{
			self.Filterreceipts=self.receipts;
		}
		else if(searchkey.length>3)
		{
			ReceiptService.registerSearch(searchkey)
			.then(
				function(filterReceipt) {
					self.Filterreceipts = filterReceipt;
				},
				function(errResponse) {
					console.log('Error while fetching branches ');
				});
		}
		else{
			self.Filterreceipts = _.filter(self.receipts, function(item) {
				return String(item.lrno_prefix).indexOf(searchkey) > -1;
					});
		}
	}
	


	//--------------------------------------------------------------------------------------------//
	
	}
]);