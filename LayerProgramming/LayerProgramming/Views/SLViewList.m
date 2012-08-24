//
//  SLViewList.m
//  LayerProgramming
//
//  Created by Ymedialabs on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SLViewList.h"

@interface SLViewList ()
{
  // make the labels private and dont allow the label to be changed 
  UILabel *sprintNumberLabel;
  UILabel *dateLabel;
  UILabel *completionDateLabel;
  UILabel *postedByLabel;
  UILabel *DetailsLabel;
}

  // make the initializations and the setting of data private
- (void)initializeComponents;
- (void)addDetailswithSprintNumber:(NSInteger)setSprintNumber withDate:(NSString *)setDate withCompletionDate:(NSString *)setCompletionDate withPoster:(NSString *)setPostedBy withDetails:(NSString *)setDetails; 
@end

@implementation SLViewList


- (id)initViewDetailswithFrame:(CGRect)frame withSprintNumber:(NSInteger)sprintNumber withDate:(NSString *)date withCompletionDate:(NSString *)completionDate withPoster:(NSString *)postedBy withDetails:(NSString *)details 
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      [self initializeComponents];
        // set the data
      [self addDetailswithSprintNumber:sprintNumber withDate:date withCompletionDate:completionDate withPoster:postedBy withDetails:details];
      
       // set the background color
      [self setBackgroundColor:SLViewBGColor];
    }
    return self;
}

- (void)dealloc
{
  [super dealloc];
}

- (void)initializeComponents
{
  sprintNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, [self bounds].size.width, 40.0f)];
  [sprintNumberLabel setTextAlignment:UITextAlignmentCenter];
  [sprintNumberLabel setFont:[UIFont fontWithName:SLHelvetica size:12.0f]];
  [sprintNumberLabel setTextColor:SLLabelTextColor];
  [sprintNumberLabel setBackgroundColor:SLClearColor];
  [self addSubview:sprintNumberLabel];
  [sprintNumberLabel release];
  
  dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 45.0f, [self bounds].size.width, 40.0f)];
  [dateLabel setTextAlignment:UITextAlignmentCenter];
  [dateLabel setFont:[UIFont fontWithName:SLHelvetica size:12.0f]];
  [dateLabel setTextColor:SLLabelTextColor];
  [dateLabel setBackgroundColor:SLClearColor];
  [self addSubview:dateLabel];
  [dateLabel release];
  
}

- (void)addDetailswithSprintNumber:(NSInteger)setSprintNumber withDate:(NSString *)setDate withCompletionDate:(NSString *)setCompletionDate withPoster:(NSString *)setPostedBy withDetails:(NSString *)setDetails 
{
  [sprintNumberLabel setText:[NSString stringWithFormat:@"SprintNumber : %i",setSprintNumber]];
  [dateLabel setText:[NSString stringWithFormat:@"Posted : %@",setDate]];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

@end
