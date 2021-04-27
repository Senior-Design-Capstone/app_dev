import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerGenerator {
  static final _markerSize=30;
  static final double _circleStrokeWidth=_markerSize / 10.0;
  static final double _circleOffset=_markerSize / 2;
  static final double _outlineCircleWidth=_circleOffset - (_circleStrokeWidth / 2);
  static final double _fillCircleWidth=_markerSize / 2;
  static final double outlineCircleInnerWidth = _markerSize - (2 * _circleStrokeWidth);
  static final double _iconSize = sqrt(pow(outlineCircleInnerWidth, 2) / 2);
  static final double rectDiagonal = sqrt(2 * pow(_markerSize, 2));
  static final double circleDistanceToCorners = (rectDiagonal - outlineCircleInnerWidth) / 2;
  static final double _iconOffset = sqrt(pow(circleDistanceToCorners, 2) / 2);

  /// Creates a BitmapDescriptor from an IconData
  static Future<BitmapDescriptor> createBitmapDescriptorFromIconData(Color iconColor) async {
    Color circleColor = Colors.black;
    IconData iconData = Icons.directions_boat_outlined;
    Color backgroundColor = Colors.white;
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    _paintCircleFill(canvas, backgroundColor);
    _paintCircleStroke(canvas, circleColor);
    _paintIcon(canvas, iconColor, iconData);

    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(_markerSize.round(), _markerSize.round());
    final bytes = await image.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  /// Paints the icon background
  static void _paintCircleFill(Canvas canvas, Color color) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawCircle(Offset(_circleOffset, _circleOffset), _fillCircleWidth, paint);
  }

  /// Paints a circle around the icon
  static void _paintCircleStroke(Canvas canvas, Color color) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = _circleStrokeWidth;
    canvas.drawCircle(Offset(_circleOffset, _circleOffset), _outlineCircleWidth, paint);
  }

  /// Paints the icon
  static void _paintIcon(Canvas canvas, Color color, IconData iconData) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
        text: String.fromCharCode(iconData.codePoint),
        style: TextStyle(
          letterSpacing: 0.0,
          fontSize: _iconSize,
          fontFamily: iconData.fontFamily,
          color: color,
        )
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(_iconOffset, _iconOffset));
  }
}