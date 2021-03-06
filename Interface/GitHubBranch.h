//
//  GitHubBranch.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/16/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubRef.h"

/**
 * Protocol for a git branch in GitHub.
 * See GitHub api documentation for details.
 */
@protocol GitHubBranch <GitHubRef>

@end
