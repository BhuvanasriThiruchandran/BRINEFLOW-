
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String temperatureUnit = '°C';
  String updateInterval = '10 seconds';

  bool smartNotifications = true;
  bool autoSync = true;
  bool hapticFeedback = true;

  void _showTemperatureOptions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return _SelectionSheet(
          title: 'Temperature Unit',
          options: const ['°C', '°F'],
          selected: temperatureUnit,
          onSelected: (value) {
            setState(() {
              temperatureUnit = value;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showUpdateOptions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return _SelectionSheet(
          title: 'Data Update Interval',
          options: const [
            '5 seconds',
            '10 seconds',
            '30 seconds',
            '1 minute',
          ],
          selected: updateInterval,
          onSelected: (value) {
            setState(() {
              updateInterval = value;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _resetSettings() {
    setState(() {
      temperatureUnit = '°C';
      updateInterval = '10 seconds';
      smartNotifications = true;
      autoSync = true;
      hapticFeedback = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings restored to default values'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Settings',
      subtitle: 'Customize your BrineFlow experience',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
        children: [
          // =====================================================
          // SYSTEM STATUS
          // =====================================================

          GlassCard(
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppTheme.success.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: AppTheme.success,
                  ),
                ),
                const SizedBox(width: 13),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'System Operational',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Sensors and cloud synchronization are active.',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const StatusPill(
                  text: 'ONLINE',
                  color: AppTheme.success,
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // =====================================================
          // MONITORING
          // =====================================================

          const SectionTitle(
            title: 'Monitoring',
            subtitle: 'Configure how sensor data is displayed',
          ),

          const SizedBox(height: 10),

          GlassCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _SettingTile(
                  icon: Icons.thermostat_rounded,
                  iconColor: AppTheme.amberWarning,
                  title: 'Temperature Unit',
                  subtitle: 'Used throughout the application',
                  trailing: temperatureUnit,
                  onTap: _showTemperatureOptions,
                ),
                const Divider(height: 1),
                _SettingTile(
                  icon: Icons.timer_outlined,
                  iconColor: AppTheme.info,
                  title: 'Data Update Interval',
                  subtitle: 'How often sensor data refreshes',
                  trailing: updateInterval,
                  onTap: _showUpdateOptions,
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // =====================================================
          // AUTOMATION
          // =====================================================

          const SectionTitle(
            title: 'Automation',
            subtitle: 'Control BrineFlow background operations',
          ),

          const SizedBox(height: 10),

          GlassCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _SwitchTile(
                  icon: Icons.notifications_active_outlined,
                  iconColor: AppTheme.amberWarning,
                  title: 'Smart Notifications',
                  subtitle: 'Receive important pond alerts',
                  value: smartNotifications,
                  onChanged: (value) {
                    setState(() {
                      smartNotifications = value;
                    });
                  },
                ),
                const Divider(height: 1),
                _SwitchTile(
                  icon: Icons.sync_rounded,
                  iconColor: AppTheme.ocean,
                  title: 'Automatic Sync',
                  subtitle: 'Synchronize sensor data automatically',
                  value: autoSync,
                  onChanged: (value) {
                    setState(() {
                      autoSync = value;
                    });
                  },
                ),
                const Divider(height: 1),
                _SwitchTile(
                  icon: Icons.vibration_rounded,
                  iconColor: AppTheme.cyan,
                  title: 'Haptic Feedback',
                  subtitle: 'Use vibration for important actions',
                  value: hapticFeedback,
                  onChanged: (value) {
                    setState(() {
                      hapticFeedback = value;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // =====================================================
          // CURRENT CONFIGURATION
          // =====================================================

          const SectionTitle(
            title: 'Current Configuration',
            subtitle: 'Your active BrineFlow preferences',
          ),

          const SizedBox(height: 10),

          GlassCard(
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Temperature',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    StatusPill(
                      text: temperatureUnit,
                      color: AppTheme.info,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Sensor refresh',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    StatusPill(
                      text: updateInterval,
                      color: AppTheme.ocean,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // =====================================================
          // RESET
          // =====================================================

          OutlinedButton.icon(
            onPressed: _resetSettings,
            icon: const Icon(Icons.restart_alt_rounded),
            label: const Text('Restore Default Settings'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          const SizedBox(height: 18),

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
// SETTING TILE
// =============================================================

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String trailing;
  final VoidCallback onTap;

  const _SettingTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 10.5,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              trailing,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppTheme.ocean,
              ),
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.chevron_right_rounded,
              size: 19,
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
// SWITCH TILE
// =============================================================

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 9,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// =============================================================
// SELECTION SHEET
// =============================================================

class _SelectionSheet extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  const _SelectionSheet({
    required this.title,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            ...options.map(
              (option) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  option,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: option == selected
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: AppTheme.success,
                      )
                    : null,
                onTap: () => onSelected(option),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
      
