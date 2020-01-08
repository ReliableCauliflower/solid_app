import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solid_app/blocs/behavior_subject_bloc.dart';

class HomeBloc extends BehaviorSubjectBloc<HomeState> {
  HomeBloc() {
    getColorsList(9);
  }

  final word = 'Hey there';

  void getColorsList(int colorsNum) {
    currentState = const HomeState.loading();
    final colors = <Color>[];
    for(var i = 0; i < colorsNum; ++i){
      colors.add(_getRandomColor());
    }
    currentState = HomeState.idle(colors);
  }

  String getColorLabel(int index){
    final position = index % word.length;
    return word[position];
  }

  void addContainer(){
    final newColorList = currentState.colorList;
    newColorList.add(_getRandomColor());
    currentState = HomeState.idle(newColorList);
  }

  void refresh(){
    getColorsList(currentState.colorList.length);
  }

  void changeItemColor(int index){
    final newColorList = currentState.colorList;
    newColorList[index] = _getRandomColor();
    currentState = HomeState.idle(newColorList);
  }

  Color getLabelColor(int index){
    final color = currentState.colorList[index];
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  void clear(){
    final newColorList = currentState.colorList;
    newColorList.clear();
    currentState = HomeState.idle(newColorList);
  }

  Color _getRandomColor() {
    final int color = (math.Random().nextDouble() * 0xFFFFFF).toInt();
    return Color(color).withOpacity(1.0);
  }
}

class HomeState {
  const HomeState(this._currentState, this.colorList);

  const HomeState.idle(this.colorList) : _currentState = HomeStateType.idle;

  const HomeState.loading()
      : _currentState = HomeStateType.loading,
        colorList = null;

  final HomeStateType _currentState;
  final List<Color> colorList;

  bool get isLoading => _currentState == HomeStateType.loading;

  bool get isIdle => _currentState == HomeStateType.idle;
}

enum HomeStateType { loading, idle }
