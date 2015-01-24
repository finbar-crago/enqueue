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

    	when('/Home', {
	    templateUrl: 'view/dashboard.html',
	    controller:  'DashboardCtrl'
	}).

    	when('/Reports', {
	    templateUrl: 'view/reports.html',
	    controller:  'ReportsCtrl'
	}).

    	when('/Logs', {
	    templateUrl: 'view/logs.html',
	    controller:  'LogsCtrl'
	}).



	when('/Admin/Agents', {
	    templateUrl: 'view/agents.html',
	    controller:  'UsersCtrl'
	}).

	when('/Admin/Agents/:uid', {
	    templateUrl: 'view/agents.html',
	    controller:  'UsersCtrl'
	}).

	when('/Admin/Queues', {
	    templateUrl: 'view/queues.html',
	    controller:  'QueuesCtrl'
	}).

	when('/Admin/System', {
	    templateUrl: 'view/system.html',
	    controller:  'SystemCtrl'
	}).


	otherwise({
	    redirectTo: '/'
	});

}]);

NewCtrl('Users' ,'/EnQ/!/User/');
NewCtrl('Queues','/EnQ/!/Queue/');
NewCtrl('System','/EnQ/!/System/');
