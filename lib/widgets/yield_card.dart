import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class YieldCard extends StatelessWidget {
  final String projectedYield;
  final String estimatedDate;
  final String growthRate;
  final double progress;

  const YieldCard({
    super.key,
    this.projectedYield = '4,250 kg',
    this.estimatedDate = 'Oct 15, 2026',
    this.growthRate = '+5.2%/wk',
    this.progress = 0.72,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Estimated Harvest Yield',
                  style: TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.oceanCyan.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    growthRate,
                    style: const TextStyle(
                      color: AppTheme.oceanCyan,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  projectedYield,
                  style: const TextStyle(
                    color: AppTheme.textDark,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Target Date: $estimatedDate',
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: AppTheme.borderLight,
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.oceanCyan),
              ),
            ),
          ],
        ),
      ),
    );
  }
}