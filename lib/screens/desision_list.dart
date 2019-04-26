import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randy_randomizer/bloc/desision_list/desision_list.dart';
import 'package:randy_randomizer/models/roulette.dart';
import 'package:randy_randomizer/repositories/roulette_repository.dart';
import 'package:randy_randomizer/widgets/desision_list_view.dart';

class DesisionListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DesisionListScreenState();
  }
}

class DesisionListScreenState extends State<DesisionListScreen> {
  DesisionListBloc desisionListBloc;

  void initState() {
    super.initState();
    desisionListBloc = DesisionListBloc(
      rouletteRepository: RouletteRepository(),
    );
    desisionListBloc.dispatch(InitDesisionListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: BlocBuilder<DesisionListEvent, DesisionListState>(
        bloc: desisionListBloc,
        builder: (BuildContext context, DesisionListState state) {
          if (state is LoadedDesisionListState) {
            return buildBody(context, state);
          } else {
            return buildLoading(context);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create-desision');
        },
        child: Icon(Icons.add, size: 30),
        backgroundColor: Color.fromRGBO(104, 59, 221, 1),
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget buildLoading(context) {
    return Container();
  }

  Widget buildBody(context, LoadedDesisionListState state) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildTitle(),
          Expanded(
            child: buildDesisionList(state.items),
          ),
        ],
      ),
    );
  }

  Widget buildDesisionList(List<Roulette> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, position) {
        var desision = items[position];
        return Dismissible(
          key: Key(desision.id.toString()),
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            desisionListBloc.dispatch(DeleteDesisionEvent(desision));
            items.removeAt(position);
          },
          background: Container(
            color: Colors.red,
          ),
          child: DesisisonListView(roulette: desision),
        );
      },
    );
  }

  Widget buildTitle() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: Text(
        'Desision list',
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
