var Hapi = require('hapi');

var server = new Hapi.Server();

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

//starting the server.
server.start(() => {
    console.log('Server running at:', server.info.uri);
});
