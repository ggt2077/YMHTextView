//
//  YMHTextView.h
//  YMHTextView
//
//  Created by Tony on 15/12/15.
//  Copyright © 2015年 yimayholiday. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMHTextView;
@protocol YMHTextViewDelegate <UITextViewDelegate>

@optional

/**
 *  键盘即将弹起
 *
 *  @param textView       第一响应者
 *  @param duration       弹起时间
 *  @param keyboardHeight 弹起高度
 */
- (void)ymh_textView:(YMHTextView *)textView keyboardWillShowWithDuration:(CGFloat)duration andKeyboardHeight:(CGFloat)keyboardHeight;

/**
 *  键盘即将收起
 *
 *  @param textView 第一响应者
 *  @param duration 收起时间
 */
- (void)ymh_textView:(YMHTextView *)textView keyboardWillHideWithDuration:(CGFloat)duration;

@end


@interface YMHTextView : UITextView

@property (nonatomic,weak) id<YMHTextViewDelegate> ymh_delegate;

/** 占位文字*/
@property (nonatomic, copy) NSString *placehoder;

/** 占位文字颜色*/
@property (nonatomic, strong) UIColor *placehoderColor;

@end
