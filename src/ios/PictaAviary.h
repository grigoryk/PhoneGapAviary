#import <Cordova/CDV.h>
#import "AFPhotoEditorController.h"

@interface PictaAviary : CDVPlugin <AFPhotoEditorControllerDelegate> {
	AFPhotoEditorController* aviaryController;
	NSString* callbackId;
}

@property (nonatomic, retain) AFPhotoEditorController *aviaryController;
@property (nonatomic, retain) NSString* callbackId;

- (void) launchEditor: (CDVInvokedUrlCommand*)command;

@end