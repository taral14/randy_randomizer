import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:randy_randomizer/models/roulette.dart';
import 'package:randy_randomizer/models/roulette_option.dart';
import 'package:randy_randomizer/repositories/roulette_option_repository.dart';
import 'package:randy_randomizer/repositories/roulette_repository.dart';
import './create_desision.dart';
import 'package:meta/meta.dart';

class CreateDesisionBloc
    extends Bloc<CreateDesisionEvent, CreateDesisionState> {
  final RouletteOptionRepository optionRepository;
  final RouletteRepository rouletteRepository;

  CreateDesisionBloc(
      {@required this.rouletteRepository, @required this.optionRepository});

  @override
  CreateDesisionState get initialState =>
      LoadedCreateDesisionState(Roulette(null, ''), []);

  @override
  Stream<CreateDesisionState> mapEventToState(
    CreateDesisionEvent event,
  ) async* {
    if (event is AddOptionEvent) {
      yield* mapAddOptionToState(event);
    } else if (event is RemoveOptionEvent) {
      yield* mapRemoveOptionToState(event);
    } else if (event is SaveFormEvent) {
      yield* mapSaveToState(event);
    }
  }

  Stream<CreateDesisionState> mapSaveToState(SaveFormEvent event) async* {
    if (currentState is LoadedCreateDesisionState) {
      var state = currentState as LoadedCreateDesisionState;
      await rouletteRepository.save(state.roulette);
      for (int i = 0; i < state.options.length; i++) {
        await optionRepository.addOptionToRoulette(
            state.roulette, state.options[i]);
      }
      yield SuccessSavedDesisionState();
    }
  }

  Stream<LoadedCreateDesisionState> mapRemoveOptionToState(
      RemoveOptionEvent event) async* {
    if (currentState is LoadedCreateDesisionState) {
      var state = currentState as LoadedCreateDesisionState;
      List<RouletteOption> options =
          state.options.where((option) => option != event.option).toList();
      yield LoadedCreateDesisionState(state.roulette, options);
    }
  }

  Stream<LoadedCreateDesisionState> mapAddOptionToState(
      AddOptionEvent event) async* {
    if (currentState is LoadedCreateDesisionState) {
      var state = currentState as LoadedCreateDesisionState;
      List<RouletteOption> options =
          state.options.where((option) => option.title != '').toList();
      options.add(RouletteOption(null, '', state.roulette.id));
      yield LoadedCreateDesisionState(state.roulette, options);
    }
  }
}
