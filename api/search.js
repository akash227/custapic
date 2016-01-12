var async = require('async');

var flickr = require('./flickr.js');

var tumblr = require('./tumblr.js');

var stack = {};

var photosObject = { photosArray: []};

function search(query,cb){
	stack.flickr = function(next){
	flickr.search(query,function(error,results){
			if(error){
				next(error,null);
			}
			console.log(results);
			next(null,results);	
		});
	};

	stack.tumblr = function(next){
		tumblr.search(query,function(error,results){
			if(error){
				next(error,null);
			}
			next(null,results);
		});
	};

	async.parallel(stack,function(error,results){
		if(error){
			cb(error,null);
		}
		cb(null,results);
	});
}

search('Mclaren',function(error,results){
	//console.log(results);
});