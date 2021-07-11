#include "SSCRootListController.h"

@implementation SSCRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	NSArray *chosenIDs = @[@"kAutomationStr"];
	self.savedSpecifiers = (self.savedSpecifiers) ?: [[NSMutableDictionary alloc] init];
	for(PSSpecifier *specifier in _specifiers) {
		if([chosenIDs containsObject:[specifier propertyForKey:@"id"]])
			[self.savedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"id"]];
	}

	return _specifiers;
}

-(void)_returnKeyPressed:(id)arg1 {
	[self.view endEditing:YES];
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
	[super setPreferenceValue:value specifier:specifier];

	NSString *key = [specifier propertyForKey:@"key"];
	if([key isEqualToString:@"kDisableAll"]) {
		if([value boolValue])
			[self removeSpecifierID:@"kAutomationStr" animated:YES];
		else
			[self insertSpecifier:self.savedSpecifiers[@"kAutomationStr"] afterSpecifierID:@"kDisableAll" animated:YES];
	}
}

-(void)reloadSpecifiers {
	[super reloadSpecifiers];

	HBPreferences *prefs = [[HBPreferences alloc] initWithIdentifier:@"com.wrp1002.shutupshortcuts"];
	if([prefs boolForKey:@"kDisableAll"])
		[self removeSpecifierID:@"kAutomationStr" animated:NO];
}

- (void)loadView {
    [super loadView];
    ((UITableView *)[self table]).keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
	[self reloadSpecifiers];
	NSLog(@"ShutupShortcuts: loadview()");
}

-(void)Respring {
	[HBRespringController respring];
}

-(void)ResetSettings {
	HBPreferences *prefs = [[HBPreferences alloc] initWithIdentifier: @"com.wrp1002.shutupshortcuts"];
	[prefs removeAllObjects];
	[self Respring];
}

-(void)OpenGithub {
	UIApplication *application = [UIApplication sharedApplication];
	NSURL *URL = [NSURL URLWithString:@"https://github.com/wrp1002/ShutupShortcuts"];
	[application openURL:URL options:@{} completionHandler:^(BOOL success) {}];
}

-(void)OpenPaypal {
	UIApplication *application = [UIApplication sharedApplication];
	NSURL *URL = [NSURL URLWithString:@"https://paypal.me/wrp1002"];
	[application openURL:URL options:@{} completionHandler:^(BOOL success) {}];
}

-(void)OpenReddit {
	UIApplication *application = [UIApplication sharedApplication];
	NSURL *URL = [NSURL URLWithString:@"https://reddit.com/u/wes_hamster"];
	[application openURL:URL options:@{} completionHandler:^(BOOL success) {}];
}

-(void)OpenEmail {
	UIApplication *application = [UIApplication sharedApplication];
	NSURL *URL = [NSURL URLWithString:@"mailto:wes.hamster@gmail.com?subject=ShutupShortcuts"];
	[application openURL:URL options:@{} completionHandler:^(BOOL success) {}];
}

@end
