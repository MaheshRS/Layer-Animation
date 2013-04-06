//
//  LPLayer.m
//  LayerProgramming
//
//  Created by Karthik Keyan B on 4/5/13.
//
//

#import "LPLayer.h"

@interface LPLayer()

@property(nonatomic, strong)UIColor *bgColor;
@property(nonatomic, strong)NSNumber *shapeType;

@end

@implementation LPLayer

- (void)drawInContext:(CGContextRef)ctx
{
    if([self.shapeType integerValue] == 1)
    {
        CGContextSetFillColorWithColor( ctx, self.bgColor.CGColor );
        CGContextFillRect( ctx, self.bounds);
        
        CGRect holeRectIntersection = CGRectMake(10., self.bounds.size.width/2 - 25., 50, 50);
        CGRect holeRectIntersection1 = CGRectMake(40., self.bounds.size.width/2 - 25., 50, 50);
        
        CGContextAddEllipseInRect(ctx, holeRectIntersection);
        CGContextAddEllipseInRect(ctx, holeRectIntersection1);
        CGContextClip(ctx);
        CGContextClearRect(ctx, holeRectIntersection);
        CGContextClearRect(ctx, holeRectIntersection1);
    }
    else if ([self.shapeType integerValue] == 2)
    {
    }
    else
    {
        
        CGContextSetFillColorWithColor( ctx, self.bgColor.CGColor );
        CGContextFillRect( ctx, self.bounds);
        
        CGRect holeRectIntersection =CGRectMake(self.bounds.size.width/2 - 25., self.bounds.size.width/2 - 25., 50, 50);
        
        CGContextAddEllipseInRect(ctx, holeRectIntersection);
        CGContextClip(ctx);
        CGContextClearRect(ctx, holeRectIntersection);
        
    }
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{

}

- (void)addBGColor:(UIColor *)color
{
    self.bgColor = color;
}

- (void)addShapeType:(NSInteger)type
{
    self.shapeType = @(type);
}

@end
