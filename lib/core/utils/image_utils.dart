import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class ImageUtils {
  static Future<String> applyWatermark(
      String imagePath,
      Position? gps,
      ) async {
    try {
      final bytes = await File(imagePath).readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      // Draw original image
      canvas.drawImage(image, Offset.zero, Paint());

      final barHeight = 50.0;
      final barY = image.height - barHeight;

      // Semi-transparent bar at bottom
      canvas.drawRect(
        Rect.fromLTWH(0, barY, image.width.toDouble(), barHeight),
        Paint()..color = const Color(0xAA000000),
      );

      // Timestamp
      final ts = DateFormat('yyyy-MM-dd HH:mm:ss UTC').format(
        DateTime.now().toUtc(),
      );

      _drawText(
        canvas,
        'RED EDGE  |  $ts',
        Offset(12, barY + 8),
        14,
        const Color(0xFFFFFFFF),
      );

      // GPS coordinates
      if (gps != null) {
        _drawText(
          canvas,
          'GPS: ${gps.latitude.toStringAsFixed(6)}, ${gps.longitude.toStringAsFixed(6)}',
          Offset(12, barY + 28),
          12,
          const Color(0xCCFFFFFF),
        );
      }

      final picture = recorder.endRecording();
      final renderedImage = await picture.toImage(image.width, image.height);
      final byteData = await renderedImage.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData != null) {
        await File(imagePath).writeAsBytes(
          byteData.buffer.asUint8List(),
        );
      }

      return imagePath;
    } catch (_) {
      // If watermarking fails, return original — don't lose the photo
      return imagePath;
    }
  }

  static void _drawText(
      Canvas canvas,
      String text,
      Offset position,
      double fontSize,
      Color color,
      ) {
    final paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        fontSize: fontSize,
      ),
    );
    paragraphBuilder.pushStyle(
      ui.TextStyle(color: color, fontSize: fontSize),
    );
    paragraphBuilder.addText(text);
    final paragraph = paragraphBuilder.build();
    paragraph.layout(const ui.ParagraphConstraints(width: 1000));
    canvas.drawParagraph(paragraph, position);
  }

  /// Compress image to target quality (0.0 to 1.0)
  static Future<Uint8List> compress(
      Uint8List bytes, {
        int quality = 85,
      }) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return data!.buffer.asUint8List();
  }
}