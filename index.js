var Hapi = require('hapi');
var api = require('./api/search.js');
var server = new Hapi.Server();

function search(query,next){
	api.search(query,function(error,results){
		if(error){
			next(error,null);
		}
		next(null,results);
	});
}
//connecting the server
server.connection({
	host:'localhost',
	port:8000
});

//get request '/'
server.route({
    method: 'GET',
    path: '/',
    handler: function (request, reply) {
        reply('Hello, world!');
    }
});
server.route({
    method: 'GET',
    path: '/api/{query}',
    handler: function (request, reply) {
        server.methods.search(request.params.query,function(error,results){
        	reply(results);
        });
    }
});
server.method({name: 'search',method: search});
//starting the server.
server.start(() => {
    console.log('Server running at:', server.info.uri);
});
