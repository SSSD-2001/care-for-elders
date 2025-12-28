import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/medication/circular_time_picker.dart';

/// Reminder screen with circular time picker
class MedicationReminderScreen extends StatefulWidget {
  final String medicationName;
  final String medicationDosage;
  final String quantity;
  final String instruction;
  final TimeOfDay? initialTime;

  const MedicationReminderScreen({
    Key? key,
    required this.medicationName,
    required this.medicationDosage,
    this.quantity = '1 Pill',
    this.instruction = 'Before Meals',
    this.initialTime,
  }) : super(key: key);

  @override
  State<MedicationReminderScreen> createState() => _MedicationReminderScreenState();
}

class _MedicationReminderScreenState extends State<MedicationReminderScreen> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime ?? const TimeOfDay(hour: 9, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: [
                      const SizedBox(height: AppSpacing.md),
                      _buildMedicationCard(),
                      const SizedBox(height: AppSpacing.xl),
                      _buildTimeSectionHeader(),
                      const SizedBox(height: AppSpacing.lg),
                      _buildCircularTimePicker(),
                    ],
                  ),
                ),
              ),
            ),
            _buildSetReminderButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppThemeColors.surfaceLight,
                borderRadius: AppRadius.mediumRadius,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppThemeColors.textPrimary,
                size: 22,
              ),
            ),
          ),
          Text(
            'Reminder',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppThemeColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppThemeColors.surfaceLight,
                borderRadius: AppRadius.mediumRadius,
              ),
              child: const Icon(
                Icons.close,
                color: AppThemeColors.textPrimary,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppThemeColors.primary.withOpacity(0.9),
            AppThemeColors.primary.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppRadius.largeRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time period header
          Row(
            children: [
              Text(
                'Morning',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.wb_sunny_outlined,
                size: 16,
                color: Colors.white.withOpacity(0.8),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Medication info
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: AppRadius.mediumRadius,
                ),
                child: const Icon(
                  Icons.medication_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.medicationName} - ${widget.medicationDosage}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.grain_rounded,
                          size: 14,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.quantity,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        const Icon(
                          Icons.restaurant_rounded,
                          size: 14,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.instruction,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSectionHeader() {
    return Text(
      'Select time',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppThemeColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildCircularTimePicker() {
    return CircularTimePicker(
      initialTime: _selectedTime,
      onTimeChanged: (time) {
        setState(() {
          _selectedTime = time;
        });
      },
    );
  }

  Widget _buildSetReminderButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: ElevatedButton(
        onPressed: _setReminder,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppThemeColors.background,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.xlRadius,
          ),
        ),
        child: const Text(
          'Set Reminder',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _setReminder() {
    // TODO: Implement reminder setting logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Reminder set for ${_selectedTime.format(context)}',
        ),
        backgroundColor: AppThemeColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mediumRadius,
        ),
      ),
    );
    Navigator.of(context).pop();
  }
}

