import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlutterDiskUtilsMethodChannel {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_disk_utils');

  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  Future<int?> getStorageSize() async {
    final total = await methodChannel.invokeMethod<int>('storage.total');
    return total;
  }

  Future<int?> getStorageAvailableSize() async {
    final available = await methodChannel.invokeMethod<int>('storage.available');
    return available;
  }

  Future<int?> getMemorySize() async {
    final total = await methodChannel.invokeMethod<int>('memory.total');
    return total;
  }

  Future<int?> getMemoryAvailableSize() async {
    final available = await methodChannel.invokeMethod<int>('memory.available');
    return available;
  }

  Future<int?> getAppMemory() async {
    final available = await methodChannel.invokeMethod<int>('memory.app');
    return available;
  }
}
