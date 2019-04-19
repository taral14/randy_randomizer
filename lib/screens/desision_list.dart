import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randy_randomizer/bloc/current/current.dart';
import 'package:randy_randomizer/bloc/desision_list/desision_list.dart';
import 'package:randy_randomizer/models/roulette.dart';
import 'package:randy_randomizer/widgets/desision_list_view.dart';

class DesisionListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DesisionListScreenState();
  }
}

class DesisionListScreenState extends State<DesisionListScreen> {
  DesisionListBloc desisisonListBloc;
  CurrentBloc currentBloc;

  void initState() {
    super.initState();
    desisisonListBloc = BlocProvider.of<DesisionListBloc>(context);
    desisisonListBloc.dispatch(InitDesisionListEvent());
    currentBloc = BlocProvider.of<CurrentBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: BlocBuilder<DesisionListEvent, DesisionListState>(
        bloc: desisisonListBloc,
        builder: (BuildContext context, DesisionListState state) {
          if (state is LoadedDesisionListState) {
            return buildBody(context, state);
          } else {
            return buildLoading(context);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
        return DesisisonListView(roulette: items[position]);
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
