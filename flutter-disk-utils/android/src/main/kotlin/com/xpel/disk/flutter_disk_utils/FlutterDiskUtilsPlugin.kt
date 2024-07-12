package com.xpel.disk.flutter_disk_utils

import androidx.annotation.NonNull
import com.xpel.disk.utils.MemoryUtil
import com.xpel.disk.utils.StorageUtil

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterDiskUtilsPlugin */
class FlutterDiskUtilsPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_disk_utils")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        val method: String = call.method
        if (method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (method == "storage.total") {
            result.success(StorageUtil.getTotalSize())
        } else if (method == "storage.available") {
            result.success(StorageUtil.getAvailableSize())
        } else if (method == "memory.total") {
            result.success(MemoryUtil.getTotalSize())
        } else if (method == "memory.available") {
            result.success(MemoryUtil.getAvailableSize())
        } else if (method == "memory.app") {
            result.success(MemoryUtil.getAppMemorySize())
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
