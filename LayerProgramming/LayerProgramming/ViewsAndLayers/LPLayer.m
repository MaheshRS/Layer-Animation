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

@end

@implementation LPLayer

- (void)drawInContext:(CGContextRef)ctx
{
    
    CGContextSetFillColorWithColor( ctx, self.bgColor.CGColor );
    CGContextFillRect( ctx, self.bounds);
    
    CGRect holeRectIntersection =CGRectMake(self.bounds.size.width/2 - 25., self.bounds.size.width/2 - 25., 50, 50);
    
    CGContextAddEllipseInRect(ctx, holeRectIntersection);
    CGContextClip(ctx);
    CGContextClearRect(ctx, holeRectIntersection);
    
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{

}

- (void)addBGColor:(UIColor *)color
{
    self.bgColor = color;
}

@end
