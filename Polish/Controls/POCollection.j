/*
 * POCollection.j
 *
 * Created by Roberto Gamboni on 05/20/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

//A generic collection using CPCollectionView
//the prototyping function is specified from outside.

@implementation POCollection : POControl {
		
		var _objects;
		var _collection_view;

		var _click_function;
		var	_double_click_function;

		var _prot;
}

- (id) collection {
	self = [super init];
	if(self) {
		
		var rect = CGRectMake(0, 0, 300, 200);
		_collection_view = [[CPCollectionView alloc] initWithFrame:rect];
		[_collection_view setAutoresizingMask:CPViewWidthSizable];
	    [_collection_view setMinItemSize:CGSizeMake(100, 20)];
	    [_collection_view setMaxItemSize:CGSizeMake(450, 100)];
	    [_collection_view setDelegate:self];
	
		var itemPrototype = [[CPCollectionViewItem alloc] init];
		_prot = [[Prototype alloc] initWithFrame:CGRectMake(0,0,300.0, 90.0)];
		[itemPrototype setView:_prot];
        [_collection_view setItemPrototype:itemPrototype];

		__delegate = [[CPScrollView alloc] initWithFrame:rect];
		[__delegate setDocumentView:_collection_view];
        [__delegate setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
        [__delegate setAutohidesScrollers:YES];

        [[__delegate contentView] setBackgroundColor:[CPColor whiteColor]];

		_objects = [  ];
		[_collection_view setContent:_objects];
		[self createJSMethods:['on_click:', 'on_double_click:', 'add:', 'contacts:', 'clear', 'populate:', 'render:', 'selected_color:']];
		
	}
	return self;
}

//voiding these two methods. no adding stuff directly to the collection view
- (void) addChild:(POControl) child {
  
}

- (void) addSubview:(CPView) v {
  
}

- (void) render:(Function) aFunction {
	[_prot render:aFunction];
}

- (void) selected_color:(id) colorName {
	var c = [self sintetize_color:colorName];
	if(c != nil)
	    [_prot setSelectedColor:c];
	else
	    console.log(color + ' is not a supported color.');
}

- (void) populate:(id) anObject {
	for(var i=0; i<anObject.length; i++) {
		var json = anObject[i];
		/*
		if(json.user == nil)
			var a = { img : json.profile_image_url, name : json.from_user, status : json.text };
		else
			var a = { img : json.user.profile_image_url, name : json.user.name, status : json.text };
		*/
	    _objects.push(json);
	}	
	objj_msgSend( _collection_view, 'reloadContent');
}

- (void) add:(id) obj {
	_objects.push( obj );
	objj_msgSend( _collection_view, 'reloadContent');
}

/*! FIXME - this method doesn't seem to work.. the collection still contains all the object !*/
- (void) clear {
	var subs = [_collection_view subviews];
	for(var view in subs) {
		a = subs[view];
		if (objj_msgSend(a, 'isKindOfClass:', CPView)) {
			objj_msgSend( a, 'removeFromSuperview');
		}
	}
	_objects = [];
	objj_msgSend( _collection_view, 'reloadContent');
}

- (void) on_click:(Function) aFunction {
	if(aFunction != undefined) {
		_click_function = aFunction;
	}
}

- (void) on_double_click:(Function) aFunction {
	if(aFunction != undefined) {
		_double_click_function = aFunction;
	}
}

- (void) color:(id) colorName {
  var c = [self sintetize_color:colorName];
  if(c != nil)
    [[__delegate contentView] setBackgroundColor:c];
  else
    console.log(color + ' is not a supported color.');
}

-(void)collectionViewDidChangeSelection:(CPCollectionView)collectionView {
	console.log('collection collectionViewDidChangeSelection');
	//TODO call the on_click function
}

-(void)collectionView:(CPCollectionView)collectionView didDoubleClickOnItemAtIndex:(int)index {
	console.log('collection didDoubleClickOnItemAtIndex');
	//TODO call the double click function
}

-(CPData)collectionView:(CPCollectionView)collectionView dataForItemsAtIndexes:(CPIndexSet)indices forType:(CPString)aType
{
    return [CPKeyedArchiver archivedDataWithRootObject:[_objects objectAtIndex:[indices firstIndex]]];
}

@end 

var _rendering_function;
@implementation Prototype : CPView {
	var _selected_color;
}

- (id) initWithFrame:(CGRect) frame {
	self = [super initWithFrame:frame];
	if(self) {
		[self setBackgroundColor:[CPColor blackColor]];
	}
	return self;
}

- (void) render:(Function) _f {
	_rendering_function = _f;
}

- (void) setSelectedColor:(CPColor) c {
	_selected_color = c;
}

- (void)setSelected:(BOOL)isSelected
{
    [self setBackgroundColor:isSelected ? (_selected_color != undefined ? _selected_color : [CPColor grayColor]) : [CPColor blackColor]];
}

- (void)setRepresentedObject:(id)anObject {
	if(_rendering_function != nil) {
		var a = _rendering_function(anObject);
		[self addSubview:[a view]];
	}
}

@end


@implementation ContactView : CPView {
	
	CPImageView		_contactImage;
	CPTextField		_contactName;
	CPTextView		_contactStatus;
}

- (id) initWithFrame:(CGRect) frame {
	self = [super initWithFrame:frame];
	if(self) {
		[self setBackgroundColor:[CPColor blackColor]];
	}
	return self;
}

- (void)setSelected:(BOOL)isSelected
{
    [self setBackgroundColor:isSelected ? [CPColor grayColor] : [CPColor blackColor]];
}

- (void)setRepresentedObject:(id)anObject
{
	var img = ( anObject.hasOwnProperty('img') ) ? anObject.img : nil;
	var cname = ( anObject.hasOwnProperty('name') ) ? anObject.name : nil;
	var cstatus = ( anObject.hasOwnProperty('status') ) ? anObject.status : nil;

	
	_contactImage = [[CPImageView alloc] initWithFrame:CGRectMake(2.0, 2.0, 70.0, 70.0)];
	[_contactImage setImage:[[CPImage alloc] initWithContentsOfFile:img size:CGSizeMake(70.0, 70.0)]];
	[self addSubview:_contactImage];
	
	_contactName = [CPTextField labelWithTitle:cname];
	[_contactName setFont:[CPFont systemFontOfSize:16]];
	[_contactName setTextColor:[CPColor whiteColor]];
	[_contactName setEditable:NO];
	[_contactName sizeToFit];
	[_contactName setFrame:CGRectMake(80.0, 0.0, CGRectGetWidth([_contactName bounds]), CGRectGetHeight([_contactName bounds]))];
	[self addSubview:_contactName];
	
	_contactStatus = [[CPTextView alloc] initWithFrame:CGRectMakeZero()];
	[_contactStatus setStringValue:cstatus];
		//[_contactStatus setFont:[CPFont systemFontOfSize:14]];
	    //[_contactStatus setTextColor:[CPColor whiteColor]];
	    //[_contactStatus setEditable:NO];
	    //[_contactStatus sizeToFit];
	[_contactStatus setFrame:CGRectMake(80.0, 23.0, 350, 49)];
	[self addSubview:_contactStatus]; 
}

@end
