var EnQ = angular.module('EnQ', 
			 ['ngRoute',

			  'EnqCtrlDashboard',
			  'EnqCtrlReports',
			  'EnqCtrlLogs',

			  'EnqCtrlUsers',
			  'EnqCtrlQueues',
			  'EnqCtrlSystem',
			 ]);

EnQ.config(['$routeProvider',
function($routeProvider) {
    $routeProvider.

    	when('/home', {
	    templateUrl: 'view/dashboard.html',
	    controller:  'DashboardCtrl'
	}).

    	when('/reports', {
	    templateUrl: 'view/reports.html',
	    controller:  'ReportsCtrl'
	}).

    	when('/logs', {
	    templateUrl: 'view/logs.html',
	    controller:  'LogsCtrl'
	}).



	when('/admin/agents', {
	    templateUrl: 'view/agents.html',
	    controller:  'UsersCtrl'
	}).

	when('/admin/agent/:uid', {
	    templateUrl: 'view/agents.html',
	    controller:  'UsersCtrl'
	}).

	when('/admin/queues', {
	    templateUrl: 'view/queues.html',
	    controller:  'QueuesCtrl'
	}).

	when('/admin/system', {
	    templateUrl: 'view/system.html',
	    controller:  'SystemCtrl'
	}).


	otherwise({
	    redirectTo: '/'
	});

}]);

NewCtrl('Users',   '/api/users/');
NewCtrl('Queues', '/api/queues/');
NewCtrl('System', '/api/system/');
