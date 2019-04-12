import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randy_randomizer/bloc/roulette/roulette.dart';
import 'package:randy_randomizer/widgets/app_bar_button.dart';
import 'package:randy_randomizer/widgets/randy.dart';
import '../models/roulette_option.dart';
import '../widgets/roulette.dart';
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
  RandyStatus randyStatus;
  int selectedOptionIndex;

  initState() {
    super.initState();
    audioPlayer = AudioCache();
    audioPlayer.load('tick.mp3');
    initRouletteBloc();
    initAnimation();
    initTitleStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: AppBarButton(
            imagePath: 'assets/icon_setting.png',
            onPressed: () {
              Navigator.pushNamed(context, '/setting');
            },
          ),
          alignment: Alignment.center,
        ),
        actions: <Widget>[
          AppBarButton(
            imagePath: 'assets/icon_edit.png',
            onPressed: () {
              Navigator.pushNamed(context, '/desision-list');
            },
          ),
        ],
        //title: Text('Roulette'),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<RouletteEvent, RouletteState>(
        bloc: rouletteBloc,
        builder: (BuildContext context, RouletteState state) {
          if (state is LoadedRouletteState) {
            return buildBody(state);
          } else {
            return buildLoading();
          }
        },
      ),
    );
  }

  Widget buildBody(LoadedRouletteState state) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          drawQuestionTitle(state.roulette.title),
          drawSelectedOptionText(),
          Container(
            height: 370.0,
            child: drawRoulette(state.options),
            margin: EdgeInsets.all(10.0),
          ),
          drawClearButton(),
        ],
      ),
    );
  }

  Widget drawClearButton() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          spinController.stop();
          setState(() {
            selectedOptionIndex = null;
            randyStatus = RandyStatus.init;
            title$.sink.add(null);
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          color: Colors.white,
          child: Text(
            'clear',
            style: TextStyle(
              fontSize: 20,
              color: Colors.lightBlue,
            ),
          ),
        ),
      ),
    );
  }

  Widget drawQuestionTitle(String title) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  initRouletteBloc() {
    rouletteBloc = BlocProvider.of<RouletteBloc>(context);
    rouletteSubscription = rouletteBloc.state.listen((state) {
      if (state is LoadedRouletteState) {
        options = state.options;
      }
    });
  }

  initTitleStream() {
    title$ = PublishSubject<String>();
    title$.stream
        .distinct()
        .throttle(new Duration(milliseconds: 100))
        .listen(playSound);

    title$.stream
        .distinct()
        .throttle(new Duration(milliseconds: 80))
        .listen(vibrate);
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
    spinController.stop();
    super.dispose();
  }

  void onFinish(AnimationStatus status) {
    if (status != AnimationStatus.completed) {
      return;
    }
    var value = (spinAnimation.value / pi / 2 - 0.25) % 1;
    int index = options.length - (value * options.length).floor() - 1;
    setState(() {
      randyStatus = RandyStatus.finish;
      selectedOptionIndex = index;
    });
    audioPlayer.play('tick.mp3');
    Vibrate.feedback(FeedbackType.heavy);
  }

  vibrate(String title) {
    Vibrate.feedback(FeedbackType.selection);
  }

  playSound(String title) {
    audioPlayer.play('tick.mp3');
  }

  drawSelectedOptionText() {
    return Container(
      height: 80.0,
      child: StreamBuilder(
        stream: title$.stream.throttle(new Duration(milliseconds: 40)),
        builder: (context, snapshot) {
          String title = snapshot.hasData ? snapshot.data : '???';
          return RouletteTitle(title: title);
        },
      ),
    );
  }

  onSpinning() {
    var value = (spinAnimation.value / pi / 2 - 0.25) % 1;
    int index = options.length - (value * options.length).floor() - 1;
    final RouletteOption option = options[index];
    title$.sink.add(option.title);
  }

  spinRoulette() {
    setState(() {
      randyStatus = RandyStatus.spinning;
      selectedOptionIndex = null;
    });
    spinTween.end = pi * 2 * (9.0 + random.nextDouble());
    spinController.reset();
    spinController.forward();
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget drawRoulette(List<RouletteOption> options) {
    return Stack(
      children: <Widget>[
        AnimatedBuilder(
          animation: spinAnimation,
          child: Roulette(options: options, selected: selectedOptionIndex),
          builder: (context, child) {
            return Transform.rotate(
              child: child,
              alignment: Alignment.center,
              angle: spinAnimation.value,
            );
          },
        ),
        Center(
          child: Randy(
            onTap: spinRoulette,
            status: randyStatus,
          ),
        ),
      ],
    );
  }
}

class RouletteTitle extends StatelessWidget {
  final String title;

  const RouletteTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = 24.0;
    if (title.length > 30) {
      fontSize = 14.0;
    } else if (title.length > 20) {
      fontSize = 18.0;
    }

    return Container(
      alignment: Alignment.center,
      height: 40.0,
      child: Text(
        title,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
