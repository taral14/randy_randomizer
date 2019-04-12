import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:randy_randomizer/models/roulette.dart';
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
      yield await addOption(event);
    } else if (event is RemoveOptionEvent) {
      yield await removeOption(event);
    } else if (event is InitUpdateDesisionEvent) {
      yield await initDesisionForm(event);
    }
  }

  Future<LoadedUpdateDesisionState> initDesisionForm(
      InitUpdateDesisionEvent event) async {
    var options = await optionRepository.getRouletteOptions(event.roulette);
    return LoadedUpdateDesisionState(event.roulette, options);
  }

  removeOption(RemoveOptionEvent event) async {
    if (currentState is LoadedUpdateDesisionState) {
      var state = currentState as LoadedUpdateDesisionState;
      List<RouletteOption> options =
          state.options.map((option) => option).toList();
      options = options.where((option) => option != event.option).toList();
      return LoadedUpdateDesisionState(state.roulette, options);
    }
  }

  addOption(AddOptionEvent event) async {
    if (currentState is LoadedUpdateDesisionState) {
      var state = currentState as LoadedUpdateDesisionState;
      List<RouletteOption> options =
          state.options.map((option) => option).toList();
      options.add(RouletteOption('', state.roulette.id, []));
      return LoadedUpdateDesisionState(state.roulette, options);
    }
  }
}
