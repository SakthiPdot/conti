/**
 * @Project_Name conti
 * @Package_Name custom js Receipt
 * @File_name Receipt_controller.js
 * @author Suresh
 * @Updated_user Suresh
  @Created_date_time August 09, 2017 11:31:53 AM
 * @Updated_date_time August 09, 2017 11:31:53 AM
 */

contiApp.controller('ReceiptController',['$scope','$http','$q','$timeout','ReceiptService','BranchService','ConfirmDialogService',function($scope,$http,$q,$timeout,ReceiptService,BranchService,ConfirmDialogService)
{
	var self=this;
	self.shipment = {}; // for individual view shipment
	self.receipts=[];
	self.receipt={
			"frombranch" : "",
			"tobranch" : "",
			"fromdate" : "",
			"todate" : "",
			"status":"",
	};
	self.receiptFilter=receiptFilter;
	self.selected_receipt=[];
	self.Filterreceipts={};
	self.receipts=[];
	self.heading="Master"
	self.message=null;
	self.print=print;
	self.receiptSearch=receiptSearch;
	self.receiptSelect=receiptSelect;
	self.makeReturn=makeReturn;
	self.makePending=makePending;
	self.makeDelete=makeDelete;
	self.receiptSelectAll=receiptSelectAll;
	self.shownoofRecord=shownoofRecord;
	$scope.shownoofrec=10;

	self.receiptSelectAll=receiptSelectAll;
	
	fetchAllReceipt_view();
	fetchAllBranches();
	
	var branch_id=$('#branch_id').val();
//	var branch_flag=$('#branch_flag').val();
	var authen_flag=$('#authen_flag').val();//for identify the Manager and Staff role
	self.receipt.tobranch=parseInt(branch_id);//for default assigning the to branch name in receipt filter
	
	function reset()
	{
		self.manifest={};
		self.heading='Master';
		fetchAllManifest();
	}	

	//-----------------------------New and close function---------------------------	
	function newOrClose(){
		console.log(self.save);				
		if(self.save== "saveclose" ){
			 drawerClose('.drawer') ;
		}
		reset();
	}
	
	//-------------------------------------------------------------------------------
	
	 //------------------------------------- VIEW SHIPEMNT INDUVIDUAL OPEN BEGIN
	 
	 self.view1Shipmet = function (receipt) {
		 self.shipment = receipt.shipmentModel;
		 self.receiptPr_id =  receipt.receipt_id;
		 self.receipt_number =  receipt.temp_receiptno;
		 self.receipt_date =  receipt.temp_date;
		 self.manifest_number=receipt.temp_manifestno;
		 if(self.shipment.sender_location==null){
				//self.shipment.sender_location.address.city = self.shipment.sender_city.city;
				$('#sender_city').val(self.shipment.sender_city.city);
				$('#sender_state').val(self.shipment.sender_city.state);
				$('#sender_country').val(self.shipment.sender_city.country);
			 }
			 if(self.shipment.consignee_location==null){
					//self.shipment.sender_location.address.city = self.shipment.sender_city.city;
					$('#consignee_city').val(self.shipment.consignee_city.city);
					$('#consignee_state').val(self.shipment.consignee_city.state);
					$('#consignee_country').val(self.shipment.consignee_city.country);
				 }
		 viewShipment_Animate('.shipment_View', 'OPEN');
	 }
	 
	 //------------------------------------- VIEW SHIPEMNT INDUVIDUAL OPEN END
	 
	 //------------------------------------- VIEW SHIPEMNT INDUVIDUAL CLOSE BEGIN
	 
	 self.viewShipemntClose = function () {
		 viewShipment_Animate('.shipment_View', 'CLOSE');
	 }
	 
	 //------------------------------------- VIEW SHIPEMNT INDUVIDUAL CLOSE END
	 
	//------------------------------------- SHIPEMNT PRINT BEGIN
	 self.shipmentPrint = function (shipment) {
		 bill_open(shipment.shipment_id);
	 }
	 //------------------------------------- SHIPEMNT PRINT END
	 
	//------------------------------------- SHIPEMNT PRINT BEGIN
	 self.receiptPrint = function (receipt_id) {
		 afterSave(receipt_id);
	 }
	 //------------------------------------- SHIPEMNT PRINT END
	 
	function close(title)
	{
		ConfirmDialogService.confirmBox(title,
				BootstrapDialog.TYPE_WARNING, title+" Without Save ..? ", 'btn-warning')
		.then(function(response){
			 drawerClose('.drawer');
				reset();
		});
	}
	
	//----------------------------------------------------------------------------
	
	//-------------------------- Fetch All Branch begin ---------------------//	
	
	function fetchAllBranches() 
	{
		console.log("get all branches")
		BranchService.fetchAllBranches()
		.then(
				function (branches) 
				{
					self.branches = branches;
					
					//console.log("get all branches "+self.branches)
				}, 
				function (errResponse) 
				{
					console.log('Error while fetching branches');
				}
			);
//			if($('#currentUserRole').val() == "SUPER_ADMIN") {
//				self.fromBranch_disable = false;
//				//self.receipt.frombranch = parseInt($('#branch_id').val());
//			} else {
//				self.fromBranch_disable = false;
//				self.receipt.frombranch = self.receipt.frombranch;
//				//self.receipt.frombranch = parseInt($('#branch_id').val());
//			}	
	}
	 //fetchAllBranches(); 
	//-------------------------- Fetch All Branch end ---------------------//
	
	//---------------------------Fetch All Receipt details start----------------------
	function fetchAllReceipt_view()
	{
		ReceiptService.fetchAllReceipt_view()
		.then(
				function(receipt)
				{
					self.receipts=receipt;
					self.Filterreceipts=self.receipts;
					console.log(self.Filterreceipts);
					pagination();
				},
				function(errResponse)
				{
					console.log('Error while fetching Receipt');
				}
			);
	}
	//--------------------------------------------------------------------

	//-----------------------Receipt select all check box function start-------------------------
	
	function receiptSelectAll()
	{
		console.log('Call select all receipt '+$scope.pageSize);
		self.selected_receipt=[];
		for (var i=0; i<$scope.pageSize;i++)
		{
			self.Filterreceipts[i].select=$scope.selectallreceipts;
			if($scope.selectallreceipts)
			{
				self.selected_receipt.push(self.Filterreceipts[i]);
			}
		}
	}
	//---------------------------------------------------------------------------------------------
	
	//-----------------------------Receipt record select on Register------------------------------
	
	function receiptSelect(receipt)
	{
		console.log('Call Receipt select function ....');
		var index=self.selected_receipt.indexOf(receipt);
		if(receipt.select)
		{
			self.selected_receipt.push(receipt);
		}
		else
		{
			self.selected_receipt.splice(index,1);
		}
	}
	//---------------------------------------------------------------------------------------------

	//--------------------------------------Show number of records-------------------------------------
	
	function shownoofRecord()
	{
		$scope.pageSize=$scope.shownoofrec;
		self.Filterreceipts=self.receipts.slice($scope.currentPage*$scope.pageSize);
		if(self.Filterreceipts.length<=$scope.pageSize)
		{
			$scope.previousDisabled=true;
			$scope.nextDisabled=true;
		}
		else
		{
			$scope.nextDisabled=false;
		}
	}
	//------------------------------------------------------------------------------------------------
	
	//----------------------------------------Register Search-----------------------------------------
	
	function registerSearch(searchkey)
	{
		if(searchkey.length==0)
		{
			self.Filterreceipts=self.receipts;
		}
		else if(searchkey.length>3)
		{
			Branch
		}
	}
	//----------------------------------------------------------------------------------------------------
	
	//-----------------------Record count begin-------------------------------------
	
	function findrecord_count()
	{
		BranchService.findrecord_count()
		.then(
				function(record_count)
				{
					console.log(record_count);
					$scope.totalnof_record_count;
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
		console.log(self.Filterreceipts.length);
		if(self.Filterreceipts.length==0)
		{
			BranchService.pagination_byPage($scope.currentPage)
			.then(function(filterReceipt){
					if(filterReceipt.length==0)
					{
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
		if($scope.currentPage==0)
		{
			$scope.previouseDisabled=true;
		}
		if(nextPrevMultiplier ==-1)
		{
			$scope.nextDisabled=false;
		}
		else
		{
			$scope.previouseDisabled=false;
		}
	}
	
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
			fetchAllReceipt_view();
		}
		else
		{
			$scope.currentPage=((Math.ceil(self.Filterreceipts.length/$scope.pageSize))-1);
			$scope.previouseDisabled+false;
			$scope.nextDisabled=true;
			self.Filterreceipts=self.receipts.slice($scope.currentPage*$scope.pageSize)
			console.log(self.Filterreceipts.length);
			if(self.Filterreceipts.length==0)
			{
				BranchService.pagination_byPage(page)
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
	}
	
	//-------------------------------View Receipt filter function----------------------------------
	
	function receiptFilter(){
		//	self.receipt.frombranch=$('#branch_id').val();
		if($('.datepicker1').val().length != 0) {
			self.receipt.fromdate = $('.datepicker1').val();	
		} 
		if($('.datepicker2').val().length != 0) {
			self.receipt.todate = $('.datepicker2').val();	
		} 
		console.log(self.receipt);
		ReceiptService.receiptFilter(self.receipt)
		.then(function(receipt){
					console.log(receipt);
					self.receipts=receipt;
					self.Filterreceipts=self.receipts;
					pagination();
				},
				function(errResponse){
					console.log('Error while filtering receipt records');
				}
			);
	}
	
	//-------------------------------Receipt register search-------------------------
	
	function receiptSearch(key){
		console.log(self.Filterreceipts);
		if (key.length==0) {
			self.Filterreceipts = self.receipts;
    	}else if(self.search.length>3){
			ReceiptService.receiptSearch(key)
			.then(function(filterreceipt){
				self.Filterreceipts=filterreceipt;	
				console.log(filterreceipt);
			},
			function(errResponse){
				console.log('Error while searching receipt');
			});
			
		}else{
			self.Filterreceipts=_.filter(self.receipts,function(item){
				return searchUtil(item,key)
				//return String((item.shipmentModel.lrno_prefix.toLowerCase()).indexOf(key.toLowerCase()) > -1);
			});
		}
			
	}
	
	
	function searchUtil(item,key){
		var success=false;
		if((item.shipmentModel.lrno_prefix.toLowerCase()).indexOf(String(key))>-1 ||
				(item.temp_receiptno.toLowerCase()).indexOf(String(key))>-1 ){
			success=true;
		}else{
			success=false;
		}
		return success
	}
	//-------------------------------------- Print begin -----------------------------//
	function print() {
	    	if(self.selected_receipt.length == 0 ) {
		   		self.message ="Please select atleast one record..!";
				successAnimate('.failure');
	    	} else {
	    		$http.get('http://localhost:8080/Conti/listprint');
	    	}
	    }
	    
//-------------------Make Pending function start---------------------------------//
	
	function makePending(){
		if(self.selected_receipt.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
		} else {
			var flag = 0;
			var b_flag = 'false';
			var receiptid=self.selected_receipt[0].receipt_id;
			var activate_flag = 0;
			angular.forEach(self.selected_receipt, function(receipt){
				if(receipt.shipmentModel.status== 'Pending') {
					flag = 1;
				}
			});
			for(var i=0; i<self.selected_receipt.length;i++)
			{
				if(self.selected_receipt[0].shipmentModel.consignee_branch.branch_id!=self.selected_receipt[i].shipmentModel.consignee_branch.branch_id)
				{
					b_flag='true';
				}
			}
			if(self.receipt.tobranch!=branch_id && authen_flag=='MANAGER_OR_STAFF')
			{
				self.message ="Origin branch user only can allow to perform Pending action...!";
				successAnimate('.failure');
			}
			else if(b_flag=='true')
			{
				self.message ="Please select same consignee branch detail...!";
				successAnimate('.failure');
			}
			else if(flag == 1) {
				self.message ="Selected record(s) already in Pending Status...!";
				successAnimate('.failure');
			} else {
				self.confirm_title = 'Pending';
				self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
				self.confirm_msg =' make selected record(s) status as '+self.confirm_title+' ?';
				self.confirm_btnclass = 'btn-success';
				ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(function (res) {
							var active_id = [];
			    			for(var i=0; i<self.selected_receipt.length; i++) {
			    				 console.log("id "+i  +" Value: "+self.selected_receipt[i].receipt_id);
			    				 active_id[i] = self.selected_receipt[i].receiptdetailid;
		    				}
			    			ReceiptService.makePending(active_id)
							.then(function(response) {
										fetchAllReceipt_view();
										self.selected_receipt = [];
										self.message ="Selected record(s) has in Pending status..!";
										successAnimate('.success');
									}, function(errResponse) {
										console.log(errResponse);    								
								}
							);
						}
					);
			}
		}
	}
	
	
//--------------------- Make Return function start---------------------------------	
	function makeReturn(){
		 console.log('call make Return function....');
		if(self.selected_receipt.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
		} else {
			var activate_flag = 0;
			var flag = 0;
			var b_flag = 'false';
			var receiptid=self.selected_receipt[0].receipt_id;
			angular.forEach(self.selected_receipt, function(receipt){
				if(receipt.shipmentModel.status== 'Return'){
					flag = 1;
				} 
			});
			for(var i=0; i<self.selected_receipt.length;i++)
			{
				if(self.selected_receipt[0].shipmentModel.consignee_branch.branch_id!=self.selected_receipt[i].shipmentModel.consignee_branch.branch_id)
				{
					b_flag='true';
				}
			}
			if(self.receipt.tobranch!=branch_id && authen_flag=='MANAGER_OR_STAFF')
			{
				self.message ="Origin branch user only can allow to perform Return action...!";
				successAnimate('.failure');
			}
			else if(b_flag=='true')
			{
				self.message ="Please select same consignee branch detail...!";
				successAnimate('.failure');
			}
			else if(flag == 1) {
				self.message ="Please Select same receipt detail..!";
				successAnimate('.failure');
			} else {
				self.confirm_title = 'Return';
				self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
				self.confirm_msg =' make selected record(s) status as '+self.confirm_title+' ?';
				self.confirm_btnclass = 'btn-success';
				ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(function (res) {
							var active_id = [];
			    			for(var i=0; i<self.selected_receipt.length; i++) {
			    				active_id[i] = self.selected_receipt[i].receiptdetailid; 
			    				console.log(active_id[i] );
			    			}
							ReceiptService.makeReturn(active_id)
							.then(function(response) {
										fetchAllReceipt_view();
										self.selected_receipt = [];
										self.message ="Selected record(s) has in Return status..!";
										successAnimate('.success');
									}, function(errResponse) {
										console.log(errResponse);    								
									}
							);
						}
					);
				
			}
		}
	}
	
	//--------------------- Make Receipt delete function start---------------------------------	
	function makeDelete(){
		 console.log('call make delete function....');
		 console.log(self.selected_receipt);
		if(self.selected_receipt.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
		} else {
			var activate_flag = 0;
			var receiptid=self.selected_receipt[0].receipt_id;
			var flag = 0;
			var b_flag = 'false';
			angular.forEach(self.selected_receipt, function(receipt){
				if(receipt.shipmentModel.status!= 'Received') {
					flag = 1;
				}
			});
			for(var i=0; i<self.selected_receipt.length;i++)
			{
				if(self.selected_receipt[0].shipmentModel.consignee_branch.branch_id!=self.selected_receipt[i].shipmentModel.consignee_branch.branch_id)
				{
					b_flag='true';
				}
			}
			if(self.receipt.tobranch!=branch_id && authen_flag=='MANAGER_OR_STAFF')
			{
				self.message ="Origin branch user only can allow to Delete...!";
				successAnimate('.failure');
			}
			else if(b_flag=='true')
			{
				self.message ="Please select same consignee branch detail...!";
				successAnimate('.failure');
			}
			else if(flag == 0) {
				self.message ="Selected record(s) already in Received status..!";
				successAnimate('.failure');
			} else {
				self.confirm_title = 'Delete';
				self.confirm_type = BootstrapDialog.TYPE_DANGER;
				self.confirm_msg =' make selected record(s) as '+self.confirm_title+' ?';
				self.confirm_btnclass = 'btn-danger';
				ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
				.then(function (res) {
							var active_id = [];
			    			for(var i=0; i<self.selected_receipt.length; i++) {
			    				active_id[i] = self.selected_receipt[i].receiptdetailid; 
			    				console.log(active_id[i] );
			    			}
							ReceiptService.makeDelete(active_id)
							.then(function(response) {
										fetchAllReceipt_view();
										self.selected_receipt = [];
										self.message ="Selected record(s) has in Received status..!";
										successAnimate('.success');
									}, function(errResponse) {
										console.log(errResponse);    								
									}
								);
						}
					);
				}
			}
		}
	
	}
]);