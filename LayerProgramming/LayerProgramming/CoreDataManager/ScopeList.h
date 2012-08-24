//
//  ScopeList.h
//  LayerProgramming
//
//  Created by Ymedialabs on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DetailScopeList;

@interface ScopeList : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * planning;
@property (nonatomic, retain) NSNumber * development;
@property (nonatomic, retain) NSNumber * codeReview;
@property (nonatomic, retain) NSNumber * ready;
@property (nonatomic, retain) NSNumber * testing;
@property (nonatomic, retain) DetailScopeList *scopeRelation;

@end
