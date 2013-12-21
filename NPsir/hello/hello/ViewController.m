//
//  ViewController.m
//  hello
//
//  Created by alok patil on 02/08/13.
//  Copyright (c) 2013 LinkITes LLC . All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h""

@implementation ViewController
@synthesize permissions;
@synthesize isCheck;
@synthesize strName;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    tableArray=[[NSArray alloc]initWithObjects:@"Sanjay",@"Somil",@"Yogendra",@"Ravi",@"Abc",@"Pqr",@"Xyz",@"Ravi",@"Abc",@"Pqr",@"Xyz", nil];;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//FaceBook LogIn Start code

-(IBAction)actionFacebookSignIn:(id)sender
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    permissions = [[NSArray alloc] initWithObjects:@"publish_stream",@"email",@"user_hometown",@"user_location", nil];
    [delegate initFacebook:self];
    
    if (![[delegate facebook] isSessionValid]) {
        [[delegate facebook] authorize:permissions];
    } 
    
}

- (void)apiFQLIMe{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT name,uid,email,first_name,last_name,pic,current_location,pic_small  FROM  user WHERE uid=me()", @"query",
                                   nil];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    FBRequest *fbRequest = [[delegate facebook] requestWithMethodName:@"fql.query" andParams:params
                                                        andHttpMethod:@"POST"
                                                          andDelegate:self];
    NSLog(@"fbRequest %@",fbRequest);
    
    
    //[self shareOnFacebook];
}

- (void)showLoggedIn {
    
    [self apiFQLIMe];
}

- (void)logout {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] logout];
    
}

- (void)apiGraphUserPermissions
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/feed" andDelegate:self];
}

-(void)fbDidLogin
{
    [self showLoggedIn];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self storeAuthData:[[delegate facebook] accessToken] expiresAt:[[delegate facebook] expirationDate]];
}

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
    [self storeAuthData:accessToken expiresAt:expiresAt];
}

- (void)storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

-(void)fbDidNotLogin:(BOOL)cancelled
{
    
}

/**
 * Called when the request logout has succeeded.
 */


- (void)fbSessionInvalidated
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"Auth Exception",nil)
                              message:NSLocalizedString(@"Your session has expired.",nil)
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    
    [alertView show];
    // [alertView release];
    [self fbDidLogout];
}
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
    if ([result isKindOfClass:[NSArray class]] && ([result count] > 0))
    {
        result = [result objectAtIndex:0];
        NSLog(@"%@",result);
    }
    if (result!=nil) 
    {
        isCheck=YES;
        [[NSUserDefaults standardUserDefaults]setValue:[result valueForKey:@"name"]forKey:@"name"];
        [[NSUserDefaults standardUserDefaults]setValue:[result valueForKey:@"email"]forKey:@"email"];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"islogin"];
        [[NSUserDefaults standardUserDefaults]setValue:[result valueForKey:@"uid"]forKey:@"id"];
        strName = [result objectForKey:@"first_name"];
        [self performSelector:@selector(UserLogin) withObject:nil afterDelay:0.5];
    }
    //    if (isFacebookShare)
    //    {
    //        isFacebookShare= NO;
    //    }
    else
    {
        // [self SharedFacebook];
    }
    
}
-(void)SharedFacebook{
   // isFacebookShare = YES;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    //[params setObject:imgP forKey:@"photo"];
    
    //[params setValue:@"I'm using Abraham Lincoln Histroy app. It is a Quiz for kids that increases the general awareness about Lincoln." forKey:@"message"];
    //[params setValue:@"Linkites" forKey:@"caption"];
    [[delegate facebook] requestWithGraphPath:@"me/feed" andParams:params andHttpMethod:@"POST" andDelegate:self];
    
}
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    
}

-(void)fbDidLogout
{
    
}

// FBDialogDelegate
- (void)dialogDidSucceed:(FBDialog*)dialog
{
    //[self.view addSubview:loadingView];
}

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError*)error
{
    
}

- (void)dialogDidNotComplete:(FBDialog *)dialog
{
    
}

//FaceBook LogIn End code

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
