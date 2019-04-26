import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randy_randomizer/bloc/current/current.dart';
import 'package:randy_randomizer/bloc/update_desision/update_desision.dart';
import 'package:randy_randomizer/models/roulette.dart';
import 'package:randy_randomizer/models/roulette_option.dart';
import 'package:randy_randomizer/repositories/roulette_option_repository.dart';
import 'package:randy_randomizer/repositories/roulette_repository.dart';
import 'package:randy_randomizer/widgets/desision_form.dart';

class UpdateDesisionScreen extends StatefulWidget {
  final Roulette roulette;

  UpdateDesisionScreen({this.roulette});

  @override
  State<StatefulWidget> createState() {
    return UpdateDesisionScreenState();
  }
}

class UpdateDesisionScreenState extends State<UpdateDesisionScreen> {
  UpdateDesisionBloc updateDesisionBloc;

  @override
  void initState() {
    updateDesisionBloc = UpdateDesisionBloc(
      rouletteRepository: RouletteRepository(),
      optionRepository: RouletteOptionRepository(),
    );
    updateDesisionBloc.dispatch(InitUpdateDesisionEvent(widget.roulette));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateDesisionEvent, UpdateDesisionState>(
      bloc: updateDesisionBloc,
      builder: (BuildContext context, UpdateDesisionState state) {
        if (state is SuccessSavedDesisionState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            BlocProvider.of<CurrentBloc>(context)
                .dispatch(ChangeCurrentEvent(widget.roulette));
            Navigator.pop(context);
          });
        }
        return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              buildSaveButton(
                onPressed: () {
                  updateDesisionBloc.dispatch(SaveFormEvent());
                },
              )
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

  Widget buildSaveButton({@required VoidCallback onPressed}) {
    return FlatButton(
      child: Text(
        'done',
        style: TextStyle(fontSize: 18.0, color: Colors.lightBlue),
      ),
      onPressed: onPressed,
    );
  }

  Widget buildBody(context, LoadedUpdateDesisionState state) {
    return DesisionForm(
      onAddOption: () {
        updateDesisionBloc.dispatch(AddOptionEvent());
      },
      onRemoveOption: (RouletteOption option) {
        updateDesisionBloc.dispatch(RemoveOptionEvent(option));
      },
      roulette: state.roulette,
      options: state.options,
    );
  }

  Widget buildLoading(context) {
    return Container();
  }
}

class UpdateDesisionForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return null;
  }
}
