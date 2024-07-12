#import "RNDiskUtils.h"

#if __has_include(<disk_utils_ios/disk_utils_ios-Swift.h>)
#import <disk_utils_ios/disk_utils_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "disk_utils_ios-Swift.h"
#endif


@implementation RNDiskUtils

RCT_EXPORT_MODULE(DiskUtils)

RCT_EXPORT_METHOD(sampleMethod:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback)
{
    // TODO: Implement some actually useful functionality
    callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
}

RCT_EXPORT_METHOD(getStorageSize:(RCTResponseSenderBlock)callback)
{
    callback(@[
        [NSString stringWithFormat: @"%llu", [StorageUtil getTotalSize]]
    ]);
}

RCT_EXPORT_METHOD(getStorageAvailableSize:(RCTResponseSenderBlock)callback)
{
    callback(@[
        [NSString stringWithFormat: @"%llu", [StorageUtil getAvailableSize]]
    ]);
}

RCT_EXPORT_METHOD(getMemorySize:(RCTResponseSenderBlock)callback)
{
    callback(@[
        [NSString stringWithFormat: @"%llu", [MemoryUtil getTotalSize]]
    ]);
}

RCT_EXPORT_METHOD(getMemoryAvailableSize:(RCTResponseSenderBlock)callback)
{
    callback(@[
        [NSString stringWithFormat: @"%llu", [MemoryUtil getAvailableSize]]
    ]);
}

RCT_EXPORT_METHOD(getAppMemory:(RCTResponseSenderBlock)callback)
{
    callback(@[
        [NSString stringWithFormat: @"%llu", [MemoryUtil getAppMemorySize]]
    ]);
}

@end
