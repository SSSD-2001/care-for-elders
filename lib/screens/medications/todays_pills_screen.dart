import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../widgets/medication/medication_widgets.dart';
import 'add_medication_screen.dart';
import 'medication_reminder_screen.dart';

/// Main medications screen showing today's pills with calendar
class TodaysPillsScreen extends StatefulWidget {
  const TodaysPillsScreen({Key? key}) : super(key: key);

  @override
  State<TodaysPillsScreen> createState() => _TodaysPillsScreenState();
}

class _TodaysPillsScreenState extends State<TodaysPillsScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedMonth = DateTime.now();

  // Sample medication data
  final List<Map<String, dynamic>> _morningMedications = [
    {
      'name': 'Amlodipine',
      'dosage': '5mg',
      'quantity': '1 Pill',
      'instruction': 'Before Meals',
      'time': '9AM',
      'category': 'Cardiovascular',
      'isTaken': true,
    },
  ];

  final List<Map<String, dynamic>> _afternoonMedications = [
    {
      'name': 'Metformin',
      'dosage': '500mg',
      'quantity': '1 Pill',
      'instruction': 'After Meals',
      'time': '2PM',
      'category': 'Diabetes',
      'isTaken': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMedicationsList(),
                    const SizedBox(height: AppSpacing.md),
                    _buildProgressBar(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildCalendar(),
                  ],
                ),
              ),
            ),
            _buildBottomNavigation(),
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
          Text(
            "Today's Pills",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppThemeColors.textPrimary,
            ),
          ),
          Row(
            children: [
              _buildIconButton(
                Icons.filter_list_rounded,
                onTap: () {
                  // TODO: Filter medications
                },
              ),
              const SizedBox(width: AppSpacing.sm),
              _buildIconButton(
                Icons.add,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddMedicationScreen(),
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

  Widget _buildIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppThemeColors.surfaceLight,
          borderRadius: AppRadius.mediumRadius,
        ),
        child: Icon(
          icon,
          color: AppThemeColors.textPrimary,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildMedicationsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Morning medications
          if (_morningMedications.isNotEmpty) ...[
            TimePeriodHeader(
              title: 'Morning',
              icon: TimePeriodHeader.getIconForPeriod('morning'),
            ),
            ..._morningMedications.map((med) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: MedicationCard(
                name: med['name'],
                dosage: med['dosage'],
                quantity: med['quantity'],
                instruction: med['instruction'],
                time: med['time'],
                category: med['category'],
                isTaken: med['isTaken'],
                onTap: () => _openReminderScreen(med),
                onTakenPressed: () => _toggleTaken(med),
              ),
            )),
          ],

          // Afternoon medications
          if (_afternoonMedications.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            TimePeriodHeader(
              title: 'Afternoon',
              icon: TimePeriodHeader.getIconForPeriod('afternoon'),
            ),
            ..._afternoonMedications.map((med) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: MedicationCard(
                name: med['name'],
                dosage: med['dosage'],
                quantity: med['quantity'],
                instruction: med['instruction'],
                time: med['time'],
                category: med['category'],
                isTaken: med['isTaken'],
                onTap: () => _openReminderScreen(med),
                onTakenPressed: () => _toggleTaken(med),
              ),
            )),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final totalMeds = _morningMedications.length + _afternoonMedications.length;
    final takenMeds = _morningMedications.where((m) => m['isTaken'] == true).length +
        _afternoonMedications.where((m) => m['isTaken'] == true).length;
    final progress = totalMeds > 0 ? takenMeds / totalMeds : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: MedicationProgressBar(
        progress: progress,
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppThemeColors.surface,
        borderRadius: AppRadius.largeRadius,
      ),
      child: Column(
        children: [
          _buildCalendarHeader(),
          const SizedBox(height: AppSpacing.md),
          _buildWeekDaysHeader(),
          const SizedBox(height: AppSpacing.sm),
          _buildCalendarDays(),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    final monthYear = DateFormat('MMMM yyyy').format(_focusedMonth);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 18,
              color: AppThemeColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              monthYear,
              style: const TextStyle(
                color: AppThemeColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _focusedMonth = DateTime(
                    _focusedMonth.year,
                    _focusedMonth.month - 1,
                  );
                });
              },
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                child: const Icon(
                  Icons.chevron_left,
                  color: AppThemeColors.textSecondary,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _focusedMonth = DateTime(
                    _focusedMonth.year,
                    _focusedMonth.month + 1,
                  );
                });
              },
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                child: const Icon(
                  Icons.chevron_right,
                  color: AppThemeColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeekDaysHeader() {
    const weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekDays.map((day) => SizedBox(
        width: 40,
        child: Text(
          day,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppThemeColors.textHint,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildCalendarDays() {
    final firstDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final lastDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0);

    // Get the weekday of the first day (1 = Monday, 7 = Sunday)
    int startWeekday = firstDayOfMonth.weekday;

    // Days from previous month
    final prevMonthDays = startWeekday - 1;
    final prevMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 0);

    List<Widget> dayWidgets = [];

    // Previous month days
    for (int i = prevMonthDays - 1; i >= 0; i--) {
      final day = prevMonth.day - i;
      dayWidgets.add(_buildDayCell(
        DateTime(prevMonth.year, prevMonth.month, day),
        isCurrentMonth: false,
      ));
    }

    // Current month days
    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      final date = DateTime(_focusedMonth.year, _focusedMonth.month, i);
      dayWidgets.add(_buildDayCell(date, isCurrentMonth: true));
    }

    // Next month days to fill the grid
    final remainingCells = 42 - dayWidgets.length; // 6 rows x 7 days
    for (int i = 1; i <= remainingCells && dayWidgets.length < 42; i++) {
      dayWidgets.add(_buildDayCell(
        DateTime(_focusedMonth.year, _focusedMonth.month + 1, i),
        isCurrentMonth: false,
      ));
    }

    // Build grid rows
    List<Widget> rows = [];
    for (int i = 0; i < dayWidgets.length; i += 7) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: dayWidgets.sublist(i, i + 7 > dayWidgets.length ? dayWidgets.length : i + 7),
          ),
        ),
      );
      if (rows.length >= 6) break;
    }

    return Column(children: rows);
  }

  Widget _buildDayCell(DateTime date, {bool isCurrentMonth = true}) {
    final now = DateTime.now();
    final isToday = date.year == now.year &&
                    date.month == now.month &&
                    date.day == now.day;
    final isSelected = date.year == _selectedDate.year &&
                       date.month == _selectedDate.month &&
                       date.day == _selectedDate.day;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = date;
        });
      },
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
              color: isSelected
                  ? Colors.white
                  : isCurrentMonth
                      ? AppThemeColors.textPrimary
                      : AppThemeColors.textHint.withOpacity(0.5),
              fontSize: 14,
              fontWeight: isSelected || isToday ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppThemeColors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, isSelected: false),
          _buildNavItem(Icons.link_rounded, isSelected: true),
          _buildNavItem(Icons.grid_view_rounded, isSelected: false),
          _buildNavItem(Icons.person_outline_rounded, isSelected: false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isSelected ? AppThemeColors.surfaceLight : Colors.transparent,
        borderRadius: AppRadius.mediumRadius,
      ),
      child: Icon(
        icon,
        color: isSelected ? AppThemeColors.textPrimary : AppThemeColors.textHint,
        size: 24,
      ),
    );
  }

  void _openReminderScreen(Map<String, dynamic> medication) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MedicationReminderScreen(
          medicationName: medication['name'],
          medicationDosage: medication['dosage'],
          quantity: medication['quantity'],
          instruction: medication['instruction'],
        ),
      ),
    );
  }

  void _toggleTaken(Map<String, dynamic> medication) {
    setState(() {
      medication['isTaken'] = !(medication['isTaken'] ?? false);
    });
  }
}

