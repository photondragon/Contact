//
//  ContactsController.m
//  Contacts
//
//  Created by photondragon on 15/3/29.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ContactsController.h"
#import "MyModels.h"
#import "ContactInfoController.h"
#import "ContactNewController.h"

@interface ContactsController ()

@end

@implementation ContactsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系人管理";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContact:)];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[self.tableView reloadData];
}

- (void)addContact:(id)sender
{
	ContactNewController* c = [[ContactNewController alloc] init];
	UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:c];
	[self presentViewController:nav animated:YES completion:nil];
//	ContactInfo* contact = [[ContactInfo alloc] init];
//	contact.name = @"Hello";
//	contact.phone = @"18812348888";
//	[[MyModels contactManager] addContact:contact];
//	[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [MyModels contactManager].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellStyleValue1"];
    if(cell==nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCellStyleValue1"];
	}

	ContactInfo* contact = [[MyModels contactManager] contactAtIndex:indexPath.row];
	cell.textLabel.text = contact.name;
	cell.detailTextLabel.text = contact.phone;
	if(contact.headImageUrl.length)
		cell.imageView.image = [UIImage imageWithContentsOfFile:contact.headImageLocalPath];
	else
		cell.imageView.image = [UIImage imageNamed:@"defaultHead.png"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	ContactInfo* contact = [[MyModels contactManager] contactAtIndex:indexPath.row];

	ContactInfoController* contactController = [[ContactInfoController alloc] init];
	contactController.contact = contact;
	[self.navigationController pushViewController:contactController animated:YES];
}

//只要实现这个Datasource方法，左划Cell就会出现红色的“Delete”按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(editingStyle==UITableViewCellEditingStyleDelete)
	{
		ContactInfo* info = [[MyModels contactManager] contactAtIndex:indexPath.row];
		[[MyModels contactManager] delContact:info];
		[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	}
}

@end
