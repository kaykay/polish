/*
 * POStack.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POStack : CPView {
	CPString	_name;
}

/*
* Init a stack with hmargin and vmargin = 0;
*/
- (id) stack {
	console.debug('test');
	self = [super create];
	if(self) {
		//TODO maybe we can set a default stack size here;
	}
	return self;
}

- (void) name:(CPString) n {
	_name = n;
}

- (CPString) name {
	return _name;
}

@end
