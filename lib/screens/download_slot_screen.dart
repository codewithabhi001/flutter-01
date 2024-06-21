import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadSlotScreen extends StatefulWidget {
  const DownloadSlotScreen({Key? key}) : super(key: key);

  @override
  _DownloadSlotScreenState createState() => _DownloadSlotScreenState();
}

class StatefulWidget {
}

class _DownloadSlotScreenState extends State<DownloadSlotScreen> {
  List<dynamic> slots = [];
  String selectedSlotId = ''; // Changed to an empty string
  bool isLoading = true;
  GlobalKey globalKey = GlobalKey();
  bool savingImage = false;

  @override
  void initState() {
    super.initState();
    fetchSlots();
  }

  Future<void> fetchSlots() async {
    try {
      final response = await http.get(
          Uri.parse("https://tournatracks.onrender.com/api/auth/getslots"));
      final data = json.decode(response.body);
      if (mounted) {
        setState(() {
          slots = data;
          isLoading = false;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget _buildSlotList() {
    List<String> teams = [];

    // Find the selected slot
    var selectedSlot = slots.firstWhere(
      (slot) => slot['_id'] == selectedSlotId,
      orElse: () => null, // Return null if not found
    );

    // Check if selectedSlot is not null and extract teams
    if (selectedSlot != null) {
      teams = List<String>.from(selectedSlot['teams'] ?? []);
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.orange),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (selectedSlot != null && teams.isNotEmpty)
            Column(
              children: [
                Text(
                  selectedSlot['organizationName'] ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  selectedSlot['matchTitle'] ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  selectedSlot['matchDate'] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: teams.length > 24 ? teams.length : 24,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final team =
                        index < teams.length ? teams[index] : 'Empty Slot';
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.orange),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            '#${index + 1}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              team,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _captureAndSavePng() async {
    if (savingImage) {
      return; // Prevent multiple save attempts concurrently
    }
    setState(() {
      savingImage = true;
    });

    try {
      // Request storage permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception('Storage permission not granted');
      }

      // Ensure globalKey.currentContext is not null
      if (globalKey.currentContext == null) {
        // If context is null, schedule a post-frame callback
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _captureAndSavePng(); // Call again after the frame is built
        });
        return; // Exit the function
      }

      // Now proceed with capturing the image
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 5.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final result = await ImageGallerySaver.saveImage(pngBytes);
      print('Image saved successfully: $result');

      // Show SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image saved to gallery')));
    } catch (e, stackTrace) {
      print('Error saving image: $e');
      print(stackTrace);

      // Show SnackBar for failure
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to save image')));
    } finally {
      setState(() {
        savingImage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey[900]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[900],
                        ),
                        child: DropdownButton<String>(
                          value: selectedSlotId.isEmpty ? null : selectedSlotId,
                          dropdownColor: Colors.grey[800],
                          onChanged: (String? value) {
                            setState(() {
                              selectedSlotId = value ?? '';
                            });
                          },
                          underline: const SizedBox(),
                          items: [
                            const DropdownMenuItem(
                              value: '',
                              child: Text(
                                'Select Slot',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            for (var slot in slots)
                              DropdownMenuItem(
                                value: slot['_id'],
                                child: Text(
                                  slot['organizationName'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                          ],
                          iconEnabledColor: Colors.orange,
                          hint: const Text(
                            'Select Slot',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      RepaintBoundary(
                        key: globalKey,
                        child: _buildSlotList(),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: _captureAndSavePng,
                        child: savingImage
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Download',
                                style: TextStyle(color: Colors.black),
                              ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DownloadSlotScreen(),
  ));
}
