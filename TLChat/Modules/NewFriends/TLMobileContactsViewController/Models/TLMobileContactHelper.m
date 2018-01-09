//
//  TLMobileContactHelper.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/9.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLMobileContactHelper.h"
#import <AddressBookUI/AddressBookUI.h>
#import "NSFileManager+TLChat.h"
#import "TLUserGroup.h"

@implementation TLMobileContactHelper

+ (void)tryToGetAllContactsSuccess:(void (^)(NSArray *data, NSArray *formatData, NSArray *headers))success
                            failed:(void (^)())failed
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 1、获取通讯录信息
        ABAddressBookRef addressBooks = nil;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
            addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){
                dispatch_semaphore_signal(sema);
            });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        else {
            addressBooks = ABAddressBookCreate();
        }
        
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
        CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
        
        // 2、加载缓存
        if (allPeople != nil && CFArrayGetCount(allPeople) > 0) {
            NSString *path = [NSFileManager pathContactsData];
            NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            if (dic) {
                NSArray *data = dic[@"data"];
                NSArray *formatData = dic[@"formatData"];
                NSArray *headers = dic[@"headers"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(data, formatData, headers);
                });
            }
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                failed();
            });
            return;
        }
        
        // 3、格式转换
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < nPeople; i++) {
            TLMobileContactModel *contact = [[TLMobileContactModel alloc] init];
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
            CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
            CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
            CFStringRef abFullName = ABRecordCopyCompositeName(person);
            NSString *nameString = (__bridge NSString *)abName;
            NSString *lastNameString = (__bridge NSString *)abLastName;
            
            if ((__bridge id)abFullName != nil) {
                nameString = (__bridge NSString *)abFullName;
            }
            else {
                if ((__bridge id)abLastName != nil) {
                    nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
                }
            }
            contact.name = nameString;
            contact.recordID = (int)ABRecordGetRecordID(person);;
            
            if(ABPersonHasImageData(person)) {
                NSData *imageData = (__bridge NSData *)ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
                NSString *imageName = [NSString stringWithFormat:@"%.0lf.jpg", [NSDate date].timeIntervalSince1970 * 10000];
                NSString *imagePath = [NSFileManager pathContactsAvatar:imageName];
                [imageData writeToFile:imagePath atomically:YES];
                contact.avatarPath = imageName;
            }
            
            ABPropertyID multiProperties[] = {
                kABPersonPhoneProperty,
                kABPersonEmailProperty
            };
            NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
            for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
                ABPropertyID property = multiProperties[j];
                ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
                NSInteger valuesCount = 0;
                if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
                if (valuesCount == 0) {
                    CFRelease(valuesRef);
                    continue;
                }
                for (NSInteger k = 0; k < valuesCount; k++) {
                    CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                    switch (j) {
                        case 0: {// Phone number
                            contact.tel = (__bridge NSString*)value;
                            break;
                        }
                        case 1: {// Email
                            contact.email = (__bridge NSString*)value;
                            break;
                        }
                    }
                    CFRelease(value);
                }
                CFRelease(valuesRef);
            }
            [data addObject:contact];
            
            if (abName) CFRelease(abName);
            if (abLastName) CFRelease(abLastName);
            if (abFullName) CFRelease(abFullName);
        }
        
        // 4、排序
        NSArray *serializeArray = [data sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            int i;
            NSString *strA = ((TLMobileContactModel *)obj1).pinyin;
            NSString *strB = ((TLMobileContactModel *)obj2).pinyin;
            for (i = 0; i < strA.length && i < strB.length; i ++) {
                char a = toupper([strA characterAtIndex:i]);
                char b = toupper([strB characterAtIndex:i]);
                if (a > b) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                else if (a < b) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
            }
            if (strA.length > strB.length) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            else if (strA.length < strB.length){
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        // 5、分组
        data = [[NSMutableArray alloc] init];
        NSMutableArray *headers = [[NSMutableArray alloc] initWithObjects:UITableViewIndexSearch, nil];
        char lastC = '1';
        TLUserGroup *curGroup;
        TLUserGroup *othGroup = [[TLUserGroup alloc] init];
        [othGroup setGroupName:@"#"];
        othGroup.tag = 27;
        for (TLMobileContactModel *contact in serializeArray) {
            // 获取拼音失败
            if (contact.pinyin == nil || contact.pinyin.length == 0) {
                [othGroup addObject:contact];
                continue;
            }
            
            char c = toupper([contact.pinyin characterAtIndex:0]);
            if (!isalpha(c)) {      // #组
                [othGroup addObject:contact];
            }
            else if (c != lastC){
                if (curGroup && curGroup.count > 0) {
                    [data addObject:curGroup];
                    [headers addObject:curGroup.groupName];
                }
                lastC = c;
                curGroup = [[TLUserGroup alloc] init];
                [curGroup setGroupName:[NSString stringWithFormat:@"%c", c]];
                [curGroup addObject:contact];
                [curGroup setTag:(NSInteger)c];
            }
            else {
                [curGroup addObject:contact];
            }
        }
        if (curGroup && curGroup.count > 0) {
            [data addObject:curGroup];
            [headers addObject:curGroup.groupName];
        }
        if (othGroup.count > 0) {
            [data addObject:othGroup];
            [headers addObject:othGroup.groupName];
        }
        
        // 6、数据返回
        dispatch_async(dispatch_get_main_queue(), ^{
            success(serializeArray, data, headers);
        });
        
        // 7、存入本地缓存
        NSDictionary *dic = @{@"data": serializeArray,
                              @"formatData": data,
                              @"headers": headers};
        NSString *path = [NSFileManager pathContactsData];
        if(![NSKeyedArchiver archiveRootObject:dic toFile:path]){
            DDLogError(@"缓存联系人数据失败");
        }
    });
}


@end
