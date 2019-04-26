import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randy_randomizer/bloc/create_desision/create_desision.dart';
import 'package:randy_randomizer/models/roulette_option.dart';
import 'package:randy_randomizer/repositories/roulette_option_repository.dart';
import 'package:randy_randomizer/repositories/roulette_repository.dart';
import 'package:randy_randomizer/widgets/desision_form.dart';

class CreateDesisionScreen extends StatefulWidget {
  @override
  _CreateDesisionScreenState createState() => _CreateDesisionScreenState();
}

class _CreateDesisionScreenState extends State<CreateDesisionScreen> {
  CreateDesisionBloc createDesisionBloc;

  @override
  void initState() {
    super.initState();
    createDesisionBloc = CreateDesisionBloc(
      rouletteRepository: RouletteRepository(),
      optionRepository: RouletteOptionRepository(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateDesisionEvent, CreateDesisionState>(
      bloc: createDesisionBloc,
      builder: (context, CreateDesisionState state) {
        if (state is SuccessSavedDesisionState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
          });
        }

        return Scaffold(
          appBar: AppBar(
            actions: <Widget>[buildSaveButton()],
          ),
          backgroundColor: Colors.white,
          body: (state is LoadedCreateDesisionState)
              ? buildBody(context, state)
              : buildLoading(context),
        );
      },
    );
  }

  Widget buildSaveButton() {
    return FlatButton(
      child: Text(
        'done',
        style: TextStyle(fontSize: 18.0, color: Colors.lightBlue),
      ),
      onPressed: () {
        createDesisionBloc.dispatch(SaveFormEvent());
      },
    );
  }

  Widget buildLoading(context) {
    return Container();
  }

  Widget buildBody(context, LoadedCreateDesisionState state) {
    return DesisionForm(
      onAddOption: () {
        createDesisionBloc.dispatch(AddOptionEvent());
      },
      onRemoveOption: (RouletteOption option) {
        createDesisionBloc.dispatch(RemoveOptionEvent(option));
      },
      roulette: state.roulette,
      options: state.options,
    );
  }
}
