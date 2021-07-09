#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Cephei/HBPreferences.h>
#import <Cephei/HBRespringController.h>

@interface SSCRootListController : PSListController
@property (nonatomic, retain) NSMutableDictionary *savedSpecifiers;
@end
