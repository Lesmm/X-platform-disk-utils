package com.xpel.disk.android_disk_utils_example

import android.os.Bundle
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.xpel.disk.utils.MemoryUtil
import com.xpel.disk.utils.StorageUtil

class MainActivity : AppCompatActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        val tv: TextView = findViewById(R.id.sample_text)

        val storageTotal = StorageUtil.toGb(StorageUtil.getTotalSize()).toInt()
        val storageAvailable = StorageUtil.toGb(StorageUtil.getAvailableSize()).toInt()
        val memoryTotal = StorageUtil.toGb(MemoryUtil.getTotalSize()).toInt()
        val memoryAvailable = StorageUtil.toGb(MemoryUtil.getAvailableSize()).toInt()
        val memoryApp = StorageUtil.toMb(MemoryUtil.getAppMemorySize()).toInt()

        tv.text = buildString {
            append("")
            append("STORAGE TOTAL: ${storageTotal}GB, AVAILABLE: ${storageAvailable}GB \n")
            append("MEMORY TOTAL: ${memoryTotal}GB, AVAILABLE: ${memoryAvailable}GB \n")
            append("MEMORY APP: ${memoryAvailable}MB")
            append("")
        }
    }

}