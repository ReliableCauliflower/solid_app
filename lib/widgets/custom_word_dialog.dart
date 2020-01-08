import 'package:flutter/material.dart';
import 'package:solid_app/blocs/home_bloc.dart';

class ChangeWordDialog extends StatefulWidget {
  const ChangeWordDialog({Key key, @required this.bloc}) : super(key: key);

  final HomeBloc bloc;

  @override
  _ChangeWordDialogState createState() => _ChangeWordDialogState();
}

class _ChangeWordDialogState extends State<ChangeWordDialog> {
  final _textFieldController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  InputDecoration _textFieldDecoration(String hintText) => InputDecoration(
        contentPadding:
            const EdgeInsets.only(left: 10.0, right: 10.0, top: 35.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        hintText: hintText,
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text('Write new word'),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          validator: (text){
            if(text.isEmpty){
              return 'Value required!';
            }
            if(text.length < 4){
              return 'Word is too short';
            }

            if(text.length > 15){
              return 'Word is too long';
            }
            return null;
          },
          autofocus: true,
          textAlign: TextAlign.center,
          controller: _textFieldController,
          decoration: _textFieldDecoration('New word'),
          style: Theme.of(context).textTheme.body1,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (word) => _changeWord(word),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
            _textFieldController.clear();
          },
        ),
        FlatButton(
          child: const Text('Ok'),
          onPressed: () => _changeWord(_textFieldController.text),
        )
      ],
      contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
      titlePadding: const EdgeInsets.all(10.0),
    );
  }

  void _changeWord(String word) {
    if(_formKey.currentState.validate()){
      Navigator.of(context).pop();
      widget.bloc.changeWord(word);
    }
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}
