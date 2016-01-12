var parallel= require('async').parallel;
var flatten = require('underscore').flatten;
var shuffle = require('underscore').shuffle;
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
			//console.log(results);
			var photos = results.photosArray;
			for(index in photos){
				var photo = photos[index];
				photosObject.photosArray.push(photo);
			}
			next(null,photosObject.photosArray);	
		});
	};

	stack.tumblr = function(next){
		tumblr.search(query,function(error,results){
			if(error){
				next(error,null);
			}
			var photos = results.photosArray;
			for(index in photos){
				var photo = photos[index];
				photosObject.photosArray.push(photo);
			}
			next(null,photosObject.photosArray);
		});
	};

	parallel(stack,function(error,results){
		if(error){
			cb(error,null);
		}
		var photosArray = [];
		for(key in results){
			photosArray.push(results[key]);
		}
		photosArray = shuffle(flatten(photosArray));
		cb(null,photosArray);
	});
}

// search('Mclaren',function(error,results){
// 	console.log(results);
// });

exports.search = search;