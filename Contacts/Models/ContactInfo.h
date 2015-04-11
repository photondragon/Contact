//
//  ContactInfo.h
//  Contacts
//
//  Created by photondragon on 15/3/22.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactInfo : NSObject

@property(nonatomic) int ID;
@property(nonatomic,strong) NSString* name;
@property(nonatomic,strong) NSString* phone;
@property(nonatomic,strong) NSString* headImageUrl;
@property(nonatomic,strong,readonly) NSString* headImageLocalPath;

@end
