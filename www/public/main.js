var EnQ = angular.module('EnQ', ['ngRoute', 'EnqCtrl']);

EnQ.config(['$routeProvider',
function($routeProvider) {
    $routeProvider.

	when('/admin/agents', {
	    templateUrl: 'agents.html',
	    controller:  'UsersCtrl'
	}).

	when('/admin/agent/:uid', {
	    templateUrl: 'agents.html',
	    controller:  'UsersCtrl'
	}).

	otherwise({
	    redirectTo: '/'
	});
}]);
