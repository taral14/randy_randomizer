import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randy_randomizer/bloc/roulette/roulette.dart';
import '../models/roulette_option.dart';
import '../widgets/roulette.dart';
import '../widgets/roulette_title.dart';
import 'package:audioplayers/audio_cache.dart';
import 'dart:math';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:vibrate/vibrate.dart';

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
  PublishSubject<String> title$;
  //StreamController<RouletteOption> title$;
  List<RouletteOption> options = [];
  Random random;
  Tween<double> spinTween;
  RouletteBloc rouletteBloc;
  StreamSubscription rouletteSubscription;
  AudioCache audioPlayer;

  initState() {
    super.initState();
    audioPlayer = AudioCache();
    title$ = PublishSubject<String>();
    rouletteBloc = BlocProvider.of<RouletteBloc>(context);
    rouletteSubscription = rouletteBloc.state.listen((state) {
      if (state is LoadedRouletteState) {
        options = state.options;
      }
    });
    rouletteBloc.dispatch(InitRouletteEvent());
    title$.stream
        .distinct()
        .throttle(new Duration(milliseconds: 80))
        .listen(playSound);

    title$.stream
        .distinct()
        .throttle(new Duration(milliseconds: 80))
        .listen(vibrate);
    initAnimation();
  }

  initAnimation() {
    spinController = AnimationController(
      duration: Duration(milliseconds: 6000),
      vsync: this,
    );
    spinController.addStatusListener(onFinish);
    spinController.addListener(onSpinning);
    random = new Random();
    spinTween = Tween<double>(begin: 0.0, end: pi * 2 * 9.0);
    spinAnimation = spinTween.animate(CurvedAnimation(
      parent: spinController,
      curve: Curves.easeOutExpo,
    ));
  }

  @override
  void dispose() {
    title$.close();
    rouletteSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roulette'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildTitle(),
            Container(
              height: 370.0,
              child: BlocBuilder<RouletteEvent, RouletteState>(
                bloc: rouletteBloc,
                builder: (BuildContext context, RouletteState state) {
                  if (state is LoadedRouletteState) {
                    return drawRoulette(state.options);
                  } else {
                    return drawRouletteLoading();
                  }
                },
              ),
              margin: EdgeInsets.all(10.0),
            ),
          ],
        ),
      ),
    );
  }

  void onFinish(AnimationStatus status) {
    if (status != AnimationStatus.completed) {
      return;
    }
    audioPlayer.play('tick.mp3');
    Vibrate.feedback(FeedbackType.heavy);
  }

  vibrate(String title) {
    Vibrate.feedback(FeedbackType.selection);
  }

  playSound(String title) {
    audioPlayer.play('tick.mp3');
  }

  buildTitle() {
    return Container(
      height: 80.0,
      child: StreamBuilder(
        stream: title$.stream.throttle(new Duration(milliseconds: 100)),
        builder: (context, snapshot) {
          String title = snapshot.hasData ? snapshot.data : '???';
          return RouletteTitle(title: title);
        },
      ),
    );
  }

  onSpinning() {
    var value = (spinAnimation.value / pi / 2 - 0.25) % 1;
    int index = (value * options.length).floor();
    final RouletteOption option = options[options.length - 1 - index];
    title$.sink.add(option.title);
  }

  spinRoulette() {
    spinTween.end = pi * 2 * (9.0 + random.nextDouble());
    spinController.reset();
    spinController.forward();
  }

  Widget drawRouletteLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget drawRoulette(List<RouletteOption> options) {
    return GestureDetector(
      onTap: spinRoulette,
      child: AnimatedBuilder(
        animation: spinAnimation,
        child: Roulette(options: options),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.center,
            angle: spinAnimation.value,
          );
        },
      ),
    );
  }
}
