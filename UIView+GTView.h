//
//  UIView+GTView.h
//  CAAnimationTest
//
//  Created by Tony on 16/1/15.
//  Copyright © 2016年 JCH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GTView)

/**
 *  为view(矩形)设置圆角
 *
 *  @param corners 指定哪个角设置为圆角(可以是一、二、三，四个角的话用下面的方法)
 *  @param radii   圆角半径
 */
- (void)addCornerRadiusWithcorners:(UIRectCorner)corners AndRadii:(CGSize)radii;

/**
 *  设置圆角矩形
 *
 *  @param cornerRadius 圆角半径
 */
- (void)addCornerRadiusWithRadius:(CGFloat)cornerRadius;

@end
