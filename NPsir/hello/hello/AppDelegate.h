//
//  AppDelegate.h
//  hello
//
//  Created by alok patil on 02/08/13.
//  Copyright (c) 2013 LinkITes LLC . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
     Facebook *facebook;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, retain) Facebook *facebook;
//- (void) updateInterfaceWithReachability: (Reachability*) curReach;
-(void)initFacebook:(id<FBSessionDelegate>)delegate;
@end
