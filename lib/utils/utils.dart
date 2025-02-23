import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FileHandler {
  final AppLinks _appLinks = AppLinks();
  static const MethodChannel _channel = MethodChannel('file_handler');

  void handleIncomingFiles(Function(String) onFileReceived) async {
    try {
      _appLinks.uriLinkStream.listen((Uri? uri) async {
        if (uri != null) {
          String? filePath = await getFilePathFromUri(uri);
          if (filePath != null) {
            onFileReceived(filePath);
          }
        }
      });

      String? initialUri = await _appLinks.getInitialLinkString();
      if (initialUri != null) {
        String? filePath = await getFilePathFromUri(Uri.parse(initialUri));
        if (filePath != null) {
          onFileReceived(filePath);
        }
      }
    } on PlatformException {
      debugPrint("Error fetching initial URI");
    }
  }

  Future<String?> getFilePathFromUri(Uri uri) async {
    if (uri.scheme == "file") {
      return uri.toFilePath();
    } else if (uri.scheme == "content") {
      return await _copyFileToLocal(uri);
    }
    return null;
  }

  Future<String?> _copyFileToLocal(Uri uri) async {
    try {
      final directory = await getTemporaryDirectory();
      final filePath = "${directory.path}/temp_file.pdf";
      final file = File(filePath);

      final Uint8List? fileBytes = await _readContentUri(uri);
      if (fileBytes == null) {
        debugPrint("Failed to read content URI: $uri");
        return null;
      }

      await file.writeAsBytes(fileBytes);
      debugPrint("File copied successfully to: $filePath");
      return filePath;
    } catch (e) {
      debugPrint("Error copying file: $e");
      return null;
    }
  }

  Future<Uint8List?> _readContentUri(Uri uri) async {
    try {
      final Uint8List? bytes =
          await _channel.invokeMethod('getFileBytes', {"uri": uri.toString()});
      return bytes;
    } on PlatformException catch (e) {
      debugPrint("Failed to read content URI: ${e.message}");
      return null;
    }
  }
}
