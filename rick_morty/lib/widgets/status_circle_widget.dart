import 'package:flutter/material.dart';
import 'package:rick_morty/theme/app_colors.dart';

enum StatusType {
  alive,
  dead,
  unknown;

  static StatusType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'alive':
        return StatusType.alive;
      case 'dead':
        return StatusType.dead;
      case 'unkown':
        return StatusType.unknown;
      default:
        return StatusType.unknown;
    }
  }

  Color color() {
    switch (this) {
      case StatusType.alive:
        return Colors.green;
      case StatusType.dead:
        return Colors.red;
      case StatusType.unknown:
        return Colors.grey;
    }
  }
}

class StatusCircleWidget extends StatelessWidget {
  final StatusType statusType;
  final Size circleSize;
  final double strokeWidth;

  const StatusCircleWidget._({
    super.key,
    required this.statusType,
    required this.circleSize,
    required this.strokeWidth,
  });

  factory StatusCircleWidget({
    Key? key,
    required String status,
    required Size circleSize,
    required double strokeWidth,
  }) {
    return StatusCircleWidget._(
      key: key,
      statusType: StatusType.fromString(status),
      circleSize: circleSize,
      strokeWidth: strokeWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: circleSize,
      painter: CirclePainter(
        circleColor: statusType.color(),
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color circleColor;
  final double strokeWidth;

  const CirclePainter({required this.circleColor, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final fillRadius = size.width / 2;
    final strokeRadius = fillRadius - strokeWidth / 2;

    final fillPaint = Paint()
      ..color = circleColor
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = AppColors.labelColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, fillRadius, fillPaint);
    canvas.drawCircle(center, strokeRadius, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
