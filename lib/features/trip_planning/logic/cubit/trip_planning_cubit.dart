import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_me/features/trip_planning/logic/cubit/trip_planning_state.dart';

import '../../data/models/planner_request.dart';
import '../../data/repos/place_repo.dart';
import '../planner_service.dart';

class PlannerCubit extends Cubit<PlannerState> {
  final PlaceRepository placeRepository;
  final PlannerService plannerService;

  PlannerCubit({required this.placeRepository, required this.plannerService})
    : super(PlannerInitial());

  Future<void> generatePlans(PlannerRequest request) async {
    emit(PlannerLoading());

    try {
      // 1. Fetch places from Supabase.
      final places = await placeRepository.fetchPlaces(request);

      // 2. Generate plans using the planner service.
      final plans = plannerService.generatePlans(
        places: places,
        request: request,
      );

      // 3. Handle the result.
      if (plans.isEmpty) {
        emit(PlannerError('No suitable plans found for this budget.'));
        return;
      }

      emit(PlannerSuccess(plans));
    } catch (e) {
      emit(PlannerError('Failed to generate plans: $e'));
    }
  }
}
