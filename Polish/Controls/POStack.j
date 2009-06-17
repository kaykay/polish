/*
 * POStack.j
 *
 * Created by Roberto Gamboni on 02/17/2009.
 * Copyright 2008 Roberto Gamboni. All rights reserved.
 */

@implementation POStack : POControl {
  id members;
  id marginY;
  id marginX;
  // need to maintain this since x,y of a child can be changed.
  id lastX;
  id lastY;
}

/*
* Init a stack with hmargin and vmargin = 0;
*/
- (id) stack {
  members = [];
  marginY = 10;
  marginX = 10;
  self = [super init];
  if(self) {
    __delegate = [[CPView alloc] initWithFrame:CGRectMakeZero()];
    [self createForwardJSMethods: polish_components];
  }
  return self;
}

- (void) addChild:(POControl) child {
  [super addChild:child];
  [self place: child];
}

- (void) place:(id)aChild
{
  //First one.
  if(members.length == 0)
    {
      lastX = self.x() + marginX;
      lastY = self.y() + marginY;
    } else
    {
      var lastMember = members[members.length - 1];
      lastY = lastY + lastMember.height() + marginY;
    }
  aChild.x(lastX);
  aChild.y(lastY);
  members.push(aChild);
}

//- (void) redraw
//{
//  var membersClone = members;
//  members = [];
//  membersClone.each { |member| [self addChild: member] }
//}
//
//- (void) removeChild: aChild
//{
//  membersRemove;
//  redraw
//}
@end
