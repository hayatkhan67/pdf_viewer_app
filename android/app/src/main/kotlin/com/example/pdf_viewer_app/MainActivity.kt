package com.hkn.pdf_viewer_app

import android.content.ContentResolver
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.io.InputStream

class MainActivity : FlutterActivity() {
    private val CHANNEL = "file_handler" // Ensure this matches the Dart side

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getFileBytes") {  // Ensure method name matches Dart side
                val uriString = call.argument<String>("uri")
                if (uriString != null) {
                    val fileBytes = getFileBytesFromUri(uriString)
                    if (fileBytes != null) {
                        result.success(fileBytes)
                    } else {
                        result.error("FILE_ERROR", "Failed to read file", null)
                    }
                } else {
                    result.error("INVALID_URI", "URI is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getFileBytesFromUri(uriString: String): ByteArray? {
        return try {
            val uri = Uri.parse(uriString)
            val contentResolver: ContentResolver = applicationContext.contentResolver
            val inputStream: InputStream? = contentResolver.openInputStream(uri)
            inputStream?.use {
                val buffer = ByteArrayOutputStream()
                val data = ByteArray(1024)
                var nRead: Int
                while (inputStream.read(data, 0, data.size).also { nRead = it } != -1) {
                    buffer.write(data, 0, nRead)
                }
                buffer.toByteArray()
            }
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }
}
