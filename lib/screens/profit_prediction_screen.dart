import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/ui.dart';

class ProfitPredictionScreen extends StatelessWidget {
  const ProfitPredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Profit Prediction',
      subtitle: 'Estimated financial outlook for the current cycle',
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: StatusPill(
            text: 'POSITIVE OUTLOOK',
            color: AppTheme.success,
            icon: Icons.trending_up_rounded,
          ),
        ),
      ],
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================================
            // PROFIT HERO CARD
            // =====================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppTheme.navy,
                    AppTheme.ocean,
                    AppTheme.primaryBlue,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryBlue.withValues(alpha: 0.18),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 13),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Estimated Profit',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Current production cycle',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.auto_graph_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    '₹3.2M',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.success.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_upward_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                            SizedBox(width: 3),
                            Text(
                              'Expected positive return',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: _HeroInfo(
                          label: 'Expected revenue',
                          value: '₹4.8M',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _HeroInfo(
                          label: 'Estimated cost',
                          value: '₹1.6M',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =====================================================
            // FINANCIAL OVERVIEW
            // =====================================================

            const SectionTitle(
              title: 'Financial Overview',
              subtitle: 'Key financial indicators for this cycle',
            ),

            const SizedBox(height: 14),

            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 700;

                return GridView.count(
                  crossAxisCount: isWide ? 3 : 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: isWide ? 1.8 : 3.2,
                  children: const [
                    MetricTile(
                      label: 'Revenue',
                      value: '₹4.8M',
                      helper: 'Expected sales value',
                      icon: Icons.payments_rounded,
                      color: AppTheme.statusGreen,
                    ),
                    MetricTile(
                      label: 'Production Cost',
                      value: '₹1.6M',
                      helper: 'Estimated cycle cost',
                      icon: Icons.receipt_long_rounded,
                      color: AppTheme.statusAmber,
                    ),
                    MetricTile(
                      label: 'Net Profit',
                      value: '₹3.2M',
                      helper: 'Revenue minus cost',
                      icon: Icons.savings_rounded,
                      color: AppTheme.emeraldGreen,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 28),

            // =====================================================
            // PROFIT BREAKDOWN
            // =====================================================

            const SectionTitle(
              title: 'Profit Breakdown',
              subtitle: 'Relationship between revenue and production cost',
            ),

            const SizedBox(height: 14),

            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.bar_chart_rounded,
                        size: 20,
                        color: AppTheme.primaryBlue,
                      ),
                      SizedBox(width: 9),
                      Text(
                        'Financial distribution',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  const ProgressMetric(
                    title: 'Expected revenue',
                    value: 1.0,
                    valueLabel: '₹4.8M',
                    color: AppTheme.statusGreen,
                  ),

                  const SizedBox(height: 22),

                  const ProgressMetric(
                    title: 'Production cost',
                    value: 0.333,
                    valueLabel: '₹1.6M',
                    color: AppTheme.statusAmber,
                  ),

                  const SizedBox(height: 22),

                  const ProgressMetric(
                    title: 'Net profit',
                    value: 0.667,
                    valueLabel: '₹3.2M',
                    color: AppTheme.emeraldGreen,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =====================================================
            // FINANCIAL DETAILS
            // =====================================================

            const SectionTitle(
              title: 'Financial Details',
              subtitle: 'Current estimates used for the prediction',
            ),

            const SizedBox(height: 14),

            GlassCard(
              child: Column(
                children: const [
                  Row(
                    children: [
                      Expanded(
                        child: MiniInfo(
                          label: 'Expected yield',
                          value: '1,240 kg',
                          valueColor: AppTheme.primaryBlue,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: MiniInfo(
                          label: 'Revenue estimate',
                          value: '₹4.8M',
                          valueColor: AppTheme.statusGreen,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: MiniInfo(
                          label: 'Production cost',
                          value: '₹1.6M',
                          valueColor: AppTheme.statusAmber,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: MiniInfo(
                          label: 'Estimated margin',
                          value: '66.7%',
                          valueColor: AppTheme.emeraldGreen,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =====================================================
            // AI INSIGHT
            // =====================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppTheme.successLight,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppTheme.success.withValues(alpha: 0.14),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.success.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.lightbulb_rounded,
                      color: AppTheme.success,
                      size: 21,
                    ),
                  ),
                  const SizedBox(width: 13),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Financial Insight',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.textDark,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'The current yield prediction indicates a '
                          'favorable financial outlook. Expected revenue '
                          'is substantially higher than the estimated '
                          'production cost for this cycle.',
                          style: TextStyle(
                            fontSize: 11,
                            height: 1.5,
                            color: AppTheme.inkSecondary,
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
      ),
    );
  }
}

// =============================================================
// HERO INFORMATION
// =============================================================

class _HeroInfo extends StatelessWidget {
  final String label;
  final String value;

  const _HeroInfo({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}