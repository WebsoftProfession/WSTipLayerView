//
//  ViewController.m
//  WSTipLayerView
//
//  Created by Praveen on 02/04/18.
//  Copyright © 2018 WebsoftProfession. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tipView = [[WSTipLayerView alloc] init];
    tipView.tipDelegate = self;
    //    tipView.arrowColor = [UIColor cyanColor];
    //    tipView.shadowColor = [UIColor cyanColor];
    [tipView showWSTipView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark WSTipLayerViewDelegate Methods
- (NSUInteger)numberOfTips{
    return 5;
}

- (UIView *)viewForTipAtIndex:(NSUInteger)index{
    UIView *view;
    switch (index) {
        case 0:
            view = btnPlay;
            break;
        case 1:
            view = btnForward;
            break;
        case 2:
            view = imgView;
            break;
        case 3:
            view = lblStatus;
            break;
        default:
            view = bottomView;
            break;
    }
    return view;
}

- (NSString *)messageForTipAtIndex:(NSUInteger)index{
    NSString *message;
    switch (index) {
        case 0:
            message = @"This is a play button and you can use this to play current song.";
            break;
        case 1:
            message = @"This is a forward button and you can use this to forward your current playing song.";
            break;
        case 2:
            message = @"This is a song image.";
            break;
        case 3:
            message = @"This is a current song status and this indicates current syncing status.";
            break;
        default:
            message = @"This is bottom view and this contains all information about current song.";
            break;
    }
    return message;
}

- (WSTipArrowStyle)tipArrowStyleForTipAtIndex:(NSUInteger)index{
    WSTipArrowStyle arrowStyle;
    switch (index) {
        case 0:
            arrowStyle = WSTipArrowStyleCenterBottom;
            break;
        case 1:
            arrowStyle = WSTipArrowStyleCenterBottom;
            break;
        case 2:
            arrowStyle = WSTipArrowStyleCenterBottom;
            break;
        case 3:
            arrowStyle = WSTipArrowStyleCenterTop;
            break;
        default:
            arrowStyle = WSTipArrowStyleCenterTop;
            break;
    }
    return arrowStyle;
}

-(void)didTapOnTipIndex:(NSUInteger)index{
    NSLog(@"Action at: %lu",(unsigned long)index);
}


@end
