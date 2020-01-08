import 'package:solid_app/blocs/behavior_subject_bloc.dart';

class HomeBloc extends BehaviorSubjectBloc<HomeState> {
  HomeBloc() {
    getColorsList();
  }

  void getColorsList(){
    currentState = const HomeState.loading();
    //get colors
    currentState = const HomeState.idle();
  }
}

class HomeState {
  const HomeState(this._currentState);

  const HomeState.idle() : _currentState = HomeStateType.idle;

  const HomeState.loading() : _currentState = HomeStateType.loading;

  final HomeStateType _currentState;

  bool get isLoading => _currentState == HomeStateType.loading;

  bool get isIdle => _currentState == HomeStateType.idle;
}

enum HomeStateType { loading, idle }
