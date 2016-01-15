//
//  UIView+GTView.m
//  CAAnimationTest
//
//  Created by Tony on 16/1/15.
//  Copyright © 2016年 JCH. All rights reserved.
//

#import "UIView+GTView.h"

@implementation UIView (GTView)

- (void)addCornerRadiusWithcorners:(UIRectCorner)corners AndRadii:(CGSize)radii {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shapLayer = [[CAShapeLayer alloc]init];
    shapLayer.path = bezierPath.CGPath;
    self.layer.mask = shapLayer;
}

- (void)addCornerRadiusWithRadius:(CGFloat)cornerRadius {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *shapLayer = [[CAShapeLayer alloc]init];
    shapLayer.path = bezierPath.CGPath;
    self.layer.mask = shapLayer;
}

@end
