var EnqCtrl = angular.module('EnqCtrl', []);

EnqCtrl.controller('UsersCtrl', ['$rootScope', '$scope', '$routeParams', '$http',
function ($rootScope, $scope, $routeParams, $http){

    $rootScope.title = 'Agents';
    var uid = $routeParams.uid;
    $scope.data  = [];
    $scope.users = [];
    $scope.user  = {};

    $http.get('/api/users').success(function(data){
        data.list.forEach(function(id){
            $http.get('/api/user/'+id).success(function(u){
                $scope.data[u.data.uid] = u.data;
		$scope.users.push(u.data.uid)
		if(u.data.uid == uid){
		    $rootScope.title = 'Agent (' + uid + ')';
		    $scope.user = u.data;
		    $scope.user.pass =  '******';
		}
            });
        });

    });
}]);
