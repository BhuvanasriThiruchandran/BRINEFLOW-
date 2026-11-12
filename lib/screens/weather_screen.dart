import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WeatherScreen extends StatelessWidget {
const WeatherScreen({super.key});

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
          _buildHeader(isMobile),

          const SizedBox(height: 24),

          _buildCurrentWeather(isMobile),

          const SizedBox(height: 22),

          _buildWeatherMetrics(isMobile),

          const SizedBox(height: 28),

          _buildForecastSection(isMobile),

          const SizedBox(height: 28),

          _buildSaltpanInsight(isMobile),
        ],
      ),
    ),
  ),
);

}

// ============================================================
// HEADER
// ============================================================

Widget _buildHeader(bool isMobile) {
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
Icons.cloud_rounded,
color: Colors.white,
size: 25,
),
),


    const SizedBox(width: 14),

    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weather Forecast',
            style: TextStyle(
              color: AppTheme.textDark,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isMobile
                ? 'Current weather conditions'
                : 'Weather conditions for intelligent saltpan management',
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
              Icons.location_on_outlined,
              size: 17,
              color: AppTheme.primaryBlue,
            ),
            SizedBox(width: 7),
            Text(
              'Saltpan Location',
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
// CURRENT WEATHER
// ============================================================

Widget _buildCurrentWeather(bool isMobile) {
return Container(
width: double.infinity,
padding: EdgeInsets.all(isMobile ? 20 : 26),
decoration: BoxDecoration(
gradient: const LinearGradient(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
colors: [
AppTheme.primaryBlue,
AppTheme.navy,
],
),
borderRadius: BorderRadius.circular(22),
boxShadow: [
BoxShadow(
color: AppTheme.primaryBlue.withValues(alpha: 0.16),
blurRadius: 24,
offset: const Offset(0, 10),
),
],
),
child: isMobile
? Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
_weatherLocation(),
const SizedBox(height: 24),
_mainWeatherInfo(),
],
)
: Row(
children: [
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
_weatherLocation(),
const SizedBox(height: 24),
_mainWeatherInfo(),
],
),
),
_weatherIcon(),
],
),
);
}

Widget _weatherLocation() {
return const Row(
children: [
Icon(
Icons.location_on_rounded,
color: Colors.white70,
size: 17,
),
SizedBox(width: 6),
Text(
'Saltpan Area',
style: TextStyle(
color: Colors.white70,
fontSize: 12,
fontWeight: FontWeight.w600,
),
),
],
);
}

Widget _mainWeatherInfo() {
return Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'32°C',
style: TextStyle(
color: Colors.white,
fontSize: 46,
fontWeight: FontWeight.w900,
height: 1,
),
),
const SizedBox(height: 8),
const Text(
'Partly Cloudy',
style: TextStyle(
color: Colors.white,
fontSize: 17,
fontWeight: FontWeight.w700,
),
),
const SizedBox(height: 5),
Text(
'Good conditions for salt evaporation',
style: TextStyle(
color: Colors.white.withValues(alpha: 0.68),
fontSize: 11,
),
),
],
);
}

Widget _weatherIcon() {
return Container(
width: 110,
height: 110,
decoration: BoxDecoration(
color: Colors.white.withValues(alpha: 0.10),
shape: BoxShape.circle,
),
child: const Icon(
Icons.cloud_queue_rounded,
color: Colors.white,
size: 58,
),
);
}

// ============================================================
// WEATHER METRICS
// ============================================================

Widget _buildWeatherMetrics(bool isMobile) {
final metrics = [
_WeatherMetric(
icon: Icons.water_drop_outlined,
title: 'Humidity',
value: '68%',
subtitle: 'Moderate',
color: AppTheme.cyan,
),
_WeatherMetric(
icon: Icons.air_rounded,
title: 'Wind Speed',
value: '14 km/h',
subtitle: 'Good airflow',
color: AppTheme.primaryBlue,
),
_WeatherMetric(
icon: Icons.wb_sunny_outlined,
title: 'UV Index',
value: '6',
subtitle: 'Moderate',
color: AppTheme.statusAmber,
),
_WeatherMetric(
icon: Icons.umbrella_outlined,
title: 'Rain Chance',
value: '20%',
subtitle: 'Low probability',
color: AppTheme.success,
),
];


if (isMobile) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(child: _metricCard(metrics[0])),
          const SizedBox(width: 10),
          Expanded(child: _metricCard(metrics[1])),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Expanded(child: _metricCard(metrics[2])),
          const SizedBox(width: 10),
          Expanded(child: _metricCard(metrics[3])),
        ],
      ),
    ],
  );
}

return Row(
  children: metrics.map((metric) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: _metricCard(metric),
      ),
    );
  }).toList(),
);


}

Widget _metricCard(_WeatherMetric metric) {
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
color: metric.color.withValues(alpha: 0.10),
borderRadius: BorderRadius.circular(12),
),
child: Icon(
metric.icon,
color: metric.color,
size: 20,
),
),


      const SizedBox(width: 11),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              metric.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppTheme.textMuted,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              metric.value,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppTheme.textDark,
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              metric.subtitle,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: metric.color,
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
// FORECAST
// ============================================================

Widget _buildForecastSection(bool isMobile) {
final forecast = [
_ForecastData('Today', '32°', '26°', Icons.cloud_rounded, 'Partly Cloudy'),
_ForecastData('Tomorrow', '34°', '27°', Icons.wb_sunny_rounded, 'Sunny'),
_ForecastData('Wed', '35°', '27°', Icons.wb_sunny_rounded, 'Sunny'),
_ForecastData('Thu', '31°', '25°', Icons.cloud_rounded, 'Cloudy'),
_ForecastData('Fri', '30°', '25°', Icons.grain_rounded, 'Rain'),
];


return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Text(
      '5-Day Forecast',
      style: TextStyle(
        color: AppTheme.textDark,
        fontSize: 21,
        fontWeight: FontWeight.w800,
      ),
    ),

    const SizedBox(height: 14),

    SizedBox(
      height: 155,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return _forecastCard(forecast[index]);
        },
      ),
    ),
  ],
);


}

Widget _forecastCard(_ForecastData data) {
return Container(
width: 145,
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(18),
border: Border.all(
color: AppTheme.borderLight,
),
),
child: Column(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text(
data.day,
style: const TextStyle(
color: AppTheme.textDark,
fontSize: 12,
fontWeight: FontWeight.w800,
),
),


      Icon(
        data.icon,
        color: AppTheme.primaryBlue,
        size: 30,
      ),

      Text(
        data.condition,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: AppTheme.textMuted,
          fontSize: 9,
        ),
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.high,
            style: const TextStyle(
              color: AppTheme.textDark,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            data.low,
            style: const TextStyle(
              color: AppTheme.textMuted,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ],
  ),
);


}

// ============================================================
// SALTPAN INSIGHT
// ============================================================

Widget _buildSaltpanInsight(bool isMobile) {
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
_insightHeader(),
const SizedBox(height: 14),
_insightContent(),
],
)
: Row(
children: [
Expanded(child: _insightHeader()),
const SizedBox(width: 30),
Expanded(child: _insightContent()),
],
),
);
}

Widget _insightHeader() {
return const Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
children: [
Icon(
Icons.auto_awesome_rounded,
color: AppTheme.cyan,
size: 21,
),
SizedBox(width: 9),
Text(
'Saltpan Weather Insight',
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
'Weather conditions can influence evaporation and salt production.',
style: TextStyle(
color: Colors.white60,
fontSize: 11,
),
),
],
);
}

Widget _insightContent() {
return Row(
children: [
Container(
width: 42,
height: 42,
decoration: BoxDecoration(
color: AppTheme.success.withValues(alpha: 0.12),
borderRadius: BorderRadius.circular(12),
),
child: const Icon(
Icons.check_circle_outline_rounded,
color: AppTheme.success,
size: 23,
),
),


    const SizedBox(width: 12),

    const Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Favorable Conditions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Low rain probability and good wind conditions support evaporation.',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 10,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  ],
);


}
}

// ============================================================
// DATA CLASSES
// ============================================================

class _WeatherMetric {
final IconData icon;
final String title;
final String value;
final String subtitle;
final Color color;

const _WeatherMetric({
required this.icon,
required this.title,
required this.value,
required this.subtitle,
required this.color,
});
}

class _ForecastData {
final String day;
final String high;
final String low;
final IconData icon;
final String condition;

const _ForecastData(
this.day,
this.high,
this.low,
this.icon,
this.condition,
);
}
