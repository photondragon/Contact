//
//  MyModels.m
//  Contacts
//
//  Created by photondragon on 15/3/29.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "MyModels.h"
#import "NSString+IDNExtend.h"

static ContactManage* contactManager = nil;

@implementation MyModels

+ (void)initialize
{
	contactManager = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSString documentsPathWithFileName:@"contacts.dat"]];
	if(contactManager==nil)
		contactManager = [[ContactManage alloc] init];
}

+ (ContactManage*)contactManager
{
	return contactManager;
}

+ (void)saveModels
{
	[NSKeyedArchiver archiveRootObject:contactManager toFile:[NSString documentsPathWithFileName:@"contacts.dat"]];
}
@end
