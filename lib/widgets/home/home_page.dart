import 'package:flutter/material.dart';
import 'package:solid_app/blocs/home_bloc.dart';

import 'home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc ??= HomeBloc();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: HomeWidget(
        bloc: _bloc,
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
