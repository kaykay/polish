/*
 * POAsk.j
 *
 * Created by Roberto Gamboni on 02/15/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

//TODO need to implement this. no cpalert with a text field

@implementation POAsk : PODialog {
	id 			__delegate;
}

- (id) ask {
	self = [super init];
	if(self) {
		__delegate = [[CPAlert alloc] init];
		[self createJSMethods: ['type:', 'message:', 'title:']];
		objj_msgSend(__delegate, 'setAlertStyle:', CPInformationalAlertStyle);
		objj_msgSend(__delegate, 'addButtonWithTitle:', 'Ok');
		objj_msgSend(__delegate, 'setDelegate:', self);
	}
	return self;
}

-(void)alertDidEnd:(CPAlert)theAlert returnCode:(int)returnCode {
	console.log('didPressAlert '+ returnCode);
}

- (void) type:(CPString) t {
	if(t != undefined) {
		if(t == 'info') { objj_msgSend(__delegate, 'setAlertStyle:', CPInformationalAlertStyle); }
		else if(t == 'warning') { objj_msgSend(__delegate, 'setAlertStyle:', CPWarningAlertStyle); }
		else if(t == 'error') { objj_msgSend(__delegate, 'setAlertStyle:', CPCriticalAlertStyle); }
	} else {
		var s = objj_msgSend(__delegate, 'alertStyle');
		if(s == CPWarningAlertStyle) return 'warning';
		if(s == CPCriticalAlertStyle) return 'error';
		return 'info'; //default setting is info
	}
}

- (void) message:(CPString) t {
	if(t != undefined) {
		objj_msgSend(__delegate, 'setMessageText:', t);
	} else {
		return objj_msgSend(__delegate, 'messageText');
	}
}

- (void) title:(CPString) t {
	if(t != undefined) {
		objj_msgSend(__delegate, 'setTitle:', t);
	} else {
		return objj_msgSend(__delegate, 'title');
	}
}

@end