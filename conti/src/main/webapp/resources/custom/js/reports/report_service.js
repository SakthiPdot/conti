contiApp.factory('ReportService',['$http','$q',function($http,$q)
	{
		var factory = {
			fetch4All : fetch4All
		};
		return factory;
		
		function fetch4All(report) {
			var deferred = $q.defer();
			$http({
				method : 'POST',
				url : 'fetch4all',
				data : report,
				headers : getCsrfHeader()
			})
			.then(
					function(response){
						deferred.resolve(response.data);
					},function(errResponse){
						deferred.reject(errResponse);
					}
				);
			return deferred.promise;
		}

	}
	]);