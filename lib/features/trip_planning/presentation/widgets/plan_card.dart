import 'package:flutter/material.dart';
import 'package:pick_me/features/trip_planning/data/models/generated_plan.dart';
import 'trip_primary_button.dart';
import 'trip_theme_constants.dart';

class PlanCard extends StatelessWidget {
  final GeneratedPlan plan;
  final VoidCallback onViewDetails;

  const PlanCard({super.key, required this.plan, required this.onViewDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: TripColors.cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: TripColors.textDark,
            ),
          ),
          const SizedBox(height: 14),

          // Cost banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: TripColors.peachBanner,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Cost',
                      style: TextStyle(
                        fontSize: 12,
                        color: TripColors.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${plan.totalCost.toStringAsFixed(0)} EGP',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: TripColors.textDark,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${plan.remainingBudget.toStringAsFixed(0)} EGP saved',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: TripColors.textSaved,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Places Grid (2 columns)
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: plan.places.map((place) {
              final itemWidth = (MediaQuery.of(context).size.width - 90) / 2;

              return Container(
                width: itemWidth,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: TripColors.chipBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.place_outlined,
                      size: 16,
                      color: TripColors.textDark,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        place.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: TripColors.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 18),
          TripPrimaryButton(
            text: 'View Detailed Itinerary & Confirm',
            icon: Icons.arrow_forward_rounded,
            onPressed: onViewDetails,
          ),
        ],
      ),
    );
  }
}
