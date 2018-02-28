//
//  WSAuthorizationCheck.m
//  手机权限动态检查
//
//  Created by wangsheng on 2018/2/28.
//  Copyright © 2018年 wangsheng. All rights reserved.
//

#import "WSAuthorizationCheck.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation WSAuthorizationCheck
/**相机权限*/
+ (void)checkCameraAuthorizationGrand:(void (^)(void))permissionGranted
                     withNoPermission:(void (^)(void))noPermission
{
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (videoAuthStatus) {
        case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                granted ? permissionGranted() : noPermission();
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:
        {
            permissionGranted();
            break;
        }
        case AVAuthorizationStatusRestricted:
            NSLog(@"不能完成授权，可能开启了访问限制");
            noPermission();
        case AVAuthorizationStatusDenied:{
            NSLog(@"请到设置授权访问相机");
            noPermission();
        }
            break;
        default:
            break;
    }
}

/**相册权限*/
+ (void)checkPhotoAlbumAuthorizationGrand:(void (^)(void))permissionGranted
                         withNoPermission:(void (^)(void))noPermission
{
    PHAuthorizationStatus photoAuthStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthStatus) {
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                status == PHAuthorizationStatusAuthorized ? permissionGranted() : noPermission();
            }];
            break;
        }
        case PHAuthorizationStatusAuthorized:
        {
            permissionGranted();
            break;
        }
        case PHAuthorizationStatusRestricted:
            NSLog(@"不能完成授权，可能开启了访问限制");
            noPermission();
        case PHAuthorizationStatusDenied:{
            NSLog(@"请到设置授权访问相册");
            noPermission();
            break;
        }
        default:
            break;
            
    }
}

/**麦克风权限*/
+ (void)checkAudioAuthorizationGrand:(void (^)(void))permissionGranted
                    withNoPermission:(void (^)(void))noPermission
{
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (videoAuthStatus) {
        case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                granted ? permissionGranted() : noPermission();
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:
        {
            permissionGranted();
            break;
        }
        case AVAuthorizationStatusRestricted:
            NSLog(@"不能完成授权，可能开启了访问限制");
            noPermission();
        case AVAuthorizationStatusDenied:{
            NSLog(@"请到设置授权访问麦克风");
            noPermission();
        }
            break;
        default:
            break;
    }
}

/**定位权限*/
+ (void)checkLocationServiceAuthorization:(void(^)(BOOL authorizationAllow))checkFinishBack
{
    if ([CLLocationManager locationServicesEnabled])
    {
        //隐私->定位 开启
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        switch (status) {
            case kCLAuthorizationStatusNotDetermined:
                checkFinishBack(NO);
                break;
            case kCLAuthorizationStatusRestricted:
                checkFinishBack(NO);
                break;
            case kCLAuthorizationStatusDenied:
                NSLog(@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)");
                break;
            case kCLAuthorizationStatusAuthorizedAlways:
                checkFinishBack(YES);
                break;
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                checkFinishBack(YES);
                break;
            default:
                break;
        }
    }else
    {
        NSLog(@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)");
    }
}

+(void)checkAddressBookAuthorizationGrand:(void (^)(void))permissionGranted withNoPermission:(void (^)(void))noPermission
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL,NULL);
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    switch (status) {
        case kABAuthorizationStatusNotDetermined:{
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                granted ? permissionGranted():noPermission();
            });
        }break;
        case kABAuthorizationStatusRestricted:
            noPermission();
            break;
        case kABAuthorizationStatusDenied:
            noPermission();
            break;
        case kABAuthorizationStatusAuthorized:
            permissionGranted();
            break;
        default:
            break;
    }
}
@end
