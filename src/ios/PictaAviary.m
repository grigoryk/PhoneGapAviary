#import "PictaAviary.h"
#import <Cordova/CDV.h>
#import "AFPhotoEditorController.h"


@implementation PictaAviary


@synthesize aviaryController;
@synthesize callbackId;


- (void) launchEditor: (CDVInvokedUrlCommand*)command
{
	[AFOpenGLManager beginOpenGLLoad];

	self.callbackId = command.callbackId;

	NSString* imageDataRaw = [command.arguments objectAtIndex:0];
	NSData* imageData = [NSData initWithBase64EncodedString:imageDataRaw];

	UIImage* image = [UIImage imageWithData:imageData];

	self.aviaryController = [[AFPhotoEditorController alloc] initWithImage:image];
	[self.aviaryController setDelegate:self];

	[self presentModalViewController:self.aviaryController animated:YES completion:nil];
}


- (void) photoEditor: (AFPhotoEditorController*)editor finishedWithImage:(UIImage*)image
{
	NSData* imageData = UIImageJPEGRepresentation(image, 80.0f);

	[self successCallback:imageData];
	[self dismissModalViewControllerAnimated:YES];
}


- (void) photoEditorCanceled:(AFPhotoEditorController*)editor
{
	[self cancelCallback];
	[self dismissModalViewControllerAnimated:YES];
}


- (void) successCallback:(NSData*)imageData
{
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
		messageAsString:imageData];

	[self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
}


- (void) cancelCallback:(NSData*)
{
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];

	[self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
}