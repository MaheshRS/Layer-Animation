//
//  RootViewController.h
//  LayerProgramming
//
//  Created by Ymedialabs on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLScrollView;

@interface RootViewController : UIViewController
{
  SLScrollView *scrollView;
  UITapGestureRecognizer *tapGesturer;
}

@property(nonatomic,retain)NSManagedObjectContext *managerContext;

- (void)fetchedResultsManagedObject;
- (void)insertSprints;
- (void)tapPressed:(UIGestureRecognizer *)gesture;
@end
