import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WeatherCard extends StatelessWidget {
  final String location;
  final String temperature;
  final String condition;
  final String humidity;
  final String windSpeed;

  const WeatherCard({
    super.key,
    this.location = 'Pond Area #1',
    this.temperature = '29°C',
    this.condition = 'Partly Cloudy',
    this.humidity = '78%',
    this.windSpeed = '12 km/h',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.oceanCyan.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.wb_cloudy_rounded,
                color: AppTheme.oceanCyan,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: const TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$temperature • $condition',
                    style: const TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Humidity: $humidity | Wind: $windSpeed',
                    style: const TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 12,
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