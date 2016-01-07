var Tumblr = require('tumblr');
var keys = require('./keys.js')
var oauth = keys.tumblrOauth() ;

var tumblr = new Tumblr.Tagged(oauth);

//search

tumblr.search('Choco',{limit:10},function(error,results){
	
	for(index in results){
		var photos=results[index].photos;
		for(photo in photos){
			console.log(photos[photo]);
		}
	}
});