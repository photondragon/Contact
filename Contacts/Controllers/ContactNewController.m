//
//  ContactNewController.m
//  Contacts
//
//  Created by photondragon on 15/3/29.
//  Copyright (c) 2015年 no. All rights reserved.
//

#import "ContactNewController.h"
#import "NSString+IDNExtend.h"
#import "IDNImagePickerController.h"
#import "NSDate+IDNExtend.h"
#import "NSString+IDNExtend.h"
#import "NSData+IDNExtend.h"
#import "MyModels.h"

@interface ContactNewController ()
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) ContactInfo* contact;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOfBottomMargin;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewHead;
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnHeadImage;

@property (nonatomic) CGSize contentSize;

@end

@implementation ContactNewController

- (void)viewDidLoad {
    [super viewDidLoad];
	if([self respondsToSelector:@selector(edgesForExtendedLayout)])
		self.edgesForExtendedLayout = 0;

	[self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blankTapped:)]];

	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];

	self.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 326);
	self.contentView.frame = CGRectMake(0, 0, _contentSize.width, _contentSize.height);

	self.scrollView.contentSize = self.contentSize;
	[self.scrollView addSubview:self.contentView];

	self.contact = [[ContactInfo alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
	[super viewWillDisappear:animated];
}
- (void)cancel:(id)sender
{
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)save:(id)sender
{
	_contact.name = self.textFieldName.text;
	_contact.phone = self.textFieldPhone.text;
	[[MyModels contactManager] addContact:_contact];
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
		self.imageViewHead.image = [UIImage imageNamed:@"imageCamera.png"];
}

- (IBAction)btnHeadImageClicked:(id)sender {
	UIImagePickerController* imgPicker = [[IDNImagePickerController alloc] init];
	imgPicker.delegate = self;

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

- (void)keyboardWillChangeFrame:(NSNotification*)note
{
	NSDictionary *userInfo = [note userInfo];

	NSTimeInterval animationDuration;
	NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
	[animationDurationValue getValue:&animationDuration];

	NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect keyboardRect = [self.view convertRect:[aValue CGRectValue] fromView:nil];//获取键盘坐标，并由屏幕坐标转为view的坐标
	CGRect containerRect = self.view.bounds;
	CGFloat bottomDistance = containerRect.size.height - keyboardRect.origin.y;

	if(bottomDistance>100)//弹出键盘
	{
		self.constraintOfBottomMargin.constant = bottomDistance;
		[self.view setNeedsUpdateConstraints];
		[UIView animateWithDuration:0.25 animations:^{
			[self.view layoutIfNeeded];
		}];
	}
	else//收起键盘
	{
		self.constraintOfBottomMargin.constant = 0;
		[self.view setNeedsUpdateConstraints];
		[UIView animateWithDuration:0.25 animations:^{
			[self.view layoutIfNeeded];
		}];
	}
}

@end
