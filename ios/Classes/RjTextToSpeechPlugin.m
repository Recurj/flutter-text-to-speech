#import "RjtexttospeechPlugin.h"
#if __has_include(<rjtexttospeech/rjtexttospeech-Swift.h>)
#import <rjtexttospeech/rjtexttospeech-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "rjtexttospeech-Swift.h"
#endif

@implementation RjTextToSpeechPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRjTextToSpeechPlugin registerWithRegistrar:registrar];
}
@end
