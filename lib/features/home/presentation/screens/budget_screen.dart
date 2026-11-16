import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../trip_request/logic/cubit/trip_request_cubit.dart';
import '../../../trip_planning/data/models/planner_request.dart';
import '../../../trip_planning/logic/cubit/trip_planning_cubit.dart';
import '../../../trip_planning/presentation/screens/generated_plans_screen.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  late final TextEditingController budgetController;

  static const Color backgroundColor = Color(0xFFFFF8F4);
  static const Color yellowColor = Color(0xFFF8D967);
  static const Color darkBrown = Color(0xFF302318);
  static const Color secondaryBrown = Color(0xFF685744);
  static const Color lightBrown = Color(0xFFEBDCC8);

  static const String cairoId = 'f6b063fb-a0fa-4ffe-b5e5-07b0c353126b';

  static const String alexandriaId = 'ace3866a-4725-4bc3-a72f-a46633c1dd4d';

  static const String sharmId = 'fd7c28db-48c9-498b-b363-a2979c150cc6';

  final List<Map<String, String>> categories = const [
    {'title': '🏛️ Historical', 'id': '7792f8d9-fa77-4395-b3bf-b5031151df7c'},
    {
      'title': '🍲 Food & Street Eats',
      'id': '51ffcaca-2c4a-43e4-9720-94a2c401bf96',
    },
    {
      'title': '🎡 Entertainment & Leisure',
      'id': 'b68c232d-01ec-4980-a802-ac5c19cdbfa4',
    },
    {
      'title': '🏖️ Beaches & Watersports',
      'id': 'd158f0c3-890a-4495-961a-c9063f2bde5d',
    },
    {
      'title': '🌴 Nature & Parks',
      'id': '10d203df-0206-4157-bcdf-890ce2804bbd',
    },
    {
      'title': '🛍️ Souks & Shopping',
      'id': 'fe923c8e-3838-4108-a222-178f3946349b',
    },
  ];

  List<Map<String, String>> getAvailableCategories(String destinationId) {
    if (destinationId == cairoId) {
      return categories
          .where(
            (category) =>
                category['id'] != 'd158f0c3-890a-4495-961a-c9063f2bde5d',
          )
          .toList();
    }

    if (destinationId == alexandriaId || destinationId == sharmId) {
      return categories;
    }

    return [];
  }

  @override
  void initState() {
    super.initState();

    final savedText = context.read<TripRequestCubit>().state.budgetText;

    budgetController = TextEditingController(text: savedText);
  }

  @override
  void dispose() {
    budgetController.dispose();
    super.dispose();
  }

  void generateTrip(TripRequestCubit cubit) {
    if (!cubit.validateTripRequest()) {
      return;
    }

    final tripData = cubit.getTripRequest();

    final plannerRequest = PlannerRequest(
      destinationId: tripData.destinationId,
      budget: tripData.budget!.toDouble(),
      selectedCategoryIds: tripData.categories,
    );

    context.read<PlannerCubit>().generatePlans(plannerRequest);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GeneratedPlansScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripRequestCubit, TripRequestState>(
      builder: (context, state) {
        final cubit = context.read<TripRequestCubit>();

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: darkBrown,
                              ),
                            ),
                            const Spacer(),
                            const CircleAvatar(
                              radius: 22,
                              backgroundColor: yellowColor,
                              child: Icon(Icons.person, color: darkBrown),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'STEP 2 OF 3',
                          style: TextStyle(
                            color: secondaryBrown,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Set Your Budget',
                          style: TextStyle(
                            color: darkBrown,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'Set your budget and choose what you love.',
                          style: TextStyle(color: secondaryBrown, fontSize: 14),
                        ),

                        const SizedBox(height: 20),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: const LinearProgressIndicator(
                            value: 0.67,
                            minHeight: 7,
                            backgroundColor: lightBrown,
                            valueColor: AlwaysStoppedAnimation(yellowColor),
                          ),
                        ),

                        const SizedBox(height: 28),

                        buildDestinationCard(state),

                        const SizedBox(height: 25),

                        buildBudgetCard(cubit, state),

                        const SizedBox(height: 25),

                        buildCategoriesCard(cubit, state),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 10, 22, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: state.isFormValid
                          ? () => generateTrip(cubit)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellowColor,
                        disabledBackgroundColor: const Color(0xFFE8E0D5),
                        foregroundColor: darkBrown,
                        disabledForegroundColor: const Color(0xFF9B9185),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Generate My Trip',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: state.isFormValid
                                  ? darkBrown
                                  : secondaryBrown,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDestinationCard(TripRequestState state) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: lightBrown),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFFFF1C2),
            child: Icon(Icons.location_on, color: darkBrown),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'YOUR DESTINATION',
                  style: TextStyle(
                    color: secondaryBrown,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  state.request.destination,
                  style: const TextStyle(
                    color: darkBrown,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Change',
              style: TextStyle(
                color: secondaryBrown,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBudgetCard(TripRequestCubit cubit, TripRequestState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: state.budgetError != null
              ? const Color(0xFFE8A1A1)
              : lightBrown,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'YOUR TOTAL BUDGET',
            style: TextStyle(
              color: secondaryBrown,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: budgetController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: darkBrown,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: cubit.updateBudget,
                  decoration: const InputDecoration(
                    hintText: 'Enter your budget',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const Text(
                'EGP',
                style: TextStyle(
                  color: secondaryBrown,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const Divider(color: lightBrown),

          const SizedBox(height: 5),

          const Text(
            'Enter the total amount you plan to spend.',
            style: TextStyle(color: secondaryBrown, fontSize: 12),
          ),

          if (state.budgetError != null) ...[
            const SizedBox(height: 14),
            buildErrorMessage(state.budgetError!),
          ],
        ],
      ),
    );
  }

  Widget buildCategoriesCard(TripRequestCubit cubit, TripRequestState state) {
    final availableCategories = getAvailableCategories(
      state.request.destinationId,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: state.categoryError != null
              ? const Color(0xFFE8A1A1)
              : lightBrown,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CHOOSE YOUR VIBES',
            style: TextStyle(
              color: secondaryBrown,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'What would you love to experience?',
            style: TextStyle(color: darkBrown, fontSize: 14),
          ),

          const SizedBox(height: 17),

          Wrap(
            spacing: 10,
            runSpacing: 12,
            children: availableCategories.map((category) {
              final categoryId = category['id']!;
              final categoryTitle = category['title']!;

              final isSelected = state.request.categories.contains(categoryId);

              return GestureDetector(
                onTap: () => cubit.toggleCategory(categoryId),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? yellowColor : backgroundColor,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected ? yellowColor : lightBrown,
                    ),
                  ),
                  child: Text(
                    categoryTitle,
                    style: TextStyle(
                      color: darkBrown,
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          if (state.categoryError != null) ...[
            const SizedBox(height: 17),
            buildErrorMessage(state.categoryError!),
          ] else if (state.request.categories.isEmpty) ...[
            const SizedBox(height: 14),
            const Text(
              'Select at least one category to continue.',
              style: TextStyle(color: secondaryBrown, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildErrorMessage(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF2CACA)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Color(0xFFC64F4F),
            size: 19,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFFAD4141),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
