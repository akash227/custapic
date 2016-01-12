var Flickr = require('flickrapi');
var keys = require('./keys.js');
var flickrOptions = keys.flickrOptions() ;

function search(query,next){
  Flickr.tokenOnly(flickrOptions, function(error, flickr) {
  // we can now use "flickr" as our API object,
  // but we can only call public methods and access public data
  if(error){next(error,null);}
  flickr.photos.search({
    text:query,
    tag:query,
    page:1,
    per_page:10,
    sort:"relevance"
  },function(error,results){
    //console.log(results.photos.photo);
    var photosObject = {photosArray: []};
    var photos = results.photos.photo;
    for (photo in photos){
      var title = photos[photo].title;
      var source = "flickr";
      var url = "https://farm"+photos[photo].farm+".staticflickr.com/"+photos[photo].server+"/" + photos[photo].id + "_" + photos[photo].secret+".jpg";
      var photo = {
        title : title,
        url : url,
        source : source
      };
      photosObject.photosArray.push(photo);
      //console.log(photosObject);

    }
    next(null,photosObject);
  });

});

}

exports.search = search;

// search('beau',function(err,results){
//   console.log(results);
// });


