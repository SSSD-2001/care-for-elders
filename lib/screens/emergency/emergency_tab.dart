import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_constants.dart';

class EmergencyTab extends StatelessWidget {
  const EmergencyTab({Key? key}) : super(key: key);

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  void _triggerSOS(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: AppColors.error),
            const SizedBox(width: 8),
            Text('Emergency SOS'),
          ],
        ),
        content: Text(
          'This will immediately notify all your emergency contacts and dial emergency services. Do you want to proceed?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Trigger emergency notifications
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Emergency SOS activated! Notifying contacts...'),
                  backgroundColor: AppColors.error,
                  duration: Duration(seconds: 3),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: Text('Activate SOS'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency'),
        backgroundColor: AppColors.emergencyColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppStyles.paddingMedium),
        children: [
          // SOS Button
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.error, Colors.red.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: AppStyles.cardBorderRadius,
              boxShadow: AppStyles.cardShadow,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _triggerSOS(context),
                borderRadius: AppStyles.cardBorderRadius,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.emergency,
                        size: 80,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'EMERGENCY SOS',
                        style: AppStyles.headline2.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to alert emergency contacts',
                        style: AppStyles.bodyText1.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'Emergency Services',
            style: AppStyles.headline3,
          ),
          const SizedBox(height: 16),

          _buildEmergencyServiceCard(
            context,
            'Ambulance',
            '911',
            Icons.local_hospital,
            AppColors.error,
          ),
          const SizedBox(height: 12),
          _buildEmergencyServiceCard(
            context,
            'Police',
            '911',
            Icons.local_police,
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildEmergencyServiceCard(
            context,
            'Fire Department',
            '911',
            Icons.local_fire_department,
            Colors.orange,
          ),

          const SizedBox(height: 24),
          Text(
            'Emergency Contacts',
            style: AppStyles.headline3,
          ),
          const SizedBox(height: 16),

          _buildEmergencyContactCard(
            context,
            'Alice Johnson',
            'Daughter',
            '+1 234 567 8900',
            true,
          ),
          const SizedBox(height: 12),
          _buildEmergencyContactCard(
            context,
            'Bob Smith',
            'Son',
            '+1 234 567 8901',
            false,
          ),
          const SizedBox(height: 12),
          _buildEmergencyContactCard(
            context,
            'Dr. Sarah Wilson',
            'Primary Care Doctor',
            '+1 234 567 8902',
            false,
          ),

          const SizedBox(height: 24),
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
            child: Padding(
              padding: const EdgeInsets.all(AppStyles.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Blood Type', 'O+'),
                  Divider(),
                  _buildInfoRow('Allergies', 'Penicillin'),
                  Divider(),
                  _buildInfoRow('Current Medications', 'Aspirin, Metformin'),
                  Divider(),
                  _buildInfoRow('Medical Conditions', 'Diabetes Type 2'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyServiceCard(
    BuildContext context,
    String name,
    String phone,
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
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(
          name,
          style: AppStyles.bodyText1.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          phone,
          style: AppStyles.headline3.copyWith(
            fontSize: 18,
            color: color,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.phone, color: color),
          onPressed: () => _makePhoneCall(phone),
        ),
        onTap: () => _makePhoneCall(phone),
      ),
    );
  }

  Widget _buildEmergencyContactCard(
    BuildContext context,
    String name,
    String relationship,
    String phone,
    bool isPrimary,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.cardBorderRadius,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Icon(Icons.person, color: AppColors.primary),
        ),
        title: Row(
          children: [
            Text(
              name,
              style: AppStyles.bodyText1.copyWith(fontWeight: FontWeight.w600),
            ),
            if (isPrimary) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Primary',
                  style: AppStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(relationship, style: AppStyles.bodyText2),
            Text(phone, style: AppStyles.caption),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.phone, color: AppColors.primary),
          onPressed: () => _makePhoneCall(phone),
        ),
        onTap: () => _makePhoneCall(phone),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppStyles.bodyText2,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppStyles.bodyText1.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

