var EnqCtrl = angular.module('EnqCtrlReports', []);

EnqCtrl.controller('ReportsCtrl', ['$rootScope', '$scope', '$routeParams', '$http',
function ($rootScope, $scope, $routeParams, $http){

    $rootScope.title = 'Reports';

}]);
