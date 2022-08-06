//
//  WBQRCodeVC.h
//  chatApp
//
//  Created by 林海波 on 2021/6/9.
//

#import <UIKit/UIKit.h>
typedef void(^ScanCallBack)(NSString *result);
@interface WBQRCodeVC : UIViewController
    @property (nonatomic, copy) ScanCallBack callBackBlock;
@end
