app.create({title : "Tweet Polish.", color : darkgray() });

login_stack = app.login({login_type : 'horizontal', x : 55, y : 15, width : 910, height : 65, color : black(), action : 'http://twitter.com/statuses/friends_timeline.json'});
login_stack.on_precondition_failed( function() { alert('please insert username and password') } );
login_stack.on_error( function(x) { alert('wrong username or password'); } );
login_stack.post(function(x) { 
	console.log(x);
	alert('auth');
} );

status_stack = app.stack({x : 55, y : 85, width : 910, height : 130, color : black()});
status_text = status_stack.text({x : 10, y : 15, width : 630, height : 40});
char_label = status_stack.label( {x : 647, y : 21, width : 40, height : 25, value : 140, color : black(), textcolor : red(), font : 20} );

status_text.on_change( function(x) {
  char_label.value( (140 - x.length).toString() );
});

public_stack = app.stack({x : 55, y : 220, width : 300, height : 400, color : lightgray()});
public_coll = public_stack.friend_collection( {color : darkgray() , x : 2, y : 2, width : 296, height : 396} );

friend_stack = app.stack({x : 360, y : 220, width : 300, height : 400, color : lightgray()});

search_res = app.stack({x : 665, y : 300, width : 300, height : 320, color : lightgray()});
search_coll = search_res.friend_collection( { color : darkgray() , x : 2, y : 2, width : 296, height : 316} );

search_form = app.form({x : 665, y : 220, width : 300, height : 80, color : lightgray(), action : 'http://search.twitter.com/search.json'});
search_form.text({name : 'q', x : 5, y : 5, width : 210, height : 40});
search_form.submit({x : 222, y : 14, width : 70, height : 24});

search_form.post( function(x) { 
	search_coll.populate(x) 
} );

//test = public_stack.photo_collection( { photos : [ 'Resources/sample.jpg', 'Resources/sample2.jpg', 'Resources/sample3.jpg', 'Resources/sample4.jpg'] , color : red() } );
//test = public_stack.friend_collection( { color : red() , x : 2, y : 2, width : 296, height : 396} );

/*
f = function() {
  var login_y = login_stack.y();
  login_stack.location(login_stack.x(), login_y - 5);
};

*/
/*
b = status_stack.button( {title : 'this is fun', x : 25, y : 70, height : 24, width : 70} );
bf = function(x) {
	b.x( b.x() + (x * 50) / 10 );
}
b.on_click( function() {
	animate(30, bf, 1 );
});
*/
download( 'http://www.twitter.com/statuses/public_timeline.json' , function(x) { public_coll.populate(x) }, function(x) {console.log(x)} );
