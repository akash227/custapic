var Tumblr = require('tumblr');
var keys = require('./keys.js')
var oauth = keys.tumblrOauth() ;

var tumblr = new Tumblr.Tagged(oauth);

//search

tumblr.search('Choco',{limit:10},function(error,results){
	console.log(results);
});