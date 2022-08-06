//
//  WBQRCodeVC.m
//  chatApp
//
//  Created by 林海波 on 2021/6/9.
//

#import "WBQRCodeVC.h"
#import "SGQRCode.h"

@interface WBQRCodeVC ()<SGScanCodeDelegate,SGScanCodeSampleBufferDelegate> {
    SGScanCode *scanCode;
}
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, assign) BOOL stop;
@end

@implementation WBQRCodeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (_stop) {
        [scanCode startRunning];
//        [scanCode startRunningWithBefore:nil completion:nil];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    NSLog(@"WBQRCodeVC - dealloc");
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blackColor];
    scanCode = [SGScanCode scanCode];
    scanCode.preview = self.view;
    [self setupQRCodeScan];
    [self setupNavigationBar];
    [scanCode startRunning];
    [self.view addSubview:self.promptLabel];
}

- (void)setupQRCodeScan {

    [scanCode setDelegate:self];
    [scanCode setSampleBufferDelegate:self];
}

- (void)scanCode:(SGScanCode *)scanCode result:(NSString *)result
{
    NSLog(@"scan result: %@",result);
    if (result) {
        [scanCode stopRunning];
        self.stop = YES;
        [scanCode playSoundEffect:@"SGQRCode.bundle/scanEndSound.caf"];
        self.callBackBlock(result);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)scanCode:(SGScanCode *)scanCode brightness:(CGFloat)brightness
{

}

- (void)setupNavigationBar {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationItem.title = @"扫一扫";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItenAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)rightBarButtonItenAction {
    self.callBackBlock(@"");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)removeScanningView {
    [scanCode stopRunning];
}


- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.backgroundColor = [UIColor clearColor];
        CGFloat promptLabelX = 0;
        CGFloat promptLabelY = 0.73 * self.view.frame.size.height;
        CGFloat promptLabelW = self.view.frame.size.width;
        CGFloat promptLabelH = 25;
        _promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _promptLabel.text = @"将二维码/条码放入框内, 即可自动扫描";
    }
    return _promptLabel;
}

@end
