//
//  ViewController.h
//  hello
//
//  Created by alok patil on 02/08/13.
//  Copyright (c) 2013 LinkITes LLC . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface ViewController : UIViewController <FBDialogDelegate,FBLoginDialogDelegate,FBRequestDelegate,FBSessionDelegate>
{
    NSArray *tableArray;
}
@property(nonatomic,readwrite)BOOL isCheck;
@property (nonatomic, retain) NSArray *permissions;
@property (nonatomic,retain)NSString *strName;
-(IBAction)actionFacebookSignIn:(id)sender;
- (void)storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt;

@end
