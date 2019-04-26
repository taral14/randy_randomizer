import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:randy_randomizer/models/roulette_option.dart';
import 'package:randy_randomizer/repositories/roulette_option_repository.dart';
import 'package:randy_randomizer/repositories/roulette_repository.dart';
import './update_desision.dart';

class UpdateDesisionBloc
    extends Bloc<UpdateDesisionEvent, UpdateDesisionState> {
  final RouletteOptionRepository optionRepository;
  final RouletteRepository rouletteRepository;

  UpdateDesisionBloc({this.rouletteRepository, this.optionRepository});

  @override
  UpdateDesisionState get initialState => LoadingUpdateDesisionState();

  @override
  Stream<UpdateDesisionState> mapEventToState(
    UpdateDesisionEvent event,
  ) async* {
    if (event is AddOptionEvent) {
      yield* mapAddOptionToState(event);
    } else if (event is RemoveOptionEvent) {
      yield* mapRemoveOptionToState(event);
    } else if (event is InitUpdateDesisionEvent) {
      yield* mapInitToState(event);
    } else if (event is UpdateOptionEvent) {
      yield* mapRenameOptionToState(event);
    } else if (event is SaveFormEvent) {
      yield* mapSaveToState(event);
    }
  }

  Stream<UpdateDesisionState> mapSaveToState(SaveFormEvent event) async* {
    if (currentState is LoadedUpdateDesisionState) {
      var state = currentState as LoadedUpdateDesisionState;
      var newOptions = state.options;
      var newOptionIds = newOptions.map((o) => o.id).toList();
      var oldOptions =
          await optionRepository.getRouletteOptions(state.roulette);
      var delOptions = oldOptions
          .where((oldOption) => newOptionIds.indexOf(oldOption.id) == -1);
      for (RouletteOption delOption in delOptions) {
        await optionRepository.deleteById(delOption.id);
      }
      await rouletteRepository.save(state.roulette);
      for (int i = 0; i < newOptions.length; i++) {
        await optionRepository.addOptionToRoulette(
            state.roulette, newOptions[i]);
      }
      yield SuccessSavedDesisionState();
    }
  }

  Stream<LoadedUpdateDesisionState> mapRenameOptionToState(
      UpdateOptionEvent event) async* {
    var state = currentState as LoadedUpdateDesisionState;
    final List<RouletteOption> updatedOptions = state.options.map((option) {
      return option.id == event.option.id ? event.option : option;
    }).toList();
    yield LoadedUpdateDesisionState(state.roulette, updatedOptions);
  }

  Stream<LoadedUpdateDesisionState> mapInitToState(
      InitUpdateDesisionEvent event) async* {
    var options = await optionRepository.getRouletteOptions(event.roulette);
    yield LoadedUpdateDesisionState(event.roulette, options);
  }

  Stream<LoadedUpdateDesisionState> mapRemoveOptionToState(
      RemoveOptionEvent event) async* {
    if (currentState is LoadedUpdateDesisionState) {
      var state = currentState as LoadedUpdateDesisionState;
      List<RouletteOption> options =
          state.options.where((option) => option != event.option).toList();
      yield LoadedUpdateDesisionState(state.roulette, options);
    }
  }

  Stream<LoadedUpdateDesisionState> mapAddOptionToState(
      AddOptionEvent event) async* {
    if (currentState is LoadedUpdateDesisionState) {
      var state = currentState as LoadedUpdateDesisionState;
      List<RouletteOption> options =
          state.options.where((option) => option.title != '').toList();
      options.add(RouletteOption(null, '', state.roulette.id));
      yield LoadedUpdateDesisionState(state.roulette, options);
    }
  }
}
