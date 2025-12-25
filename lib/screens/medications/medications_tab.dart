import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class MedicationsTab extends StatelessWidget {
  const MedicationsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medications'),
        backgroundColor: AppColors.medicationColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // TODO: Add new medication
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppStyles.paddingMedium),
        children: [
          Text(
            'Today\'s Schedule',
            style: AppStyles.headline3,
          ),
          const SizedBox(height: 16),
          _buildMedicationCard(
            context,
            'Aspirin',
            '100mg',
            'Morning - 8:00 AM',
            'Take after breakfast',
            true,
          ),
          const SizedBox(height: 12),
          _buildMedicationCard(
            context,
            'Metformin',
            '500mg',
            'Afternoon - 2:00 PM',
            'Take with lunch',
            false,
          ),
          const SizedBox(height: 12),
          _buildMedicationCard(
            context,
            'Lisinopril',
            '10mg',
            'Evening - 8:00 PM',
            'Take before dinner',
            false,
          ),
          const SizedBox(height: 24),
          Text(
            'All Medications',
            style: AppStyles.headline3,
          ),
          const SizedBox(height: 16),
          _buildMedicationListItem(
            context,
            'Aspirin',
            '100mg - Once daily',
            5,
          ),
          const SizedBox(height: 8),
          _buildMedicationListItem(
            context,
            'Metformin',
            '500mg - Twice daily',
            12,
          ),
          const SizedBox(height: 8),
          _buildMedicationListItem(
            context,
            'Lisinopril',
            '10mg - Once daily',
            3,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new medication
        },
        backgroundColor: AppColors.medicationColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildMedicationCard(
    BuildContext context,
    String name,
    String dosage,
    String time,
    String instructions,
    bool isTaken,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.cardBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppStyles.paddingMedium),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isTaken
                    ? AppColors.success.withOpacity(0.1)
                    : AppColors.medicationColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.medication,
                color: isTaken ? AppColors.success : AppColors.medicationColor,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppStyles.headline3.copyWith(fontSize: 16),
                  ),
                  Text(
                    dosage,
                    style: AppStyles.bodyText2,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(time, style: AppStyles.caption),
                    ],
                  ),
                  Text(
                    instructions,
                    style: AppStyles.caption,
                  ),
                ],
              ),
            ),
            Checkbox(
              value: isTaken,
              onChanged: (value) {
                // TODO: Mark as taken
              },
              activeColor: AppColors.success,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicationListItem(
    BuildContext context,
    String name,
    String dosage,
    int remainingDays,
  ) {
    final needsRefill = remainingDays <= 7;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.cardBorderRadius,
      ),
      child: ListTile(
        leading: Icon(
          Icons.medication,
          color: AppColors.medicationColor,
        ),
        title: Text(
          name,
          style: AppStyles.bodyText1.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dosage, style: AppStyles.bodyText2),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  needsRefill ? Icons.warning : Icons.check_circle,
                  size: 14,
                  color: needsRefill ? AppColors.warning : AppColors.success,
                ),
                const SizedBox(width: 4),
                Text(
                  '$remainingDays days remaining',
                  style: AppStyles.caption.copyWith(
                    color: needsRefill ? AppColors.warning : AppColors.success,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.chevron_right, color: AppColors.textHint),
        onTap: () {
          // TODO: View medication details
        },
      ),
    );
  }
}

