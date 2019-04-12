import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:randy_randomizer/bloc/current/current.dart';
import '../../repositories/roulette_option_repository.dart';
import '../../repositories/roulette_repository.dart';
import './roulette.dart';
import '../../models/roulette.dart';
import '../../models/roulette_option.dart';
import 'package:flutter/material.dart';

class RouletteBloc extends Bloc<RouletteEvent, RouletteState> {
  RouletteOptionRepository optionRepository;
  CurrentBloc currentBloc;

  RouletteBloc({
    @required this.optionRepository,
    @required this.currentBloc,
  }) {
    currentBloc.state.listen((CurrentState state) {
      if (state is LoadedCurrentState) {
        dispatch(ChangeRouletteEvent(state.roulette));
      }
    });
  }

  @override
  RouletteState get initialState => InitialRouletteState();

  @override
  Stream<RouletteState> mapEventToState(
    RouletteEvent event,
  ) async* {
    if (event is ChangeRouletteEvent) {
      yield await mapChangeEventToState(event);
    }
  }

  Future<LoadedRouletteState> mapChangeEventToState(
      ChangeRouletteEvent event) async {
    return makeStateFromRoulette(event.roulette);
  }

  Future<LoadedRouletteState> makeStateFromRoulette(Roulette roulette) async {
    List<RouletteOption> options =
        await optionRepository.getRouletteOptions(roulette);
    return LoadedRouletteState(roulette: roulette, options: options);
  }
}
