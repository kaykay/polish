/*
 * POButton.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import "POControl.j"

@implementation POLink : POControl {
  //var         _function;
}

- (id) control:(CPString)aControl withArgs: (id)args parent:(id)aParent {
	if(aControl == 'link')
    	var control = [self link: args[0]];
  	else {
    	console.error('Wrong selector sent to POLink');
    	return nil;
  	}
  	if(args[1]) {
    	[self applyMethods:args[1] onControl: control];
  	}
	[aParent addChild: self];
  	return control;
}

/*
* Init a cpbutton with hmargin and vmargin = 0;
*/
- (id) link:(id)aHref {
  	self = [super init];
	if(self) {
		__delegate = [POLinkImpl linkWithTextValue:aHref href: aHref];
		[self createJSMethods: ['click:', 'text:', 'textcolor:']];
	}
    return self;
}

- (void) text:(CPString) aText {
    [__delegate text: aText];
}

- (void) click:(CPString) aLink {
	[__delegate href: aLink];
}

//TODO implement this if you want an hook before following the link
/*
- (void) on_click:(Function)aFunction {
  	_function = aFunction;
}

- (void) exec {
  if(_function != nil)
    	_function();
}
*/

- (void) textcolor:(id) colorName {
	var c = [self sintetize_color:colorName];
	if(c != nil) {
		[__delegate setTextColor:c];
	}
}

@end
