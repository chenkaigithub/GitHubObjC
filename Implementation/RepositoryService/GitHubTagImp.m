//
//  GitHubTagImp.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/16/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubTagImp.h"


@implementation GitHubTagImp
@synthesize name, commitId, userName, repositoryName;

+(id<GitHubTag>)tag {
  
  return [[[GitHubTagImp alloc] init] autorelease]; 
}

-(NSString *)description {
  
  return [NSString
          stringWithFormat:@"\nSTART - GitHubTag\n"
          "Name:%@\n"
          "CommitId:%@\n"
          "UserName:%@\n"
          "RepositoryName:%@\n"
          "END - GitHubTag\n"
          ,
          self.name,
          self.commitId,
          self.userName,
          self.repositoryName
          ];
}

-(NSComparisonResult)compare:(id<GitHubTag>)otherTag {
  
  return [self.name compare:otherTag.name];
}

-(void)dealloc {
  
  self.name = nil;
  self.commitId = nil;
  self.userName = nil;
  self.repositoryName = nil;
  [super dealloc];
}

@end
