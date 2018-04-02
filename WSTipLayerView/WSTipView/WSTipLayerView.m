//
//  WSTipLayerView.m
//  WSTipLayerView
//
//  Created by Praveen on 29/03/18.
//  Copyright © 2018 WebsoftProfession. All rights reserved.
//

#import "WSTipLayerView.h"

@implementation WSTipLayerView
@synthesize tipViewIndex;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath *backgroundPath = [UIBezierPath bezierPathWithRect:rect];
    UIView *view = [self.tipDelegate viewForTipAtIndex:tipViewIndex];
    UIViewController *controller = (UIViewController *)self.tipDelegate;
    CGRect frame = [controller.view convertRect:view.frame fromView:controller.view];
    UIBezierPath *buttonPath = [UIBezierPath bezierPathWithRect:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [backgroundPath appendPath:buttonPath];
    [backgroundPath setUsesEvenOddFillRule:YES];

    // draw shadow
    [self drawShadowForFrame:frame];
    
    
    [[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7] setFill];
    [backgroundPath fill];
    buttonPath.lineWidth = 1.0;
    [self.shadowColor setStroke];
    [buttonPath stroke];
    
    // draw arrow
    [self drawArrowOfFrame:frame onViewController:controller withArrowStyle:[self.tipDelegate tipArrowStyleForTipAtIndex:tipViewIndex]];
}

-(void)drawShadowForFrame:(CGRect)frame{
    // draw shadow
    
    // Top
    for (CAShapeLayer *layer in self.layer.sublayers) {
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            if ([layer.name isEqualToString:@"Top"] || [layer.name isEqualToString:@"Left"] || [layer.name isEqualToString:@"Right"] || [layer.name isEqualToString:@"Bottom"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [layer removeFromSuperlayer];
                });
            }
        }
    }
    CAShapeLayer *shadowLayerTop = [CAShapeLayer layer];
    shadowLayerTop.name = @"Top";
    shadowLayerTop.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(frame.origin.x, frame.origin.y-2, frame.size.width, 2)].CGPath;
    shadowLayerTop.shadowColor = self.shadowColor.CGColor;
    shadowLayerTop.shadowOffset = CGSizeMake(0, -3);
    shadowLayerTop.shadowOpacity = 1.0;
    shadowLayerTop.shadowRadius = 3;
    shadowLayerTop.masksToBounds = NO;
    [self.layer addSublayer:shadowLayerTop];
    
    // Left
    CAShapeLayer *shadowLayerLeft = [CAShapeLayer layer];
    shadowLayerLeft.name = @"Left";
    shadowLayerLeft.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(frame.origin.x-2, frame.origin.y, 2, frame.size.height)].CGPath;
    shadowLayerLeft.shadowColor = self.shadowColor.CGColor;
    shadowLayerLeft.shadowOffset = CGSizeMake(-3, 0);
    shadowLayerLeft.shadowOpacity = 1.0;
    shadowLayerLeft.shadowRadius = 3;
    shadowLayerLeft.masksToBounds = NO;
    [self.layer addSublayer:shadowLayerLeft];
    
    // Right
    CAShapeLayer *shadowLayerRight = [CAShapeLayer layer];
    shadowLayerRight.name = @"Right";
    shadowLayerRight.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(frame.origin.x+frame.size.width, frame.origin.y, 2, frame.size.height)].CGPath;
    shadowLayerRight.shadowColor = self.shadowColor.CGColor;
    shadowLayerRight.shadowOffset = CGSizeMake(3, 0);
    shadowLayerRight.shadowOpacity = 1.0;
    shadowLayerRight.shadowRadius = 3;
    shadowLayerRight.masksToBounds = NO;
    [self.layer addSublayer:shadowLayerRight];
    
    //Bottom
    CAShapeLayer *shadowLayerBottom = [CAShapeLayer layer];
    shadowLayerBottom.name = @"Bottom";
    shadowLayerBottom.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, 2)].CGPath;
    shadowLayerBottom.shadowColor = self.shadowColor.CGColor;
    shadowLayerBottom.shadowOffset = CGSizeMake(0, 3);
    shadowLayerBottom.shadowOpacity = 1.0;
    shadowLayerBottom.shadowRadius = 3;
    shadowLayerBottom.masksToBounds = NO;
    [self.layer addSublayer:shadowLayerBottom];
}

-(void)drawArrowOfFrame:(CGRect)frame onViewController:(UIViewController *)controller withArrowStyle:(WSTipArrowStyle)style {
    CGPoint centerPoint = CGPointMake(frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2);
    CGPoint movePointBottom = CGPointMake(centerPoint.x, centerPoint.y+frame.size.height/2+10);
    CGPoint movePointTop = CGPointMake(centerPoint.x, centerPoint.y-frame.size.height/2-10);
    UIBezierPath *lineArrowPath = [UIBezierPath bezierPath];
    UIBezierPath *lineArrowPath2 = [UIBezierPath bezierPath];
    switch (style) {
        case WSTipArrowStyleCenterTop:
        {
            [lineArrowPath moveToPoint:movePointTop];
            
            if (centerPoint.x<controller.view.center.x) {
                // Top Left
                CGPoint endPoint = CGPointMake(centerPoint.x+20, movePointTop.y-50);
                [lineArrowPath addQuadCurveToPoint:endPoint controlPoint:CGPointMake((movePointTop.x+endPoint.x)/2-25, (movePointTop.y+endPoint.y)/2)];
                
                [lineArrowPath2 moveToPoint:CGPointMake(movePointTop.x-10, movePointTop.y-5)];
                [lineArrowPath2 addLineToPoint:movePointTop];
                [lineArrowPath2 addLineToPoint:CGPointMake(movePointTop.x+5, movePointTop.y-5)];
                [lineArrowPath appendPath:lineArrowPath2];
                
                NSString *message = [self.tipDelegate messageForTipAtIndex:tipViewIndex];
                [self drawString:message withFont:[UIFont fontWithName:@"Arial" size:17] inRect:CGRectMake(controller.view.frame.origin.x+20, endPoint.y-10, controller.view.frame.size.width-40, 10) viewFrame:frame];
            }
            else{
                // Top Right
                CGPoint endPoint = CGPointMake(movePointTop.x-20, movePointTop.y-50);
                [lineArrowPath addQuadCurveToPoint:endPoint controlPoint:CGPointMake((movePointTop.x+endPoint.x)/2+25, (movePointTop.y+endPoint.y)/2)];
                
                [lineArrowPath2 moveToPoint:CGPointMake(movePointTop.x-5, movePointTop.y-5)];
                [lineArrowPath2 addLineToPoint:movePointTop];
                [lineArrowPath2 addLineToPoint:CGPointMake(movePointTop.x+10, movePointTop.y-5)];
                [lineArrowPath appendPath:lineArrowPath2];
                
                NSString *message = [self.tipDelegate messageForTipAtIndex:tipViewIndex];
                [self drawString:message withFont:[UIFont fontWithName:@"Arial" size:17] inRect:CGRectMake(controller.view.frame.origin.x+20, endPoint.y-10, controller.view.frame.size.width-40, 10) viewFrame:frame];
            }
        }
            break;
        case WSTipArrowStyleCenterBottom:
        {
            [lineArrowPath moveToPoint:movePointBottom];
            if (centerPoint.x<controller.view.center.x) {
                // Bottom Left
                CGPoint endPoint = CGPointMake(centerPoint.x+20, centerPoint.y+frame.size.height/2+50);
                [lineArrowPath addQuadCurveToPoint:endPoint controlPoint:CGPointMake((movePointBottom.x+endPoint.x)/2-25, (movePointBottom.y+endPoint.y)/2)];
                
                [lineArrowPath2 moveToPoint:CGPointMake(movePointBottom.x-10, movePointBottom.y+5)];
                [lineArrowPath2 addLineToPoint:movePointBottom];
                [lineArrowPath2 addLineToPoint:CGPointMake(movePointBottom.x+5, movePointBottom.y+5)];
                [lineArrowPath appendPath:lineArrowPath2];
                
                NSString *message = [self.tipDelegate messageForTipAtIndex:tipViewIndex];
                [self drawString:message withFont:[UIFont fontWithName:@"Arial" size:17] inRect:CGRectMake(controller.view.frame.origin.x+20, endPoint.y+10, controller.view.frame.size.width-40, 10) viewFrame:frame];
            }
            else{
                // Bottom Right
                CGPoint endPoint = CGPointMake(centerPoint.x-20, centerPoint.y+frame.size.height/2+50);
                [lineArrowPath addQuadCurveToPoint:endPoint controlPoint:CGPointMake((movePointBottom.x+endPoint.x)/2+25, (movePointBottom.y+endPoint.y)/2)];
                
                [lineArrowPath2 moveToPoint:CGPointMake(movePointBottom.x-5, movePointBottom.y+5)];
                [lineArrowPath2 addLineToPoint:movePointBottom];
                [lineArrowPath2 addLineToPoint:CGPointMake(movePointBottom.x+10, movePointBottom.y+5)];
                [lineArrowPath appendPath:lineArrowPath2];
                
                NSString *message = [self.tipDelegate messageForTipAtIndex:tipViewIndex];
                [self drawString:message withFont:[UIFont fontWithName:@"Arial" size:17] inRect:CGRectMake(controller.view.frame.origin.x+20, endPoint.y+10, controller.view.frame.size.width-40, 10) viewFrame:frame];
            }
        }
            break;
        default:{
            
        }
            break;
    }
    
    [self.arrowColor set];
    lineArrowPath.lineWidth = 2;
    [lineArrowPath setLineCapStyle:kCGLineCapRound];
    [lineArrowPath stroke];
}


-(void)showWSTipView{
    if (self.tipDelegate) {
        UIViewController *controller = (UIViewController *)self.tipDelegate;
        layerImage = [self getLayerImageOfController:controller];
        [self setupInitialPropertiesOnController:controller];
    }
}

-(void)setupInitialPropertiesOnController:(UIViewController *)controller{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor clearColor];
    if (!self.shadowColor) {
        self.shadowColor = [UIColor whiteColor];
    }
    if (!self.arrowColor) {
        self.arrowColor = [UIColor whiteColor];
    }
    if (!self.superview) {
        [controller.view addSubview:self];
    }
}

-(UIImage *)getLayerImageOfController:(UIViewController *)controller{
    
    UIGraphicsBeginImageContextWithOptions(controller.view.frame.size, NO, [UIScreen mainScreen].scale);
    
    CGRect rec = CGRectMake(0, 0, controller.view.frame.size.width, controller.view.frame.size.height);
    [controller.view drawViewHierarchyInRect:rec afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void) drawString: (NSString*) s
           withFont: (UIFont*) font
             inRect: (CGRect) contextRect viewFrame:(CGRect)viewFrame{
    
    /// Make a copy of the default paragraph style
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary * attributes = @{ NSFontAttributeName: font,
                                   NSForegroundColorAttributeName: [UIColor whiteColor],
                                   NSParagraphStyleAttributeName: paragraphStyle };
    
    if ([self.tipDelegate respondsToSelector:@selector(attributesForTipViewMessageAtIndex:)]) {
        attributes = [self.tipDelegate attributesForTipViewMessageAtIndex:tipViewIndex];
    }
    
    CGFloat textHeight = [self heightForMessage:s containerWidth:contextRect.size.width withAttributes:attributes];
    if ([self.tipDelegate tipArrowStyleForTipAtIndex:tipViewIndex]==WSTipArrowStyleCenterBottom) {
        contextRect.size.height = textHeight;
    }
    else if ([self.tipDelegate tipArrowStyleForTipAtIndex:tipViewIndex]==WSTipArrowStyleCenterTop){
        contextRect.origin.y -= textHeight;
        contextRect.size.height = textHeight;
    }
    
    [s drawInRect:contextRect withAttributes:attributes];
}

-(CGRect)getAreaOfMessageWithSize:(CGSize)textSize{
    
    return CGRectZero;
}

-(CGFloat)heightForMessage:(NSString *)msg containerWidth:(CGFloat)width withAttributes:(NSDictionary *)attributes{
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
    CGRect textRect = [msg boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attributes
                                           context:nil];
    
    return textRect.size.height;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[touches allObjects] lastObject];
    CGPoint touchPoint = [touch locationInView:self];
    UIView *view = [self.tipDelegate viewForTipAtIndex:tipViewIndex];
    UIViewController *controller = (UIViewController *)self.tipDelegate;
    CGRect frame = [controller.view convertRect:view.frame fromView:controller.view];
    if (CGRectContainsPoint(frame, touchPoint)) {
        [self.tipDelegate didTapOnTipIndex:tipViewIndex];
        tipViewIndex++;
        if (tipViewIndex<[self.tipDelegate numberOfTips]) {
            [self setNeedsDisplay];
            return;
        }
        [self removeFromSuperview];
        tipViewIndex = 0;
    }
}

@end
