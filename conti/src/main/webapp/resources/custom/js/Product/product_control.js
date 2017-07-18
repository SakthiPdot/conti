/**
 * @Project_Name conti
 * @Package_Name com.conti.product  com.conti.product
 * @File_name ProductDaoImpl.java com.conti.product
 * @author Monu.C
 * @Created_date_time Jul 8, 2017 6:23:19 PM
 */

angular.module('contiApp').controller('productController',
		['$scope','ProductService','ConfirmDialogService',function($scope,ProductService,ConfirmDialogService){
	
	/*	      $scope.exportToExcel=function(tableId){ // ex: '#my-table'
		            var exportHref=Excel.tableToExcel(tableId,'WireWorkbenchDataExport');
		            $timeout(function(){location.href=exportHref;},100); // trigger download
		        }
		      */
			
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
	
	//===================================select all====================================
	function selectAll(){

		console.log("select all");
		angular.forEach(self.products,function(x){
			x.select=self.selectAllProduct;
		});
		//self.selectedProducts=self.selectAllProduct?self.products:[];
		if(self.selectAllProduct){
			self.selectedProducts=self.products
		}else{
			self.selectedProducts=[];
		}
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
		
		if(self.product.product_id==null){
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
	       self.product.product_Type=selected.originalObject.product_Type;
	       }      
	          
	
	//===================================fetch product====================================
	 fetchProducts();
	 
	 
	function fetchProducts(){
	
			
			ProductService.fetchAllProduct()
			.then(function(Response){
				self.products=Response;
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
					self.products.splice(self.product,1);
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
		self.product.dimension_flag="Y";
		self.heading="Master";
		$("#selectedProductType_value").val("");
		$scope.productForm.$setPristine();
	}

	//===================================pagination====================================
    function pagination() {
        
    	$scope.viewby = 10;
		$scope.totalItems = self.products.length;
		$scope.currentPage = 1;
		$scope.itemsPerPage = $scope.viewby;
		$scope.maxSize = 2; //Number of pager buttons to show
			
		$scope.setPage = function (pageNo) {
			$scope.currentPage = pageNo;
		  };

		  $scope.pageChanged = function() {
			console.log('Page changed to: ' + $scope.currentPage);
		  };

		  $scope.setItemsPerPage = function(num) {
			  $scope.itemsPerPage = num;
			  $scope.currentPage = 1; //reset to first paghe
		}
		
    }
	
}]);
