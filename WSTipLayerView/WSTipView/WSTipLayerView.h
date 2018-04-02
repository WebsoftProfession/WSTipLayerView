//
//  WSTipLayerView.h
//  WSTipLayerView
//
//  Created by Praveen on 29/03/18.
//  Copyright © 2018 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> 

typedef enum {
    WSTipArrowStyleCenterTop,
    WSTipArrowStyleCenterBottom,
}WSTipArrowStyle;


@protocol WSTipLayerViewDelegate<NSObject>
@required
-(NSUInteger)numberOfTips;
-(UIView *)viewForTipAtIndex:(NSUInteger)index;
-(NSString *)messageForTipAtIndex:(NSUInteger)index;
//-(UIView *)detailViewForTipAtIndex:(NSUInteger)index;
-(WSTipArrowStyle)tipArrowStyleForTipAtIndex:(NSUInteger)index;

@optional
-(void)didTapOnTipIndex:(NSUInteger)index;
-(NSDictionary *)attributesForTipViewMessageAtIndex:(NSUInteger)index;
@end

@interface WSTipLayerView : UIView{
    UIImage *layerImage;
    NSUInteger tipViewIndex;
}

@property(nonatomic,strong) id<WSTipLayerViewDelegate> tipDelegate;
@property (nonatomic,strong) UIColor *shadowColor;
@property (nonatomic,strong) UIColor *arrowColor;
@property (nonatomic,assign) NSUInteger tipViewIndex;

-(void)showWSTipView;
@end
