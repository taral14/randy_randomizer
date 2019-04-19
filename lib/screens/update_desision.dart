import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randy_randomizer/bloc/current/current.dart';
import 'package:randy_randomizer/bloc/roulette/roulette.dart';
import 'package:randy_randomizer/bloc/update_desision/update_desision.dart';
import 'package:randy_randomizer/models/roulette.dart';
import 'package:randy_randomizer/models/roulette_option.dart';
import 'package:randy_randomizer/repositories/roulette_option_repository.dart';
import 'package:randy_randomizer/repositories/roulette_repository.dart';

class UpdateDesisionScreen extends StatefulWidget {
  final Roulette roulette;

  UpdateDesisionScreen({this.roulette});

  @override
  State<StatefulWidget> createState() {
    return UpdateDesisionScreenState();
  }
}

class UpdateDesisionScreenState extends State<UpdateDesisionScreen> {
  RouletteBloc rouletteBloc;
  CurrentBloc currentBloc;
  UpdateDesisionBloc updateDesisionBloc;
  RouletteOptionRepository optionRepository;
  RouletteRepository rouletteRepository;

  @override
  void initState() {
    optionRepository = RouletteOptionRepository();
    rouletteRepository = RouletteRepository();
    updateDesisionBloc = UpdateDesisionBloc(
      rouletteRepository: rouletteRepository,
      optionRepository: optionRepository,
    );
    updateDesisionBloc.dispatch(InitUpdateDesisionEvent(widget.roulette));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateDesisionEvent, UpdateDesisionState>(
      bloc: updateDesisionBloc,
      builder: (BuildContext context, UpdateDesisionState state) {
        return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'done',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.lightBlue,
                  ),
                ),
                onPressed: saveForm,
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: (state is LoadedUpdateDesisionState)
              ? buildBody(context, state)
              : buildLoading(context),
        );
      },
    );
  }

  saveForm() {
    updateDesisionBloc.dispatch(SaveFormEvent());
    //rouletteBloc.dispatch(ChangeRouletteEvent(widget.roulette));
    Navigator.pushNamed(context, '/');
  }

  Widget buildBody(context, LoadedUpdateDesisionState state) {
    var roulette = state.roulette;

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          buildRouletteTitleField(context, roulette),
          SizedBox(height: 33.0),
          Expanded(
            child: Column(
              children: <Widget>[
                buildAddOptionButton(context),
                SizedBox(height: 35.0),
                Expanded(
                  child: ListView(
                    children: state.options
                        .map((RouletteOption option) =>
                            buildEditOption(context, option))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRouletteTitleField(context, Roulette roulette) {
    return TextField(
      controller: TextEditingController(
        text: roulette.title,
      ),
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        //helperStyle: ,
        hintText: 'Please enter a search term',
      ),
      style: TextStyle(fontSize: 22.0),
      onChanged: (String value) {
        roulette.title = value;
      },
    );
  }

  Widget buildEditOption(context, RouletteOption option) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.remove_circle,
            size: 30.0,
            color: Color.fromRGBO(255, 59, 48, 1),
          ),
          onPressed: () {
            updateDesisionBloc.dispatch(RemoveOptionEvent(option));
          },
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: TextField(
              controller: TextEditingController(
                text: option.title,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                //helperStyle: ,
                hintText: 'Please enter item name',
              ),
              onChanged: (String value) {
                option.title = value;
                //updateDesisionBloc.dispatch(UpdateOptionEvent(option: option));
              },
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAddOptionButton(context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_circle,
            size: 30.0,
            color: Color.fromRGBO(103, 105, 255, 1),
          ),
          onPressed: () {
            updateDesisionBloc.dispatch(AddOptionEvent());
          },
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Add a new item',
              style: TextStyle(
                fontSize: 16.0,
                color: Color.fromRGBO(103, 105, 255, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLoading(context) {
    return Container();
  }
}
