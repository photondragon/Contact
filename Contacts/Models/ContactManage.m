//
//  StudentManage.m
//  Contacts
//
//  Created by photondragon on 15/3/22.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ContactManage.h"

@implementation ContactManage
{
	NSMutableArray* contacts;
	int nextContactID;
}

- (instancetype)init
{
	self = [super init];
	if(self)
	{
		nextContactID = 1;
		contacts = [[NSMutableArray alloc] init];
	}
	return self;
}

- (NSUInteger)count{
	return contacts.count;
}

- (void)addContact:(ContactInfo*)contact;
{
	contact.ID = nextContactID++;
	[contacts addObject:contact];
}

- (void)delContact:(ContactInfo*)contact;
{
	[contacts removeObjectIdenticalTo:contact];
}

- (ContactInfo*)contactAtIndex:(NSUInteger)index
{
	if(index>=contacts.count)
		return nil;
	return contacts[index];
}

- (ContactInfo*)findByName:(NSString*)name
{
	if (name.length==0) {
		return nil;
	}
	for (ContactInfo* contact in contacts) {
//		if ([contact.name isEqualToString:name]) {
		if ([contact.name rangeOfString:name].location>0) {
			return contact;
		}
	}
	return nil;
}

- (NSString*)description
{
	NSMutableString* desc = [[NSMutableString alloc] init];
	for(ContactInfo* contact in contacts)
	{
		[desc appendFormat:@"%@\n",contact];
	}
	[desc appendFormat:@"共%d个联系人", (int)contacts.count];
	return [desc copy];
}

#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder*)decoder
{
	self = [super init];
	if (self) {
		nextContactID = [decoder decodeIntForKey:@"nextContactID"];
		contacts = [decoder decodeObjectForKey:@"contacts"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder*)coder
{
	[coder encodeInt:nextContactID forKey:@"nextContactID"];
	[coder encodeObject:contacts forKey:@"contacts"];
}

@end
