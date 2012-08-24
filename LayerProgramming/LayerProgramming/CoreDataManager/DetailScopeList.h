//
//  DetailScopeList.h
//  LayerProgramming
//
//  Created by Ymedialabs on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ScopeList;

@interface DetailScopeList : NSManagedObject

@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSNumber * scopeid;
@property (nonatomic, retain) NSString * postedBy;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDate * expectedEndDate;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) ScopeList *scopeRelation;

@end
