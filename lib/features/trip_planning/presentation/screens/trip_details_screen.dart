import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_me/features/trip_planning/data/models/generated_plan.dart';
import '../../../home/trip_request/logic/cubit/trip_request_cubit.dart';
import '../widgets/budget_confirmed_card.dart';
import '../widgets/cost_summary_card.dart';
import '../widgets/place_detail_card.dart';
import '../widgets/trip_primary_button.dart';
import '../widgets/trip_success_dialog.dart';
import '../widgets/trip_theme_constants.dart';

class TripDetailsScreen extends StatelessWidget {
  final GeneratedPlan plan;

  const TripDetailsScreen({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final imageUrls = plan.places
        .map((place) => place.imageUrl)
        .whereType<String>()
        .where((url) => url.trim().isNotEmpty)
        .toList();

    return Scaffold(
      backgroundColor: TripColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back to Plans Row
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: TripColors.textDark,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Back to Plans',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: TripColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Selected Plan Top Card
              Container(
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
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: TripColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Horizontal Images Row
                    SizedBox(
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: imageUrls.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              imageUrls[index],
                              width: 95,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 95,
                                height: 80,
                                color: TripColors.peachBanner,
                                child: const Icon(
                                  Icons.image,
                                  color: TripColors.textMuted,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Budget Confirmed Box
                    BudgetConfirmedCard(plan: plan),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Places Details Cards
              ...plan.places.map((place) => PlaceDetailCard(place: place)),
              const SizedBox(height: 10),

              // Cost Summary Card
              CostSummaryCard(plan: plan),
              const SizedBox(height: 24),

              // Confirm Button
              TripPrimaryButton(
                text: 'Confirm This Plan',
                icon: Icons.check_circle_outline,
                onPressed: () {
                  final destination = context
                      .read<TripRequestCubit>()
                      .state
                      .request
                      .destination;

                  TripSuccessDialog.show(
                    context,
                    destination: destination,
                    onViewMyTrips: () {
                      Navigator.pop(context);
                      // Navigate to My Trips screen if needed
                    },
                    onBackToHome: () {
                      Navigator.pop(context);
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
