import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randy_randomizer/bloc/current/current.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: buildDesisionTitle(context),
          ),
          buildEditButton(onTap: () {
            Navigator.pushNamed(context, '/update-desision',
                arguments: widget.roulette);
          }),
        ],
      ),
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

  Widget buildDesisionTitle(context) {
    var currentBloc = BlocProvider.of<CurrentBloc>(context);
    Roulette roulette = widget.roulette;
    return GestureDetector(
      onTap: () {
        currentBloc.dispatch(ChangeCurrentEvent(widget.roulette));
        Navigator.pushNamed(context, '/');
      },
      child: Container(
        color: Colors.transparent,
        padding:
            EdgeInsets.only(top: 18.0, bottom: 16.0, left: 15.0, right: 15.0),
        child: Text(roulette.title, style: TextStyle(fontSize: 16.0)),
      ),
    );
  }

  Widget buildEditButton({@required Function onTap}) {
    return GestureDetector(
      onTap: onTap,
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
