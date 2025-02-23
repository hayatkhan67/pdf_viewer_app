import 'package:flutter/material.dart';

import 'services/shared_prefs_service/shared_prefs_service.dart';
import 'ui/screens/bottom_nav_screen.dart';
import 'ui/screens/pdf_view_screen.dart';
import 'utils/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Prefs.init();
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
      home: pdfPath == null ? BottomNavScreen() : PDFViewerScreen(pdfPath!),
    );
  }
}
