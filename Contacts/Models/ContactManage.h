//
//  StudentManage.h
//  Contacts
//
//  Created by photondragon on 15/3/22.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactInfo.h"

@interface ContactManage : NSObject

@property(nonatomic,readonly) NSUInteger count;

- (void)addContact:(ContactInfo*)contact;
- (void)delContact:(ContactInfo*)contact;
- (ContactInfo*)contactAtIndex:(NSUInteger)index;

@end
