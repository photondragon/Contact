//
//  MyModels.h
//  Contacts
//
//  Created by photondragon on 15/3/29.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactManage.h"

@interface MyModels : NSObject

+ (ContactManage*)contactManager;
+ (void)saveModels;

@end
