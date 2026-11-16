import 'package:flutter/material.dart';
import '../../data/models/generated_plan.dart';
import 'trip_theme_constants.dart';

class CostSummaryCard extends StatelessWidget {
  final GeneratedPlan plan;

  const CostSummaryCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TripColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 18,
                          color: TripColors.textDark,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Cost Summary',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: TripColors.textDark,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7E7B8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'All-Inclusive Est.',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF5C4700),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildRow(
                  Icons.confirmation_number_outlined,
                  'Selected Places',
                  '${plan.totalCost.toStringAsFixed(0)} EGP',
                ),
                const SizedBox(height: 10),
                _buildRow(
                  Icons.restaurant_outlined,
                  'Number of Places',
                  '${plan.places.length}',
                ),
                const SizedBox(height: 10),
                _buildRow(
                  Icons.account_balance_wallet_outlined,
                  'Remaining Budget',
                  '${plan.remainingBudget.toStringAsFixed(0)} EGP',
                ),
              ],
            ),
          ),

          // Total footer
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              color: TripColors.peachBanner,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TOTAL PROJECTED',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: TripColors.textMuted,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${plan.totalCost.toStringAsFixed(0)} EGP',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: TripColors.textDark,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.check_circle_outline,
                            size: 13,
                            color: TripColors.textDark,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Under Budget',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: TripColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Saves ${plan.remainingBudget.toStringAsFixed(0)} EGP',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: TripColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(IconData icon, String title, String cost) {
    return Row(
      children: [
        Icon(icon, size: 16, color: TripColors.textMuted),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: TripColors.textDark,
            ),
          ),
        ),
        Text(
          cost,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: TripColors.textDark,
          ),
        ),
      ],
    );
  }
}
