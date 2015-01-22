var EnqCtrl = angular.module('EnqCtrlUsers', []);

EnqCtrl.controller('UsersCtrl', ['$rootScope', '$scope', '$routeParams', '$http',
function ($rootScope, $scope, $routeParams, $http){

    $rootScope.title = 'Agents';
    var uid = $routeParams.uid;
    $scope.data    = [];
    $scope.users   = [];
    $scope.user    = {};
    $scope.isEdit  = false;
    $scope.allGood = true;
    $scope.error   = '';

    $http.get('/api/users').success(function(data){
        data.list.forEach(function(id){
	    if(data.status == 'ERROR'){
		$scope.allGood = false;
		$scope.error = r.error;
		return;
	    }
            $http.get('/api/users/'+id).success(function(u){
		if(u.status == 'ERROR'){
		    $scope.allGood = false;
		    $scope.error = r.error;
		    return;
		}

                $scope.data[u.data.uid] = u.data;
		$scope.users.push(u.data.uid)
		if(u.data.uid == uid){
		    $rootScope.title = 'Agent (' + uid + ')';
		    $scope.user = u.data;
		    $scope.isEdit = true;
		}
            });
        });
    });

    $scope.submit = function() {
        if ($scope.user) {
	    console.log($scope.user);
	    $http.post('/api/users/'+uid, $scope.user).success(function(r){
		if(r.status == 'ERROR'){
		    $scope.allGood = false;
		    $scope.error = r.error;
		} else {
		    $scope.isEdit = true;
                    $scope.data[$scope.user.uid] = $scope.user;
		    if($scope.users.indexOf($scope.user.uid) == -1){
			$scope.users.push($scope.user.uid);
		    }
		}
	    });
        }
    };

    $scope.purge = function(id){
	$http.delete('/api/users/'+id).success(function(r){
	    if(r.status == 'ERROR'){
		$scope.allGood = false;
		$scope.error = r.error;
	    } else {
		$scope.users.splice($scope.users.indexOf(id),1);
	    }
	});
    };

}]);
