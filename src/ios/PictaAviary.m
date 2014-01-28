#import "PictaAviary.h"
#import <Cordova/CDV.h>
#import "AFPhotoEditorController.h"


@implementation PictaAviary

@synthesize callbackId;

- (void) launchEditor: (CDVInvokedUrlCommand*)command
{
	[AFOpenGLManager beginOpenGLLoad];

	self.callbackId = command.callbackId;

	NSString *imageDataBase64 = [command.arguments objectAtIndex:0];
	NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imageDataBase64 options:0];

	UIImage *image = [UIImage imageWithData:imageData];

	AFPhotoEditorController *aviaryController = [[AFPhotoEditorController alloc] initWithImage:image];
	[aviaryController setDelegate:self];

	[self.viewController presentViewController:aviaryController animated:YES completion:nil];
}


- (void) photoEditor: (AFPhotoEditorController*)editor finishedWithImage:(UIImage*)image
{
	[self successCallback:image];
	[self.viewController dismissViewControllerAnimated:YES completion:nil];
}


- (void) photoEditorCanceled:(AFPhotoEditorController*)editor
{
	[self cancelCallback];
	[self.viewController dismissViewControllerAnimated:YES completion:nil];
}


- (void) successCallback:(UIImage*)image
{
    NSString *base64Image = [UIImageJPEGRepresentation(image, 80.0f) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
		messageAsString:base64Image];

	[self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
}


- (void) cancelCallback
{
	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];

	[self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
}

@end