function NewCtrl(name, rpc){
var EnqCtrl = angular.module('EnqCtrl'+name, []);

EnqCtrl.controller(name+'Ctrl', ['$rootScope', '$scope', '$routeParams', '$http',
function ($rootScope, $scope, $routeParams, $http){

    var uid = $routeParams.uid;
    $rootScope.title = name;
    $scope.uid   = uid;
    $scope.data  = {};
    $scope.error = null;

    $http.get('/EnQ/@/' + rpc).success(function(obj){
	if(obj.status == 'ok')
	    $scope.data = obj.data;
	else
	    $scope.error = obj.error;
    });

    $scope.push = function() {
	if(!$scope.data[uid]) return;
	$http.post('/EnQ/!/' + rpc + '/' + uid, $scope.data[uid]).success(function(r){
	    if(r.status != 'ok'){
		$scope.error = r.error;
		return;
	    }
	    $scope.uid = null;
	});
    };

    $scope.purge = function(id){
	if(!id) return;
	$http.delete('/EnQ/!/' + rpc + '/' + id).success(function(r){
	    if(r.status != 'ok'){
		$scope.error = r.error;
		return;
	    }
	    delete $scope.data[id];
	});
    };

}]);

return EnqCtrl;
}
