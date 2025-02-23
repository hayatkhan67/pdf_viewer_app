import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:app_links/app_links.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? pdfPath;
  final FileHandler _fileHandler = FileHandler();

  @override
  void initState() {
    super.initState();
    debugPrint('run the init is the $pdfPath');
    handle();
  }

  handle() {
    _fileHandler.handleIncomingFiles((String filePath) {
      debugPrint('run the init is the $filePath');
      setState(() {
        pdfPath = filePath;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('here is the $pdfPath');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDF Viewer',
      home: pdfPath == null ? HomeScreen() : PDFViewerScreen(pdfPath!),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewerScreen(result.files.single.path!),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Viewer")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => pickFile(context),
          child: Text("Pick a PDF File"),
        ),
      ),
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String pdfPath;

  const PDFViewerScreen(this.pdfPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Viewer")),
      body: FutureBuilder<PDFDocument>(
        future: PDFDocument.fromFile(File(pdfPath)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('Error loading PDF: ${snapshot.error}'));
            }
            return snapshot.data != null
                ? PDFViewer(
                    document: snapshot.data!,
                  )
                : Center(child: Text('No document available'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

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
