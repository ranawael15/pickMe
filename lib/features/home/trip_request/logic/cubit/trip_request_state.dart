part of 'trip_request_cubit.dart';

class TripRequestData extends Equatable {
  final String destination;
  final String destinationId;
  final int? budget;
  final List<String> categories;

  const TripRequestData({
    this.destination = '',
    this.destinationId = '',
    this.budget,
    this.categories = const [],
  });

  TripRequestData copyWith({
    String? destination,
    String? destinationId,
    int? budget,
    bool clearBudget = false,
    List<String>? categories,
  }) {
    return TripRequestData(
      destination: destination ?? this.destination,
      destinationId: destinationId ?? this.destinationId,
      budget: clearBudget ? null : (budget ?? this.budget),
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [destination, destinationId, budget, categories];
}

class TripRequestState extends Equatable {
  final TripRequestData request;
  final String budgetText;
  final String? budgetError;
  final String? categoryError;
  final bool isBudgetTouched;
  final bool isCategoryTouched;

  const TripRequestState({
    this.request = const TripRequestData(),
    this.budgetText = '',
    this.budgetError,
    this.categoryError,
    this.isBudgetTouched = false,
    this.isCategoryTouched = false,
  });

  bool get isFormValid {
    return request.destination.trim().isNotEmpty &&
        request.destinationId.trim().isNotEmpty &&
        request.budget != null &&
        request.budget! > 0 &&
        request.categories.isNotEmpty;
  }

  TripRequestState copyWith({
    TripRequestData? request,
    String? budgetText,
    String? budgetError,
    bool clearBudgetError = false,
    String? categoryError,
    bool clearCategoryError = false,
    bool? isBudgetTouched,
    bool? isCategoryTouched,
  }) {
    return TripRequestState(
      request: request ?? this.request,
      budgetText: budgetText ?? this.budgetText,
      budgetError: clearBudgetError ? null : (budgetError ?? this.budgetError),
      categoryError: clearCategoryError
          ? null
          : (categoryError ?? this.categoryError),
      isBudgetTouched: isBudgetTouched ?? this.isBudgetTouched,
      isCategoryTouched: isCategoryTouched ?? this.isCategoryTouched,
    );
  }

  @override
  List<Object?> get props => [
    request,
    budgetText,
    budgetError,
    categoryError,
    isBudgetTouched,
    isCategoryTouched,
  ];
}
