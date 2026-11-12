
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Profile',
      subtitle: 'Account information',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
        children: [

          // =====================================================
          // PROFILE HEADER
          // =====================================================

          GlassCard(
            child: Column(
              children: [
                Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppTheme.ocean,
                        AppTheme.cyan,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 44,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  'Saltpan Administrator',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'Operations Manager',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 13),

                const StatusPill(
                  text: 'ACTIVE ACCOUNT',
                  color: AppTheme.success,
                  icon: Icons.check_circle_outline,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // =====================================================
          // PERSONAL INFORMATION
          // =====================================================

          const SectionTitle(
            title: 'Personal Information',
            subtitle: 'Your BrineFlow account details',
          ),

          const SizedBox(height: 10),

          const _ProfileInfo(
            icon: Icons.person_outline_rounded,
            label: 'Full Name',
            value: 'Saltpan Administrator',
          ),

          const _ProfileInfo(
            icon: Icons.mail_outline_rounded,
            label: 'Email Address',
            value: 'admin@brineflow.app',
          ),

          const _ProfileInfo(
            icon: Icons.badge_outlined,
            label: 'Role',
            value: 'Operations Manager',
          ),

          const SizedBox(height: 12),

          // =====================================================
          // FARM INFORMATION
          // =====================================================

          const SectionTitle(
            title: 'Farm Information',
            subtitle: 'Saltpan assigned to this account',
          ),

          const SizedBox(height: 10),

          const _ProfileInfo(
            icon: Icons.agriculture_outlined,
            label: 'Farm',
            value: 'BrineFlow Salt Farm',
          ),

          const _ProfileInfo(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: 'Tamil Nadu, India',
          ),

          const _ProfileInfo(
            icon: Icons.water_drop_outlined,
            label: 'Assigned Ponds',
            value: '3 ponds',
          ),

          const SizedBox(height: 12),

          // =====================================================
          // ACCOUNT INFORMATION
          // =====================================================

          const SectionTitle(
            title: 'Account Information',
            subtitle: 'Account status and access',
          ),

          const SizedBox(height: 10),

          const _ProfileInfo(
            icon: Icons.admin_panel_settings_outlined,
            label: 'Access Level',
            value: 'Administrator',
          ),

          const _ProfileInfo(
            icon: Icons.calendar_today_outlined,
            label: 'Member Since',
            value: '2026',
          ),

          const _ProfileInfo(
            icon: Icons.verified_user_outlined,
            label: 'Account Status',
            value: 'Active',
            valueColor: AppTheme.success,
          ),

          const SizedBox(height: 22),

          // =====================================================
          // EDIT PROFILE
          // =====================================================

          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Profile editing will be available soon.',
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit Profile'),
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: AppTheme.ocean,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // =====================================================
          // LOGOUT
          // =====================================================

          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Logout functionality will be connected later.',
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Log Out'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              foregroundColor: AppTheme.danger,
              side: BorderSide(
                color: AppTheme.danger.withValues(alpha: 0.35),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: Text(
              'BrineFlow • Intelligent Saltpan Management',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// PROFILE INFORMATION CARD
// =============================================================

class _ProfileInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _ProfileInfo({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppTheme.ocean.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppTheme.ocean,
                size: 20,
              ),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: valueColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
      
