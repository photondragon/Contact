//
//  ContactInfo.m
//  Contacts
//
//  Created by photondragon on 15/3/22.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ContactInfo.h"
#import "NSString+IDNExtend.h"

@interface ContactInfo()
<NSCoding,
NSCopying>

@end
@implementation ContactInfo

- (instancetype)initWithCoder:(NSCoder*)decoder
{
	self = [super init];
	if (self) {
		self.ID = [decoder decodeIntForKey:@"ID"];
		self.name = [decoder decodeObjectForKey:@"name"];
		self.phone = [decoder decodeObjectForKey:@"phone"];
		self.headImageUrl = [decoder decodeObjectForKey:@"headImageUrl"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder*)coder
{
	[coder encodeInt:self.ID forKey:@"ID"];
	[coder encodeObject:self.name forKey:@"name"];
	[coder encodeObject:self.phone forKey:@"phone"];
	[coder encodeObject:self.headImageUrl forKey:@"headImageUrl"];
}

- (id)copyWithZone:(NSZone *)zone
{
	ContactInfo* contact = [[ContactInfo allocWithZone:zone] init];
	contact.ID = self.ID;
	contact.name = self.name;
	contact.phone = self.phone;
	contact.headImageUrl = self.headImageUrl;
	return contact;
}

- (NSString*)description
{
	return [NSString stringWithFormat:@"ID：%d 姓名：%@ 电话：%@", _ID, _name, _phone];
}

- (NSString*)headImageLocalPath
{
	return [NSString stringWithFormat:@"%@/%@", [NSString documentsPath], self.headImageUrl];
}

@end
