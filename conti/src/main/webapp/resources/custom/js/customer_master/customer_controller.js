/**
 * @Project_Name conti
 * @Package_Name custom js customer_controller.js
 * @File_name customer_controller.js
 * @author Sankar
 * @Updated_user Sankar
 * @Created_date_time Jun 26, 2017 12:59:17 PM
 * @Updated_date_time Jun 26, 2017 12:59:17 PM
 */

contiApp.controller('CustomerController', ['$http', '$scope','$q','$timeout', '$window','CustomerService', 'BranchService', 'LocationService', 'ConfirmDialogService', function($http, $scope, $q, $timeout,  $window, CustomerService, BranchService, LocationService, ConfirmDialogService)
{
	$("#screen_customer").addClass("active-menu");
	var self=this;
	self.customers=[];
	self.Filtercustomers = [];
	self.customer={};
	
	self.heading = "Master";
	
	self.message = null;
	self.submit = submit;
	self.save = "saveclose";
	self.reset = reset;
	self.deleteCustomer = deleteCustomer;
	self.updateCustomer = updateCustomer;
	self.close = close;
	self.clear = clear;
	self.customerSelect = customerSelect;
	self.customerSelectall = customerSelectall;
	self.makeActive = makeActive;
	self.makeinActive = makeinActive;
	self.print = print;
	self.shownoofRecord = shownoofRecord;
	self.registerSearch = registerSearch;
	$scope.shownoofrec = 10;
	self.selected_customer = [];
	self.confirm_title = 'Save';
	self.confirm_type = 'TYPE_SUCCESS';
	self.confirm_msg = self.confirm_title+ ' ' + self.customer.customer_name + ' customer?';
	self.confirm_btnclass = 'btn-success';
	//self.selectedBranch = selectedBranch;

	fetchAllCustomers();
	fetchAllBranches();
	fetchAllLocations();
	
	
	$scope.customer_city=function(customer_city){
		console.log(customer_city);
	
		if(customer_city==undefined){
			$("#customer_city").val('');
			self.customer.customer_city=null;
			$("#state").val('');
			$("#country").val('');
		}else{
			self.customer.customer_city=customer_city.originalObject;
			$("#customer_city").val(customer_city.originalObject.city);
			$("#state").val(customer_city.originalObject.state);
			$("#country").val(customer_city.originalObject.country);
		}
	}
	
	
	$scope.location_name=function(location_name){
		console.log(location_name);
		if(location_name==undefined){
			self.customer.location_name=null;
			$("#customer_city_value").val('');
			self.customer.customer_city=null;
			$("#state").val('');
 	    	$("#country").val('');
 	    	$("#pincode").val('');
		}else{
			$('#location_id').val(JSON.stringify(location_name.originalObject));
			self.customer.customer_city=location_name.originalObject;
			self.customer.location_name=location_name.originalObject;
			$("#customer_city_value").val(location_name.originalObject.address.city);
			$("#state").val(location_name.originalObject.address.state);
			$("#country").val(location_name.originalObject.address.country);
			$("#pincode").val(location_name.originalObject.pincode);
		}
	}
	
	function reset () 
	{
		   self.customer = {};
		   $('#branch_name_value').val('');
		   $('#location_name_value').val('');
		   $('#customer_city_value').val('');
		   $('.locations').val('');

	    	self.heading = "Master";
		   /*$scope.$broadcast('angucomplete-alt:clearInput');*/
	    	fetchAllCustomers();

	}
	
	function resetSorting(){
		$scope.customerName  =false;
		$scope.customerCode  =false;
		$scope.customerType  =false;
		$scope.custBranch  =false;
		$scope.custCompanyName  =false;
		$scope.custAddress  =false;
		$scope.custPhoneNumber  =false;
		$scope.custEmail  =false;
		$scope.custStatus  =false;
	}
	// ===================================sort table====================================
	$scope.sortTable=function(x,status){
		console.log(x);
		if(!$scope.disableSorting){
			$scope.lastSorted = x;	
			resetSorting();
			$scope[x]=status;
			CustomerService.sortBy(x,status?"ASC":"DESC")
			.then(function(response){
						self.customers=response;
						self.Filtercustomers =response;
						
					},function(errRespone){
						console.log("error while fetching customer service in search"+errRespone);
					});
		}
	}
	
//---------------------Customer Master drawer close begin-----------
	
	
	function close(title){
		ConfirmDialogService.confirmBox(title,
				BootstrapDialog.TYPE_WARNING, title+" Without Save ..? ", 'btn-warning')
		.then(function(response){
			 drawerClose('.drawer');
				reset();
		});
	}
		
	
	//----------------Customer Master drawer field clear begin------------------
	function clear() {
		self.confirm_title = 'Clear';
		self.confirm_type = BootstrapDialog.TYPE_WARNING;
		self.confirm_msg = self.confirm_title+ ' the data?';
		self.confirm_btnclass = 'btn-warning';
		ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(
					function (res) {
		 	        	reset();
		 	        	
					}
				);
	}
	
	
	//-------------------------- Fetch All Employees Start ---------------------//
	function fetchAllCustomers() {
		CustomerService.fetchAllCustomers()
			.then(
					function (customer) {
						self.customers = customer;
						self.Filtercustomers=self.customers;
						console.log(customer);
						/*fetchAllBranches();	
						fetchAllLocations();	*/	
						pagination();
					}, 
					function (errResponse) {
						console.log('Error while fetching customers');
					}
				);
	}
	//-------------------------- Fetch All Employees end ---------------------//
	
//-------------------------- Fetch All Branch begin ---------------------//	
	
	function fetchAllBranches() {
		BranchService.fetchAllBranches()
			.then(
					function (branches) {
						self.branches = branches;				
					}, 
					function (errResponse) {
						console.log('Error while fetching branches');
					}
				);
	}
	
	//-------------------------- Fetch All Branch end ---------------------//	
	
	//-------------------------- Fetch All Location begin ---------------------//	
	
	function fetchAllLocations() {
		LocationService.fetchAllLocation()
			.then(
					function (locations) {
						self.locations = locations;				
					}, 
					function (errResponse) {
						console.log('Error while fetching branches');
					}
				);
	}
	
	//-------------------------- Fetch All Location end ---------------------//	
	//===========================on save button click set value as SAVEANDCLOSE or SAVEANDNEW begin============
	$scope.save = function(event){
		self.save=event.target.id;
	}
	//===========================on save button click set value as SAVEANDCLOSE or SAVEANDNEW end============	
	
	function newOrClose(){
		
		if(self.save== "saveclose" ){
			 drawerClose('.drawer') ;
		}
		reset();
	}
	
	//-------------------------- Selected branch details end ---------------------//	
	
	//------------------------ Location block changes begin ----------------------//
   /* $scope.location_name = function (loc_selected) {
    	
    	$('#location_id').val(JSON.stringify(loc_selected.originalObject));
    	$('#customer_city').val(loc_selected.originalObject.address.city);
    	$('#country').val(loc_selected.originalObject.address.country);
    	$('#state').val(loc_selected.originalObject.address.state);
    	$('#pincode').val(loc_selected.originalObject.pincode);
	    	    
	};*/	
	//------------------------ Location block changes end ----------------------//
	
	
	//------------------------ Branch block changes begin ----------------------//
    $scope.branch_name = function (branch_selected) {
    	
    	$('#branch_id').val(JSON.stringify(branch_selected.originalObject));

	    	    
	};	
	//------------------------ Branch block changes end ----------------------//
	
	

	//------------------------- Create new Customer begin ------------------//
    function createCustomer(customer){
    	CustomerService.createCustomer(customer)
            .then(
            		function () {
//                        fetchAllCustomers();
//                      
            			self.message = customer.customer_name+" customer created..!";
            			successAnimate('.success');            			
            		},
           
            function(errResponse){
                console.error('Error while creating Customer ' + customer.customer_name );
            }
        );
    } 
	//------------------------- Create new Customer end ----------------------------------------------//    
    
    
  //------------------------- Update existing Customer begin ------------------//
    function editCustomer(customer)
    {
    	CustomerService.updateCustomer(customer)
	        .then(
	        		function () {
	                    fetchAllCustomers();
	                    self.message = customer.customer_name+" Customer updated..!";
	        			successAnimate('.success');
	        			window.setTimeout(function(){
	        				newOrClose();
	        			},5000);
	        			
	        		},
	       
	        function(errResponse){
	            console.error('Error while creating customer ' + customer.customer_name );
	        }
	    );
    } 
	//------------------------- Update existing Customer end ----------------------------------------------//  
   
	
  //------------------------- Submit for new Customer / update Customer begin ---------------------//
    function submit() {
    		
    		if(self.customer.customer_addressline2 == null) {
    			self.customer.customer_addressline2 = "";
    		}
    		
    		if( $("#branch_id").val() == "" || $("#branch_id").val() == null || $("#branch_name_value").val() == "" || $("#branch_name_value").val() == null) {
    			$("#branch_name_value").focus();
    		}
//    		 else if ($("#location_id").val() == "" || $("#location_id").val() =="" || $("#location_name_value").val() == "" || $("#location_name_value").val() == null) {
//    			$("#location_name_value").focus();
//    		} 
    		
    		else {
    			
    			if( self.customer.customer_id == null ) {
        			
        			self.confirm_title = 'Save';
        			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
        			self.confirm_msg = self.confirm_title+ ' ' + self.customer.customer_name + ' Customer?';
        			self.confirm_btnclass = 'btn-success';
        			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
        				.then(
        						function (res) {
        							self.customer.branchModel = JSON.parse($("#branch_id").val());
        							if(self.customer.location!=null){
        			 	    		self.customer.location = JSON.parse($("#location_id").val());}    	
        							
        							console.log(self.customer);
        			 	        	createCustomer(self.customer);  
        			 	        	reset();
        			 	        	window.setTimeout( function(){	 	        		
        			 	        		newOrClose();
        							},5000);
        						}
        					);
        			
        			

        		} else {
        			// update customer
        					    			
        			self.confirm_title = 'Update';
        			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
        			self.confirm_msg = self.confirm_title+ ' ' + self.customer.customer_name + ' Customer?';
        			self.confirm_btnclass = 'btn-success';
        			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
        				.then(
        						function (res) {
        							self.customer.branchModel =JSON.parse($("#branch_id").val());
        			 	    		//self.employee.empcategory = $("#empcategory_value").val();  
        			 	    		self.customer.location = JSON.parse($("#location_id").val());    	

        			 	    		editCustomer(self.customer);  
        			 	        	
        			 	        	window.setTimeout( function(){	 	        		
        			 	        		newOrClose();
        			 	        		reset();
        							},5000);
        						}
        					);
    		}
		
    		
    		}
    	} 

    
    //------------------------- Submit for new customer / update customer end ---------------------//
   
    
  //------------------------- update customer begin ---------------------//
    function updateCustomer(customer) 
    {
    	self.customer = customer;
    	console.log(customer);
    	if(self.customer.location!=null){
    		$('#location_id').val(JSON.stringify(self.customer.location));
  		
	    	$('#customer_city_value').val(self.customer.customer_city.city);
	    	$('#country').val(self.customer.customer_city.country);
	    	$('#state').val(self.customer.customer_city.state);
	    	$('#pincode').val(self.customer.location.pincode);
	    	$('#location_name_value').val(self.customer.location.location_name);
    	}else{
    		$('#customer_city_value').val(self.customer.customer_city.city);
	    	$('#country').val(self.customer.customer_city.country);
	    	$('#state').val(self.customer.customer_city.state);
    	}
//    	(self.customer.customer_name).length> 15?
//				self.heading="- "+(self.customer.customer_name).substr(0,14)+"..."
//				:self.heading="- "+self.customer.customer_name;
//		$('#branch_id').val(JSON.stringify(self.customer.branchModel));
//		if($('#location_id').val()!=''){
//	    	$('#location_id').val(JSON.stringify(self.customer.location));
//	    	$('#customer_city').val(self.customer.customer_city);
//	    	$('#country').val(self.customer.location.address.country);
//	    	$('#state').val(self.customer.location.address.state);
//	    	$('#pincode').val(self.customer.location.pincode);
//	    	$('#location_name_value').val(self.customer.location.location_name);
//		}else{
//			self.customer.customer_city=customer_city.originalObject;
//			$("#customer_city").val(customer_city.city);
//			$("#state").val(customer_city.state);
//			$("#country").val(customer_city.country);
	//	}
    	
    	$('#branch_id').val(JSON.stringify(self.customer.branchModel));
    	 $('#branch_name_value').val(self.customer.branchModel.branch_name);
		// $('#location_name_value').val(self.customer.location.location_name);
		 
    	drawerOpen('.drawer');
    }
    //------------------------- update customer end ---------------------//    
    

//------------------------- delete customer begin ---------------------//
    
    function deleteCustomer() {
    	
    	self.confirm_title = 'Delete';
		self.confirm_type = BootstrapDialog.TYPE_DANGER;
		self.confirm_msg = self.confirm_title+ ' ' + self.customer.customer_name + ' Customer?';
		self.confirm_btnclass = 'btn-danger';
		ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
			.then(
					function (res) {
												
						CustomerService.deleteCustomer(self.customer.customer_id)
						.then(
								function (msg) {
									var index = self.customers.indexOf(self.customer);
									self.customers.splice(index,1);
									self.message =self.customer.customer_name+ " Customer Deleted..!";
									successAnimate('.success');
									window.setTimeout(function(){
										newOrClose();
									},5000);
									
									
								}, function(refershipment) {
									self.message =self.customer.customer_name+ " referred in Add Shipment..!";
									successAnimate('.failure');
									window.setTimeout(function(){
										newOrClose();
									},5000);
								
								},
								
								function (errResponse) {
					                console.error('Error while Delete Customer' + errResponse );
								}
							);
						
					}
				);
		
    }
    
  //------------------------- delete Customer end ---------------------//
    
    //------------------------- Register select begin ------------------//
    function customerSelect(customer){
    	var index = self.selected_customer.indexOf(customer);
    	//(customer.select)? self.selected_customer.push(customer) : self.selected_customer.splice(index, 1);

    	if (customer.select){
    		self.selected_customer.push(customer);
    	} else {
    		$scope.selectall = false;
    		self.selected_customer.splice(index, 1);
    	}
    }
    //------------------------- Register select end ----------------------//
    
    //------------------------- Register select all begin ------------------//   
    function customerSelectall()
    {
    	for(var i = 0; i < $scope.pageSize; i++) 
		{
			self.Filtercustomers[i].select = $scope.selectall;
			if($scope.selectall)
			{
				self.selected_customer.push(self.Filtercustomers[i])
				//self.selected_customer=$scope.selectall?self.Filtercustomers:[];
			}
		
		}
        
    }
    //------------------------- Register select all end ------------------//       
    
    //-------------------------- Make Active begin ----------------------//
    function makeActive()
    {
    	if(self.selected_customer.length == 0 ) 
    	{
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
    	} else {
    		var activate_flag = 0;
    		angular.forEach(self.selected_customer, function(customer){
    			if(customer.active == 'Y') {
    				activate_flag = 1;
    			} 
    			
    		});
    		if(activate_flag == 1) {
				self.message ="Selected record(s) already in active status..!";
				successAnimate('.failure');
    			
    		} else {
    			
    			self.confirm_title = 'Active';
    			self.confirm_type = BootstrapDialog.TYPE_SUCCESS;
    			self.confirm_msg = self.confirm_title+ ' selected record(s)?';
    			self.confirm_btnclass = 'btn-success';
    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
    			.then(
    					function (res) {
    						var active_id = [];
    		    			for(var i=0; i<self.selected_customer.length; i++) {
    		    				active_id[i] = self.selected_customer[i].customer_id;    				
    		    			}
    		    			CustomerService.makeActive(active_id)
							.then(function(response) 
								{
									fetchAllCustomers();
									self.selected_customer = [];
									self.message ="Selected record(s) has in activat status..!";
									successAnimate('.success');
								}, 
								function(errResponse)
								{
									console.log(errResponse);    								
								}
							);
    					}
    				);
    		}
    	}
     }
    //-------------------------- Make Active end ----------------------//    
    
    
  //-------------------------- Make inActive begin ----------------------//
    function makeinActive(){
   	if(self.selected_customer.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
    	} else {
    		var inactivate_flag = 0;
    		angular.forEach(self.selected_customer, function(customer){
    			if(customer.active == 'N') {
    				inactivate_flag = 1;
    			} 
    			
    		});
    		if(inactivate_flag == 1) {
				self.message ="Selected record(s) already in inactive status..!";
				successAnimate('.failure');
    			
    		} else {
    			
    			self.confirm_title = 'In-Active';
    			self.confirm_type = BootstrapDialog.TYPE_DANGER;
    			self.confirm_msg = self.confirm_title+ ' selected record(s)?';
    			self.confirm_btnclass = 'btn-danger';
    			ConfirmDialogService.confirmBox(self.confirm_title, self.confirm_type, self.confirm_msg, self.confirm_btnclass)
    			.then(function (res) {
						var inactive_id = [];
		    			for(var i=0; i<self.selected_customer.length; i++) {
		    				inactive_id[i] = self.selected_customer[i].customer_id;        				
		    			}
		    			CustomerService.makeinActive(inactive_id)
						.then(function(response) {
									fetchAllCustomers();
									self.selected_customer = [];
									self.message ="Selected record(s) has in inactive status..!";
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
    //-------------------------- Make inActive end ----------------------//   
    
    
   //-------------------------- Record Count begin -----------------------//
	
	function findrecord_count() {
		CustomerService.findrecord_count()
		.then(function (record_count) {
				$scope.totalnof_records  = record_count;
			}, 
			function (errResponse) {
				console.log('Error while fetching record count');
			}
		);
	}
	
	//-------------------------- Record Count end -----------------------//
    
    
    //-------------------------- Pagination begin -----------------------//
    
    function pagination() 
    {
        $scope.pageSize = $scope.shownoofrec;
    	$scope.currentPage = 0;
		$scope.totalPages = 0;
		//$scope.totalItems = Math.ceil(self.Filtercustomers.length/$scope.pageSize);
		self.Filtercustomers = self.customers;
		
		$scope.nextDisabled = false;
		$scope.previouseDisabled = true;
		
		if( self.Filtercustomers.length <=10) {
			$scope.nextDisabled = true;
		} 
		
		if( self.Filtercustomers.length < 100 ) {
			$scope.totalnof_records  = self.Filtercustomers.length;
			//findrecord_count();
		} else {
			findrecord_count();
		}
		
    }
    
  //-------------------------- Pagination End ---------------------------//  
    
 //-------------------------- Paginate Start ---------------------------//  
    
    $scope.paginate = function(nextPrevMultiplier) 
    {
    	$scope.currentPage += (nextPrevMultiplier * 1);
    	console.log('current page : '+$scope.currentPage);
    	self.Filtercustomers = self.customers.slice($scope.currentPage*$scope.pageSize);
    	if(self.Filtercustomers.length == 0) 
    	{
    		CustomerService.pagination_byPage($scope.currentPage)
    		.then(function (filterCust) 
    				{
    					if ( filterCust.length == 0 ) 
    					{
    						$scope.nextDisabled = true;
    					} else if ( filterCust.length < 10 ) {
    						self.Filtercustomers = filterCust;
    						/*$scope.nextDisabled = true;*/
    					}
    					else 
    					{
    						self.Filtercustomers = filterCust;
    					}
    				}, 
    				function (errResponse) 
    				{
    					console.log('Error while pagination');
    				}
    			);
    	} 	
    	
    	$scope.disableSorting=  ($scope.currentPage > 0) ?true:false;
    	console.log('Filter customer length : '+self.Filtercustomers.length+' and pageSize : '+$scope.pageSize);
    	if(self.Filtercustomers.length < $scope.pageSize) 
    	{
    		console.log(self.Filtercustomers.length);
    		$scope.nextDisabled = true;
    	}
    	
    	console.log(nextPrevMultiplier);
    	if($scope.currentPage == 0) {
    		$scope.previouseDisabled = true;
    	}
    	if(nextPrevMultiplier == -1) {    		
    		$scope.nextDisabled = false;
    	} else {
    		$scope.previouseDisabled = false;
    	}
    	
    }
 //--------------------------------------------------------------------------------------//	
    
  //---------------------------- Pagination begin ---------------------------------------//
    $scope.firstlastPaginate = function (page) 
    {
    	$scope.selectall = false;
    	if( page == 1 ) 
    	{
    		$scope.currentPage = 0;
    		$scope.previouseDisabled = true;
    		$scope.nextDisabled = false;
    		self.Filtercustomers = self.customers.slice($scope.currentPage*$scope.pageSize);
    		fetchAllCustomers();
    	} 
    	else 
    	{
    		$scope.currentPage = ( (Math.ceil(self.Filtercustomers.length/$scope.pageSize)) - 1 );
    		console.log("Count: "+$scope.currentPage );
    		$scope.previouseDisabled = false;
    		$scope.nextDisabled = true;
    		
    		self.Filtercustomers = self.customers.slice($scope.currentPage*$scope.pageSize);
    		
    		if(self.Filtercustomers.length == 0) 
    		{
    			CustomerService.pagination_byPage(page)
        		.then(
        				function (filterCust) {
        					self.Filtercustomers = filterCust;
        				}, 
        				function (errResponse) {
        					console.log('Error while fetching Customers');
        				}
        			);
    		}
    	}
    	$scope.disableSorting=  ($scope.currentPage > 0) ?true:false;
    }

      //-----------------------------------------------------------------//	
    
    
//-------------------------------- Show no of record begin ----------------------------------------//
    
    function shownoofRecord() 
    {    
    	self.cust_regSearch = null;
    	$scope.pageSize = $scope.shownoofrec;
    	self.Filtercustomers=self.customers.slice($scope.currentPage*$scope.pageSize);
    	if(self.Filtercustomers.length <= $scope.pageSize)
    	{
    		$scope.previouseDisabled=true;
    		$scope.nextDisabled=true;
    	}
    	else
    	{
    		//$scope.previouseDisabled=false;
    		$scope.nextDisabled=false;
    	}
    	fetchAllCustomers();
    	    		
    }
//-------------------------------- Show no of record end ----------------------------------------//  
    
    
    
    
    //-------------------------------------- Print begin -----------------------------//
    function print() {
    	if(self.selected_customer.length == 0 ) {
	   		self.message ="Please select atleast one record..!";
			successAnimate('.failure');
    	} else {
    			
    		console.log(self.selected_customer);
    		$http.get('http://localhost:8080/Conti/listprint');
    	}
    }
    
    //-------------------------------------- Print end -----------------------------//
    
    
    
    
    
  //---------------------------- Register search begin ---------------------------------------//
    function registerSearch(searchkey) {
    	if ( searchkey.length == 0 ) {
    		self.Filtercustomers = self.customers;
    	}else if( searchkey.length > 3 ) {
    		CustomerService.registerSearch(searchkey)
	    		.then(function (filterCust) {
					self.Filtercustomers =filterCust;
					console.log(self.Filtercustomers);
					}, 
					function (errResponse) {
						console.log('Error while fetching Customers');
					}
	    		);
    	} else {
    		self.Filtercustomers = _.filter(self.customers,function(item){  
				 return searchUtil(item,searchkey); 
			 });
		}
   }
    
    function searchUtil(item,toSearch)
	{
    	var success = false;
    	if ((String(item.customer_name).toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
				|| (item.customer_city.city.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)
				|| (item.customer_city.state.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)
				|| (item.customer_city.country.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)
				||((String(item.customer_mobileno)).indexOf(toSearch) > -1 ))
			
		{
			success = true;
		} 
		else
		{
			success = false;
		}
    	/*if(item.location==null){
			if ((item.customer_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
					|| (item.customer_city.city.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)
					|| (item.customer_city.state.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)
					|| (item.customer_city.country.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)
					||((String(item.customer_mobileno)).indexOf(toSearch) > -1 ))
				
			{
				success = true;
			} 
			else
			{
				success = false;
			}
		}else{
			if ((item.customer_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
					|| (item.branchModel.branch_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
					|| (item.location.location_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
					|| (item.location.address.city.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
					|| (item.location.address.district.toLowerCase().indexOf(toSearch.toLowerCase()) > -1) 
					|| (item.location.address.state.toLowerCase().indexOf(toSearch.toLowerCase()) > -1)
					||((String(item.customer_mobileno)).indexOf(toSearch) > -1 ))
				
			{
				success = true;
			} 
			else
			{
				success = false;
			}
		}*/
		return success;
	}
    //---------------------------- Register search end ---------------------------------------//
   
	
}]);
	