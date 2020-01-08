import 'package:flutter/material.dart';
import 'package:solid_app/blocs/home_bloc.dart';
import 'package:solid_app/widgets/loading_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key, @required this.bloc}) : super(key: key);

  final HomeBloc bloc;

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Solid app',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<HomeState>(
      stream: widget.bloc.stateStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.isLoading) {
          return LoadingWidget();
        }
        return Center(
          child: Text(
            'Hello world!',
            style: Theme.of(context).textTheme.body1,
          ),
        );
      },
    );
  }
}
