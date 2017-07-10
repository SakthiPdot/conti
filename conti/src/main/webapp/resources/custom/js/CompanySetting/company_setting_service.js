/**
 * @Project_Name conti
 * @Package_Name resources/custom/js
 * @File_name company_setting_service.js
 * @author Monu.c
 * @Created_date_time Jun 21, 2017 7:20:17 PM
 * @Updated_date_time Jun 21, 2017 7:20:17 PM
 * 
 */


angular.module('contiApp').factory('CompanySettingService',['$http','$q',function($http,$q){
	
	var COMPANY_SETTING_REST_URL="http://localhost:8080/Conti/company_settings/";
	

	var factory={
			fetchCompanySetting:fetchCompanyWithId,
			addCompanySetting:saveCompany,
			updateCompanySetting:updateCS
		
	};
	
	return factory;
	
	
	//=============================save file====================================
	function saveCompany(company,file, Url){


		var deferred =$q.defer();
		
		console.log('saving');
		console.log(Url);
		console.log(file);
	  
		var fd = new FormData();

		 if($("#image").val().length){	
			  fd.append('file', file);
			 console.log("file available");
		 }else{				
			 console.log("file not available");
		 }
     
        fd.append('company',JSON.stringify(company));
		
		$http({
			  method: 'POST',
			  url: Url,
			  data:fd,
			  transformRequest: angular.identity,
			  headers:getHeaderWithContentType()
			})
		.then(
				function(response){
					console.log('save done');
					console.log(response.data);
					deferred.resolve(response.data);
				},
				function(errResponse){
					console.log('save error');
					console.log(errResponse.data);
					deferred.reject(errResponse);
				}
		);

		return deferred.promise;           
	}
	
	
	
	//=============================fetch company settings====================================
	function fetchCompanyWithId(id){
		var deferred =$q.defer();
		$http.get("company/"+id)
		.then(
				function(response){
					console.error(" fetched company");
					deferred.resolve(response);
				},
				function(errResponse){
					console.error("error while fetching company");
					deferred.reject(errResponse);					
				}
				);	
		return deferred.promise;
	}
	

	//=============================update company settings====================================
	function updateCS(){
		
	}
	
	function getHeader(){
		 
		 var csrfToken = $("input[name='_csrf']").val();

		 var headers = {}; 
		 headers["X-CSRF-TOKEN"] = csrfToken;
		 headers["_csrf"] = csrfToken;
		 
		 return headers;
	}; 
	
	
	
	function getHeaderWithContentType(){
		 
		 var csrfToken = $("input[name='_csrf']").val();

		 var headers = {}; 
		 headers["X-CSRF-TOKEN"] = csrfToken;
		 headers["_csrf"] = csrfToken;
		 headers["Content-Type"] = undefined;
		 
		 return headers;
	}; 
	
	
	
}]);

