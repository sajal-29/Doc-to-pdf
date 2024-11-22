// ignore_for_file: sort_child_properties_last, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_web_libraries_in_flutter, unused_field
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html' as html;

class DocxToPdfConverter extends StatefulWidget {
  @override
  _DocxToPdfConverterState createState() => _DocxToPdfConverterState();
}

class _DocxToPdfConverterState extends State<DocxToPdfConverter> {
  PlatformFile? _selectedFileButton;
  bool _isUploaded = false;
  String _fileId = "";
  bool _isUploading = false;
  bool _isProcessing = false;
  bool _isDownloading = false;

  // File drop handler for DragTarget

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx'],
      withData: true, // Important for web compatibility
    );

    if (result != null) {
      setState(() {
        _isUploaded = true;
        _selectedFileButton = result.files.first;
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFileButton == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://pdofile.shouryadoes.tech/api/v1/convert/docx-to-pdf'));

      // Use bytes for cross-platform compatibility
      request.files.add(http.MultipartFile.fromBytes(
          'file', _selectedFileButton!.bytes!,
          filename: _selectedFileButton!.name));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 202) {
        setState(() {
          _fileId = jsonDecode(responseBody)["jobId"];
        });
        await _checkProcessingStatus();
      } else {
        _showErrorSnackbar('Upload failed');
      }
    } catch (e) {
      _showErrorSnackbar('Error: ${e.toString()}');
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _checkProcessingStatus() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://pdofile.shouryadoes.tech/api/v1/convert/status/$_fileId'));

      if (response.statusCode == 200) {
        var status = response.body;
        if (status == "\"COMPLETED\"") {
          _downloadPdf();
        } else {
          // Wait and check again
          _checkProcessingStatus();
        }
      } else {
        _showErrorSnackbar('Status check failed');
      }
    } catch (e) {
      _showErrorSnackbar('Error: ${e.toString()}');
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _downloadPdf() async {
    setState(() {
      _isDownloading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://pdofile.shouryadoes.tech/api/v1/convert/download/$_fileId'));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        final blob = html.Blob([bytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..target = 'blank'
          ..download = 'converted.pdf';

        anchor.click();

        html.Url.revokeObjectUrl(url);

        _showSuccessSnackbar('PDF Ready for Download');
      } else {
        _showErrorSnackbar('Download failed');
      }
    } catch (e) {
      _showErrorSnackbar('Error: ${e.toString()}');
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  void _cancelFile() {
    setState(() {
      _selectedFileButton = null;
      _isDownloading = false;
      _isProcessing = false;
      _isUploaded = false;
      _isUploading = false;
    });
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red));
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.green));
  }

  Padding _getFileMetadataTable() {
    if (_selectedFileButton != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 140, right: 140),
        child: Table(
          
          border: TableBorder.all(color: Colors.black),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(3),
          },
          children: [
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('File Name', 
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFDA8359))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_selectedFileButton!.name, 
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFFDA8359))),
                ),
              ],
            ),
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('File Size',textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFDA8359)),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${_selectedFileButton!.size} bytes', textAlign: TextAlign.center,style: const TextStyle(color: Color(0xFFDA8359))),
                ),
              ],
            ),
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('File Extension', textAlign: TextAlign.center,style: TextStyle(color: Color(0xFFDA8359))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('.${_selectedFileButton!.extension}',textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFFDA8359))),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('No file selected', textAlign: TextAlign.center,style: TextStyle(color: Color(0xFFA6AEBF)))
      );
    }
  }

  void _showErrorBar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No File Uploaded"), backgroundColor: Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PDFify-Me',
          style: TextStyle(
              color: Color(0xFF89A8B2),
              fontWeight: FontWeight.bold,
              fontSize: 35),
        ),
        backgroundColor: const Color(0xFFB3C8CF),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFE5E1DA),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Lets Get Started !',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFFA6AEBF), fontWeight: FontWeight.w900, fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Convert Your Docx File to Pdf',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            _isUploaded
                ? 'Selected File: ${_selectedFileButton!.name}'
                : 'No File Selected',
            style: TextStyle(
                color: _isUploaded
                    ? const Color.fromARGB(255, 100, 211, 141)
                    : Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 400,
                  height: 200,
                  child: DottedBorder(
                    borderType: BorderType.Circle,
                    radius: const Radius.circular(40),
                    dashPattern: const [10, 10],
                    color: const Color(0xFFB1C29E),
                    strokeWidth: 5,
                    child: Center(
                        child: Container(
                      child: _isUploading
                          ? const CircularProgressIndicator()
                          : IconButton(
                              icon: const Icon(
                                Icons.upload_file_outlined,
                                size: 50,
                              ),
                              onPressed: _pickFile,
                            ),
                    )),
                  ),
                ),
                const SizedBox(height: 20),
                _isUploaded
                    ? Column(
                        children: [
                          ElevatedButton(
                            onPressed: _selectedFileButton == null
                                ? _showErrorBar
                                : _uploadFile,
                            child: const Text(
                              'Convert and Download',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF89A8B2)),
                                shape: MaterialStateProperty.all(
                                    ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: _selectedFileButton == null
                                ? _showErrorBar
                                : _cancelFile,
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF89A8B2)),
                                shape: MaterialStateProperty.all(
                                    ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ))),
                          ),
                        ],
                      )
                    : const Text(
                        'Tap the icon to choose a file',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: _getFileMetadataTable(),
          ),
          
        ],
      ),
    );
  }
}
