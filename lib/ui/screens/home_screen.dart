import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_viewer_app/controller/recent_pdf_controller.dart';

import '../../utils/text_theme_extension.dart';
import 'pdf_view_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => setData, //  pickFile(context),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("PDF Viewer")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(6),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Divider(),
            ValueListenableBuilder<int>(
              valueListenable: counter,
              builder: (context, value, child) {
                return Text(
                  'Counter: $value',
                  style: TextStyle(fontSize: 24),
                );
              },
            ),
            Text(
              'Recents PDF',
              style: context.titleLarge,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: Icon(Icons.picture_as_pdf),
                    title: Text("PDF Viewer"),
                    onTap: () => pickFile(context),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
