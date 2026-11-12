import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trip_request_state.dart';

class TripRequestCubit extends Cubit<TripRequestState> {
  TripRequestCubit() : super(TripRequestInitial());
}
