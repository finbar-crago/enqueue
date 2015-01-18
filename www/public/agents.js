
EnQ.controller('UsersCtrl', function ($scope, $http){
    $scope.users = [];
    $http.get('/api/users').success(function(data){
        data.list.forEach(function(uid){
            console.log('get /api/user/'+uid);
            $http.get('/api/user/'+uid).success(function(u){
                $scope.users.push( u.data );
            });
        });
        $scope.orderProp = 'uid';
    });
});
