import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../repositories/roulette_option_repository.dart';
import './roulette.dart';
import '../../models/roulette.dart';
import '../../models/roulette_option.dart';
import 'package:flutter/material.dart';

class RouletteBloc extends Bloc<RouletteEvent, RouletteState> {
  RouletteOptionRepository optionRepository;

  RouletteBloc({@required this.optionRepository});

  @override
  RouletteState get initialState => InitialRouletteState();

  @override
  Stream<RouletteState> mapEventToState(
    RouletteEvent event,
  ) async* {
    if (event is InitRouletteEvent) {
      yield await mapInitEventToState(event);
    } else if (event is ChangeRouletteEvent) {
      yield await mapChangeEventToState(event);
    }
  }

  Future<LoadedRouletteState> mapInitEventToState(RouletteEvent event) async {
    var roulette = Roulette('-', '-');
    return await makeStateFromRoulette(roulette);
  }

  Future<LoadedRouletteState> mapChangeEventToState(
      ChangeRouletteEvent event) async {
    return makeStateFromRoulette(event.roulette);
  }

  Future<LoadedRouletteState> makeStateFromRoulette(Roulette roulette) async {
    List<RouletteOption> options = await optionRepository.getAllOptions();
    return LoadedRouletteState(roulette: roulette, options: options);
  }
}
