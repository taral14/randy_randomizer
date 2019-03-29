import 'package:flutter/material.dart';
import 'package:randy_randomizer/repositories/roulette_option_repository.dart';
import 'screens/roulette.dart';
import 'bloc/roulette/roulette.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  RouletteBloc rouletteBloc;
  RouletteOptionRepository optionRepository;

  void initState() {
    super.initState();
    optionRepository = RouletteOptionRepository();
    rouletteBloc = RouletteBloc(optionRepository: optionRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<RouletteBloc>(
        bloc: rouletteBloc,
        child: RouletteScreen(title: 'Flutter Demo Home Page'),
      ),
    );
  }

  @override
  void dispose() {
    rouletteBloc.dispose();
    super.dispose();
  }
}
