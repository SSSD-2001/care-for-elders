import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// A styled medication card matching the reference design
class MedicationCard extends StatelessWidget {
  final String name;
  final String dosage;
  final String quantity;
  final String instruction;
  final String time;
  final String? category;
  final bool isTaken;
  final VoidCallback? onTap;
  final VoidCallback? onTakenPressed;

  const MedicationCard({
    Key? key,
    required this.name,
    required this.dosage,
    this.quantity = '1 Pill',
    this.instruction = 'Before Meals',
    this.time = '9AM',
    this.category,
    this.isTaken = false,
    this.onTap,
    this.onTakenPressed,
  }) : super(key: key);

  Color get _categoryColor {
    switch (category?.toLowerCase()) {
      case 'cardiovascular':
        return AppThemeColors.cardiovascular;
      case 'diabetes':
        return AppThemeColors.diabetes;
      case 'pain':
        return AppThemeColors.pain;
      case 'vitamins':
        return AppThemeColors.vitamins;
      case 'antibiotics':
        return AppThemeColors.antibiotics;
      default:
        return AppThemeColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _categoryColor.withOpacity(0.9),
              _categoryColor.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppRadius.largeRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with category and time
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Category badge
                  if (category != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: AppRadius.smallRadius,
                      ),
                      child: Text(
                        category!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  const Spacer(),
                  // Time badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppRadius.smallRadius,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.alarm,
                          size: 14,
                          color: _categoryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          time,
                          style: TextStyle(
                            color: _categoryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Medication details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                children: [
                  // Pill icon
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
                  // Name and dosage
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$name - $dosage',
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
                              quantity,
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
                              instruction,
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
            ),

            const SizedBox(height: AppSpacing.md),

            // Taken button
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: ElevatedButton(
                onPressed: onTakenPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: isTaken ? AppThemeColors.success : _categoryColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.mediumRadius,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isTaken ? Icons.check_circle : Icons.check_circle_outline,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isTaken ? 'Taken' : 'Mark as Taken',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

/// Time period header (Morning, Afternoon, Evening, Night)
class TimePeriodHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const TimePeriodHeader({
    Key? key,
    required this.title,
    this.icon = Icons.wb_sunny_outlined,
  }) : super(key: key);

  static IconData getIconForPeriod(String period) {
    switch (period.toLowerCase()) {
      case 'morning':
        return Icons.wb_sunny_outlined;
      case 'afternoon':
        return Icons.wb_sunny;
      case 'evening':
        return Icons.nights_stay_outlined;
      case 'night':
        return Icons.nightlight_round;
      default:
        return Icons.schedule;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppThemeColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            icon,
            size: 18,
            color: AppThemeColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

/// Calendar day widget for the pills screen
class CalendarDayWidget extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final bool hasMedications;
  final VoidCallback? onTap;

  const CalendarDayWidget({
    Key? key,
    required this.date,
    this.isSelected = false,
    this.isToday = false,
    this.hasMedications = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected
              ? AppThemeColors.primary
              : isToday
                  ? AppThemeColors.primary.withOpacity(0.2)
                  : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle(
              color: isSelected || isToday
                  ? Colors.white
                  : date.weekday == 6 || date.weekday == 7
                      ? AppThemeColors.textHint
                      : AppThemeColors.textPrimary,
              fontSize: 14,
              fontWeight: isSelected || isToday ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

/// Medication type selector chip
class MedicationTypeChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;

  const MedicationTypeChip({
    Key? key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppThemeColors.primary : AppThemeColors.surfaceLight,
          borderRadius: AppRadius.mediumRadius,
          border: isSelected
              ? null
              : Border.all(
                  color: AppThemeColors.textHint.withOpacity(0.3),
                  width: 1,
                ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppThemeColors.textSecondary,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppThemeColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Frequency pill counter widget
class FrequencyPillCounter extends StatelessWidget {
  final int count;
  final int maxCount;
  final ValueChanged<int>? onChanged;

  const FrequencyPillCounter({
    Key? key,
    required this.count,
    this.maxCount = 5,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxCount, (index) {
        final isActive = index < count;
        final isSelected = index == count - 1;
        return GestureDetector(
          onTap: () => onChanged?.call(index + 1),
          child: Container(
            width: 36,
            height: 36,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppThemeColors.primary
                  : isActive
                      ? AppThemeColors.primary.withOpacity(0.3)
                      : AppThemeColors.surfaceLight,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isSelected
                  ? Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : isActive
                      ? Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppThemeColors.primary,
                            shape: BoxShape.circle,
                          ),
                        )
                      : Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppThemeColors.textHint.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
            ),
          ),
        );
      }),
    );
  }
}

/// Custom styled text field for the medication forms
class StyledTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool isValid;

  const StyledTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.isValid = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        color: AppThemeColors.textPrimary,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: AppThemeColors.textHint,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onSuffixTap,
                child: Icon(
                  suffixIcon,
                  color: isValid ? AppThemeColors.success : AppThemeColors.textHint,
                ),
              )
            : isValid
                ? const Icon(
                    Icons.check_circle,
                    color: AppThemeColors.success,
                  )
                : null,
      ),
    );
  }
}

/// Meal timing toggle (Before meals / After meals)
class MealTimingToggle extends StatelessWidget {
  final bool isBeforeMeals;
  final ValueChanged<bool>? onChanged;

  const MealTimingToggle({
    Key? key,
    this.isBeforeMeals = true,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildOption(
          label: 'Before meals',
          isSelected: isBeforeMeals,
          onTap: () => onChanged?.call(true),
        ),
        const SizedBox(width: AppSpacing.sm),
        _buildOption(
          label: 'After meals',
          isSelected: !isBeforeMeals,
          onTap: () => onChanged?.call(false),
        ),
        const Spacer(),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppThemeColors.surfaceLight,
            borderRadius: AppRadius.smallRadius,
          ),
          child: const Icon(
            Icons.add,
            color: AppThemeColors.textSecondary,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppThemeColors.primary : AppThemeColors.textHint,
                width: isSelected ? 5 : 2,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppThemeColors.textPrimary : AppThemeColors.textSecondary,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

/// Progress bar for medication adherence
class MedicationProgressBar extends StatelessWidget {
  final double progress;
  final Color? progressColor;
  final Color? backgroundColor;
  final double height;

  const MedicationProgressBar({
    Key? key,
    required this.progress,
    this.progressColor,
    this.backgroundColor,
    this.height = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppThemeColors.surfaceLight,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Progress indicator
              Container(
                width: constraints.maxWidth * progress.clamp(0.0, 1.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      progressColor ?? AppThemeColors.primary,
                      (progressColor ?? AppThemeColors.primary).withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(height / 2),
                ),
              ),
              // Danger zone (last portion in red)
              if (progress > 0.7)
                Positioned(
                  right: 0,
                  child: Container(
                    width: constraints.maxWidth * 0.15,
                    height: height,
                    decoration: BoxDecoration(
                      color: AppThemeColors.error.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(height / 2),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

