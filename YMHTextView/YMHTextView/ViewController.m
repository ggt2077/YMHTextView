//
//  ViewController.m
//  YMHTextView
//
//  Created by Tony on 15/12/15.
//  Copyright © 2015年 yimayholiday. All rights reserved.
//

#import "ViewController.h"
#import "YMHTextView.h"

@interface ViewController ()<YMHTextViewDelegate>

@property (strong,nonatomic) YMHTextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    YMHTextView *textView = [[YMHTextView alloc] initWithFrame:CGRectMake(50, 400, 250, 100)];
    textView.placehoder = @"这是测试用的，你打我呀";
    textView.placehoderColor = [UIColor blueColor];
    textView.font = [UIFont systemFontOfSize:18];
    //显示边框
    textView.layer.borderColor = [[UIColor colorWithRed:230.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0]CGColor];
    textView.layer.borderWidth = 1.0;
    
//    textView.layer.cornerRadius = 8.0f;
    
    [textView.layer setMasksToBounds:YES];
    
    [self.view addSubview:textView];
    self.textView = textView;
    self.textView.ymh_delegate = self;
    self.textView.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果
    
    
    //按钮点击
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 500, 100, 50);
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick
{
    NSLog(@"self.textView.text == %@",self.textView.text);
}

#pragma mark - YMHTextViewDelegate

- (void)ymh_textView:(YMHTextView *)textView keyboardWillShowWithDuration:(CGFloat)duration andKeyboardHeight:(CGFloat)keyboardHeight
{
    [UIView animateWithDuration:duration+0.5 animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:duration];
        self.view.transform = CGAffineTransformMakeTranslation(0, - keyboardHeight);;
    }];
}

- (void)ymh_textView:(YMHTextView *)textView keyboardWillHideWithDuration:(CGFloat)duration
{
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

@end
