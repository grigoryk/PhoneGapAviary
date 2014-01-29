#import "PictaAviary.h"
#import <Cordova/CDV.h>
#import "AFPhotoEditorController.h"
#import "AFPhotoEditorCustomization.h"
#import "AssetsLibrary/AssetsLibrary.h"


@implementation PictaAviary

@synthesize callbackId;

- (void) launchEditor: (CDVInvokedUrlCommand*)command
{
	[AFOpenGLManager beginOpenGLLoad];
    
	self.callbackId = command.callbackId;
    
	NSString *imageUri = [command.arguments objectAtIndex:0];
	NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUri]];
    
	UIImage *image = [UIImage imageWithData:imageData];
    
	AFPhotoEditorController *aviaryController = [[AFPhotoEditorController alloc] initWithImage:image];
	[aviaryController setDelegate:self];
    
    [AFPhotoEditorCustomization setToolOrder:@[kAFEnhance, kAFOrientation, kAFCrop, kAFAdjustments, kAFSharpness, kAFFocus, kAFText]];
    
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
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error) {
            [self cancelCallback];
        } else {
            CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                              messageAsString:[assetURL absoluteString]];
            
            [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
        }
    }];
}

- (void) cancelCallback
{
	CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    
	[self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
}

@end