import 'package:flutter/material.dart';
import 'package:randy_randomizer/bloc/current/current.dart';
import 'package:randy_randomizer/repositories/roulette_option_repository.dart';
import 'package:randy_randomizer/repositories/roulette_repository.dart';
import 'package:randy_randomizer/screens/create_desision.dart';
import 'package:randy_randomizer/screens/desision_list.dart';
import 'package:randy_randomizer/screens/update_desision.dart';
import 'screens/roulette.dart';
import 'bloc/roulette/roulette.dart';
import 'bloc/desision_list/desision_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/setting.dart';
import 'package:flutter/rendering.dart';

void main() async {
  //debugPaintSizeEnabled = true;
  return runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  CurrentBloc currentBloc;
  RouletteBloc rouletteBloc;

  void initState() {
    super.initState();
    var optionRepository = RouletteOptionRepository();
    var rouletteRepository = RouletteRepository();
    currentBloc = CurrentBloc(
      rouletteRepository: rouletteRepository,
    );
    rouletteBloc = RouletteBloc(
      currentBloc: currentBloc,
      optionRepository: optionRepository,
    );
    currentBloc.dispatch(InitCurrentEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<RouletteBloc>(bloc: rouletteBloc),
        BlocProvider<CurrentBloc>(bloc: currentBloc),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: 'Helvetica',
            //primarySwatch: Colors.blue,
            primarySwatch: Colors.grey,
            primaryTextTheme: TextTheme(
              title: TextStyle(color: Color.fromRGBO(53, 54, 55, 1)),
            ),
            appBarTheme: AppBarTheme(
              elevation: 0.0,
              color: Colors.white,
            )),
        home: RouletteScreen(title: 'Flutter Demo Home Page'),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                  builder: (context) =>
                      RouletteScreen(title: 'Flutter Demo Home Page'));
              break;
            case '/update-desision':
              return MaterialPageRoute(
                  builder: (context) =>
                      UpdateDesisionScreen(roulette: settings.arguments));
              break;
            case '/create-desision':
              return MaterialPageRoute(
                  builder: (context) => CreateDesisionScreen());
              break;
            case '/setting':
              return MaterialPageRoute(builder: (context) => SettingScreen());
              break;
            case '/desision-list':
              return MaterialPageRoute(
                  builder: (context) => DesisionListScreen());
              break;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    rouletteBloc.dispose();
    super.dispose();
  }
}
