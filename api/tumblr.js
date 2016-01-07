var Tumblr = require('tumblr');
var keys = require('./keys.js')
var oauth = keys.tumblrOauth() ;

var tumble = new Tumblr.Tagged(oauth);
