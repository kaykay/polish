/*
 * AppController.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "AppBuilder.j"

@implementation AppController : CPObject
{
	
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
	//this is the mainWindow. For modify this object there are utilities methods in app.
    theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];

	//app is visible outside using objj syntax.
	//js can interact with app using objj_msgSend(app, message, params..);
	app = [[AppBuilder alloc] initWithContentView:theWindow];
	
	//default stuff... setting background black.
	[theWindow orderFront:self];
	
	[app create:'json string'];
	stack = [app stack];
	console.log(stack);
	[stack frame:CGRectMake(10,10,400,300)];
	[stack color:'grayColor'];
	
	button = [stack button];
	console.log(button);
	[button frame:CGRectMake(300,10,70,18.0)];
	[button title:'click'];
	
	text = [stack text];
	console.log(text);
	[text frame:CGRectMake(120,10,150.0,18.0)];
	
	label = [stack label];
	console.log(label);
	[label frame:CGRectMake(10,10,100,18)];
}

@end
