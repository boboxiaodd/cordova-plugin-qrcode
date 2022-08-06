#import <Cordova/CDV.h>
#import "CDVQRCode.h"
#import "WBQRCodeVC.h"
#import "MyNavigationController.h"

@implementation CDVQRCode
- (void)scan_qrcode:(CDVInvokedUrlCommand *)command
{
    WBQRCodeVC * vc = [[WBQRCodeVC alloc] init];
    MyNavigationController * nc = [[MyNavigationController alloc] initWithRootViewController:vc];
    nc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.viewController presentViewController:nc animated:YES completion:nil];
    vc.callBackBlock = ^(NSString *result) {
        [self send_event:command withMessage:@{@"result":result} Alive:YES State:YES];
    };
}

#pragma mark 公共方法

- (void)send_event:(CDVInvokedUrlCommand *)command withMessage:(NSDictionary *)message Alive:(BOOL)alive State:(BOOL)state{
    if(!command) return;
    CDVPluginResult* res = [CDVPluginResult resultWithStatus: (state ? CDVCommandStatus_OK : CDVCommandStatus_ERROR) messageAsDictionary:message];
    if(alive) [res setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult: res callbackId: command.callbackId];
}


@end
