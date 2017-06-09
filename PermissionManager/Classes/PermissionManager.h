//
//  VISIPermissionManager.h
//  VISI
//
//  Created by 袁平华 on 2016/11/15.
//  Copyright © 2016年 ushareit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, VISIAuthorizationStatus) {
     VISIAuthorizationStatusAuthorized = 0,    // 已授权
     VISIAuthorizationStatusDenied,            // 拒绝
     VISIAuthorizationStatusRestricted,        // 应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
     VISIAuthorizationStatusNotDetermined         // 用户没有决定
};


@interface PermissionManager : NSObject

/**
 检查相册权限
 
 @param callback 权限状态
 */
+(void)checkPhotoLibraryPermission:(void(^)(VISIAuthorizationStatus status))callback;

/**
 获取相册权限
 
 @param callback 获取权限状态
 */
+(void)requestPhotolibraryPermission:(void(^)(VISIAuthorizationStatus status)) callback;


/**
 检查相机权限
 
 @param callback 权限状态
 */
+(void)checkCameraPermission:(void(^)(VISIAuthorizationStatus status))callback;

/**
 获取相机权限
 
 @param callback 获取权限状态
 */
+(void)requestCameraPermission:(void(^)(VISIAuthorizationStatus status) )  callback;


/**
 检查联系人权限
 
 @param callback 权限状态
 */
+(void)checkContactPermission:(void(^)(VISIAuthorizationStatus status)) callback;

/**
 获取联系人权限
 
 @param callback 获取权限状态
 */
+(void)requestContactPermission:(void(^)(VISIAuthorizationStatus status))callback;


/**
 检查录音机权限

 @param callback 权限状态
 */
+(void)checkMediaPermission:(void(^)(VISIAuthorizationStatus status))callback;

/**
 获取录音权限

 @param callback 获取权限状态
 */
+(void)requestMediaPermission:(void(^)(VISIAuthorizationStatus status))callback;
@end
