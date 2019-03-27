import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class RouletteOptionBloc extends Bloc<RouletteOptionEvent, RouletteOptionState> {
  @override
  RouletteOptionState get initialState => InitialRouletteOptionState();

  @override
  Stream<RouletteOptionState> mapEventToState(
    RouletteOptionEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
