import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'trip_request_state.dart';

class TripRequestCubit extends Cubit<TripRequestState> {
  TripRequestCubit() : super(const TripRequestState());

  void setDestination(String destination, String destinationId) {
    final destinationChanged = state.request.destinationId != destinationId;

    emit(
      state.copyWith(
        request: state.request.copyWith(
          destination: destination,
          destinationId: destinationId,
          categories: destinationChanged ? [] : state.request.categories,
        ),
        categoryError: null,
        clearCategoryError: true,
        isCategoryTouched: destinationChanged ? false : state.isCategoryTouched,
      ),
    );
  }

  void updateBudget(String value) {
    final text = value.trim();
    final parsedBudget = int.tryParse(text);

    String? error;

    if (text.isEmpty) {
      error = 'Please enter your budget.';
    } else if (parsedBudget == null) {
      error = 'Please enter a valid whole number.';
    } else if (parsedBudget <= 0) {
      error = 'Your budget must be greater than zero.';
    }

    emit(
      state.copyWith(
        request: state.request.copyWith(
          budget: error == null ? parsedBudget : null,
          clearBudget: error != null,
        ),
        budgetText: value,
        budgetError: error,
        clearBudgetError: error == null,
        isBudgetTouched: true,
      ),
    );
  }

  void toggleCategory(String categoryId) {
    final updatedCategories = List<String>.from(state.request.categories);

    if (updatedCategories.contains(categoryId)) {
      updatedCategories.remove(categoryId);
    } else {
      updatedCategories.add(categoryId);
    }

    final error = updatedCategories.isEmpty
        ? 'Please choose at least one category.'
        : null;

    emit(
      state.copyWith(
        request: state.request.copyWith(categories: updatedCategories),
        categoryError: error,
        clearCategoryError: error == null,
        isCategoryTouched: true,
      ),
    );
  }

  bool validateTripRequest() {
    final text = state.budgetText.trim();
    final budget = int.tryParse(text);

    String? budgetError;

    if (text.isEmpty) {
      budgetError = 'Please enter your budget.';
    } else if (budget == null) {
      budgetError = 'Please enter a valid whole number.';
    } else if (budget <= 0) {
      budgetError = 'Your budget must be greater than zero.';
    }

    final categoryError = state.request.categories.isEmpty
        ? 'Please choose at least one category.'
        : null;

    final destinationIsValid =
        state.request.destination.trim().isNotEmpty &&
        state.request.destinationId.trim().isNotEmpty;

    final updatedRequest = state.request.copyWith(
      budget: budgetError == null ? budget : null,
      clearBudget: budgetError != null,
    );

    emit(
      state.copyWith(
        request: updatedRequest,
        budgetError: budgetError,
        clearBudgetError: budgetError == null,
        categoryError: categoryError,
        clearCategoryError: categoryError == null,
        isBudgetTouched: true,
        isCategoryTouched: true,
      ),
    );

    return budgetError == null && categoryError == null && destinationIsValid;
  }

  TripRequestData getTripRequest() {
    return state.request;
  }
}
