/*
 * POSlider.j
 *
 * Created by Roberto Gamboni on 02/18/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <AppKit/CPSlider.j>

//FIXME this class is bugged.. cause i cannot create a slider with size 0 using init method.
@implementation POSlider : CPSlider {
	CPString	_name;
}

/*
* Init a slider with hmargin and vmargin = 0;
*/
- (id) slider {
	self = [super createWithFrame:CGRectMake(0,0,200,20)];
	if(self) {
		//looks like it's not possible to create a slider with size 0 or too small.
		//self.size(200.0, 20.0);
		[self createJSMethods: ['min:', 'max:', 'value:']];
	}
	return self;
}

//setter for the min value
- (void) min:(double) v {
	if(v != undefined)
		[self setMinValue:v];
	else
		return [self minValue];
}

//setter for the max value
- (void) max:(double) v {
	if(v != undefined)
		[self setMaxValue:v];
	else 
		return [self maxValue];
}

//setter for the slider value
- (void) value:(double) v {
	if(v != undefined)
		[self setValue:v];
	else
		return [self value];
}

- (void) name:(CPString) n {
	_name = n;
}

- (CPString) name {
	return _name;
}

@end
