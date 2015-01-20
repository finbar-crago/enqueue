var EnqCtrl = angular.module('EnqCtrlQueues', []);

EnqCtrl.controller('QueuesCtrl', ['$rootScope', '$scope', '$routeParams', '$http',
function ($rootScope, $scope, $routeParams, $http){

    $rootScope.title = 'Queues';
    $scope.allGood   =     true;

}]);
