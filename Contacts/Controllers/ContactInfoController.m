//
//  ContactInfoController.m
//  Contacts
//
//  Created by photondragon on 15/3/29.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ContactInfoController.h"
#import "NSData+IDNExtend.h"
#import "IDNImagePickerController.h"
#import "NSDate+IDNExtend.h"

@interface ContactInfoController ()
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageViewHead;
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnHeadImage;

@end

@implementation ContactInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
	if([self respondsToSelector:@selector(edgesForExtendedLayout)])
		self.edgesForExtendedLayout = 0;

	self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	[super setEditing:editing animated:animated];
	if(editing)
	{
		self.textFieldName.enabled = YES;
		self.textFieldPhone.enabled = YES;

		[self.navigationItem setHidesBackButton:YES animated:animated];
		if(animated)
			[self.textFieldName becomeFirstResponder];
	}
	else
	{
		self.textFieldName.enabled = NO;
		self.textFieldPhone.enabled = NO;

		[self.navigationItem setHidesBackButton:NO animated:animated];

		[self saveContact];
	}
}

- (void)setContact:(ContactInfo *)contact
{
	_contact = contact;

	[self view];

	self.textFieldName.text = contact.name;
	self.textFieldPhone.text = contact.phone;
	[self showHeadImage];
}

- (void)showHeadImage
{
	if(_contact.headImageUrl.length)
		self.imageViewHead.image = [UIImage imageWithContentsOfFile:_contact.headImageLocalPath];
	else
		self.imageViewHead.image = [UIImage imageNamed:@"defaultHead.png"];
}

- (void)saveContact
{
	_contact.name = self.textFieldName.text;
	_contact.phone = self.textFieldPhone.text;
}

- (IBAction)btnHeadImageClicked:(id)sender {
	UIImagePickerController* imgPicker = [[IDNImagePickerController alloc] init];
	imgPicker.delegate = self;

//	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//		imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//	else
//		imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;

	[self presentViewController:imgPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage* image = info[UIImagePickerControllerOriginalImage];
	if(image==nil)
		return;
	NSString* filePathInDocument = [NSString stringWithFormat:@"head/%@.jpg", [[NSDate date] stringWithFormat:@"yyyyMMddHHmmss"]];
	if([UIImageJPEGRepresentation(image, 0.9) writeToDocumentFile:filePathInDocument]==FALSE)
		return;
	_contact.headImageUrl = filePathInDocument;
	[self showHeadImage];

	[picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)blankTapped:(id)sender {
	[self.textFieldName resignFirstResponder];
	[self.textFieldPhone resignFirstResponder];
}
@end
