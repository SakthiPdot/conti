/**
 * @Project_Name conti
 * @Package_Name com.conti.product 
 * @File_name ProductDaoImpl.java 
 * @author Monu.C
 * @Created_date_time Jul 8, 2017 6:23:19 PM
 */

angular.module('contiApp').controller('productController',
		['$scope','ProductService','ConfirmDialogService',function($scope,ProductService,ConfirmDialogService){
		
	
	$("#screen_product").addClass("active-menu");
	
	$scope.shownoofrec = 10;
	$scope.nameWrong=false;
	
	var self=this;
	self.submit=submit;
	self.fetchProducts=fetchProducts;
	self.updateProduct=updateProduct;
	self.deleteProduct=deleteProduct;
	self.reset=reset;
	self.cancel=close;
	self.close=close;
	self.resetForm=resetForm;
	self.heading="Master";
	self.message="Message";
	self.save="saveclose";
	self.products=[];
	self.selectProduct=[];
	self.selectAll=selectAll;
	self.makeActive=makeActive;
	self.makeInActive=makeInActive;
	self.selectProduct=selectProduct;
	self.selectedProducts=[];
	self.registerSearch=registerSearch;
	self.FilteredProducts=[];
	self.product={
		    "product_id": null,
		    "product_name": null,
		    "product_code": null,
		    "product_Type": null,
		    "max_weight": null,
		    "dimension_flag": null,
		    "max_height": null,
		    "max_width": null,
		    "max_length":null,
		    "created_datetime": null,
		    "updated_datetime": null,
		    "updated_by": null,
		    "created_by": null,
		    "obsolete": null,
		    "active": null
		};
	

	//===================================check for product name====================================
	self.checkProductName=function checkProductName(name){
		
		console.log(self.product.product_name,self.UpdateNotCheckProductName);
		if(self.product.product_id != null &&  self.product.product_name ==	self.UpdateNotCheckProductName){
			$scope.nameWrong=false;
			//Dont check name
		}else{
		ProductService.checkProductName(name)
		.then(function (response){
			if(response=="204"){
				$scope.nameWrong=true;
				self.product.product_name=null;
			}else{
				$scope.nameWrong=false;
			}
		},function(errResponse){
			$scope.nameWrong=false;
			self.product.product_name=null;
			console.log("error checking name");
		});
		}
	}
	//===================================change no of page to view in register====================================
    self.shownoofRecord=function shownoofRecord() {    
    	$scope.pageSize = $scope.shownoofrec;
    }
    
    
   //===================================next and previous page====================================  
    $scope.paginate=function(nextPrevMultiplier){
    	self.selectAllProduct=false;
    	$scope.currentPage += (nextPrevMultiplier * 1);
    	console.log(self.products.length);
    	self.FilteredProducts = self.products.slice($scope.currentPage*$scope.pageSize);
    	console.log(self.FilteredProducts.length);
    	
    	
    	if(self.FilteredProducts.length == 0) {
        	console.log("empty");
        	ProductService.paginateFirstOrLast($scope.currentPage)
			.then(function (response) {
				console.log(response);
				
				if ( response.length == 0 ) {
					$scope.nextDisabled = true;
				} else if ( response.length < 10 ) {
					self.FilteredProducts = response;
					$scope.nextDisabled = true;
				} else {
					self.FilteredProducts = response;
				}
				
			}, 
			function (errResponse) {
				console.log('Error while pagination');
			}
		);
    	}
    	
    	
       	if(self.FilteredProducts.length < $scope.pageSize) {
    		$scope.nextDisabled = true;
    	}
    	
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
		self.selectAllProduct=false;
		ProductService.paginateFirstOrLast(page)
		.then(
				function(response){
					self.FilteredProducts=response;
					console.log(response);
				},function(errRespone){
					console.log("error while fetching products in search"+errResponse);
				});
		
		
		if( page == 1 ) {
    		$scope.currentPage = 0;
    		$scope.previouseDisabled = true;
    		$scope.nextDisabled = false;
    	} else {
    		$scope.previouseDisabled = false;
    		$scope.nextDisabled = true;
    		
    	}
	}
		
	//===================================SEARCH REGISTER====================================
	function registerSearch(searchString){
		if(searchString.length == 0){
			self.FilteredProducts=self.products;
		}else if(searchString.length>3){
			ProductService.searchProduct(searchString)
			.then(
					function(response){
						self.FilteredProducts=response	;
					},function(errRespone){
						console.log("error while fetching products in search"+errResponse);
					});
		}else{
			self.FilteredProducts=_.filter(self.products,function(item){
				return searchProduct(item,searchString);
			});
		}
	}
	
	function searchProduct(item,toSearch){
		
		var success=false;
		
		try{
			if(
					item.product_name.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ||
					item.product_code.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ||
					item.product_Type.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ||
					String(item.max_weight).indexOf(toSearch) > -1 ||
					item.dimension_flag.toLowerCase().indexOf(toSearch.toLowerCase()) > -1 ||
					String(item.max_height).indexOf(toSearch) > -1 ||
					String(item.max_width).indexOf(toSearch) > -1 ||
					String(item.max_length).indexOf(toSearch) > -1	 		
			){
				success = true;
			} else {
				success = false;
			}
		}catch(e){
			success = false;
		}
		
		return success;	
	}
	//===================================select all====================================
	function selectAll(){

		
		self.selectedProducts=[];
		
		if(!self.selectAllProduct){
			self.selectedProducts=[];
		}
		
		for(var i=0;i<$scope.pageSize;i++){
			self.FilteredProducts[i].select = self.selectAllProduct;
			if(self.selectAllProduct){
				self.selectedProducts.push(self.FilteredProducts[i]);
			}
		
		}
			
		
		/*
		angular.forEach(self.products,function(x){
			x.select=self.selectAllProduct;
		});*/

	/*	if(self.selectAllProduct){
			self.selectedProducts=self.products
		}else{
			self.selectedProducts=[];
		}*/
	}
	//===================================select Product====================================
	function selectProduct(x){
		console.log(x);

		if(x.select){
			self.selectedProducts.push(x)
			
		}else{
			self.selectAllProduct=x.select;
			  var index = self.selectedProducts.indexOf(x);
				console.log(index);
				self.selectedProducts.splice(index,1);
		}
		
		//(x.select)?self.selectedProducts.push(x):self.selectedProducts.splice(x,1);
	}
	
	function selectOneRecord(){
   		self.message ="Please select atleast one record..!";
		successAnimate('.failure');
	}
	
	function showStatus(status){
	self.message ="Selected record(s) already in "+status+" status..!";
	successAnimate('.failure');
	}
	
	function showStatusAfterSave(status){
		 fetchProducts();
		self.message ="Selected record(s) has been made  "+status+"..!";
		successAnimate('.success');
		 self.selectedProducts=[];
		 self.selectAllProduct=false;
		}
	
	//===================================make acive====================================
	function makeActive(){
		
		
		var hitController=true;
		var active_id=[];
		
		
		if(self.selectedProducts.length==0){
			 selectOneRecord();
		}else{
			var loop=true;				
				for(var i=0;i<self.selectedProducts.length;i++){
					if(loop){
						if(self.selectedProducts[i].active=="Y"){
							loop=false;
						    hitController=false;
							showStatus("Active");
						}
	    				active_id[i] = self.selectedProducts[i].product_id;  
					}
				}
				

				if(hitController){
					console.log(active_id);
					ConfirmDialogService.confirmBox("Active",
		    				BootstrapDialog.TYPE_SUCCESS, "Make Records Active  ..?", 'btn-success')
		    		.then(function(response){
		    			
					ProductService.changeActive(active_id,"Active")
					.then(
							function(response){
								showStatusAfterSave("Active");
							},function(errRespone){
								console.log("error making product active"+errResponse);
							});
		    		});
				}
				
				
				
		}
		
		

		
	}
	//===================================make inactive====================================
	function makeInActive(){
		
		var hitController=true;
		var In_active_id=[];
		
		
		if(self.selectedProducts.length==0){
			 selectOneRecord();
		}else{
			
			var loop=true;
			
			
			for(var i=0;i<self.selectedProducts.length;i++){
				if(loop){
					
					if(self.selectedProducts[i].active=="N"){
						loop=false;
					    hitController=false;
						showStatus("InActive");
					}
					
					In_active_id[i] = self.selectedProducts[i].product_id; 
				}
			}
			

			if(hitController){
				console.log(In_active_id);
				ConfirmDialogService.confirmBox("InActive",
	    				BootstrapDialog.TYPE_DANGER, "Make Records InActive  ..?", 'btn-danger')
	    		.then(function(response){
	    			
				ProductService.changeActive(In_active_id,"InActive")
				.then(
						function(response){
							showStatusAfterSave("InActive");
						},function(errRespone){
							console.log("error making product InActive"+errResponse);
						});
	    		});
			}
			
			
		
		}
	}
	
	//===================================close====================================
	function close(title){
		ConfirmDialogService.confirmBox(title,
				BootstrapDialog.TYPE_WARNING, title+" Without Save ..? ", 'btn-warning')
		.then(function(response){
			 drawerClose('.drawer');
		});
	}
		
	//===========================on save button click set value as SAVEANDCLOSE or SAVEANDNEW============
	$scope.save = function(event){
		self.save=event.target.id;
	}
	
	 
	//===================================submit product====================================
	function submit(){		
		
		if(self.product.dimension_flag=="N"){
	        self.product.max_height=null;
	        self.product.max_width=null;
	        self.product.max_length=null;
		}
		
		if(!($("#selectedProductType_value").val()).length>0){
				console.log("no");
				$("#selectedProductType_value").focus();
		} else{
			
			if(self.product.product_id==null ){
	            console.log('Saving Product', self.product);

	    		ConfirmDialogService.confirmBox("Save",
	    				BootstrapDialog.TYPE_SUCCESS, "Save Product "+self.product.product_name+"  ..?", 'btn-success')
	    		.then(function(response){
	    			ProductService.saveProduct(self.product)
	    			.then(
							function(response){
								 fetchProducts();
								self.message ="Product "+self.product.product_name+ "  Created..!";
								newOrClose();
								successAnimate('.success');	
							},function(errResponse){
								self.message = "Error While Creating Product ("+self.product.product_name+") ..!";
								successAnimate('.failure');
							});	
	    		});
	    		
			}else{
	            console.log('updating Product', self.product.product_id);
	        	
	            ConfirmDialogService.confirmBox("Update",
	    				BootstrapDialog.TYPE_SUCCESS, "Update Product "+self.product.product_name+"  ..?", 'btn-success')
	    		.then(function(response){
	    			ProductService.updateProduct(self.product, self.product.product_id)
	    			.then(
							function(response){
								 fetchProducts();
								self.message ="Product "+self.product.product_name+ " Updated..!";							
								newOrClose();	
								successAnimate('.success');	
							},function(errResponse){
								self.message = "Error While Updating Product ("+self.product.product_name+") ..!";
								successAnimate('.failure');
							});	
	    		});            
			}
		}

	}
	//===========================CHECK SAVEANDCLOSE or SAVEANDNEW============
	function newOrClose(){
		console.log(self.save);				
		if(self.save== "saveclose" ){
			 drawerClose('.drawer') ;
		}
		reset();
	}
	
	//===================================onchange of angucomplete====================================
	  $scope.product_type=function(selected){
	       	console.log(selected);
	    	if(typeof selected.originalObject.product_Type != 'undefined'){
	    		self.product.product_Type=selected.originalObject.product_Type;
	    	}else{
	    		self.product.product_Type=selected.originalObject;	
	    	}
	       } 
	
	//===================================fetch product====================================
	 fetchProducts();
	 
	 
	function fetchProducts(){
	
			
			ProductService.fetchAllProduct()
			.then(function(Response){
				self.products=Response;
				self.FilteredProducts=self.products;
				pagination();
				console.log(Response);
			},function(errResponse){			
				console.log("error Fetching product");
			});	
			
		
		
	}
	//===================================delete Product====================================
	function deleteProduct(){

		
		ConfirmDialogService.confirmBox("Delete",
				BootstrapDialog.TYPE_DANGER, "Delete Product "+self.product.product_name+"  ..?", 'btn-danger')
		.then(function(response){
			
			
		ProductService.deleteProduct(self.product.product_id)
		.then(
				function(response){
					var index=self.products.indexOf(self.product);
					self.products.splice(index,1);
					self.message ="Product "+self.product.product_name+ " deleted..!";
					self.save="saveclose";								
					newOrClose();	
					successAnimate('.success');
				},function(errResponse){
					self.message = "Error While Deleting Product ("+self.product.product_name+") ..!";
					successAnimate('.failure');
				});	
		
		});
	}
	
	//===================================update product====================================
	function updateProduct(product,index){		
		self.product=product;
		$scope.nameWrong=false;
		console.log(self.product);

		$("#selectedProductType_value").val(self.product.product_Type);
		self.UpdateNotCheckProductName=self.product.product_name;
		(self.product.product_name).length> 15?
			self.heading="- "+(self.product.product_name).substr(0,14)+"..."
			:self.heading="- "+self.product.product_name ;
		drawerOpen('.drawer');
	}
	
	//===================================reset====================================
	function resetForm(){
		 ConfirmDialogService.confirmBox("Clear",
 				BootstrapDialog.TYPE_WARNING, "Clear Details  ..?", 'btn-warning')
 		.then(function(response){
		reset();
 		});
	}
	
	function reset(){
		self.product={};
		$scope.nameWrong=false;
		self.product.dimension_flag="Y";
		self.heading="Master";
		$("#selectedProductType_value").val("");
		$scope.productForm.$setPristine();
	}

	//===================================pagination====================================
    function pagination() {

    	$scope.pageSize = $scope.shownoofrec;

		$scope.currentPage = 0;
		$scope.totalPages = 0;	
    	
    	
		$scope.previouseDisabled = true;	
		$scope.nextDisabled = false;
	
	
		
    }
	
}]);
