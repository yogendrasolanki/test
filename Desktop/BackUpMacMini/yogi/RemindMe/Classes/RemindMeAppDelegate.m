//
//  RemindMeAppDelegate.m
//
//  Created by Keith Harrison on 12/07/2010 http://useyourloaf.com
//  Copyright (c) 2010 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  Neither the name of Keith Harrison nor the names of its contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 

#import "RemindMeAppDelegate.h"
#import "RemindMeViewController.h"

@implementation RemindMeAppDelegate

@synthesize window;
@synthesize viewController;

NSString *kRemindMeNotificationDataKey = @"kRemindMeNotificationDataKey";

#pragma mark -
#pragma mark === Application Delegate Methods ===
#pragma mark -

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

	Class cls = NSClassFromString(@"UILocalNotification");
	if (cls) {
		UILocalNotification *notification = [launchOptions objectForKey:
								UIApplicationLaunchOptionsLocalNotificationKey];
		
		if (notification) {
			NSString *reminderText = [notification.userInfo 
									  objectForKey:kRemindMeNotificationDataKey];
			[viewController showReminder:reminderText];
		}
	}
	
	application.applicationIconBadgeNumber = 0;
	
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	
	application.applicationIconBadgeNumber = 0;
}

- (void)application:(UIApplication *)application 
        didReceiveLocalNotification:(UILocalNotification *)notification {
	
	// UIApplicationState state = [application applicationState];
	// if (state == UIApplicationStateInactive) {
		
		// Application was in the background when notification
		// was delivered.
	// }
	
	
	application.applicationIconBadgeNumber = 0;
	NSString *reminderText = [notification.userInfo
							  objectForKey:kRemindMeNotificationDataKey];
	[viewController showReminder:reminderText];
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

@end
