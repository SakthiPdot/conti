/**
 * @Project_Name conti
 * @Package_Name com.conti.product  com.conti.product
 * @File_name ProductDaoImpl.java com.conti.product
 * @author Monu.C
 * @Created_date_time Jul 8, 2017 6:23:19 PM
 */

angular.module('contiApp').controller('productController',
		['$scope','ProductService','ConfirmDialogService',function($scope,ProductService,ConfirmDialogService){
	
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
	

    
/*	BootstrapDialog.TYPE_WARNING;
	BootstrapDialog.TYPE_SUCCESS
	 BootstrapDialog.TYPE_DANGER
	 'btn-success';*/
	
	 
	function close(title){
		ConfirmDialogService.confirmBox(title,
				BootstrapDialog.TYPE_WARNING, title+" Without Save ..? ", 'btn-warning')
		.then(function(response){
			 drawerClose('.drawer') ;
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
	
	//===================================fetch product====================================
	 fetchProducts();
	 
	 
	function fetchProducts(){
	
			
			ProductService.fetchAllProduct()
			.then(function(Response){
				self.products=Response;
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
		self.heading=self.product.product_name;
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
		$scope.productForm.$setPristine();
	}

	
}]);
