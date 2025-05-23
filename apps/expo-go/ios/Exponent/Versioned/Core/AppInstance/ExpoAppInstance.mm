#import "ExpoAppInstance.h"
#import "ExpoGoReactNativeFactory.h"
#import <ReactCommon/RCTTurboModuleManager.h>
#import <ReactCommon/RCTHost.h>

#if __has_include(<ReactAppDependencyProvider/RCTAppDependencyProvider.h>)
#import <ReactAppDependencyProvider/RCTAppDependencyProvider.h>
#endif

@implementation ExpoAppInstance

- (instancetype)initWithSourceURL:(NSURL *)sourceURL manager:(EXVersionManagerObjC *)manager onLoad:(nonnull OnLoad)onLoad {
  if (self = [self init]) {
    _sourceURL = sourceURL;
    _manager = manager;
    _onLoad = onLoad;
    self.dependencyProvider = [RCTAppDependencyProvider new];
    self.reactNativeFactory = [[ExpoGoReactNativeFactory alloc] initWithDelegate:self];
  }
  return self;
}

- (NSURL *)bundleURL {
  return _sourceURL;
}

- (NSArray<id<RCTBridgeModule>> *)extraModulesForBridge:(RCTBridge *)bridge {
  return [_manager extraModules];
}

- (Class)getModuleClassFromName:(const char *)name {
  return [_manager getModuleClassFromName:name];
}

- (id<RCTTurboModule>)getModuleInstanceFromClass:(Class)moduleClass {
  return [_manager getModuleInstanceFromClass:moduleClass];
}

- (void)hostDidStart:(RCTHost *)host
{
  [_manager hostDidStart:[self bundleURL]];
}

- (void)loadBundleAtURL:(NSURL *)sourceURL
             onProgress:(RCTSourceLoadProgressBlock)onProgress
             onComplete:(RCTSourceLoadBlock)loadCallback {
  self.onLoad(sourceURL, loadCallback);
}

- (void)host:(nonnull RCTHost *)host didReceiveJSErrorStack:(nonnull NSArray<NSDictionary<NSString *,id> *> *)stack message:(nonnull NSString *)message exceptionId:(NSUInteger)exceptionId isFatal:(BOOL)isFatal {
}

@end
