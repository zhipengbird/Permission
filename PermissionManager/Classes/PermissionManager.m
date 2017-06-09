//
//  VISIPermissionManager.m
//  VISI
//
//  Created by 袁平华 on 2016/11/15.
//  Copyright © 2016年 ushareit. All rights reserved.
//

#import "PermissionManager.h"
#import <Photos/Photos.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>
#import <AVFoundation/AVFoundation.h>

/**系统版本号宏判断*/
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



@implementation PermissionManager

+(void)checkMediaPermission:(void (^)(VISIAuthorizationStatus))callback{
    // 检查录音权限
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (status) {
        case AVAuthorizationStatusDenied:
            [self excuteCallback:callback status:VISIAuthorizationStatusDenied];
            break;
        case AVAuthorizationStatusAuthorized:
            [self excuteCallback:callback status:VISIAuthorizationStatusAuthorized];
            
            break;
        case AVAuthorizationStatusRestricted:
            [self excuteCallback:callback status:VISIAuthorizationStatusRestricted];
            
            break;
        case AVAuthorizationStatusNotDetermined:
            [self excuteCallback:callback status:VISIAuthorizationStatusNotDetermined];
            
            break;
        default:
            break;
    }

}

+(void)requestMediaPermission:(void (^)(VISIAuthorizationStatus))callback{
    // 获取录音权限
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        if (granted) {
            [self excuteCallback:callback status:VISIAuthorizationStatusAuthorized];
        }else{
            [self excuteCallback:callback status:VISIAuthorizationStatusDenied];
        }
    }];
}

+(void)checkCameraPermission:(void (^)(VISIAuthorizationStatus))callback{
    // 检查相机权限
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusDenied:
            [self excuteCallback:callback status:VISIAuthorizationStatusDenied];
            break;
        case AVAuthorizationStatusAuthorized:
            [self excuteCallback:callback status:VISIAuthorizationStatusAuthorized];

            break;
        case AVAuthorizationStatusRestricted:
            [self excuteCallback:callback status:VISIAuthorizationStatusRestricted];

            break;
        case AVAuthorizationStatusNotDetermined:
            [self excuteCallback:callback status:VISIAuthorizationStatusNotDetermined];

            break;
        default:
            break;
    }
}

+(void)requestCameraPermission:(void (^)(VISIAuthorizationStatus))callback{
    // 获取相机权限
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (granted) {
            [self excuteCallback:callback status:VISIAuthorizationStatusAuthorized];
        }else{
            [self excuteCallback:callback status:VISIAuthorizationStatusDenied];
        }
    }];
    
}

+(void)checkContactPermission:(void (^)(VISIAuthorizationStatus))callback{
    //检查联系人权限
    
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    switch (status) {
        case kABAuthorizationStatusDenied:
            [self excuteCallback:callback status:VISIAuthorizationStatusDenied];
            break;
        case kABAuthorizationStatusAuthorized:
            [self excuteCallback:callback status:VISIAuthorizationStatusAuthorized];
            
            break;
        case kABAuthorizationStatusRestricted:
            [self excuteCallback:callback status:VISIAuthorizationStatusRestricted];
            
            break;
        case kABAuthorizationStatusNotDetermined:
            [self excuteCallback:callback status:VISIAuthorizationStatusNotDetermined];
            
            break;
        default:
            break;
    }
}
+(void)requestContactPermission:(void (^)(VISIAuthorizationStatus))callback{
    // 获取联系人权限
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
        CNContactStore * contact =  [[CNContactStore  alloc]init];
        
        [contact requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {

            if (granted) {
                [self excuteCallback:callback status:VISIAuthorizationStatusAuthorized];
            }else{
                [self excuteCallback:callback status:VISIAuthorizationStatusDenied];
            }
            
        }];
    }else{
        ABAddressBookRef addbook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addbook, ^(bool granted, CFErrorRef error) {
            if (granted) {
                [self excuteCallback:callback status:VISIAuthorizationStatusAuthorized];
            }else{
                [self excuteCallback:callback status:VISIAuthorizationStatusDenied];
            }
        });
    }
    
}

+(void)checkPhotoLibraryPermission:(void (^)(VISIAuthorizationStatus))callback{
    // 检查相册权限
    PHAuthorizationStatus status =  [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusDenied:
            [self excuteCallback:callback status:VISIAuthorizationStatusDenied];
            break;
        case PHAuthorizationStatusAuthorized:
            [self excuteCallback:callback status:VISIAuthorizationStatusAuthorized];
            
            break;
        case  PHAuthorizationStatusRestricted:
            [self excuteCallback:callback status:VISIAuthorizationStatusRestricted];
            break;
        case PHAuthorizationStatusNotDetermined:
            [self excuteCallback:callback status:VISIAuthorizationStatusNotDetermined];
            break;
        default:
            break;
    }
}
+(void)requestPhotolibraryPermission:(void (^)(VISIAuthorizationStatus))callback{
    // 获取相册权限
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusDenied:
                [self excuteCallback:callback status:VISIAuthorizationStatusDenied];
                break;
            case PHAuthorizationStatusAuthorized:
                [self excuteCallback:callback status:VISIAuthorizationStatusAuthorized];
                
                break;
            case  PHAuthorizationStatusRestricted:
                [self excuteCallback:callback status:VISIAuthorizationStatusRestricted];
                break;
            case PHAuthorizationStatusNotDetermined:
                [self excuteCallback:callback status:VISIAuthorizationStatusNotDetermined];
                break;
            default:
                break;
        }
    }];
}

+(void)excuteCallback:(void(^)(VISIAuthorizationStatus status))callback status:(VISIAuthorizationStatus)status{
    dispatch_async(dispatch_get_main_queue(), ^{
        callback(status);
    });
}


@end
