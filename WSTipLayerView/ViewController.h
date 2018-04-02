//
//  ViewController.h
//  WSTipLayerView
//
//  Created by Praveen on 02/04/18.
//  Copyright © 2018 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTipLayerView.h"

@interface ViewController : UIViewController<WSTipLayerViewDelegate>
{
    WSTipLayerView *tipView;
    __weak IBOutlet UIButton *btnPlay;
    __weak IBOutlet UIButton *btnForward;
    __weak IBOutlet UIImageView *imgView;
    __weak IBOutlet UILabel *lblStatus;
    __weak IBOutlet UIView *bottomView;
}


@end

