import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:red_edge_app/features/photos/data/datasource/photo_local_datasource.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/image_utils.dart';

class PhotoReviewArgs {
  final String imagePath;
  final Position? gps;
  final String? address;
  final String jobId;
  final String stepId;

  const PhotoReviewArgs({
    required this.imagePath,
    this.gps,
    this.address,
    required this.jobId,
    required this.stepId,
  });
}

class CameraScreen extends ConsumerStatefulWidget {
  final String jobId;
  final String stepId;

  const CameraScreen({
    super.key,
    required this.jobId,
    required this.stepId,
  });

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  CameraController? _controller;
  Position? _gpsPosition;
  bool _isCapturing = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initCamera();
    _captureGPS();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _errorMessage = 'No cameras available');
        return;
      }
      _controller = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _controller!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      setState(() => _errorMessage = 'Camera error: $e');
    }
  }

  Future<void> _captureGPS() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      _gpsPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (mounted) setState(() {});
    } catch (_) {
      // GPS is optional — continue without
    }
  }

  Future<void> _takePicture() async {
    if (_isCapturing ||
        _controller == null ||
        !_controller!.value.isInitialized) {
      return;
    }
    setState(() => _isCapturing = true);

    try {
      final file = await _controller!.takePicture();

      // Save locally
      final bytes = await File(file.path).readAsBytes();
      final photoId = const Uuid().v4();
      final savedPath =
          await PhotoLocalDataSource.savePhotoFile(bytes, photoId);

      // Apply watermark
      await ImageUtils.applyWatermark(savedPath, _gpsPosition);

      // Reverse geocode GPS to address
      String? address;
      if (_gpsPosition != null) {
        address = await _reverseGeocode(
            _gpsPosition!.latitude, _gpsPosition!.longitude);
      }

      if (mounted) {
        context.push(
          '/jobs/${widget.jobId}/steps/${widget.stepId}/photo-review',
          extra: PhotoReviewArgs(
            imagePath: savedPath,
            gps: _gpsPosition,
            address: address,
            jobId: widget.jobId,
            stepId: widget.stepId,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Capture failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<String?> _reverseGeocode(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = [
          p.street,
          p.subLocality,
          p.locality,
          p.administrativeArea,
          p.country,
        ].where((s) => s != null && s.isNotEmpty).join(', ');
        return parts.isNotEmpty ? parts : null;
      }
    } catch (_) {}
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera_alt, color: Colors.white54, size: 48),
              const SizedBox(height: 16),
              Text(_errorMessage!, style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 16),
              Text('Initializing camera...',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview
          Positioned.fill(
            child: CameraPreview(_controller!),
          ),

          // Frame overlay (corner brackets)
          const Positioned.fill(child: _FrameOverlay()),

          // GPS pill
          if (_gpsPosition != null)
            Positioned(
              bottom: 100,
              left: AppSpacing.md,
              child: _GPSPill(position: _gpsPosition!),
            ),

          // Capture button
          Positioned(
            bottom: AppSpacing.xl,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _takePicture,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: _isCapturing ? 60 : 72,
                  height: _isCapturing ? 60 : 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.5),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: _isCapturing
                      ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.camera_alt,
                          color: Colors.white, size: 28),
                ),
              ),
            ),
          ),

          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () => context.pop(),
            ),
          ),

          // Step label
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Photo Capture',
                  style: AppTextStyles.label.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FrameOverlay extends StatelessWidget {
  const _FrameOverlay();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _FramePainter());
  }
}

class _FramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    const inset = 40.0;
    const length = 30.0;
    final rect = Rect.fromLTRB(
        inset, inset + 60, size.width - inset, size.height - inset - 80);

    // Top-left
    canvas.drawLine(rect.topLeft, Offset(rect.left + length, rect.top), paint);
    canvas.drawLine(rect.topLeft, Offset(rect.left, rect.top + length), paint);

    // Top-right
    canvas.drawLine(
        rect.topRight, Offset(rect.right - length, rect.top), paint);
    canvas.drawLine(
        rect.topRight, Offset(rect.right, rect.top + length), paint);

    // Bottom-left
    canvas.drawLine(
        rect.bottomLeft, Offset(rect.left + length, rect.bottom), paint);
    canvas.drawLine(
        rect.bottomLeft, Offset(rect.left, rect.bottom - length), paint);

    // Bottom-right
    canvas.drawLine(
        rect.bottomRight, Offset(rect.right - length, rect.bottom), paint);
    canvas.drawLine(
        rect.bottomRight, Offset(rect.right, rect.bottom - length), paint);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _GPSPill extends StatelessWidget {
  final Position position;

  const _GPSPill({required this.position});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.completed,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.gps_fixed, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(
            '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}',
            style: AppTextStyles.code.copyWith(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
