var EnqCtrl = angular.module('EnqCtrlLogs', []);

EnqCtrl.controller('LogsCtrl', ['$rootScope', '$scope', '$routeParams', '$http',
function ($rootScope, $scope, $routeParams, $http){

    $rootScope.title = 'Logs';

}]);
