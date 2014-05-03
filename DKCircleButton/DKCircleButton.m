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

@end

@implementation DKCircleButton

@synthesize highLightView = _highLightView;
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
        
        self.clipsToBounds = YES;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;

        [self addSubview:_highLightView];        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateMaskToBounds:self.bounds];
}

- (void)setHighlighted:(BOOL)highlighted {
    
    if (highlighted) {
        self.layer.borderColor = [self.borderColor colorWithAlphaComponent:1.0].CGColor;

        self.highLightView.alpha = 1;

        __weak typeof(self) this = self;
        
        [self triggerAnimateTap];
        
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            this.highLightView.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
        }];
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
    self.layer.borderWidth = DKCircleButtonBorderWidth;
    
    self.highLightView.frame = self.bounds;
}

- (void)triggerAnimateTap {
    
    if (self.animateTap == NO) {
        return;
    }
    
    CGRect pathFrame = CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), self.bounds.size.width, self.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:self.layer.cornerRadius];
    
    // accounts for left/right offset and contentOffset of scroll view
    CGPoint shapePosition = [self.superview convertPoint:self.center fromView:self.superview];
    
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = path.CGPath;
    circleShape.position = shapePosition;
    circleShape.fillColor = [UIColor clearColor].CGColor;
    circleShape.opacity = 0;
    circleShape.strokeColor = [UIColor whiteColor].CGColor;
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

@end
