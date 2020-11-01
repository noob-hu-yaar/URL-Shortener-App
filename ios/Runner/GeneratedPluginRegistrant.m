//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_clipboard_manager/FlutterClipboardManagerPlugin.h>)
#import <flutter_clipboard_manager/FlutterClipboardManagerPlugin.h>
#else
@import flutter_clipboard_manager;
#endif

#if __has_include(<path_provider/FLTPathProviderPlugin.h>)
#import <path_provider/FLTPathProviderPlugin.h>
#else
@import path_provider;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterClipboardManagerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterClipboardManagerPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
}

@end
