import 'package:equatable/equatable.dart';

abstract class SpaceXBlocEvent extends Equatable {
  const SpaceXBlocEvent();
}

class GetLastLaunch extends SpaceXBlocEvent {
  const GetLastLaunch();

  @override
  List<Object> get props => [];
}

class GetAllLaunchs extends SpaceXBlocEvent {
  const GetAllLaunchs();

  @override
  List<Object> get props => [];
}
