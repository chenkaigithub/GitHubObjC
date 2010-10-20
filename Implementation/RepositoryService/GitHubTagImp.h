//
//  GitHubTagImp.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/16/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubTag.h"

@interface GitHubTagImp : NSObject <GitHubTag> {
  NSString *name;
  NSString *commitId;
  NSString *repositoryName;
  NSString *userName;
}
+(id<GitHubTag>)tag;

@end
