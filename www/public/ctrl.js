function NewCtrl(name, rpc){
var EnqCtrl = angular.module('EnqCtrl'+name, []);

EnqCtrl.controller(name+'Ctrl', ['$rootScope', '$scope', '$routeParams', '$http',
function ($rootScope, $scope, $routeParams, $http){

    var uid = $routeParams.uid;
    $rootScope.title = name;
    $scope.uid   = uid;
    $scope.data  = {};
    $scope.error = null;

    $http.get(rpc).success(function(obj){
	if(obj.status != 'ok'){
	    $scope.error = obj.error;
	    return;
	}

        obj.list.forEach(function(i){
            $http.get(rpc+i).success(function(j){
		if(j.status != 'ok'){
		    $scope.error = r.error;
		    return;
		}
                $scope.data[j.data.uid] = j.data;
            });
        });
    });

    $scope.push = function() {
	if(!$scope.data[uid]) return;
	$http.post(rpc + uid, $scope.data[uid]).success(function(r){
	    if(r.status != 'ok'){
		$scope.error = r.error;
		return;
	    }
	    $scope.uid = null;
	});
    };

    $scope.purge = function(id){
	if(!id) return;
	$http.delete(rpc + id).success(function(r){
	    if(r.status != 'ok'){
		$scope.error = r.error;
		return;
	    }
	    delete $scope.data[id];
	});
    };

}]);

}
