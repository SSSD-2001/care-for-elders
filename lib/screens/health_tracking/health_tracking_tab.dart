import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class HealthTrackingTab extends StatelessWidget {
  const HealthTrackingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tracking'),
        backgroundColor: AppColors.vitalsColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppStyles.paddingMedium),
        children: [
          Text(
            'Vital Signs',
            style: AppStyles.headline3,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildVitalCard(
                  context,
                  'Blood Pressure',
                  '120/80',
                  'mmHg',
                  Icons.favorite,
                  AppColors.vitalsColor,
                  'Normal',
                  true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildVitalCard(
                  context,
                  'Heart Rate',
                  '72',
                  'bpm',
                  Icons.monitor_heart,
                  AppColors.error,
                  'Normal',
                  true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildVitalCard(
                  context,
                  'Blood Sugar',
                  '95',
                  'mg/dL',
                  Icons.water_drop,
                  AppColors.warning,
                  'Normal',
                  true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildVitalCard(
                  context,
                  'Temperature',
                  '98.6',
                  '°F',
                  Icons.thermostat,
                  AppColors.info,
                  'Normal',
                  true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Activity Log',
            style: AppStyles.headline3,
          ),
          const SizedBox(height: 16),
          _buildActivityCard(
            context,
            'Walking',
            '30 minutes',
            'Today at 8:00 AM',
            Icons.directions_walk,
          ),
          const SizedBox(height: 12),
          _buildActivityCard(
            context,
            'Yoga',
            '15 minutes',
            'Today at 6:30 AM',
            Icons.self_improvement,
          ),
          const SizedBox(height: 24),
          Text(
            'Wellness Goals',
            style: AppStyles.headline3,
          ),
          const SizedBox(height: 16),
          _buildGoalCard(
            context,
            'Walk 10,000 steps daily',
            7500,
            10000,
            Icons.directions_walk,
          ),
          const SizedBox(height: 12),
          _buildGoalCard(
            context,
            'Drink 8 glasses of water',
            5,
            8,
            Icons.water_drop,
          ),
          const SizedBox(height: 12),
          _buildGoalCard(
            context,
            'Sleep 8 hours',
            6.5,
            8,
            Icons.bedtime,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new vital sign or activity
        },
        backgroundColor: AppColors.vitalsColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildVitalCard(
    BuildContext context,
    String title,
    String value,
    String unit,
    IconData icon,
    Color color,
    String status,
    bool isNormal,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.cardBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppStyles.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(
              title,
              style: AppStyles.bodyText2,
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: AppStyles.headline2.copyWith(fontSize: 20),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    unit,
                    style: AppStyles.caption,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isNormal
                    ? AppColors.success.withOpacity(0.1)
                    : AppColors.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                status,
                style: AppStyles.caption.copyWith(
                  color: isNormal ? AppColors.success : AppColors.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(
    BuildContext context,
    String name,
    String duration,
    String time,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.cardBorderRadius,
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.activityColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.activityColor),
        ),
        title: Text(
          name,
          style: AppStyles.bodyText1.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(duration, style: AppStyles.bodyText2),
            Text(time, style: AppStyles.caption),
          ],
        ),
        trailing: Icon(Icons.chevron_right, color: AppColors.textHint),
        onTap: () {
          // TODO: View activity details
        },
      ),
    );
  }

  Widget _buildGoalCard(
    BuildContext context,
    String goal,
    double current,
    double target,
    IconData icon,
  ) {
    final progress = current / target;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.cardBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppStyles.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.activityColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    goal,
                    style: AppStyles.bodyText1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${current.toStringAsFixed(current % 1 == 0 ? 0 : 1)} / $target',
                  style: AppStyles.bodyText2,
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: AppStyles.bodyText2.copyWith(
                    color: AppColors.activityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.activityColor.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.activityColor,
                ),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

