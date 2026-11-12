
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  bool allRead = false;

  final alerts = const [
    {
      'title': 'High Salinity Detected',
      'description':
          'Evaporation pond salinity has exceeded the configured threshold.',
      'time': '10 mins ago',
      'status': 'Warning',
      'pond': 'Evaporation Pond',
    },
    {
      'title': 'Flow Rate Drop',
      'description':
          'Water movement has dropped below the expected operating range.',
      'time': '42 mins ago',
      'status': 'Critical',
      'pond': 'Reservoir Pond',
    },
    {
      'title': 'System Auto-Calibrated',
      'description':
          'Connected sensors synchronized successfully with the monitoring system.',
      'time': '2 hours ago',
      'status': 'Resolved',
      'pond': 'All Ponds',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final activeAlerts = allRead ? 0 : 2;

    return AppPage(
      title: 'Alerts & Notifications',
      subtitle: 'Monitor important events across your saltpan system',
      actions: [
        IconButton(
          onPressed: allRead
              ? null
              : () {
                  setState(() {
                    allRead = true;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All notifications marked as read'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
          tooltip: 'Mark all as read',
          icon: const Icon(Icons.done_all_rounded),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          // =====================================================
          // ALERT SUMMARY
          // =====================================================

          Row(
            children: [
              Expanded(
                child: KpiCard(
                  label: 'Active Alerts',
                  value: '$activeAlerts',
                  status: allRead ? 'All clear' : 'Needs attention',
                  statusColor:
                      allRead ? AppTheme.success : AppTheme.amberWarning,
                  icon: allRead
                      ? Icons.notifications_none_rounded
                      : Icons.notifications_active_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: KpiCard(
                  label: 'System Status',
                  value: 'Healthy',
                  status: 'All systems normal',
                  statusColor: AppTheme.success,
                  icon: Icons.check_circle_outline_rounded,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          const SectionTitle(
            title: 'Recent Notifications',
            subtitle: 'Latest events detected by BrineFlow',
          ),

          const SizedBox(height: 12),

          // =====================================================
          // ALERT 1
          // =====================================================

          GlassCard(
            child: _AlertItem(
              icon: Icons.water_drop_rounded,
              iconColor: AppTheme.amberWarning,
              title: alerts[0]['title']!,
              description: alerts[0]['description']!,
              time: alerts[0]['time']!,
              status: alerts[0]['status']!,
              statusColor: AppTheme.amberWarning,
              pond: alerts[0]['pond']!,
              isRead: allRead,
            ),
          ),

          const SizedBox(height: 12),

          // =====================================================
          // ALERT 2
          // =====================================================

          GlassCard(
            child: _AlertItem(
              icon: Icons.speed_rounded,
              iconColor: AppTheme.danger,
              title: alerts[1]['title']!,
              description: alerts[1]['description']!,
              time: alerts[1]['time']!,
              status: alerts[1]['status']!,
              statusColor: AppTheme.danger,
              pond: alerts[1]['pond']!,
              isRead: allRead,
            ),
          ),

          const SizedBox(height: 12),

          // =====================================================
          // ALERT 3
          // =====================================================

          GlassCard(
            child: _AlertItem(
              icon: Icons.sync_rounded,
              iconColor: AppTheme.success,
              title: alerts[2]['title']!,
              description: alerts[2]['description']!,
              time: alerts[2]['time']!,
              status: alerts[2]['status']!,
              statusColor: AppTheme.success,
              pond: alerts[2]['pond']!,
              isRead: true,
            ),
          ),

          const SizedBox(height: 24),

          // =====================================================
          // AI RECOMMENDATION
          // =====================================================

          const SectionTitle(
            title: 'AI Recommendation',
            subtitle: 'Based on current pond conditions',
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryBlue.withValues(alpha: 0.10),
                  AppTheme.cyan.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppTheme.primaryBlue.withValues(alpha: 0.15),
              ),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 44,
                  height: 44,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0x1A0288D1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(13),
                      ),
                    ),
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      color: AppTheme.primaryBlue,
                      size: 22,
                    ),
                  ),
                ),
                SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BrineFlow AI',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Monitor salinity closely before transferring brine to the next pond stage.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.45,
                          color: AppTheme.textDark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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

// =============================================================
// ALERT ITEM
// =============================================================

class _AlertItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String time;
  final String status;
  final Color statusColor;
  final String pond;
  final bool isRead;

  const _AlertItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.pond,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isRead ? 0.62 : 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 21,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (!isRead)
                          Container(
                            width: 7,
                            height: 7,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: const BoxDecoration(
                              color: AppTheme.primaryBlue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textDark,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 11.5,
                        height: 1.4,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              StatusPill(
                text: status,
                color: statusColor,
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              const Icon(
                Icons.water_drop_outlined,
                size: 14,
                color: AppTheme.textMuted,
              ),

              const SizedBox(width: 5),

              Text(
                pond,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textMuted,
                ),
              ),

              const Spacer(),

              const Icon(
                Icons.schedule_rounded,
                size: 14,
                color: AppTheme.textMuted,
              ),

              const SizedBox(width: 5),

              Text(
                time,
                style: const TextStyle(
                  fontSize: 10.5,
                  color: AppTheme.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
      
