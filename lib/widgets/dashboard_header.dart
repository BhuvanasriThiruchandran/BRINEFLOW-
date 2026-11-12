
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DashboardHero extends StatelessWidget {
  final VoidCallback? onAlerts;

  const DashboardHero({
    super.key,
    this.onAlerts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Row(
        children: [
          // BrineFlow icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.infoLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.water_drop_rounded,
              color: AppTheme.blue,
              size: 25,
            ),
          ),

          const SizedBox(width: 14),

          // Title
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BrineFlow',
                  style: TextStyle(
                    color: AppTheme.ink,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Intelligent Saltpan Management System',
                  style: TextStyle(
                    color: AppTheme.muted,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // IoT status
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppTheme.successLight,
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.circle,
                  size: 8,
                  color: AppTheme.success,
                ),
                SizedBox(width: 6),
                Text(
                  'IoT Connected',
                  style: TextStyle(
                    color: AppTheme.success,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Notification
          Material(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: onAlerts,
              borderRadius: BorderRadius.circular(12),
              child: const SizedBox(
                width: 42,
                height: 42,
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: AppTheme.inkSecondary,
                  size: 21,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // User
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppTheme.infoLight,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const Text(
              'SF',
              style: TextStyle(
                color: AppTheme.blue,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

