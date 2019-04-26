import 'package:flutter/material.dart';
import 'package:randy_randomizer/models/roulette.dart';
import 'package:randy_randomizer/models/roulette_option.dart';

typedef AddOptionCallback = void Function();
typedef RemoveOptionCallback = void Function(RouletteOption option);

class DesisionForm extends StatelessWidget {
  final Roulette roulette;
  final List<RouletteOption> options;
  final AddOptionCallback onAddOption;
  final RemoveOptionCallback onRemoveOption;
  //final _formKey = GlobalKey<FormState>();

  DesisionForm(
      {@required this.roulette,
      @required this.options,
      @required this.onAddOption,
      @required this.onRemoveOption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          buildRouletteTitleField(context, roulette),
          SizedBox(height: 33.0),
          Expanded(
            child: buildOptionsForm(context, options),
          ),
        ],
      ),
    );
  }

  Widget buildOptionsForm(context, List<RouletteOption> options) {
    return Column(
      children: <Widget>[
        buildAddOptionButton(context),
        SizedBox(height: 35.0),
        Expanded(
          child: ListView(
            children: options
                .map(
                    (RouletteOption option) => buildEditOption(context, option))
                .toList(),
          ),
        ),
      ],
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

  Widget buildAddOptionButton(context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_circle,
            size: 30.0,
            color: Color.fromRGBO(103, 105, 255, 1),
          ),
          onPressed: onAddOption,
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
            return onRemoveOption(option);
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
}
