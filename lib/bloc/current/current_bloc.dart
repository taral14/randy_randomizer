import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:randy_randomizer/repositories/roulette_repository.dart';
import './current.dart';
import 'package:flutter/material.dart';

class CurrentBloc extends Bloc<CurrentEvent, CurrentState> {
  @override
  CurrentState get initialState => InitialCurrentState();

  RouletteRepository rouletteRepository;

  CurrentBloc({@required this.rouletteRepository});

  @override
  Stream<CurrentState> mapEventToState(
    CurrentEvent event,
  ) async* {
    if (event is InitCurrentEvent) {
      var roulette = await rouletteRepository.getFirst();
      yield LoadedCurrentState(roulette);
    } else if (event is ChangeCurrentEvent) {
      yield LoadedCurrentState(event.roulette);
    }
  }
}
