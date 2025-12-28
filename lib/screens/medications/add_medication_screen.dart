import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/medication/medication_widgets.dart';

/// Screen for adding new medication
class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({Key? key}) : super(key: key);

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedType = 'Pill';
  String _frequency = 'Per day';
  int _morningCount = 2;
  int _afternoonCount = 1;
  bool _morningBeforeMeals = true;
  bool _afternoonBeforeMeals = false;
  bool _nameValid = false;

  final List<Map<String, dynamic>> _medicationTypes = [
    {'label': 'Tablet', 'icon': Icons.medication_outlined},
    {'label': 'Pill', 'icon': Icons.medication_rounded},
    {'label': 'Syringe', 'icon': Icons.vaccines_rounded},
    {'label': 'Syrup', 'icon': Icons.local_drink_rounded},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMedicationNameField(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildMedicationTypeSelector(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildFrequencySection(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildTimingSection('Morning', Icons.wb_sunny_outlined,
                      _morningCount, _morningBeforeMeals,
                      (count) => setState(() => _morningCount = count),
                      (before) => setState(() => _morningBeforeMeals = before),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _buildTimingSection('Afternoon', Icons.wb_sunny,
                      _afternoonCount, _afternoonBeforeMeals,
                      (count) => setState(() => _afternoonCount = count),
                      (before) => setState(() => _afternoonBeforeMeals = before),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
            _buildAddButton(),
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
            'Add medication',
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

  Widget _buildMedicationNameField() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppThemeColors.surfaceLight,
        borderRadius: AppRadius.mediumRadius,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _nameController,
              style: const TextStyle(
                color: AppThemeColors.textPrimary,
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                hintText: 'Medication name (e.g., Amlodipine - 5mg)',
                hintStyle: TextStyle(
                  color: AppThemeColors.textHint,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) {
                setState(() {
                  _nameValid = value.trim().length >= 3;
                });
              },
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: _nameValid ? AppThemeColors.success : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: _nameValid
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  )
                : null,
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppThemeColors.surface,
              borderRadius: AppRadius.smallRadius,
            ),
            child: const Icon(
              Icons.qr_code_scanner_rounded,
              color: AppThemeColors.textSecondary,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationTypeSelector() {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _medicationTypes.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final type = _medicationTypes[index];
          final isSelected = _selectedType == type['label'];
          return MedicationTypeChip(
            label: type['label'],
            icon: type['icon'],
            isSelected: isSelected,
            onTap: () {
              setState(() {
                _selectedType = type['label'];
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildFrequencySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pills Frequency',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppThemeColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Set how many pills should take',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppThemeColors.textSecondary,
                  ),
                ),
              ],
            ),
            _buildFrequencyDropdown(),
          ],
        ),
      ],
    );
  }

  Widget _buildFrequencyDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppThemeColors.surfaceLight,
        borderRadius: AppRadius.mediumRadius,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _frequency,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppThemeColors.textSecondary,
          ),
          dropdownColor: AppThemeColors.surface,
          style: const TextStyle(
            color: AppThemeColors.textPrimary,
            fontSize: 14,
          ),
          items: ['Per day', 'Per week', 'As needed']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _frequency = value;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildTimingSection(
    String period,
    IconData icon,
    int count,
    bool beforeMeals,
    ValueChanged<int> onCountChanged,
    ValueChanged<bool> onMealTimingChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppThemeColors.surface,
        borderRadius: AppRadius.largeRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period header
          Row(
            children: [
              Text(
                period,
                style: TextStyle(
                  color: period == 'Morning'
                      ? AppThemeColors.warning
                      : AppThemeColors.info,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                icon,
                size: 18,
                color: period == 'Morning'
                    ? AppThemeColors.warning
                    : AppThemeColors.info,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Pill counter
          FrequencyPillCounter(
            count: count,
            onChanged: onCountChanged,
          ),
          const SizedBox(height: AppSpacing.md),

          // Meal timing toggle
          MealTimingToggle(
            isBeforeMeals: beforeMeals,
            onChanged: onMealTimingChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: ElevatedButton(
        onPressed: _addMedication,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppThemeColors.background,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.xlRadius,
          ),
        ),
        child: const Text(
          'Add to Pill list',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _addMedication() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter medication name'),
          backgroundColor: AppThemeColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.mediumRadius,
          ),
        ),
      );
      return;
    }

    // TODO: Save medication to database
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_nameController.text} added to your pill list'),
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

