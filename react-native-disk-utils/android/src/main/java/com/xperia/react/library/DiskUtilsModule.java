// DiskUtilsModule.java

package com.xperia.react.library;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.xpel.disk.utils.MemoryUtil;
import com.xpel.disk.utils.StorageUtil;

public class DiskUtilsModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public DiskUtilsModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "DiskUtils";
    }

    @ReactMethod
    public void sampleMethod(String stringArgument, int numberArgument, Callback callback) {
        // TODO: Implement some actually useful functionality
        callback.invoke("Received numberArgument: " + numberArgument + " stringArgument: " + stringArgument);
    }

    @ReactMethod
    public void getStorageSize(Callback callback) {
        callback.invoke(String.valueOf(StorageUtil.getTotalSize()));
    }

    @ReactMethod
    public void getStorageAvailableSize(Callback callback) {
        callback.invoke(String.valueOf(StorageUtil.getAvailableSize()));
    }

    @ReactMethod
    public void getMemorySize(Callback callback) {
        callback.invoke(String.valueOf(MemoryUtil.getTotalSize()));
    }

    @ReactMethod
    public void getMemoryAvailableSize(Callback callback) {
        callback.invoke(String.valueOf(MemoryUtil.getAvailableSize()));
    }

    @ReactMethod
    public void getAppMemory(Callback callback) {
        callback.invoke(String.valueOf(MemoryUtil.getAppMemorySize()));
    }

}
