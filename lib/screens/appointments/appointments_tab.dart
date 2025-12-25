import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class AppointmentsTab extends StatelessWidget {
  const AppointmentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        backgroundColor: AppColors.appointmentColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // TODO: Add new appointment
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppStyles.paddingMedium),
        children: [
          Text(
            'Upcoming Appointments',
            style: AppStyles.headline3,
          ),
          const SizedBox(height: 16),
          _buildAppointmentCard(
            context,
            'Dr. Sarah Johnson',
            'Cardiologist',
            'December 28, 2025 at 10:00 AM',
            'City Hospital',
            'Routine Checkup',
          ),
          const SizedBox(height: 12),
          _buildAppointmentCard(
            context,
            'Dr. Michael Brown',
            'General Physician',
            'December 30, 2025 at 2:30 PM',
            'Health Center',
            'Follow-up Visit',
          ),
          const SizedBox(height: 24),
          Text(
            'Past Appointments',
            style: AppStyles.headline3,
          ),
          const SizedBox(height: 16),
          _buildAppointmentCard(
            context,
            'Dr. Emily Davis',
            'Neurologist',
            'December 20, 2025 at 11:00 AM',
            'Medical Plaza',
            'Consultation',
            isPast: true,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new appointment
        },
        backgroundColor: AppColors.appointmentColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildAppointmentCard(
    BuildContext context,
    String doctorName,
    String specialty,
    String dateTime,
    String location,
    String purpose, {
    bool isPast = false,
  }) {
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
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.appointmentColor.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    color: AppColors.appointmentColor,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctorName,
                        style: AppStyles.headline3.copyWith(fontSize: 16),
                      ),
                      Text(
                        specialty,
                        style: AppStyles.bodyText2,
                      ),
                    ],
                  ),
                ),
                if (!isPast)
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.textHint,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Text(dateTime, style: AppStyles.bodyText2),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Text(location, style: AppStyles.bodyText2),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.medical_services, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Text(purpose, style: AppStyles.bodyText2),
              ],
            ),
            if (!isPast) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Reschedule
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.appointmentColor,
                      ),
                      child: Text('Reschedule'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: View details
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.appointmentColor,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('View Details'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

