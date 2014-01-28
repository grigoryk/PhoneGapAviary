#import <Cordova/CDV.h>
#import "AFPhotoEditorController.h"

@interface PictaAviary : CDVPlugin <AFPhotoEditorControllerDelegate> {
	NSString *callbackId;
}

@property (nonatomic, retain) NSString *callbackId;

- (void) launchEditor: (CDVInvokedUrlCommand*)command;

@end