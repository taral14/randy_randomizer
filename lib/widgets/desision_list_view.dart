import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randy_randomizer/bloc/current/current.dart';
import 'package:randy_randomizer/bloc/roulette/roulette.dart';
import 'package:randy_randomizer/models/roulette.dart';

class DesisisonListView extends StatefulWidget {
  final Roulette roulette;

  DesisisonListView({this.roulette});

  @override
  State<StatefulWidget> createState() {
    return DesisisonListViewState();
  }
}

class DesisisonListViewState extends State<DesisisonListView> {
  RouletteBloc rouletteBloc;
  CurrentBloc currentBloc;

  @override
  void initState() {
    super.initState();
    rouletteBloc = BlocProvider.of<RouletteBloc>(context);
    currentBloc = BlocProvider.of<CurrentBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                currentBloc.dispatch(ChangeCurrentEvent(widget.roulette));
                Navigator.pushNamed(context, '/');
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(
                    top: 18.0, bottom: 16.0, left: 15.0, right: 15.0),
                child: Text(
                  widget.roulette.title,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
          buildEditButton(),
        ],
      ),
      //padding:
      //    EdgeInsets.only(top: 18.0, bottom: 16.0, left: 15.0, right: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(0, 0, 0, 0.1),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
    );
  }

  Widget buildEditButton() {
    return GestureDetector(
      onTap: () {
        currentBloc.dispatch(ChangeCurrentEvent(widget.roulette));
        Navigator.pushNamed(context, '/update-desision',
            arguments: widget.roulette);
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(15),
        child: Opacity(
          opacity: 0.2,
          child: Image.asset(
            'assets/icon_edit.png',
            width: 20.0,
            height: 20.0,
          ),
        ),
      ),
    );
  }
}
