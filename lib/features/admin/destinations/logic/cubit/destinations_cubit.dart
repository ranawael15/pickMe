import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'destinations_state.dart';

class DestinationsCubit extends Cubit<DestinationsState> {
  DestinationsCubit() : super(DestinationsInitial());
}
