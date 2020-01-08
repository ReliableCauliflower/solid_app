import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solid_app/blocs/behavior_subject_bloc.dart';

class HomeBloc extends BehaviorSubjectBloc<HomeState> {
  HomeBloc() {
    getColorsList(9);
  }

  void getColorsList(int length, {String word}) {
    currentState = const HomeState.loading();
    final colors = _generateRandomColors(length);
    currentState = HomeState.idle(colors,word: word);
  }

  List<Color> _generateRandomColors(int length) {
    final colors = <Color>[];
    for (var i = 0; i < length; ++i) {
      colors.add(_getRandomColor());
    }
    return colors;
  }

  String getColorLabel(int index) {
    final position = index % currentState.word.length;
    return currentState.word[position];
  }

  void addContainer() {
    final newColorList = currentState.colorList;
    newColorList.add(_getRandomColor());
    currentState = HomeState.idle(newColorList, word: currentState.word);
  }

  void refresh() {
    getColorsList(currentState.colorList.length, word: currentState.word);
  }

  void changeItemColor(int index) {
    final newColorList = currentState.colorList;
    newColorList[index] = _getRandomColor();
    currentState = HomeState.idle(newColorList, word: currentState.word);
  }

  Color getLabelColor(int index) {
    final color = currentState.colorList[index];
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  void clearColors() {
    final newColorList = currentState.colorList;
    newColorList.clear();
    currentState = HomeState.idle(newColorList, word: currentState.word);
  }

  void changeWord(String word) {
    currentState = const HomeState.loading();
    final colors = _generateRandomColors(word.length);
    currentState = HomeState.idle(colors, word: word);
  }

  Color _getRandomColor() {
    final int color = (math.Random().nextDouble() * 0xFFFFFF).toInt();
    return Color(color).withOpacity(1.0);
  }
}

class HomeState {
  const HomeState(this._currentState, this.colorList, this.word);

  const HomeState.idle(this.colorList, {String word})
      : _currentState = HomeStateType.idle,
        word = word ?? 'Hey there';

  const HomeState.loading()
      : _currentState = HomeStateType.loading,
        colorList = null,
        word = null;

  final HomeStateType _currentState;
  final List<Color> colorList;
  final String word;

  bool get isLoading => _currentState == HomeStateType.loading;

  bool get isIdle => _currentState == HomeStateType.idle;
}

enum HomeStateType { loading, idle }
