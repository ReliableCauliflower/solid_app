import 'package:flutter/material.dart';
import 'package:solid_app/blocs/home_bloc.dart';
import 'package:solid_app/widgets/loading_widget.dart';
import 'package:solid_app/widgets/pages/color_widget.dart';

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
        title: const Text(
          'Solid app',
        ),
      ),
      body: _buildBody(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'add',
            child: Icon(Icons.add),
            onPressed: () => widget.bloc.addContainer(),
          ),
          const SizedBox(
            width: 8.0,
          ),
          FloatingActionButton(
            heroTag: 'reload',
            child: Icon(Icons.refresh),
            onPressed: () => widget.bloc.refresh(),
          ),
          const SizedBox(
            width: 8.0,
          ),
          FloatingActionButton(
            heroTag: 'clear',
            child: Icon(Icons.delete),
            onPressed: () => widget.bloc.clear(),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<HomeState>(
      stream: widget.bloc.stateStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.isLoading) {
          return LoadingWidget();
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 9),
          itemBuilder: (context, index) => _buildGridItem(index),
          itemCount: snapshot.data.colorList.length,
        );
      },
    );
  }

  Widget _buildGridItem(int index) {
    final sideSize = MediaQuery.of(context).size.width / 9;
    final color = widget.bloc.currentState.colorList[index];
    return GestureDetector(
      onLongPress: () => widget.bloc.changeItemColor(index),
      onTap: () => _goToColorPage(index),
      child: Container(
        width: sideSize,
        height: sideSize,
        alignment: Alignment.center,
        color: color,
        child: Text(
          widget.bloc.getColorLabel(index),
          style: TextStyle(
              fontSize: sideSize,
              color: widget.bloc.getLabelColor(index)),
        ),
      ),
    );
  }

  void _goToColorPage(int index) {
    Navigator.push<void>(
        context,
        MaterialPageRoute(
            builder: (context) => ColorWidget(
                  bloc: widget.bloc,
                  index: index,
                )));
  }
}
