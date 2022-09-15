import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_launches_case/Bloc/SpaceXBloc/spacex_event.dart';

import '../../Repository/spacex_repository.dart';
import '../../Utils/ApiStatus/api_status.dart';
import 'spacex_bloc_state.dart';

class SpaceXBloc extends Bloc<SpaceXBlocEvent, SpaceXBlocState> {
  final SpaceXRepository serviceRepository;

  SpaceXBloc({
    required this.serviceRepository,
  })  
  // ignore: unnecessary_null_comparison
  : assert(serviceRepository != null),
        super(LoadingState()) {
    on<SpaceXBlocEvent>((event, emit) async {
      if (event is GetLastLaunch) {
        await _getLastLaunch(emit);
      }
      if (event is GetAllLaunchs) {
        await _getAllLaunch(emit);
      }
    });
  }

  Future _getLastLaunch(
    Emitter<SpaceXBlocState> emit,
  ) async {
    emit(LoadingState());
    try {
      final response = await serviceRepository.getLastLaunch();
      if (response is Success) {
        emit(SuccessState(response));
      } else if (response is Failure) {
        emit(FailureState(response));
      }
    } catch (_) {
      emit(FailureState(Failure(errorMessage: _)));
    }
  }

  Future _getAllLaunch(
    Emitter<SpaceXBlocState> emit,
  ) async {
    emit(LoadingState());
    try {
      final response = await serviceRepository.getAllLaunchs();
      if (response is Success) {
        emit(SuccessState(response));
      } else if (response is Failure) {
        emit(FailureState(response));
      }
    } catch (_) {
      emit(FailureState(Failure(errorMessage: _)));
    }
  }
}
