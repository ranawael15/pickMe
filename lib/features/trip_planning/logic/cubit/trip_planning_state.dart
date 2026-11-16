import '../../data/models/generated_plan.dart';

abstract class PlannerState {}

class PlannerInitial extends PlannerState {}

class PlannerLoading extends PlannerState {}

class PlannerSuccess extends PlannerState {
  final List<GeneratedPlan> plans;

  PlannerSuccess(this.plans);
}

class PlannerError extends PlannerState {
  final String message;

  PlannerError(this.message);
}
