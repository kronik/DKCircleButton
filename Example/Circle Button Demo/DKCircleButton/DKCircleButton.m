//
//  DKCircleButton.m
//  DKCircleButton
//
//  Created by Dmitry Klimkin on 23/4/14.
//  Copyright (c) 2014 Dmitry Klimkin. All rights reserved.
//

#import "DKCircleButton.h"

#define DKCircleButtonBorderWidth 3.0f

@interface DKCircleButton ()

@property (nonatomic, strong) UIView *highLightView;
@property (nonatomic, strong) CAGradientLayer *gradientLayerTop;
@property (nonatomic, strong) CAGradientLayer *gradientLayerBottom;

@end

@implementation DKCircleButton

@synthesize highLightView = _highLightView;
@synthesize displayShading = _displayShading;
@synthesize gradientLayerTop = _gradientLayerTop;
@synthesize gradientLayerBottom = _gradientLayerBottom;
@synthesize borderSize = _borderSize;
@synthesize borderColor = _borderColor;
@synthesize animateTap = _animateTap;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _highLightView = [[UIView alloc] initWithFrame:frame];
        
        _highLightView.userInteractionEnabled = YES;
        _highLightView.alpha = 0;
        _highLightView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        
        _borderColor = [UIColor whiteColor];
        _animateTap = YES;
        _borderSize = DKCircleButtonBorderWidth;
        
        self.clipsToBounds = YES;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        _gradientLayerTop = [CAGradientLayer layer];
        _gradientLayerTop.frame = CGRectMake(0.0, 0.0, frame.size.width, frame.size.height / 4);
        _gradientLayerTop.colors = @[(id)[UIColor blackColor].CGColor, (id)[[UIColor lightGrayColor] colorWithAlphaComponent:0.01].CGColor];
        
        _gradientLayerBottom = [CAGradientLayer layer];
        _gradientLayerBottom.frame = CGRectMake(0.0, frame.size.height * 3 / 4, frame.size.width, frame.size.height / 4);
        _gradientLayerBottom.colors = @[(id)[[UIColor lightGrayColor] colorWithAlphaComponent:0.01].CGColor, (id)[UIColor blackColor].CGColor];

        [self addSubview:_highLightView];        
    }
    
    return self;
}

- (void)setDisplayShading:(BOOL)displayShading {
    _displayShading = displayShading;
    
    if (displayShading) {
        [self.layer addSublayer:self.gradientLayerTop];
        [self.layer addSublayer:self.gradientLayerBottom];
    } else {
        [self.gradientLayerTop removeFromSuperlayer];
        [self.gradientLayerBottom removeFromSuperlayer];
    }
    [self layoutSubviews];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    
    [self layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateMaskToBounds:self.bounds];
}

- (void)setHighlighted:(BOOL)highlighted {
    
    if (highlighted) {
        self.layer.borderColor = [self.borderColor colorWithAlphaComponent:1.0].CGColor;
        
        [self triggerAnimateTap];
    }
    else {
        self.layer.borderColor = [self.borderColor colorWithAlphaComponent:0.7].CGColor;
    }
}

- (void)updateMaskToBounds:(CGRect)maskBounds {
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    CGPathRef maskPath = CGPathCreateWithEllipseInRect(maskBounds, NULL);
    
    maskLayer.bounds = maskBounds;
    maskLayer.path = maskPath;
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    
    CGPoint point = CGPointMake(maskBounds.size.width/2, maskBounds.size.height/2);
    maskLayer.position = point;
    
    [self.layer setMask:maskLayer];
    
    self.layer.cornerRadius = CGRectGetHeight(maskBounds) / 2.0;
    self.layer.borderColor = [self.borderColor colorWithAlphaComponent:0.7].CGColor;
    self.layer.borderWidth = self.borderSize;
    
    self.highLightView.frame = self.bounds;
}

- (void)blink {
    CGRect pathFrame = CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), self.bounds.size.width, self.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:self.layer.cornerRadius];
    
    // accounts for left/right offset and contentOffset of scroll view
    CGPoint shapePosition = [self.superview convertPoint:self.center fromView:self.superview];
    
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = path.CGPath;
    circleShape.position = shapePosition;
    circleShape.fillColor = [UIColor clearColor].CGColor;
    circleShape.opacity = 0;
    circleShape.strokeColor = self.borderColor.CGColor;
    circleShape.lineWidth = 2.0;
    
    [self.superview.layer addSublayer:circleShape];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0, 2.0, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation, alphaAnimation];
    animation.duration = 0.7f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [circleShape addAnimation:animation forKey:nil];
}

- (void)triggerAnimateTap {
    
    if (self.animateTap == NO) {
        return;
    }
    
    self.highLightView.alpha = 1;
    
    __weak typeof(self) this = self;
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        this.highLightView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
    }];
    
    CGRect pathFrame = CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), self.bounds.size.width, self.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:self.layer.cornerRadius];
    
    // accounts for left/right offset and contentOffset of scroll view
    CGPoint shapePosition = [self.superview convertPoint:self.center fromView:self.superview];

    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = path.CGPath;
    circleShape.position = shapePosition;
    circleShape.fillColor = [UIColor clearColor].CGColor;
    circleShape.opacity = 0;
    circleShape.strokeColor = self.borderColor.CGColor;
    circleShape.lineWidth = 2.0;
    
    [self.superview.layer addSublayer:circleShape];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5, 2.5, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation, alphaAnimation];
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [circleShape addAnimation:animation forKey:nil];
}

- (void)setImage:(UIImage *)image animated: (BOOL)animated {
    
    [super setImage:nil forState:UIControlStateNormal];
    [super setImage:image forState:UIControlStateSelected];
    [super setImage:image forState:UIControlStateHighlighted];
    
    if (animated) {
        UIImageView *tmpImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        tmpImageView.image = image;
        tmpImageView.alpha = 0;
        tmpImageView.backgroundColor = [UIColor clearColor];
        tmpImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:tmpImageView];
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            tmpImageView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [super setImage:image forState:UIControlStateNormal];
            [tmpImageView removeFromSuperview];
        }];
    } else {
        [super setImage:image forState:UIControlStateNormal];
    }
}

@end
