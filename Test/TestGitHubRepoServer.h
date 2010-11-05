//
//  TestGitHubUserServer.h
//  GitHubLib


#import <SenTestingKit/SenTestingKit.h>
#import "GitHubServiceGotRepositoryDelegate.h"

@interface TestGitHubRepoServer : SenTestCase
<GitHubServiceGotRepositoryDelegate> {
  BOOL testCaseLock;
  BOOL response;
  NSInteger repoSearchCount;
  NSString *testCase;
  BOOL done;
  BOOL doneWithErrors;
}

@property (assign) BOOL testCaseLock;
@property (assign) BOOL doneWithErrors;
@property (assign) BOOL done;
@property (assign) BOOL response;
@property (assign) NSInteger repoSearchCount;
@property (copy) NSString *testCase;

-(void)testSearchRepo1;


@end
