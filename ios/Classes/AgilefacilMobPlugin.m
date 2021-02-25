#import "AgilefacilMobPlugin.h"
#if __has_include(<agilefacil_mob/agilefacil_mob-Swift.h>)
#import <agilefacil_mob/agilefacil_mob-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "agilefacil_mob-Swift.h"
#endif

@implementation AgilefacilMobPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAgilefacilMobPlugin registerWithRegistrar:registrar];
}
@end
