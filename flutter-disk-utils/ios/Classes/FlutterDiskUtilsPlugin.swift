import Flutter
import UIKit
import disk_utils_ios

public class FlutterDiskUtilsPlugin: NSObject, FlutterPlugin {
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_disk_utils", binaryMessenger: registrar.messenger())
    let instance = FlutterDiskUtilsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      let method: String = call.method
      if (method == "getPlatformVersion") {
          result("iOS " + UIDevice.current.systemVersion)
      } else if (method == "storage.total") {
          result(StorageUtil.getTotalSize())
      } else if (method == "storage.available") {
          result(StorageUtil.getAvailableSize())
      } else if (method == "memory.total") {
          result(MemoryUtil.getTotalSize())
      } else if (method == "memory.available") {
          result(MemoryUtil.getAvailableSize())
      } else if (method == "memory.app") {
          result(MemoryUtil.getAppMemorySize())
      } else {
          result(FlutterMethodNotImplemented)
      }
    
  }
    
}
