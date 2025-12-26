import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';
import '../profile/profile_screen.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.person_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(AppStyles.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: AppStyles.bodyText1.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.name ?? 'User',
                    style: AppStyles.headline2.copyWith(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hope you\'re feeling well today!',
                    style: AppStyles.bodyText2.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppStyles.paddingMedium,
              ),
              child: Text(
                'Quick Actions',
                style: AppStyles.headline3,
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppStyles.paddingMedium,
              ),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.3,
                children: [
                  _buildQuickActionCard(
                    context,
                    'Schedule Appointment',
                    Icons.calendar_today,
                    AppColors.appointmentColor,
                    () {
                      // TODO: Navigate to appointment booking
                    },
                  ),
                  _buildQuickActionCard(
                    context,
                    'Track Vitals',
                    Icons.favorite,
                    AppColors.vitalsColor,
                    () {
                      // TODO: Navigate to vitals tracking
                    },
                  ),
                  _buildQuickActionCard(
                    context,
                    'Medication Reminder',
                    Icons.medication,
                    AppColors.medicationColor,
                    () {
                      // TODO: Navigate to medications
                    },
                  ),
                  _buildQuickActionCard(
                    context,
                    'Emergency SOS',
                    Icons.emergency,
                    AppColors.emergencyColor,
                    () {
                      // TODO: Trigger emergency
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Today's Overview
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppStyles.paddingMedium,
              ),
              child: Text(
                'Today\'s Overview',
                style: AppStyles.headline3,
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppStyles.paddingMedium,
              ),
              child: Column(
                children: [
                  _buildOverviewCard(
                    context,
                    'Upcoming Appointments',
                    '2 appointments today',
                    Icons.calendar_today,
                    AppColors.appointmentColor,
                  ),
                  const SizedBox(height: 12),
                  _buildOverviewCard(
                    context,
                    'Medication Schedule',
                    '3 medications pending',
                    Icons.medication,
                    AppColors.medicationColor,
                  ),
                  const SizedBox(height: 12),
                  _buildOverviewCard(
                    context,
                    'Health Goals',
                    '5 out of 10 steps completed',
                    Icons.track_changes,
                    AppColors.activityColor,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Health Tips
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppStyles.paddingMedium,
              ),
              child: Text(
                'Health Tips',
                style: AppStyles.headline3,
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppStyles.paddingMedium,
              ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: AppStyles.cardBorderRadius,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppStyles.paddingMedium),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outlined,
                        color: AppColors.warning,
                        size: 40,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Stay Hydrated',
                              style: AppStyles.headline3.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Drink at least 8 glasses of water daily to maintain good health.',
                              style: AppStyles.bodyText2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.cardBorderRadius,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppStyles.cardBorderRadius,
        child: Padding(
          padding: const EdgeInsets.all(AppStyles.paddingMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: AppStyles.bodyText1.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
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
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: AppStyles.bodyText1.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppStyles.bodyText2,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.textHint,
        ),
        onTap: () {
          // TODO: Navigate to respective screens
        },
      ),
    );
  }
}

