//
//  GitHubContributorFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubContributorFactory.h"
#import "GitHubServiceGotContributorDelegate.h"
#import "GitHubServiceDelegate.h"
#import "GitHubContributorImp.h"

@implementation GitHubContributorFactory

@synthesize contributor;

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict {
  
  if ([elementName isEqualToString:@"contributor"]) {
    
    self.contributor = [GitHubContributorImp contributor];
  }
  self.currentStringValue = [NSMutableString stringWithCapacity:100];
}

-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName {
  
  if ([elementName isEqualToString:@"contributor"]) {
    
    [(id<GitHubServiceGotContributorDelegate>)self.delegate
     gitHubService:self
     gotContributor:self.contributor];
    
  } else if ([elementName isEqualToString:@"login"]) {
    
    self.contributor.name = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"contributions"]) {
    
    self.contributor.contributions = [self.currentStringValue intValue];
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self.parser abortParsing];
  }
  self.currentStringValue = nil;
}

-(void)requestContributorsByName:(NSString *)name user:(NSString *)user {
  
  [self makeRequest:
   [NSString stringWithFormat:@"%@/api/v2/xml/repos/show/%@/%@/contributors",
    [GitHubBaseFactory serverAddress], user, name]];
}

+(GitHubContributorFactory *)contributorFactoryWithDelegate:
(id<GitHubServiceGotContributorDelegate>)delegate {
  
  return [[[GitHubContributorFactory alloc]
           initWithDelegate:delegate] autorelease]; 
}

-(void)dealloc {
  
  self.contributor = nil;
  [super dealloc];
}

@end
