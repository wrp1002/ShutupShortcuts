#include "SSCRootListController.h"

@implementation SSCRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	NSArray *chosenIDs = @[@"kDisableAll", @"kDisableAllGroup"];
	self.savedSpecifiers = (self.savedSpecifiers) ?: [[NSMutableDictionary alloc] init];
	for(PSSpecifier *specifier in _specifiers) {
		if([chosenIDs containsObject:[specifier propertyForKey:@"id"]])
			[self.savedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"id"]];
	}

	return _specifiers;
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
	[super setPreferenceValue:value specifier:specifier];

	NSString *key = [specifier propertyForKey:@"key"];
	if([key isEqualToString:@"kEnabled"]) {
		if([value boolValue])
			[self insertContiguousSpecifiers:@[self.savedSpecifiers[@"kDisableAllGroup"], self.savedSpecifiers[@"kDisableAll"]] afterSpecifierID:@"kEnabled" animated:YES];
		else
			[self removeSpecifierID:@"kDisableAllGroup" animated:YES];
	}
}

-(void)reloadSpecifiers {
	[super reloadSpecifiers];

	HBPreferences *prefs = [[HBPreferences alloc] initWithIdentifier:@"com.wrp1002.shutupshortcuts"];
	if(![prefs boolForKey:@"kEnabled"])
		[self removeSpecifierID:@"kDisableAllGroup" animated:NO];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self reloadSpecifiers];
}

-(void)Respring {
	[HBRespringController respring];
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
