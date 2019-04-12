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
      yield await mapInitEventToState(event);
    }
  }

  Future<LoadedDesisionListState> mapInitEventToState(
      InitDesisionListEvent event) async {
    var items = await rouletteRepository.findAll();

    return LoadedDesisionListState(items);
  }
}
