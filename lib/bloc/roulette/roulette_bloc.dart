import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class RouletteBloc extends Bloc<RouletteEvent, RouletteState> {
  @override
  RouletteState get initialState => InitialRouletteState();

  @override
  Stream<RouletteState> mapEventToState(
    RouletteEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
