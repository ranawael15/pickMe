import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_me/features/trip_planning/logic/cubit/trip_planning_state.dart';

import '../../../home/trip_request/logic/cubit/trip_request_cubit.dart';
import '../../logic/cubit/trip_planning_cubit.dart';
import '../widgets/plan_card.dart';
import '../widgets/trip_theme_constants.dart';
import 'trip_details_screen.dart';

class GeneratedPlansScreen extends StatelessWidget {
  const GeneratedPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TripColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.arrow_back, color: TripColors.textDark),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              ),
              const SizedBox(height: 16),

              // Step indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: TripColors.primaryYellow,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            '3',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: TripColors.textDark,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Step 3 of 3',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: TripColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Next: confirm & review',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: TripColors.textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Title
              const Text(
                'Choose Your Plan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: TripColors.textDark,
                ),
              ),
              const SizedBox(height: 6),

              // Yellow Progress bar
              Container(
                height: 5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: TripColors.primaryYellow,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 12),

              // Destination & Budget
              BlocBuilder<TripRequestCubit, TripRequestState>(
                builder: (context, requestState) {
                  final request = requestState.request;

                  return Text(
                    'Destination: ${request.destination} • Budget: ${request.budget ?? 0} EGP',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF57534E),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Plan Cards List
              BlocBuilder<PlannerCubit, PlannerState>(
                builder: (context, plannerState) {
                  if (plannerState is PlannerLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (plannerState is PlannerError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          plannerState.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: TripColors.textMuted,
                          ),
                        ),
                      ),
                    );
                  }

                  if (plannerState is PlannerSuccess) {
                    return Column(
                      children: plannerState.plans.map((plan) {
                        return PlanCard(
                          plan: plan,
                          onViewDetails: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TripDetailsScreen(plan: plan),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  }

                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'Waiting for plans...',
                        style: TextStyle(
                          fontSize: 14,
                          color: TripColors.textMuted,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
