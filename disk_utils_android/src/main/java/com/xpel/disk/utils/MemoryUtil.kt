package com.xpel.disk.utils

import android.annotation.SuppressLint
import android.app.ActivityManager
import android.app.Application
import android.content.Context
import android.os.Debug
import android.os.Process

class MemoryUtil {

    @SuppressLint("StaticFieldLeak")
    companion object {

        private var context: Context? = null

        @JvmStatic
        fun setContext(context: Context) {
            this.context = context
        }

        @SuppressLint("PrivateApi", "DiscouragedPrivateApi")
        @JvmStatic
        fun getContext(): Context? {
            if (context == null) {
                try {
                    val clazz = Class.forName("android.app.ActivityThread")
                    val method = clazz.getDeclaredMethod("currentActivityThread")
                    method.isAccessible = true
                    val instance = method.invoke(clazz)
                    val application = clazz.getDeclaredMethod("getApplication")
                    application.isAccessible = true
                    context = application.invoke(instance, *arrayOf()) as Application
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
            return context
        }

        @JvmStatic
        fun getMemoryInfo(): ActivityManager.MemoryInfo {
            val memoryInfo = ActivityManager.MemoryInfo()
            try {
                val am: ActivityManager? = getContext()?.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager?
                am?.getMemoryInfo(memoryInfo)
            } catch (e: Exception) {
                e.printStackTrace()
            }
            return memoryInfo
        }

        @JvmStatic
        fun getTotalSize(): Long {
            return getMemoryInfo().totalMem
        }

        @JvmStatic
        fun getAvailableSize(): Long {
            return getMemoryInfo().availMem
        }

        @JvmStatic
        fun getAppMemorySize(): Long {
            return getPssSize()
        }

        @JvmStatic
        fun getPssSize(): Long {
            return getDebugMemoryInfo().totalPss.toLong() * 1024
        }

        @JvmStatic
        fun getThreshold(): Long {
            return getMemoryInfo().threshold
        }

        @JvmStatic
        fun isLowMemory(): Boolean {
            return getMemoryInfo().lowMemory
        }

        @JvmStatic
        fun getDebugMemoryInfo(): Debug.MemoryInfo {
            val debugInfo = Debug.MemoryInfo()
            Debug.getMemoryInfo(debugInfo)
            return debugInfo
        }

    }
}