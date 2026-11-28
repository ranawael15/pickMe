import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:pick_me/features/trip_planning/data/models/generated_plan.dart';
import '../../../home/trip_request/logic/cubit/trip_request_cubit.dart';
import '../widgets/budget_confirmed_card.dart';
import '../widgets/cost_summary_card.dart';
import '../widgets/place_detail_card.dart';
import '../widgets/trip_primary_button.dart';
import '../widgets/trip_success_dialog.dart';
import '../widgets/trip_theme_constants.dart';
import 'mock_payment_screen.dart';

class TripDetailsScreen extends StatefulWidget {
  final GeneratedPlan plan;

  const TripDetailsScreen({super.key, required this.plan});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  bool _isSaving = false;

  Future<void> _confirmTrip() async {
    if (_isSaving) return;

    if (widget.plan.places.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No places found in this plan.')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      if (user == null) {
        throw Exception('Please login first.');
      }

      // Save trip
      final trip = await supabase
          .from('trips')
          .insert({
            'user_id': user.id,
            'destination_id': widget.plan.places.first.destinationId,
            'budget': widget.plan.budget,
          })
          .select('id')
          .single();

      final tripId = trip['id'];

      // Save trip places
      final tripPlaces = widget.plan.places.map((place) {
        return {
          'trip_id': tripId,
          'place_id': place.id,
          'place_name': place.name,
          'estimated_cost': place.estimatedCost,
          'image_url': place.imageUrl,
        };
      }).toList();

      await supabase.from('trip_places').insert(tripPlaces);

      if (!mounted) return;

      final destination = context
          .read<TripRequestCubit>()
          .state
          .request
          .destination;

      await TripSuccessDialog.show(
        context,
        destination: destination,

        // Cancel trip
        onCancel: () async {
          try {
            await supabase
                .from('trips')
                .update({'status': 'Cancelled'})
                .eq('id', tripId);

            if (!mounted) return;

            Navigator.pop(context); // Close dialog
            Navigator.pop(context); // Back to Plans
          } catch (e) {
            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to cancel trip: $e')),
            );
          }
        },

        // Go to Book Now
        onBookNow: () {
          Navigator.pop(context); // Close success dialog

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MockPaymentScreen(
                destination: destination,
                amount: widget.plan.budget.toDouble(),
              ),
            ),
          );
        },

      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save trip: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrls = widget.plan.places
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
                      widget.plan.name,
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
                    BudgetConfirmedCard(plan: widget.plan),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Places Details Cards
              ...widget.plan.places.map(
                (place) => PlaceDetailCard(place: place),
              ),
              const SizedBox(height: 10),

              // Cost Summary Card
              CostSummaryCard(plan: widget.plan),
              const SizedBox(height: 24),

              // Confirm Button
              TripPrimaryButton(
                text: _isSaving ? 'Saving...' : 'Confirm This Plan',
                icon: Icons.check_circle_outline,
                onPressed: _confirmTrip,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
