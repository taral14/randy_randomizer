import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:randy_randomizer/repositories/roulette_repository.dart';
import './desision_list.dart';

class DesisionListBloc extends Bloc<DesisionListEvent, DesisionListState> {
  @override
  DesisionListState get initialState => InitialDesisionListState();

  RouletteRepository rouletteRepository;

  DesisionListBloc({this.rouletteRepository});

  @override
  Stream<DesisionListState> mapEventToState(
    DesisionListEvent event,
  ) async* {
    if (event is InitDesisionListEvent) {
      print('DesisionListBloc:InitDesisionListEvent');
      yield* mapInitEventToState(event);
    } else if (event is DeleteDesisionEvent) {
      yield* mapDeleteEventToState(event);
    }
  }

  Stream<LoadedDesisionListState> mapDeleteEventToState(
      DeleteDesisionEvent event) async* {
    await rouletteRepository.deleteById(event.roulette.id);
    var items = await rouletteRepository.findAll();
    yield LoadedDesisionListState(items);
  }

  Stream<LoadedDesisionListState> mapInitEventToState(
      InitDesisionListEvent event) async* {
    var items = await rouletteRepository.findAll();

    yield LoadedDesisionListState(items);
  }
}
