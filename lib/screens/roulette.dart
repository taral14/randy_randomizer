import 'package:flutter/material.dart';
import '../repositories/roulette_option_repository.dart';
import '../models/roulette_option.dart';
import '../widgets/roulette.dart';
import '../widgets/roulette_title.dart';
import 'dart:math';
import 'dart:async';

class RouletteScreen extends StatefulWidget {
  final String title;

  RouletteScreen({this.title});

  @override
  RouletteScreenState createState() => RouletteScreenState();
}

class RouletteScreenState extends State<RouletteScreen>
    with TickerProviderStateMixin {
  Animation<double> spinAnimation;
  AnimationController spinController;
  StreamController<RouletteOption> title$;
  List<RouletteOption> options = [];
  RouletteOptionRepository repository;

  //String title = '???';

  initState() {
    super.initState();
    repository = RouletteOptionRepository();
    title$ = StreamController<RouletteOption>();
    spinController = AnimationController(
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );
    spinController.addListener(onSpinning);
    initAnumation();
    loadOptions();
  }

  loadOptions() async {
    List<RouletteOption> newOptions = await repository.getAllOptions();
    setState(() {
      options = newOptions;
    });
  }

  @override
  void dispose() {
    title$.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roulette'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildTitle(),
              GestureDetector(
                onTap: spinRoulette,
                child: Container(
                  height: 370.0,
                  child: drawRoulette(),
                  margin: EdgeInsets.all(10.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildTitle() {
    return StreamBuilder(
      stream: title$.stream,
      builder: (context, snapshot) {
        String title = snapshot.hasData ? snapshot.data.title : '???';
        return RouletteTitle(title: title);
      },
    );
  }

  initAnumation() {
    var random = Random();
    print(random.nextDouble());
    double laps = 9.0 + random.nextDouble();
    var animation = CurvedAnimation(
      parent: spinController,
      curve: Curves.easeOutExpo,
    );

    spinAnimation = Tween<double>(
      begin: 0.0,
      end: pi * 2 * laps,
    ).animate(animation);
  }

  onSpinning() {
    var value = (spinAnimation.value / pi / 2 - 0.25) % 1;
    int index = (value * options.length).floor();
    title$.sink.add(options[options.length - 1 - index]);
  }

  spinRoulette() {
    initAnumation();

    spinController.reset();
    spinController.forward();
  }

  Widget drawRoulette() {
    return AnimatedBuilder(
      animation: spinAnimation,
      child: Roulette(options: options),
      builder: (context, child) {
        return Transform.rotate(
          child: child,
          alignment: Alignment.center,
          angle: spinAnimation.value,
        );
      },
    );
  }
}
