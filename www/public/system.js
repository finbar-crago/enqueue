var EnqCtrl = angular.module('EnqCtrlSystem', []);

EnqCtrl.controller('SystemCtrl', ['$rootScope', '$scope', '$routeParams', '$http',
function ($rootScope, $scope, $routeParams, $http){

    $rootScope.title = 'System';

}]);
