import 'package:flutter/material.dart';
import 'package:solid_app/blocs/home_bloc.dart';
import 'package:solid_app/widgets/loading_widget.dart';

class ColorWidget extends StatefulWidget {
  const ColorWidget({Key key, this.bloc, this.index}) : super(key: key);

  final HomeBloc bloc;
  final int index;

  @override
  _ColorWidgetState createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<ColorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color page'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<HomeState>(
        stream: widget.bloc.stateStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () => widget.bloc.changeItemColor(widget.index),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: snapshot.data.colorList[widget.index],
                child: Center(
                  child: Text(
                    widget.bloc.word,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: widget.bloc.getLabelColor(widget.index)),
                  ),
                ),
              ),
            );
          }
          return LoadingWidget();
        });
  }
}
