//
//  WSAuthorizationCheck.h
//  手机权限动态检查
//
//  Created by wangsheng on 2018/2/28.
//  Copyright © 2018年 wangsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSAuthorizationCheck : NSObject
/**相机权限*/
+ (void)checkCameraAuthorizationGrand:(void (^)(void))permissionGranted
                     withNoPermission:(void (^)(void))noPermission;
/**相册权限*/
+ (void)checkPhotoAlbumAuthorizationGrand:(void (^)(void))permissionGranted
                         withNoPermission:(void (^)(void))noPermission;

/**麦克风权限*/
+ (void)checkAudioAuthorizationGrand:(void (^)(void))permissionGranted
                    withNoPermission:(void (^)(void))noPermission;

/**定位权限*/
+ (void)checkLocationServiceAuthorization:(void(^)(BOOL authorizationAllow))checkFinishBack;

/**通讯录权限*/
+ (void)checkAddressBookAuthorizationGrand:(void (^)(void))permissionGranted
                          withNoPermission:(void (^)(void))noPermission;

@end
