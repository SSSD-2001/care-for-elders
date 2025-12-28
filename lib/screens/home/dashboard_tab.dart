import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../profile/profile_screen.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      backgroundColor: AppThemeColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(context, user?.name ?? 'User'),

              const SizedBox(height: AppSpacing.lg),

              // Quick Actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppThemeColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              _buildQuickActionsGrid(context),

              const SizedBox(height: AppSpacing.lg),

              // Today's Overview
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  "Today's Overview",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppThemeColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              _buildOverviewList(context),

              const SizedBox(height: AppSpacing.lg),

              // Health Tips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  'Health Tips',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppThemeColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              _buildHealthTipCard(context),

              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String userName) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppThemeColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppThemeColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Hope you're feeling well today!",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppThemeColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildHeaderIconButton(
                Icons.notifications_outlined,
                onTap: () {
                  // TODO: Navigate to notifications
                },
              ),
              const SizedBox(width: AppSpacing.sm),
              _buildHeaderIconButton(
                Icons.person_outline_rounded,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ProfileScreen()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
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

  Widget _buildQuickActionsGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.3,
        children: [
          _buildQuickActionCard(
            context,
            'Schedule\nAppointment',
            Icons.calendar_month_rounded,
            AppThemeColors.info,
            () {},
          ),
          _buildQuickActionCard(
            context,
            'Track\nVitals',
            Icons.favorite_rounded,
            AppThemeColors.error,
            () {},
          ),
          _buildQuickActionCard(
            context,
            'Medication\nReminder',
            Icons.medication_rounded,
            AppThemeColors.primary,
            () {},
          ),
          _buildQuickActionCard(
            context,
            'Emergency\nSOS',
            Icons.emergency_rounded,
            AppThemeColors.warning,
            () {},
          ),
        ],
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppThemeColors.surface,
          borderRadius: AppRadius.largeRadius,
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: AppRadius.mediumRadius,
              ),
              child: Icon(
                icon,
                size: 28,
                color: color,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppThemeColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        children: [
          _buildOverviewCard(
            context,
            'Upcoming Appointments',
            '2 appointments today',
            Icons.calendar_month_rounded,
            AppThemeColors.info,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildOverviewCard(
            context,
            'Medication Schedule',
            '3 medications pending',
            Icons.medication_rounded,
            AppThemeColors.primary,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildOverviewCard(
            context,
            'Health Goals',
            '5 out of 10 steps completed',
            Icons.track_changes_rounded,
            AppThemeColors.success,
          ),
        ],
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
    return Container(
      decoration: BoxDecoration(
        color: AppThemeColors.surface,
        borderRadius: AppRadius.largeRadius,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: AppRadius.mediumRadius,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppThemeColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppThemeColors.textSecondary,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: AppThemeColors.textHint,
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildHealthTipCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppThemeColors.primary.withOpacity(0.2),
            AppThemeColors.primary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppRadius.largeRadius,
        border: Border.all(
          color: AppThemeColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppThemeColors.warning.withOpacity(0.2),
              borderRadius: AppRadius.mediumRadius,
            ),
            child: const Icon(
              Icons.lightbulb_rounded,
              color: AppThemeColors.warning,
              size: 28,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stay Hydrated',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppThemeColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Drink at least 8 glasses of water daily to maintain good health.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppThemeColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

