import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// Circular time picker widget matching the reference design
class CircularTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay>? onTimeChanged;
  final bool is24HourFormat;
  final double size;

  const CircularTimePicker({
    Key? key,
    required this.initialTime,
    this.onTimeChanged,
    this.is24HourFormat = false,
    this.size = 280,
  }) : super(key: key);

  @override
  State<CircularTimePicker> createState() => _CircularTimePickerState();
}

class _CircularTimePickerState extends State<CircularTimePicker> {
  late int _selectedHour;
  late int _selectedMinute;
  bool _isAM = true;
  bool _selectingHour = true;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.initialTime.hourOfPeriod;
    if (_selectedHour == 0) _selectedHour = 12;
    _selectedMinute = widget.initialTime.minute;
    _isAM = widget.initialTime.hour < 12;
  }

  void _notifyTimeChanged() {
    int hour = _selectedHour;
    if (!widget.is24HourFormat) {
      if (!_isAM && hour != 12) {
        hour += 12;
      } else if (_isAM && hour == 12) {
        hour = 0;
      }
    }
    widget.onTimeChanged?.call(TimeOfDay(hour: hour, minute: _selectedMinute));
  }

  void _handlePanUpdate(DragUpdateDetails details, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final position = details.localPosition;
    final angle = math.atan2(position.dy - center.dy, position.dx - center.dx);

    // Convert angle to value (hour or minute)
    double normalizedAngle = (angle + math.pi / 2) % (2 * math.pi);
    if (normalizedAngle < 0) normalizedAngle += 2 * math.pi;

    setState(() {
      if (_selectingHour) {
        _selectedHour = ((normalizedAngle / (2 * math.pi)) * 12).round();
        if (_selectedHour == 0) _selectedHour = 12;
      } else {
        _selectedMinute = ((normalizedAngle / (2 * math.pi)) * 60).round() % 60;
      }
    });
    _notifyTimeChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Time display
        _buildTimeDisplay(),
        const SizedBox(height: AppSpacing.lg),
        // Circular dial
        _buildCircularDial(),
      ],
    );
  }

  Widget _buildTimeDisplay() {
    final hourStr = _selectedHour.toString().padLeft(2, '0');
    final minuteStr = _selectedMinute.toString().padLeft(2, '0');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        GestureDetector(
          onTap: () => setState(() => _selectingHour = true),
          child: Text(
            hourStr,
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w300,
              color: _selectingHour
                  ? AppThemeColors.textPrimary
                  : AppThemeColors.textSecondary,
            ),
          ),
        ),
        Text(
          ' : ',
          style: TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.w300,
            color: AppThemeColors.textSecondary,
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => _selectingHour = false),
          child: Text(
            minuteStr,
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w300,
              color: !_selectingHour
                  ? AppThemeColors.textPrimary
                  : AppThemeColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 8),
        if (!widget.is24HourFormat) _buildAmPmToggle(),
      ],
    );
  }

  Widget _buildAmPmToggle() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            setState(() => _isAM = true);
            _notifyTimeChanged();
          },
          child: Text(
            'AM',
            style: TextStyle(
              fontSize: 18,
              fontWeight: _isAM ? FontWeight.w600 : FontWeight.w400,
              color: _isAM
                  ? AppThemeColors.textPrimary
                  : AppThemeColors.textHint,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() => _isAM = false);
            _notifyTimeChanged();
          },
          child: Text(
            'PM',
            style: TextStyle(
              fontSize: 18,
              fontWeight: !_isAM ? FontWeight.w600 : FontWeight.w400,
              color: !_isAM
                  ? AppThemeColors.textPrimary
                  : AppThemeColors.textHint,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularDial() {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: GestureDetector(
        onPanUpdate: (details) => _handlePanUpdate(details, Size(widget.size, widget.size)),
        child: CustomPaint(
          painter: _CircularDialPainter(
            selectedValue: _selectingHour ? _selectedHour : _selectedMinute,
            isHourMode: _selectingHour,
            primaryColor: AppThemeColors.primary,
            trackColor: AppThemeColors.surfaceLight,
            textColor: AppThemeColors.textPrimary,
            textSecondaryColor: AppThemeColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _CircularDialPainter extends CustomPainter {
  final int selectedValue;
  final bool isHourMode;
  final Color primaryColor;
  final Color trackColor;
  final Color textColor;
  final Color textSecondaryColor;

  _CircularDialPainter({
    required this.selectedValue,
    required this.isHourMode,
    required this.primaryColor,
    required this.trackColor,
    required this.textColor,
    required this.textSecondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;

    // Draw track circle
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius, trackPaint);

    // Calculate angle for selected value
    double selectedAngle;
    if (isHourMode) {
      selectedAngle = (selectedValue / 12) * 2 * math.pi - math.pi / 2;
    } else {
      selectedAngle = (selectedValue / 60) * 2 * math.pi - math.pi / 2;
    }

    // Draw active arc from 12 o'clock to selected position
    final activePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      selectedAngle + math.pi / 2,
      false,
      activePaint,
    );

    // Draw hand line
    final handEnd = Offset(
      center.dx + radius * 0.7 * math.cos(selectedAngle),
      center.dy + radius * 0.7 * math.sin(selectedAngle),
    );

    final handPaint = Paint()
      ..color = textSecondaryColor.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawLine(center, handEnd, handPaint);

    // Draw center dot
    final centerDotPaint = Paint()
      ..color = textSecondaryColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 4, centerDotPaint);

    // Draw selected value indicator on the track
    final indicatorPosition = Offset(
      center.dx + radius * math.cos(selectedAngle),
      center.dy + radius * math.sin(selectedAngle),
    );

    // Draw indicator background
    final indicatorBgPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(indicatorPosition, 24, indicatorBgPaint);

    // Draw indicator text
    final textPainter = TextPainter(
      text: TextSpan(
        text: selectedValue.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        indicatorPosition.dx - textPainter.width / 2,
        indicatorPosition.dy - textPainter.height / 2,
      ),
    );

    // Draw hour/minute markers
    if (isHourMode) {
      _drawHourMarkers(canvas, center, radius);
    } else {
      _drawMinuteMarkers(canvas, center, radius);
    }
  }

  void _drawHourMarkers(Canvas canvas, Offset center, double radius) {
    for (int i = 0; i < 12; i++) {
      final hour = i == 0 ? 12 : i;
      if (hour == selectedValue) continue; // Skip selected hour

      final angle = (i / 12) * 2 * math.pi - math.pi / 2;
      final position = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: hour.toString(),
          style: TextStyle(
            color: textSecondaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          position.dx - textPainter.width / 2,
          position.dy - textPainter.height / 2,
        ),
      );
    }
  }

  void _drawMinuteMarkers(Canvas canvas, Offset center, double radius) {
    for (int i = 0; i < 12; i++) {
      final minute = i * 5;
      if (minute == selectedValue) continue;

      final angle = (i / 12) * 2 * math.pi - math.pi / 2;
      final position = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: minute.toString().padLeft(2, '0'),
          style: TextStyle(
            color: textSecondaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          position.dx - textPainter.width / 2,
          position.dy - textPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CircularDialPainter oldDelegate) {
    return oldDelegate.selectedValue != selectedValue ||
           oldDelegate.isHourMode != isHourMode;
  }
}

