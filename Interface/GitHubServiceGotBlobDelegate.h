//
//  GitHubServiceGotBlobDelegate.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/29/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubServiceDelegate.h"
#import "GitHubBlob.h"

@protocol GitHubServiceGotBlobDelegate <GitHubServiceDelegate>

-(void)gitHubService:(id<GitHubService>)gitHubService
             gotBlob:(id<GitHubBlob>)blob;
@end
