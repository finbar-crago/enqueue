var EnqCtrl = angular.module('EnqCtrlDashboard', []);

EnqCtrl.controller('DashboardCtrl', ['$rootScope', '$scope', '$routeParams', '$http',
function ($rootScope, $scope, $routeParams, $http){

    $rootScope.title = 'Dashboard';

}]);
