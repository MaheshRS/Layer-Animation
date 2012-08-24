//
//  SLViewList.h
//  LayerProgramming
//
//  Created by Ymedialabs on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLViewList : UIView
{
  BOOL dragging;
}

- (id)initViewDetailswithFrame:(CGRect)frame withSprintNumber:(NSInteger)sprintNumber withDate:(NSString *)date withCompletionDate:(NSString *)completionDate withPoster:(NSString *)postedBy withDetails:(NSString *)details;

@end
