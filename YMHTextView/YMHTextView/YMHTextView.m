//
//  YMHTextView.m
//  YMHTextView
//
//  Created by Tony on 15/12/15.
//  Copyright © 2015年 yimayholiday. All rights reserved.
//

#import "YMHTextView.h"
#import "UIView+Extension.h"

@interface YMHTextView ()

/** 占位label*/
@property (nonatomic, weak) UILabel *placehoderLabel;
/** 工具条*/
@property (nonatomic,strong) UIToolbar *toolBar;

/** 是否正在切换键盘*/
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;

@end

@implementation YMHTextView

#define KToolBarHeight 30

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //添加占位文字的label
        UILabel *placehoderLabel = [[UILabel alloc] init];
        placehoderLabel.numberOfLines = 0;
        placehoderLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:placehoderLabel];
        self.placehoderLabel = placehoderLabel;
        // 设置默认的占位文字颜色
        self.placehoderColor = [UIColor lightGrayColor];
        // 设置默认的字体
        self.font = [UIFont systemFontOfSize:14];
        
        self.inputAccessoryView = self.toolBar;
        
// 不要设置自己的代理为自己本身
        
        // 监听内部文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing) name:UITextViewTextDidEndEditingNotification object:self];
        

        // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
        // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - getter

-(UIToolbar *)toolBar
{
    if (!_toolBar) {
        
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.width, KToolBarHeight)];
        _toolBar.backgroundColor = [UIColor whiteColor];
        _toolBar.barTintColor = [UIColor whiteColor];
        
        //左边item
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        //中间item
        UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        //右边item
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithTitle:@"收起\t" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked)];
        rightItem.tintColor = [UIColor orangeColor];
        
        
        _toolBar.items=@[leftItem, centerSpace, rightItem];
        
        //添加底部的分割线
//        [_toolBar addSubview:self.separatorView];
        
    }
    return _toolBar;
}


#pragma mark - setter

- (void)setPlacehoder:(NSString *)placehoder
{
    //如果是copy策略，setter最好这么写
    _placehoder = [placehoder copy];
    
    // 设置文字
    self.placehoderLabel.text = placehoder;
    
    // 重新计算子控件的fame
    [self setNeedsLayout];
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor
{
    _placehoderColor = placehoderColor;
    
    // 设置颜色
    self.placehoderLabel.textColor = placehoderColor;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placehoderLabel.font = font;
    
    // 重新计算子控件的fame
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placehoderLabel.y = 8;
    self.placehoderLabel.x = 5;
    self.placehoderLabel.width = self.width - 2 * self.placehoderLabel.x;
    // 根据文字计算label的高度
    CGSize maxSize = CGSizeMake(self.placehoderLabel.width, MAXFLOAT);
    NSDictionary *attribute = @{NSFontAttributeName: self.placehoderLabel.font};
    CGSize placehoderSize = [self.placehoder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin |
                             NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    self.placehoderLabel.height = placehoderSize.height;
}

#pragma mark - action

- (void)rightButtonClicked
{
    [self resignFirstResponder];
}

#pragma mark - textDidChange

- (void)textDidChange
{
    self.placehoderLabel.hidden = (self.text.length != 0);
    
}

- (void)textDidEndEditing
{
    [self resignFirstResponder];
}

#pragma mark - 键盘处理

/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    
    // 2.响应代理方法
    if ([self.ymh_delegate respondsToSelector:@selector(ymh_textView:keyboardWillHideWithDuration:)]) {
        [self.ymh_delegate ymh_textView:self keyboardWillHideWithDuration:duration];
    }
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    objectForKey:UIKeyboardAnimationCurveUserInfoKey
    // 2.键盘弹出的高度
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = keyboardF.size.height;
    
    // 3.响应代理方法
    if ([self.ymh_delegate respondsToSelector:@selector(ymh_textView:keyboardWillShowWithDuration:andKeyboardHeight:)]) {
        [self.ymh_delegate ymh_textView:self keyboardWillShowWithDuration:duration andKeyboardHeight:keyboardH];
    }
}

@end
