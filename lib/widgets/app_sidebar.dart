import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../screens/ai_assistant_screen.dart';

class AppSidebar extends StatelessWidget {
  final String currentPage;

  const AppSidebar({
    super.key,
    required this.currentPage,
  });

  void _openPage(BuildContext context, String page) {
    if (page == currentPage) return;

    Widget screen;

    switch (page) {
      case 'Dashboard':
        Navigator.popUntil(context, (route) => route.isFirst);
        return;

      case 'AI Assistant':
        screen = const AIAssistantScreen();
        break;

      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        border: Border(
          right: BorderSide(
            color: AppTheme.border,
          ),
        ),
      ),
      child: Column(
        children: [
          // LOGO
          Padding(
            padding: const EdgeInsets.all(22),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppTheme.cyan,
                        AppTheme.primaryBlue,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.water_drop_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 10),

                const Text(
                  'BrineFlow',
                  style: TextStyle(
                    color: AppTheme.ink,
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            color: AppTheme.border,
          ),

          const SizedBox(height: 18),

          // NAVIGATION
          _SidebarItem(
            icon: Icons.dashboard_rounded,
            title: 'Dashboard',
            selected: currentPage == 'Dashboard',
            onTap: () => _openPage(context, 'Dashboard'),
          ),

          _SidebarItem(
            icon: Icons.water_drop_rounded,
            title: 'Pond Monitoring',
            selected: currentPage == 'Pond Monitoring',
            onTap: () => _openPage(context, 'Pond Monitoring'),
          ),

          _SidebarItem(
            icon: Icons.cloud_rounded,
            title: 'Weather',
            selected: currentPage == 'Weather',
            onTap: () => _openPage(context, 'Weather'),
          ),

          _SidebarItem(
            icon: Icons.analytics_rounded,
            title: 'Yield Prediction',
            selected: currentPage == 'Yield Prediction',
            onTap: () => _openPage(context, 'Yield Prediction'),
          ),

          _SidebarItem(
            icon: Icons.currency_rupee_rounded,
            title: 'Profit Prediction',
            selected: currentPage == 'Profit Prediction',
            onTap: () => _openPage(context, 'Profit Prediction'),
          ),

          _SidebarItem(
            icon: Icons.notifications_rounded,
            title: 'Notifications',
            selected: currentPage == 'Notifications',
            onTap: () => _openPage(context, 'Notifications'),
          ),

          const SizedBox(height: 10),

          // AI ASSISTANT
          _SidebarItem(
            icon: Icons.auto_awesome_rounded,
            title: 'AI Assistant',
            selected: currentPage == 'AI Assistant',
            onTap: () => _openPage(context, 'AI Assistant'),
            highlight: true,
          ),

          const Spacer(),

          // BOTTOM STATUS
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.successLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.cloud_done_rounded,
                  color: AppTheme.success,
                  size: 18,
                ),
                SizedBox(width: 9),
                Expanded(
                  child: Text(
                    'System Online',
                    style: TextStyle(
                      color: AppTheme.success,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
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

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final bool highlight;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 3,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: selected
                ? AppTheme.blue.withValues(alpha: 0.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 19,
                color: selected
                    ? AppTheme.blue
                    : highlight
                        ? AppTheme.cyan
                        : AppTheme.textMuted,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: selected
                        ? AppTheme.blue
                        : AppTheme.inkSecondary,
                    fontSize: 11,
                    fontWeight:
                        selected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ),

              if (highlight)
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppTheme.cyan,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}