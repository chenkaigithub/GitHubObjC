//
//  GitHubContributorImp.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/15/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubContributorImp.h"

@implementation GitHubContributorImp

@synthesize name, contributions;

+(id<GitHubContributor>)contributor {
  
  return [[[GitHubContributorImp alloc] init] autorelease]; 
}

-(NSString *)description {
  
  return [NSString
          stringWithFormat:@"\nSTART - GitHubContributor\n"
          "Name:%@\n"
          "Contributions:%i\n"
          "END - GitHubContributor\n",
          self.name,
          self.contributions
          ];
}

-(NSComparisonResult)compare:(id<GitHubContributor>)otherContributor {
  
  return otherContributor.contributions - self.contributions;
}

-(void)dealloc {
  
  self.name = nil;
  [super dealloc];
}

@end
