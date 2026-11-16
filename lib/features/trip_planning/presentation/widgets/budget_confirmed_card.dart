import 'package:flutter/material.dart';
import '../../data/models/generated_plan.dart';
import 'trip_theme_constants.dart';

class BudgetConfirmedCard extends StatelessWidget {
  final GeneratedPlan plan;

  const BudgetConfirmedCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final budgetPercentage = plan.budget > 0
        ? (plan.totalCost / plan.budget).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TripColors.peachBanner,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.account_balance_wallet,
                      size: 18,
                      color: Color(0xFF6B5820),
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Budget Confirmed',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: TripColors.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${plan.totalCost.toStringAsFixed(0)} EGP',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: TripColors.textDark,
                          ),
                        ),
                        TextSpan(
                          text: ' / ${plan.budget.toStringAsFixed(0)} EGP',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: TripColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: budgetPercentage,
              minHeight: 8,
              backgroundColor: const Color(0xFFE5DDD0),
              valueColor: const AlwaysStoppedAnimation<Color>(
                TripColors.primaryYellow,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.shield_outlined,
                size: 15,
                color: TripColors.textMuted,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  'Safe buffer: ${plan.remainingBudget.toStringAsFixed(0)} EGP',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: TripColors.textMuted,
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
