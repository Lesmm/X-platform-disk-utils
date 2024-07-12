package com.xpel.disk.utils

import android.os.Environment
import android.os.StatFs
import java.io.File

class StorageUtil {

    companion object {

        @JvmStatic
        fun getTotalSize(): Long {
            if (isExternalStorageAvailable()) {
                val path: File = Environment.getExternalStorageDirectory()
                val stat = StatFs(path.path)
                return stat.totalBytes // stat.blockSizeLong * stat.blockCountLong
            }
            return -1
        }

        @JvmStatic
        fun getAvailableSize(): Long {
            if (isExternalStorageAvailable()) {
                val path: File = Environment.getExternalStorageDirectory()
                val stat = StatFs(path.path)
                return stat.availableBytes // stat.blockSizeLong * stat.availableBlocksLong
            }
            return -1
        }

        @JvmStatic
        fun isExternalStorageAvailable(): Boolean {
            return Environment.getExternalStorageState() == Environment.MEDIA_MOUNTED
        }

        @JvmStatic
        fun getSizeOfFile(path: String): Long {
            val file = File(path)
            if (file.exists()) {
                if (file.isFile) {
                    return file.length()
                } else if (file.isDirectory) {
                    return getSizeOfDirectory(path)
                }
            }
            return -1
        }

        @JvmStatic
        fun getSizeOfDirectory(directory: String): Long {
            return File(directory).walkTopDown().map { it.length() }.sum()
        }

        /**
         * Extra methods
         */

        @JvmStatic
        fun toMb(bytes: Long): Double {
            return bytes.toDouble() / 1024 / 1024
        }

        @JvmStatic
        fun toGb(bytes: Long): Double {
            return bytes.toDouble() / 1024 / 1024 / 1024
        }
    }


}