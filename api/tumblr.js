var Tumblr = require('tumblr');
var keys = require('./keys.js')
var oauth = keys.tumblrOauth() ;

var tumblr = new Tumblr.Tagged(oauth);

//search

tumblr.search('Choco',{limit:10},function(error,results){
	var photosObject = {photosArray: []};
	for(index in results){
		var photos=results[index].photos;
		var title = results[index].blog_name;
		var source = "tumblr";
		for(photo in photos){
			//gives the url of photo
			var url = photos[photo].original_size.url;
			var pht = {title: title,source: source,url: url};
			photosObject.photosArray.push(photo);
		}
	}
	console.log(photosObject);
});