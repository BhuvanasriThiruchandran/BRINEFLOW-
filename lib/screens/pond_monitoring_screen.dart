import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PondMonitoringScreen extends StatelessWidget {
  const PondMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 760;

    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              _buildHeader(context, isMobile),

              const SizedBox(height: 24),

              // SUMMARY
              _buildSummaryCards(isMobile),

              const SizedBox(height: 28),

              // SECTION TITLE
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Pond Overview',
                      style: TextStyle(
                        color: AppTheme.textDark,
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.success.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 7,
                          color: AppTheme.success,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Live Data',
                          style: TextStyle(
                            color: AppTheme.success,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // POND CARDS
              if (isMobile)
                Column(
                  children: [
                    _buildPondCard(
                      context,
                      name: 'Reservoir Pond',
                      pondNumber: 'POND 01',
                      level: 82,
                      salinity: '28.5',
                      temperature: '31.2',
                      humidity: '65',
                      status: 'Healthy',
                      statusColor: AppTheme.success,
                      icon: Icons.water_drop_rounded,
                    ),
                    const SizedBox(height: 14),
                    _buildPondCard(
                      context,
                      name: 'Evaporation Pond',
                      pondNumber: 'POND 02',
                      level: 65,
                      salinity: '26.8',
                      temperature: '33.1',
                      humidity: '68',
                      status: 'Monitoring',
                      statusColor: AppTheme.statusAmber,
                      icon: Icons.wb_sunny_rounded,
                    ),
                    const SizedBox(height: 14),
                    _buildPondCard(
                      context,
                      name: 'Crystallizer Pond',
                      pondNumber: 'POND 03',
                      level: 41,
                      salinity: '30.2',
                      temperature: '34.5',
                      humidity: '64',
                      status: 'Critical Level',
                      statusColor: Colors.redAccent,
                      icon: Icons.grain_rounded,
                    ),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildPondCard(
                        context,
                        name: 'Reservoir Pond',
                        pondNumber: 'POND 01',
                        level: 82,
                        salinity: '28.5',
                        temperature: '31.2',
                        humidity: '65',
                        status: 'Healthy',
                        statusColor: AppTheme.success,
                        icon: Icons.water_drop_rounded,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildPondCard(
                        context,
                        name: 'Evaporation Pond',
                        pondNumber: 'POND 02',
                        level: 65,
                        salinity: '26.8',
                        temperature: '33.1',
                        humidity: '68',
                        status: 'Monitoring',
                        statusColor: AppTheme.statusAmber,
                        icon: Icons.wb_sunny_rounded,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildPondCard(
                        context,
                        name: 'Crystallizer Pond',
                        pondNumber: 'POND 03',
                        level: 41,
                        salinity: '30.2',
                        temperature: '34.5',
                        humidity: '64',
                        status: 'Critical Level',
                        statusColor: Colors.redAccent,
                        icon: Icons.grain_rounded,
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 28),

              // SENSOR SECTION
              _buildSensorSection(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(BuildContext context, bool isMobile) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppTheme.primaryBlue,
                AppTheme.cyan,
              ],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.water_drop_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pond Monitoring',
                style: TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isMobile
                    ? 'Real-time pond conditions'
                    : 'Real-time monitoring of your saltpan ponds',
                style: const TextStyle(
                  color: AppTheme.textMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        if (!isMobile)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.borderLight,
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.sync_rounded,
                  size: 17,
                  color: AppTheme.primaryBlue,
                ),
                SizedBox(width: 7),
                Text(
                  'Updated just now',
                  style: TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ============================================================
  // SUMMARY CARDS
  // ============================================================

  Widget _buildSummaryCards(bool isMobile) {
    final cards = [
      _SummaryData(
        title: 'Active Ponds',
        value: '3',
        subtitle: 'All connected',
        icon: Icons.water_drop_rounded,
        color: AppTheme.primaryBlue,
      ),
      _SummaryData(
        title: 'Healthy Ponds',
        value: '1',
        subtitle: 'Good condition',
        icon: Icons.check_circle_rounded,
        color: AppTheme.success,
      ),
      _SummaryData(
        title: 'Need Attention',
        value: '2',
        subtitle: 'Requires monitoring',
        icon: Icons.warning_rounded,
        color: AppTheme.statusAmber,
      ),
      _SummaryData(
        title: 'IoT Sensors',
        value: '8',
        subtitle: 'Online',
        icon: Icons.sensors_rounded,
        color: AppTheme.cyan,
      ),
    ];

    if (isMobile) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildSummaryCard(cards[0])),
              const SizedBox(width: 10),
              Expanded(child: _buildSummaryCard(cards[1])),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _buildSummaryCard(cards[2])),
              const SizedBox(width: 10),
              Expanded(child: _buildSummaryCard(cards[3])),
            ],
          ),
        ],
      );
    }

    return Row(
      children: cards
          .map(
            (card) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _buildSummaryCard(card),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildSummaryCard(_SummaryData data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              data.icon,
              color: data.color,
              size: 20,
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  data.value,
                  style: const TextStyle(
                    color: AppTheme.textDark,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  data.subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: data.color,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // POND CARD
  // ============================================================

  Widget _buildPondCard(
    BuildContext context, {
    required String name,
    required String pondNumber,
    required int level,
    required String salinity,
    required String temperature,
    required String humidity,
    required String status,
    required Color statusColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOP
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryBlue.withValues(alpha: 0.14),
                      AppTheme.cyan.withValues(alpha: 0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.primaryBlue,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pondNumber,
                      style: const TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      name,
                      style: const TextStyle(
                        color: AppTheme.textDark,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // WATER LEVEL
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Water Level',
                style: TextStyle(
                  color: AppTheme.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$level%',
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: level / 100,
              minHeight: 8,
              backgroundColor: AppTheme.borderLight,
              valueColor: AlwaysStoppedAnimation<Color>(
                level < 50
                    ? Colors.redAccent
                    : level < 70
                        ? AppTheme.statusAmber
                        : AppTheme.primaryBlue,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // SENSOR VALUES
          Row(
            children: [
              Expanded(
                child: _sensorValue(
                  Icons.water_drop_outlined,
                  'Salinity',
                  '$salinity °Bé',
                ),
              ),
              Expanded(
                child: _sensorValue(
                  Icons.thermostat_outlined,
                  'Temperature',
                  '$temperature °C',
                ),
              ),
              Expanded(
                child: _sensorValue(
                  Icons.water_outlined,
                  'Humidity',
                  '$humidity%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sensorValue(
    IconData icon,
    String label,
    String value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: AppTheme.primaryBlue,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppTheme.textMuted,
            fontSize: 9,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppTheme.textDark,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SENSOR STATUS
  // ============================================================

  Widget _buildSensorSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.navy,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.navy.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sensorHeader(),
                const SizedBox(height: 18),
                _sensorStatusRow(),
              ],
            )
          : Row(
              children: [
                Expanded(child: _sensorHeader()),
                _sensorStatusRow(),
              ],
            ),
    );
  }

  Widget _sensorHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.sensors_rounded,
              color: AppTheme.cyan,
              size: 21,
            ),
            SizedBox(width: 9),
            Text(
              'IoT Sensor Network',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: 7),
        Text(
          'All connected sensors are transmitting live data.',
          style: TextStyle(
            color: Colors.white60,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _sensorStatusRow() {
    return Row(
      children: [
        _miniStatus('8', 'Online', AppTheme.success),
        const SizedBox(width: 22),
        _miniStatus('0', 'Offline', Colors.redAccent),
        const SizedBox(width: 22),
        _miniStatus('100%', 'Health', AppTheme.cyan),
      ],
    );
  }

  Widget _miniStatus(
    String value,
    String label,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// SUMMARY DATA
// ============================================================

class _SummaryData {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _SummaryData({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}