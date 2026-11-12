import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trip_planning_state.dart';

class TripPlanningCubit extends Cubit<TripPlanningState> {
  TripPlanningCubit() : super(TripPlanningInitial());
}
