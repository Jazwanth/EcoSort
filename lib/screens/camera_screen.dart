import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:developer' as developer;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  String? _detectedWasteType;
  double? _confidence;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _controller = CameraController(cameras[0], ResolutionPreset.medium);
        try {
          await _controller!.initialize();
          setState(() {
            _isCameraInitialized = true;
          });
        } catch (e) {
          developer.log('Error initializing camera', error: e);
        }
      }
    }
  }

  Future<void> _analyzeWaste() async {
    if (!_isCameraInitialized || _controller == null) return;

    try {
      // TODO: Implement waste recognition using ML Kit
      // This is a placeholder for the actual implementation
      setState(() {
        _detectedWasteType = 'Plastic Bottle';
        _confidence = 0.95;
      });
    } catch (e) {
      developer.log('Error analyzing waste', error: e);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Waste'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // TODO: Show scanning tips
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          if (_isCameraInitialized && _controller != null)
            CameraPreview(_controller!)
          else
            const Center(child: CircularProgressIndicator()),
          if (_detectedWasteType != null)
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Detected: $_detectedWasteType',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_confidence != null)
                        Text(
                          'Confidence: ${(_confidence! * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Add to recycling history
                              setState(() {
                                _detectedWasteType = null;
                              });
                            },
                            child: const Text('Confirm'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _detectedWasteType = null;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _analyzeWaste,
        child: const Icon(Icons.camera),
      ),
    );
  }
} 