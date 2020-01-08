import 'package:flutter/material.dart';
import 'package:solid_app/blocs/home_bloc.dart';
import 'package:solid_app/widgets/custom_word_dialog.dart';
import 'package:solid_app/widgets/loading_widget.dart';
import 'package:solid_app/widgets/pages/color_page.dart';

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
            onPressed: () => widget.bloc.clearColors(),
          ),
          const SizedBox(
            width: 8.0,
          ),
          FloatingActionButton(
            heroTag: 'new_word',
            child: Icon(Icons.edit),
            onPressed: () => _changeWordPressed(),
          )
        ],
      ),
    );
  }

  void _changeWordPressed(){
    showDialog<void>(
      context: context,
      builder: (context) {
        return ChangeWordDialog(
          bloc: widget.bloc,
        );
      },
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: snapshot.data.word.length),
          itemBuilder: (context, index) => _buildGridItem(index,snapshot.data.word),
          itemCount: snapshot.data.colorList.length,
        );
      },
    );
  }

  Widget _buildGridItem(int index,String word) {
    final sideSize = MediaQuery.of(context).size.width / word.length;
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
              fontSize: sideSize - sideSize * 0.2,
              color: widget.bloc.getLabelColor(index)),
        ),
      ),
    );
  }

  void _goToColorPage(int index) {
    Navigator.push<void>(
        context,
        MaterialPageRoute(
            builder: (context) => ColorPage(
                  bloc: widget.bloc,
                  index: index,
                )));
  }
}
