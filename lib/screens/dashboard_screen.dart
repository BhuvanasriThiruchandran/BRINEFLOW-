import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'ai_assistant_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 760;

            return SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? 16 : 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DashboardHeader(isMobile: isMobile),

                  const SizedBox(height: 24),

                  _WelcomeBanner(isMobile: isMobile),

                  const SizedBox(height: 22),

                  const _SectionTitle(
                    title: 'Live Overview',
                    subtitle: 'Real-time saltpan conditions',
                  ),

                  const SizedBox(height: 14),

                  _MetricGrid(isMobile: isMobile),

                  const SizedBox(height: 24),

                  if (isMobile)
                    const Column(
                      children: [
                        _BrineReadinessCard(),
                        SizedBox(height: 18),
                        _SystemStatusCard(),
                      ],
                    )
                  else
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: _BrineReadinessCard(),
                        ),
                        SizedBox(width: 18),
                        Expanded(
                          flex: 2,
                          child: _SystemStatusCard(),
                        ),
                      ],
                    ),

                  const SizedBox(height: 24),

                  const _SectionTitle(
                    title: 'Pond Monitoring',
                    subtitle: 'Current conditions across your saltpan',
                  ),

                  const SizedBox(height: 14),

                  _PondGrid(isMobile: isMobile),

                  const SizedBox(height: 24),

                  const _SectionTitle(
                    title: 'AI Recommendation',
                    subtitle: 'BrineFlow intelligence',
                  ),

                  const SizedBox(height: 14),

                  _RecommendationCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AIAssistantScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ============================================================
// HEADER
// ============================================================

class _DashboardHeader extends StatelessWidget {
  final bool isMobile;

  const _DashboardHeader({
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: isMobile ? 24 : 30,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.ink,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Intelligent Saltpan Management System',
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  color: AppTheme.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (!isMobile) ...[
          const _ConnectionChip(),
          const SizedBox(width: 12),
          const _NotificationButton(),
          const SizedBox(width: 12),
          const _ProfileAvatar(),
        ] else
          const _NotificationButton(),
      ],
    );
  }
}

// ============================================================
// CONNECTION
// ============================================================

class _ConnectionChip extends StatelessWidget {
  const _ConnectionChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: AppTheme.successLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.success.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: AppTheme.success,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'IoT Connected',
            style: TextStyle(
              color: AppTheme.success,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// NOTIFICATION
// ============================================================

class _NotificationButton extends StatelessWidget {
  const _NotificationButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Center(
            child: Icon(
              Icons.notifications_none_rounded,
              color: AppTheme.inkSecondary,
              size: 21,
            ),
          ),
          Positioned(
            right: 9,
            top: 8,
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: AppTheme.danger,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE
// ============================================================

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppTheme.cyan,
            AppTheme.primaryBlue,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          'A',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// WELCOME BANNER
// ============================================================

class _WelcomeBanner extends StatelessWidget {
  final bool isMobile;

  const _WelcomeBanner({
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppTheme.navy,
            AppTheme.ocean,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.navy.withValues(alpha: 0.16),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Good morning, Admin 👋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your saltpan is being monitored in real time.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.72),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '3 ponds monitored',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile)
            const Icon(
              Icons.water_drop_rounded,
              color: Colors.white24,
              size: 90,
            ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION TITLE
// ============================================================

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppTheme.ink,
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: const TextStyle(
            color: AppTheme.textMuted,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// METRICS
// ============================================================

class _MetricGrid extends StatelessWidget {
  final bool isMobile;

  const _MetricGrid({
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final cards = [
      _MetricData(
        title: 'Water Level',
        value: '78',
        unit: '%',
        icon: Icons.water_drop_rounded,
        color: AppTheme.blue,
      ),
      _MetricData(
        title: 'Salinity',
        value: '31.2',
        unit: 'ppt',
        icon: Icons.science_rounded,
        color: AppTheme.cyan,
      ),
      _MetricData(
        title: 'Temperature',
        value: '36',
        unit: '°C',
        icon: Icons.thermostat_rounded,
        color: AppTheme.statusAmber,
      ),
      _MetricData(
        title: 'Humidity',
        value: '64',
        unit: '%',
        icon: Icons.water_rounded,
        color: AppTheme.emeraldGreen,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cards.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 4,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: isMobile ? 1.35 : 1.65,
      ),
      itemBuilder: (context, index) {
        return _MetricCard(data: cards[index]);
      },
    );
  }
}

class _MetricData {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  const _MetricData({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });
}

class _MetricCard extends StatelessWidget {
  final _MetricData data;

  const _MetricCard({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: AppTheme.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: data.color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  data.icon,
                  color: data.color,
                  size: 18,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.more_horiz_rounded,
                color: AppTheme.muted,
                size: 18,
              ),
            ],
          ),
          const Spacer(),
          Text(
            data.title,
            style: const TextStyle(
              color: AppTheme.textMuted,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data.value,
                style: const TextStyle(
                  color: AppTheme.ink,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 3),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  data.unit,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// BRINE READINESS
// ============================================================

class _BrineReadinessCard extends StatelessWidget {
  const _BrineReadinessCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 115,
            height: 115,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 110,
                  height: 110,
                  child: CircularProgressIndicator(
                    value: 0.82,
                    strokeWidth: 10,
                    backgroundColor:
                        AppTheme.border.withValues(alpha: 0.5),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(
                      AppTheme.cyan,
                    ),
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '82',
                      style: TextStyle(
                        color: AppTheme.ink,
                        fontSize: 29,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'BRS',
                      style: TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 22),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Brine Readiness Score',
                  style: TextStyle(
                    color: AppTheme.ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Current brine conditions are favorable for the next processing stage.',
                  style: TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 12),
                _StatusTag(
                  text: 'GOOD CONDITION',
                  color: AppTheme.success,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// STATUS TAG
// ============================================================

class _StatusTag extends StatelessWidget {
  final String text;
  final Color color;

  const _StatusTag({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ============================================================
// SYSTEM STATUS
// ============================================================

class _SystemStatusCard extends StatelessWidget {
  const _SystemStatusCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'System Status',
            style: TextStyle(
              color: AppTheme.ink,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 18),
          const _StatusRow(
            icon: Icons.sensors_rounded,
            title: 'IoT Sensors',
            status: 'Online',
            color: AppTheme.success,
          ),
          const SizedBox(height: 13),
          const _StatusRow(
            icon: Icons.cloud_done_rounded,
            title: 'Weather API',
            status: 'Connected',
            color: AppTheme.blue,
          ),
          const SizedBox(height: 13),
          const _StatusRow(
            icon: Icons.psychology_rounded,
            title: 'ML Engine',
            status: 'Ready',
            color: AppTheme.cyan,
          ),
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String status;
  final Color color;

  const _StatusRow({
    required this.icon,
    required this.title,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppTheme.inkSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          status,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// POND GRID
// ============================================================

class _PondGrid extends StatelessWidget {
  final bool isMobile;

  const _PondGrid({
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final ponds = [
      _PondData(
        name: 'Reservoir Pond',
        subtitle: 'Pond 01',
        level: '78%',
        salinity: '0 ppt',
        temperature: '30°C',
        status: 'Normal',
        color: AppTheme.blue,
      ),
      _PondData(
        name: 'Evaporation Pond',
        subtitle: 'Pond 02',
        level: '62%',
        salinity: '25.8 ppt',
        temperature: '34°C',
        status: 'Monitoring',
        color: AppTheme.cyan,
      ),
      _PondData(
        name: 'Crystallizer Pond',
        subtitle: 'Pond 03',
        level: '41%',
        salinity: '31.2 ppt',
        temperature: '36°C',
        status: 'Ready',
        color: AppTheme.emeraldGreen,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ponds.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 3,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: isMobile ? 2.0 : 1.45,
      ),
      itemBuilder: (context, index) {
        return _PondCard(data: ponds[index]);
      },
    );
  }
}

class _PondData {
  final String name;
  final String subtitle;
  final String level;
  final String salinity;
  final String temperature;
  final String status;
  final Color color;

  const _PondData({
    required this.name,
    required this.subtitle,
    required this.level,
    required this.salinity,
    required this.temperature,
    required this.status,
    required this.color,
  });
}

class _PondCard extends StatelessWidget {
  final _PondData data;

  const _PondCard({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: data.color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  Icons.water_drop_rounded,
                  color: data.color,
                  size: 19,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: const TextStyle(
                        color: AppTheme.ink,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      data.subtitle,
                      style: const TextStyle(
                        color: AppTheme.muted,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusTag(
                text: data.status.toUpperCase(),
                color: data.color,
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PondValue(
                label: 'Level',
                value: data.level,
              ),
              _PondValue(
                label: 'Salinity',
                value: data.salinity,
              ),
              _PondValue(
                label: 'Temp.',
                value: data.temperature,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PondValue extends StatelessWidget {
  final String label;
  final String value;

  const _PondValue({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.muted,
            fontSize: 9,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.ink,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// AI RECOMMENDATION
// ============================================================

class _RecommendationCard extends StatelessWidget {
  final VoidCallback? onTap;

  const _RecommendationCard({
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.infoLight,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppTheme.blue.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppTheme.blue.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: AppTheme.blue,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Recommendation',
                    style: TextStyle(
                      color: AppTheme.ink,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Current brine conditions indicate favorable evaporation. Continue monitoring Pond 02 before the next transfer decision.',
                    style: TextStyle(
                      color: AppTheme.inkSecondary,
                      fontSize: 11,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_forward_rounded,
              color: AppTheme.blue,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}