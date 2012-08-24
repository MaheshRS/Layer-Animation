//
//  RootViewController.m
//  LayerProgramming
//
//  Created by Ymedialabs on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "ScopeList.h"
#import "SLViewList.h"
#import "SLScrollView.h"
#import <QuartzCore/QuartzCore.h>

#define SUBLAYER_WIDTH  50
#define SUBLAYER_HEIGHT 50  
#define INTERSPACE      8
#define XINSTANCES      3
#define YINSTANCES      2

#define SQUARE_SIZE     100.0f
#define FRAME   CGRectMake(0.0f, 0.0f, SQUARE_SIZE, SQUARE_SIZE)
#define BORDERWIDTH     1.0f

@interface RootViewController ()
{
    CALayer *layer;
}

- (CABasicAnimation *)pushAnimation;
- (CABasicAnimation *)rotateAnimation;
- (CABasicAnimation *)waveAnimation;
- (CATransformLayer *)generate3DCubicalTransformLayer;

@end

@implementation RootViewController

@synthesize managerContext;

- (id)init{
    self = [super init];
    if (self) {
        // Custom initialization
      [[self view]setBackgroundColor:[UIColor grayColor]];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
  SL_RELEASE_SAFELY(scrollView);
  [super dealloc];
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
  [super loadView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  
}

-(void)storeData
{
  //[self insertSprints]; // call when the view has been loaded
  
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
  
    CATransformLayer *generatedTransformLayer = [self generate3DCubicalTransformLayer];
    
    CALayer *generatedlayer = [CALayer layer];
    [generatedlayer setFrame:CGRectMake(100,100, 100, 100)];
    [generatedlayer addSublayer:generatedTransformLayer];
    
    CABasicAnimation *basicanimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    [basicanimation setAutoreverses:YES];
    [basicanimation setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI, 1, 0, 1)]];
    [basicanimation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(( 2 *M_PI), 1, 0, 1)]];
    [basicanimation setDuration:3.0f];
    [basicanimation setRepeatCount:HUGE_VAL];
    [basicanimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [generatedTransformLayer addAnimation:basicanimation forKey:@"transform"];
    
    [[[self view]layer]addSublayer:generatedlayer];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - CoreData Implementation
- (void)fetchedResultsManagedObject
{
  // the entity
  NSString *entityName=scope;

  // error
  NSError *error;
  
  // request the entity
  // Create and configure a fetch request.
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                            inManagedObjectContext:managerContext];
  [request setEntity:entity];
  [request setFetchBatchSize:30];
  //get the data
  NSArray *fetchedobjects=[managerContext executeFetchRequest:request error:&error];
  for(NSManagedObject *info in fetchedobjects)
  {
    NSLog(@"id %i\n ",[[info valueForKey:SLId]integerValue]);
  }
  // sort and filter if you want
  SL_RELEASE_SAFELY(request);
}

- (void)insertSprints
{
  NSManagedObject *scopeList= [NSEntityDescription insertNewObjectForEntityForName:scope inManagedObjectContext:managerContext];
  [scopeList setValue:[NSNumber numberWithBool:NO] forKey:SLCodeReview];
  [scopeList setValue:[NSNumber numberWithBool:NO] forKey:SLDevelopment];
  [scopeList setValue:[NSNumber numberWithBool:YES] forKey:SLPlanning];
  [scopeList setValue:[NSNumber numberWithBool:NO] forKey:SLReady];
  [scopeList setValue:[NSNumber numberWithBool:NO] forKey:SLTesting];
  [scopeList setValue:[NSNumber numberWithInt:0001] forKey:SLId];
  
  NSManagedObject *scopeDetailList=[NSEntityDescription insertNewObjectForEntityForName:detailScope inManagedObjectContext:managerContext];
  [scopeDetailList setValue:@"gray" forKey:SLDetailColor];
  [scopeDetailList setValue:[NSDate date] forKey:SLDetailDate];
  [scopeDetailList setValue:[NSDate date] forKey:SLDetailExpectedEndDate];
  [scopeDetailList setValue:@"Learn Core Data Basics" forKey:SLDetailDetails];
  [scopeDetailList setValue:[NSNumber numberWithInt:0001] forKey:SLDetailscopeId];
  [scopeDetailList setValue:@"Mahesh Shanbhag" forKey:SLDetailpostedBy];
  
  NSError *error;
  if(![managerContext save:&error])
  {
    NSLog(@"Error in Saving [-->] %@",[error localizedDescription]);
  }
  else
  {
    [self fetchedResultsManagedObject];
  }
}

#pragma mark - touches detected
- (BOOL)canBecomeFirstResponder
{
  return YES;
}

#pragma mark - tap Gesture
- (void)tapPressed:(UIGestureRecognizer *)gesture
{
  NSLog(@"view tapped Description %@",[gesture view]);
}

#pragma mark - Private methods
- (CABasicAnimation *)pushAnimation
{
    CABasicAnimation *pushAnimation = [CABasicAnimation animationWithKeyPath:@"instanceTransform"];
    pushAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(SUBLAYER_WIDTH+INTERSPACE, 0, 0)];
    pushAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(SUBLAYER_WIDTH+INTERSPACE + 60, 0, 0)];
    pushAnimation.duration = 3.0f;
    pushAnimation.autoreverses = YES;
    pushAnimation.repeatCount = HUGE_VAL;
    pushAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return pushAnimation;
}


- (CABasicAnimation *)rotateAnimation
{
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D t = CATransform3DIdentity;
    CATransform3D t1 = CATransform3DRotate(t, -1, 1.0f, 1.0f, 1.0f);
    CATransform3D t2 = CATransform3DRotate(t, 1, 1.0f, 1.0f, 1.0f);
    rotateAnimation.duration=1.5f;
    rotateAnimation.fromValue = [NSValue valueWithCATransform3D:t1];
    rotateAnimation.toValue = [NSValue valueWithCATransform3D:t2];
    rotateAnimation.autoreverses = YES;
    rotateAnimation.repeatCount = HUGE_VAL;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return rotateAnimation;
}

- (CABasicAnimation *)waveAnimation
{
    CABasicAnimation *wave = [CABasicAnimation animationWithKeyPath:@"transform"];
    wave.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, 0.0f, -100.0f)];
    wave.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, 0.0f, 100.0f)];
    wave.duration = 1.5f;
    wave.autoreverses = YES;
    wave.repeatCount = HUGE_VAL;
    wave.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return wave;
}

- (CATransformLayer *)generate3DCubicalTransformLayer
{
    // generate a transform layer
    CATransformLayer *transformLayer = [CATransformLayer layer];
    [transformLayer setBounds:CGRectMake(0, 0,100,100)];
    
    CGPoint centralPoint =CGPointMake([transformLayer bounds].size.width/2, [transformLayer bounds].size.height/2); 

    // this is the first face of the cube
    CALayer *layer1 = [CALayer layer]; 
    [layer1 setBounds:FRAME];
    [layer1 setBorderWidth:BORDERWIDTH];
    [layer1 setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:0.7].CGColor];
    [layer1 setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [layer1 setPosition:centralPoint]; // this is added so the center is same for all the sublayers, and is translated and rotate along the same position
    
    // adding text to layer 1
    CATextLayer *layerText1 = [CATextLayer layer];
    [layerText1 setFont:@"Helvetica-Bold"];
    [layerText1 setFontSize:20];
    [layerText1 setFrame:CGRectMake(0, [transformLayer frame].size.height/2, [transformLayer frame].size.width, [transformLayer frame].size.height)];
    [layerText1 setString:@"1"];
    [layerText1 setAlignmentMode:kCAAlignmentCenter];
    [layerText1 setForegroundColor:[[UIColor whiteColor] CGColor]];
    [layer1 addSublayer:layerText1];
    

    
    // this is the second face of the cube
    CALayer *layer2 = [CALayer layer];
    [layer2 setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [layer2 setBounds:FRAME];
    [layer2 setBorderWidth:1];
    [layer2 setBackgroundColor:[UIColor lightGrayColor].CGColor];
    [layer2 setBackgroundColor:[[UIColor colorWithRed:0 green:1 blue:0 alpha:0.7]CGColor]];
    [layer2 setPosition:centralPoint]; // this is added so the center is same for all the sublayers, and is translated and rotate along the same position
    
    CGFloat degrees =90.0f;
    CGFloat radians = (degrees/180)*M_PI;
    
    // to rotate the second face we need to apply a transform matrix to the second face
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, radians, 0, 1, 0);
    transform = CATransform3DTranslate(transform, 0, 0, SQUARE_SIZE/2);
    transform = CATransform3DTranslate(transform, SQUARE_SIZE/2, 0, 0);
    layer2.transform = transform;
    
    // adding text to layer 2
    CATextLayer *layerText2 = [CATextLayer layer];
    [layerText2 setFont:@"Helvetica-Bold"];
    [layerText2 setFontSize:20]; 
    [layerText2 setFrame:CGRectMake(0, [transformLayer frame].size.height/2, [transformLayer frame].size.width, [transformLayer frame].size.height)];
    [layerText2 setString:@"2"];
    [layerText2 setAlignmentMode:kCAAlignmentCenter];
    [layerText2 setForegroundColor:[[UIColor whiteColor] CGColor]];
    [layer2 addSublayer:layerText2];
    
    // this is the third face of the cube
    CALayer *layer3 = [CALayer layer];
    [layer3 setBounds:FRAME];
    [layer3 setBackgroundColor:[[UIColor colorWithRed:0 green:0 blue:1 alpha:0.7]CGColor]];
    [layer3 setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [layer3 setBorderWidth:BORDERWIDTH];
    [layer3 setPosition:centralPoint];
    
    // now add the transformations to the layer 3 to rotate and translate
    transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 0, -SQUARE_SIZE);
    layer3.transform = transform;
    
    // adding text to layer 3
    CATextLayer *layerText3 = [CATextLayer layer];
    [layerText3 setFont:@"Helvetica-Bold"];
    [layerText3 setFontSize:20];
    [layerText3 setFrame:CGRectMake(0, [transformLayer frame].size.height/2, [transformLayer frame].size.width, [transformLayer frame].size.height)];
    [layerText3 setString:@"3"];
    [layerText3 setAlignmentMode:kCAAlignmentCenter];
    [layerText3 setForegroundColor:[[UIColor whiteColor] CGColor]];
    [layer3 addSublayer:layerText3];
    
    // this is the fourth face of the cube
    CALayer *layer4 = [CALayer layer];
    [layer4 setBounds:FRAME];
    [layer4 setPosition:centralPoint];
    [layer4 setBackgroundColor:[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]CGColor]];
    [layer4 setBorderWidth:1];
    [layer4 setBorderColor:[[UIColor lightGrayColor]CGColor]];
    
    // now adding the transform to the fourth face to align it with the other faces
    transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, -radians, 0, 1, 0);
    transform = CATransform3DTranslate(transform, -SQUARE_SIZE/2, 0, 0);
    transform = CATransform3DTranslate(transform, 0, 0, SQUARE_SIZE/2);
    layer4.transform = transform;
    
    // adding text to layer 4
    CATextLayer *layerText4 = [CATextLayer layer];
    [layerText4 setFont:@"Helvetica-Bold"];
    [layerText4 setFontSize:20]; 
    [layerText4 setFrame:CGRectMake(0 ,[transformLayer frame].size.height/2, [transformLayer frame].size.width, [transformLayer frame].size.height)];
    [layerText4 setString:@"4"];
    [layerText4 setAlignmentMode:kCAAlignmentCenter];
    [layerText4 setForegroundColor:[[UIColor whiteColor] CGColor]];
    [layer4 addSublayer:layerText4];
    
    
    // now adding the top face of the cube
    CALayer *layer5 = [CALayer layer];
    [layer5 setBounds:FRAME];
    [layer5 setBackgroundColor:[[UIColor orangeColor]CGColor]];
    [layer5 setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [layer5 setBorderWidth:1];
    [layer5 setPosition:centralPoint];
    
    // adding the transform to the layer5 to get it aligned with others
    transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, radians, 1, 0, 0);
    transform = CATransform3DTranslate(transform, 0,-SQUARE_SIZE/2, 0 );
    transform = CATransform3DTranslate(transform, 0, 0, +SQUARE_SIZE/2);
    layer5.transform = transform;
    
    // adding text to layer 5
    CATextLayer *layerText5 = [CATextLayer layer];
    [layerText5 setFont:@"Helvetica-Bold"];
    [layerText5 setFontSize:20]; 
    [layerText5 setFrame:CGRectMake(0, [transformLayer frame].size.height/2, [transformLayer frame].size.width, [transformLayer frame].size.height)];
    [layerText5 setString:@"5"];
    [layerText5 setAlignmentMode:kCAAlignmentCenter];
    [layerText5 setForegroundColor:[[UIColor whiteColor] CGColor]];
    [layer5 addSublayer:layerText5];
    
    // now adding the bottom face of the cube
    CALayer *layer6 = [CALayer layer];
    [layer6 setBounds:FRAME];
    [layer6 setBackgroundColor:[[UIColor purpleColor]CGColor]];
    [layer6 setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [layer6 setBorderWidth:1];
    [layer6 setPosition:centralPoint];
    
    // adding the transform to the layer5 to get it aligned with others
    transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, radians, 1, 0, 0);
    transform = CATransform3DTranslate(transform, 0,-SQUARE_SIZE/2, 0 );
    transform = CATransform3DTranslate(transform, 0, 0, -SQUARE_SIZE/2);
    layer6.transform = transform;

    // adding text to layer 6
    CATextLayer *layerText6 = [CATextLayer layer];
    [layerText6 setFont:@"Helvetica-Bold"];
    [layerText6 setFontSize:20];  
    [layerText6 setFrame:CGRectMake(0, [transformLayer frame].size.height/2, [transformLayer frame].size.width, [transformLayer frame].size.height)];
    [layerText6 setString:@"6"];
    [layerText6 setAlignmentMode:kCAAlignmentCenter];
    [layerText6 setForegroundColor:[[UIColor whiteColor] CGColor]];
    [layer6 addSublayer:layerText6];
    
    
    // add the above 4 faces of the cube to the transform layer
    [transformLayer addSublayer:layer1];
    [transformLayer addSublayer:layer2];
    [transformLayer addSublayer:layer3];
    [transformLayer addSublayer:layer4];
    [transformLayer addSublayer:layer5];
    [transformLayer addSublayer:layer6];
    
    // set the anchor point to the center of the transform layer
    [transformLayer setAnchorPointZ:-SQUARE_SIZE/2];
     
    // return transformlayer
    return transformLayer;
}

#pragma mark - touch methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end
