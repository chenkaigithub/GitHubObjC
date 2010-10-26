//
//  GitHubRepositoryFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubRepositoryFactory.h"
#import "GitHubServiceGotRepositoryDelegate.h"
#import "GitHubServiceDelegate.h"
#import "GitHubRepositoryImp.h"

@implementation GitHubRepositoryFactory

#pragma mark -
#pragma mark Memory and member management

//Retain
@synthesize repository;

//Assign
@synthesize networkElement;

-(void)cleanUp {
  
  self.repository = nil;
  [super cleanUp];
}

-(void)dealloc {
  
  [self cleanUp];
  [super dealloc];
}

#pragma mark -
#pragma mark Delegate protocol implementation
#pragma mark - NSXMLParserDelegate

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict {
  
  if ([elementName isEqualToString:@"repository"]) {
    
    self.repository = [GitHubRepositoryImp repository];
    
  } else if ([elementName isEqualToString:@"network"]) {
    
    if (![attributeDict count]) {
      
      self.networkElement++;
      self.repository = [GitHubRepositoryImp repository];
    }
  }
  self.currentStringValue = [NSMutableString stringWithCapacity:100];
}

-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName {
  
  if ([elementName isEqualToString:@"repository"]) {
    
    [(id<GitHubServiceGotRepositoryDelegate>)self.delegate
     gitHubService:self
     gotRepository:self.repository];
    
  } else if ([elementName isEqualToString:@"network"]) {
    
    if (self.networkElement) {
      
      [(id<GitHubServiceGotRepositoryDelegate>)self.delegate
       gitHubService:self
       gotRepository:self.repository];
      
      self.networkElement--;
    }
  } else if ([elementName isEqualToString:@"homepage"]) {
    
    NSURL *url = [NSURL URLWithString:self.currentStringValue];
    
    if (!url.scheme) {
      
      url = [NSURL URLWithString:[NSString
                                  stringWithFormat:@"http://%@",
                                  currentStringValue]];
      
    }
    self.repository.homepage = url;
    
  } else if ([elementName isEqualToString:@"has-issues"]) {
    
    self.repository.hasIssues = [self.currentStringValue boolValue];
    
  } else if ([elementName isEqualToString:@"created-at"]) {
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    self.repository.creationDate = 
    [formatter dateFromString:[self.currentStringValue substringToIndex:18]];
    
  } else if ([elementName isEqualToString:@"pushed-at"]) {
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    self.repository.pushDate = 
    [formatter dateFromString:[self.currentStringValue substringToIndex:18]];
    
  } else if ([elementName isEqualToString:@"watchers"]) {
    
    self.repository.watchers  = [self.currentStringValue intValue];
    
  } else if ([elementName isEqualToString:@"forks"]) {
    
    self.repository.forks = [self.currentStringValue intValue];
    
  } else if ([elementName isEqualToString:@"fork"]) {
    
    self.repository.fork = [self.currentStringValue boolValue];
  
  } else if ([elementName isEqualToString:@"has-downloads"]) {
    
    self.repository.hasDownloads = [self.currentStringValue boolValue];
    
  } else if ([elementName isEqualToString:@"description"]) {
    
    self.repository.desc = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"private"]) {
    
    self.repository.private = [self.currentStringValue boolValue];
    
  } else if ([elementName isEqualToString:@"has-wiki"]) {
    
    self.repository.hasWiki = [self.currentStringValue boolValue];
    
  } else if ([elementName isEqualToString:@"name"]) {
    
    self.repository.name = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"owner"]) {
    
    self.repository.owner = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"username"]) {
    
    self.repository.owner = self.currentStringValue;
    
  } else if ([elementName isEqualToString:@"url"]) {
    
    NSURL *url = [NSURL URLWithString:self.currentStringValue];
    
    if (!url.scheme) {
      
      url = [NSURL URLWithString:[NSString
                                  stringWithFormat:@"http://%@",
                                  self.currentStringValue]];
    }
    self.repository.url = url;
    
  } else if ([elementName isEqualToString:@"open-issues"]) {
    
    self.repository.openIssues = [self.currentStringValue intValue];
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self handleErrorWithCode:GitHubServerServerError];
  }
  self.currentStringValue = nil;
}

#pragma mark -
#pragma mark Interface implementation
#pragma mark - Class

+(GitHubRepositoryFactory *)repositoryFactoryWithDelegate:
(id<GitHubServiceGotRepositoryDelegate>)delegate {
  
  return [[[GitHubRepositoryFactory alloc]
           initWithDelegate:delegate] autorelease]; 
}

#pragma mark - Instance

-(void)searchRepositoriesByName:(NSString *)name {
  
  [self makeRequest:[NSString
                     stringWithFormat:@"%@/api/v2/xml/repos/search/%@",
                     [GitHubBaseFactory serverAddress], name]];
}

-(void)requestRepositoriesInNetworkByName:(NSString *)name
                                     user:(NSString *)user {
  
  [self makeRequest:[NSString
                     stringWithFormat:@"%@/api/v2/xml/repos/show/%@/%@/network",
                     [GitHubBaseFactory serverAddress], user ,name]];
}

-(void)requestRepositoryByName:(NSString *)name
                          user:(NSString *)user {
  
  [self makeRequest:[NSString
                     stringWithFormat:@"%@/api/v2/xml/repos/show/%@/%@",
                     [GitHubBaseFactory serverAddress], user, name]];
}

-(void)requestRepositoriesWatchedByUser:(NSString *)name {
  
  [self makeRequest:[NSString
                     stringWithFormat:@"%@/api/v2/xml/repos/watched/%@",
                     [GitHubBaseFactory serverAddress], name]];
}

-(void)requestRepositoriesOwnedByUser:(NSString *)name {
  
  [self makeRequest:[NSString stringWithFormat:@"%@/api/v2/xml/repos/show/%@",
                     [GitHubBaseFactory serverAddress], name]];
}

@end
