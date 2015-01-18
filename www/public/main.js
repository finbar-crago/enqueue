var EnQ = angular.module('EnQ', ['ngRoute']);

EnQ.config(['$routeProvider',
function($routeProvider) {
    $routeProvider.

	when('/admin/agents', {
	    templateUrl: 'agents.html',
	    controller:  'UsersCtrl'
	}).

	otherwise({
	    redirectTo: '/'
	});
}]);
