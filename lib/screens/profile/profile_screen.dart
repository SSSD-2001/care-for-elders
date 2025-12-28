import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../theme/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppThemeColors.surface,
        title: Text(
          'Logout',
          style: TextStyle(color: AppThemeColors.textPrimary),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: AppThemeColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppThemeColors.error,
              foregroundColor: Colors.white,
            ),
            child: Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.logout();

      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      backgroundColor: AppThemeColors.background,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: AppThemeColors.background,
        foregroundColor: AppThemeColors.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppThemeColors.primary.withOpacity(0.3),
                        AppThemeColors.primaryLight.withOpacity(0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppThemeColors.primary,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 50,
                    color: AppThemeColors.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  user?.name ?? 'User',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppThemeColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppThemeColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppThemeColors.primary.withOpacity(0.2),
                    borderRadius: AppRadius.circularRadius,
                    border: Border.all(
                      color: AppThemeColors.primary.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    user?.role ?? 'Elder',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppThemeColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Personal Information
          Text(
            'Personal Information',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppThemeColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              color: AppThemeColors.surface,
              borderRadius: AppRadius.largeRadius,
            ),
            child: Column(
              children: [
                _buildProfileItem(
                  Icons.phone_rounded,
                  'Phone',
                  user?.phoneNumber ?? 'Not set',
                ),
                Divider(height: 1, color: AppThemeColors.surfaceLight),
                _buildProfileItem(
                  Icons.location_on_rounded,
                  'Address',
                  user?.address ?? 'Not set',
                ),
                Divider(height: 1, color: AppThemeColors.surfaceLight),
                _buildProfileItem(
                  Icons.water_drop_rounded,
                  'Blood Type',
                  user?.bloodType ?? 'Not set',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Medical Information
          Text(
            'Medical Information',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppThemeColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              color: AppThemeColors.surface,
              borderRadius: AppRadius.largeRadius,
            ),
            child: Column(
              children: [
                _buildProfileItem(
                  Icons.medical_services_rounded,
                  'Allergies',
                  user?.allergies.isNotEmpty == true
                      ? user!.allergies.join(', ')
                      : 'None',
                ),
                Divider(height: 1, color: AppThemeColors.surfaceLight),
                _buildProfileItem(
                  Icons.contact_emergency_rounded,
                  'Emergency Contacts',
                  user?.emergencyContacts.isNotEmpty == true
                      ? '${user!.emergencyContacts.length} contacts'
                      : 'None',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Settings
          Text(
            'Settings',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppThemeColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              color: AppThemeColors.surface,
              borderRadius: AppRadius.largeRadius,
            ),
            child: Column(
              children: [
                _buildSettingsItem(
                  context,
                  Icons.edit_rounded,
                  'Edit Profile',
                  () {
                    // TODO: Navigate to edit profile
                  },
                ),
                Divider(height: 1, color: AppThemeColors.surfaceLight),
                _buildSettingsItem(
                  context,
                  Icons.notifications_rounded,
                  'Notification Settings',
                  () {
                    // TODO: Navigate to notification settings
                  },
                ),
                Divider(height: 1, color: AppThemeColors.surfaceLight),
                _buildSettingsItem(
                  context,
                  Icons.security_rounded,
                  'Privacy & Security',
                  () {
                    // TODO: Navigate to privacy settings
                  },
                ),
                Divider(height: 1, color: AppThemeColors.surfaceLight),
                _buildSettingsItem(
                  context,
                  Icons.help_rounded,
                  'Help & Support',
                  () {
                    // TODO: Navigate to help
                  },
                ),
                Divider(height: 1, color: AppThemeColors.surfaceLight),
                _buildSettingsItem(
                  context,
                  Icons.info_rounded,
                  'About',
                  () {
                    showAboutDialog(
                      context: context,
                      applicationName: AppConstants.appName,
                      applicationVersion: AppConstants.appVersion,
                      applicationIcon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppThemeColors.primary.withOpacity(0.2),
                          borderRadius: AppRadius.mediumRadius,
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: AppThemeColors.primary,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Logout Button
          ElevatedButton(
            onPressed: () => _handleLogout(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppThemeColors.error,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.xlRadius,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.logout_rounded),
                SizedBox(width: 8),
                Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppThemeColors.primary.withOpacity(0.15),
          borderRadius: AppRadius.smallRadius,
        ),
        child: Icon(icon, color: AppThemeColors.primary, size: 22),
      ),
      title: Text(
        label,
        style: const TextStyle(
          color: AppThemeColors.textSecondary,
          fontSize: 12,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          color: AppThemeColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppThemeColors.surfaceLight,
          borderRadius: AppRadius.smallRadius,
        ),
        child: Icon(icon, color: AppThemeColors.textSecondary, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppThemeColors.textPrimary,
          fontSize: 14,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppThemeColors.textHint,
      ),
      onTap: onTap,
    );
  }
}

