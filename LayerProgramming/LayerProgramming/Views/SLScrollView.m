//
//  SLScrollView.m
//  LayerProgramming
//
//  Created by Ymedialabs on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SLScrollView.h"
#import "SLViewList.h"

@implementation SLScrollView

- (id)initWithFrame:(CGRect)frame 
{
	return [super initWithFrame:frame];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  UITouch *touch=[[event allTouches]anyObject];
  if([[touch view]isKindOfClass:[SLViewList class]])
    [self.nextResponder touchesBegan:touches withEvent:event]; 
  [self setScrollEnabled:NO];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  UITouch *touch=[[event allTouches]anyObject];
  NSLog(@"DESCRIPTION %@",[touch view]);
  if([[touch view]isKindOfClass:[SLViewList class]])
  {
    [[touch view]setFrame:CGRectMake([touch locationInView:self].x, [touch locationInView:self].y, 150.0f, 80.0f)];
    [self.nextResponder touchesMoved:touches withEvent:event]; 
  }
}

- (void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
	// If not dragging, send event to next responder
	if (!self.dragging) 
		[self.nextResponder touchesEnded: touches withEvent:event]; 
	else
		[super touchesEnded: touches withEvent: event];
  [self setScrollEnabled:YES];
}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
  return YES;
}

@end
