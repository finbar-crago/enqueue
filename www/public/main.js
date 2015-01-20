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
	    templateUrl: 'dashboard.html',
	    controller:  'DashboardCtrl'
	}).

    	when('/reports', {
	    templateUrl: 'reports.html',
	    controller:  'ReportsCtrl'
	}).

    	when('/logs', {
	    templateUrl: 'logs.html',
	    controller:  'LogsCtrl'
	}).



	when('/admin/agents', {
	    templateUrl: 'agents.html',
	    controller:  'UsersCtrl'
	}).

	when('/admin/agent/:uid', {
	    templateUrl: 'agents.html',
	    controller:  'UsersCtrl'
	}).

	when('/admin/queues', {
	    templateUrl: 'queues.html',
	    controller:  'QueuesCtrl'
	}).

	when('/admin/system', {
	    templateUrl: 'system.html',
	    controller:  'SystemCtrl'
	}).




	otherwise({
	    redirectTo: '/'
	});

}]);
