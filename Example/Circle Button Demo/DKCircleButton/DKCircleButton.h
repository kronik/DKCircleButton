//
//  DKCircleButton.h
//  DKCircleButton
//
//  Created by Dmitry Klimkin on 23/4/14.
//  Copyright (c) 2014 Dmitry Klimkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKCircleButton : UIButton

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic) BOOL animateTap;
@property (nonatomic) BOOL displayShading;
@property (nonatomic) CGFloat borderSize;

- (void)blink;

- (void)setImage:(UIImage *)image animated: (BOOL)animated;

@end
