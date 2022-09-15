import 'package:equatable/equatable.dart';

import '../../Utils/ApiStatus/api_status.dart';

class SpaceXBlocState extends Equatable {
  const SpaceXBlocState();

  @override
  List<Object> get props => [];
}

class LoadingState extends SpaceXBlocState {}

class SuccessState extends SpaceXBlocState {
  final Success response;

  const SuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class FailureState extends SpaceXBlocState {
  final Failure failure;

  const FailureState(this.failure);

  @override
  List<Object> get props => [failure];
}
