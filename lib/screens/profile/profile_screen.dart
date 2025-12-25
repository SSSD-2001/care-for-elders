import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
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
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppStyles.paddingMedium),
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user?.name ?? 'User',
                  style: AppStyles.headline2,
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? '',
                  style: AppStyles.bodyText2,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user?.role ?? 'Elder',
                    style: AppStyles.bodyText2.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Personal Information
          Text(
            'Personal Information',
            style: AppStyles.headline3,
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: AppStyles.cardBorderRadius,
            ),
            child: Column(
              children: [
                _buildProfileItem(
                  Icons.phone,
                  'Phone',
                  user?.phoneNumber ?? 'Not set',
                ),
                Divider(height: 1),
                _buildProfileItem(
                  Icons.location_on,
                  'Address',
                  user?.address ?? 'Not set',
                ),
                Divider(height: 1),
                _buildProfileItem(
                  Icons.water_drop,
                  'Blood Type',
                  user?.bloodType ?? 'Not set',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Medical Information
          Text(
            'Medical Information',
            style: AppStyles.headline3,
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: AppStyles.cardBorderRadius,
            ),
            child: Column(
              children: [
                _buildProfileItem(
                  Icons.medical_services,
                  'Allergies',
                  user?.allergies.isNotEmpty == true
                      ? user!.allergies.join(', ')
                      : 'None',
                ),
                Divider(height: 1),
                _buildProfileItem(
                  Icons.contact_emergency,
                  'Emergency Contacts',
                  user?.emergencyContacts.isNotEmpty == true
                      ? '${user!.emergencyContacts.length} contacts'
                      : 'None',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Settings
          Text(
            'Settings',
            style: AppStyles.headline3,
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: AppStyles.cardBorderRadius,
            ),
            child: Column(
              children: [
                _buildSettingsItem(
                  context,
                  Icons.edit,
                  'Edit Profile',
                  () {
                    // TODO: Navigate to edit profile
                  },
                ),
                Divider(height: 1),
                _buildSettingsItem(
                  context,
                  Icons.notifications,
                  'Notification Settings',
                  () {
                    // TODO: Navigate to notification settings
                  },
                ),
                Divider(height: 1),
                _buildSettingsItem(
                  context,
                  Icons.security,
                  'Privacy & Security',
                  () {
                    // TODO: Navigate to privacy settings
                  },
                ),
                Divider(height: 1),
                _buildSettingsItem(
                  context,
                  Icons.help,
                  'Help & Support',
                  () {
                    // TODO: Navigate to help
                  },
                ),
                Divider(height: 1),
                _buildSettingsItem(
                  context,
                  Icons.info,
                  'About',
                  () {
                    showAboutDialog(
                      context: context,
                      applicationName: AppConstants.appName,
                      applicationVersion: AppConstants.appVersion,
                      applicationIcon: Icon(
                        Icons.favorite_rounded,
                        color: AppColors.primary,
                        size: 48,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Logout Button
          ElevatedButton(
            onPressed: () => _handleLogout(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: AppStyles.buttonBorderRadius,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout),
                const SizedBox(width: 8),
                Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        label,
        style: AppStyles.bodyText2,
      ),
      subtitle: Text(
        value,
        style: AppStyles.bodyText1.copyWith(fontWeight: FontWeight.w600),
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
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: AppStyles.bodyText1,
      ),
      trailing: Icon(Icons.chevron_right, color: AppColors.textHint),
      onTap: onTap,
    );
  }
}

