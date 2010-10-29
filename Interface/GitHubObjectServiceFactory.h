//
//  GitHubObjectServiceFactory.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/29/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubService.h"
#import "GitHubServiceGotTreeItemDelegate.h"
#import "GitHubServiceGotBlobDelegate.h"
#import "GitHubServiceGotDataDelegate.h"

@interface GitHubObjectServiceFactory : NSObject {
}

+(id<GitHubService>)
requestTreeItemsByTreeSha:(NSString *)sha
user:(NSString *)user
repository:(NSString *)repository
delegate:(id<GitHubServiceGotTreeItemDelegate>)delegate;

+(id<GitHubService>)
requestBlobByTreeSha:(NSString *)sha
user:(NSString *)user
repository:(NSString *)repository
path:(NSString *)path
delegate:(id<GitHubServiceGotBlobDelegate>)delegate;

+(id<GitHubService>)
requestBlobWithDataByTreeSha:(NSString *)sha
user:(NSString *)user
repository:(NSString *)repository
path:(NSString *)path
delegate:(id<GitHubServiceGotBlobDelegate>)delegate;

+(id<GitHubService>)
requestDataBySha:(NSString *)sha
user:(NSString *)user
repository:(NSString *)repository
delegate:(id<GitHubServiceGotDataDelegate>)delegate;

@end
