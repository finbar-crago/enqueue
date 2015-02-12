var EnQ = angular.module('EnQ', 
			 ['ngRoute',

			  'EnqCtrlDashboard',
			  'EnqCtrlReports',
			  'EnqCtrlLogs',

			  'EnqCtrlUsers',
			  'EnqCtrlQueues',
			  'EnqCtrlLanding',
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



	when('/Admin/Users', {
	    templateUrl: 'view/users.html',
	    controller:  'UsersCtrl'
	}).

	when('/Admin/Users/:uid', {
	    templateUrl: 'view/users.html',
	    controller:  'UsersCtrl'
	}).

	when('/Admin/Queues', {
	    templateUrl: 'view/queues.html',
	    controller:  'QueuesCtrl'
	}).

	when('/Admin/Queues/:uid', {
	    templateUrl: 'view/queues.html',
	    controller:  'QueuesCtrl'
	}).

	when('/Admin/Landing', {
	    templateUrl: 'view/landing.html',
	    controller:  'LandingCtrl'
	}).

	when('/Admin/Landing/:uid', {
	    templateUrl: 'view/landing.html',
	    controller:  'LandingCtrl'
	}).

	when('/Admin/System', {
	    templateUrl: 'view/system.html',
	    controller:  'SystemCtrl'
	}).


	otherwise({
	    redirectTo: '/Home'
	});

}]).

run(['$rootScope', function ( $rootScope ) {

    $rootScope.niceJson = function (obj){ return JSON.stringify(JSON.parse(obj), null, 4);};

}]).

filter("toArray", function(){
    return function(obj) {
        var result = [];
        angular.forEach(obj, function(val, key) {
	    result.push(val);
        });
        return result;
    };
});


NewCtrl('Logs' ,'Event');

NewCtrl('Users' ,'User');
NewCtrl('Queues','Queue');
NewCtrl('Landing','DID');
NewCtrl('System','System');
