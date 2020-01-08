import 'package:rxdart/rxdart.dart';

class BehaviorSubjectBloc<T>{
  BehaviorSubjectBloc(){
    _behaviorSubject = BehaviorSubject<T>();
  }

  BehaviorSubjectBloc.seeded(T event){
    _behaviorSubject = BehaviorSubject.seeded(event);
  }

  BehaviorSubject<T> _behaviorSubject;

  T _currentState;

  T get currentState => _currentState;

  set currentState(T event) {
    _currentState = event;
    _behaviorSubject.sink.add(event);
  }

  Stream<T> get stateStream => _behaviorSubject.stream;

  void dispose(){
    _behaviorSubject?.close();
  }
}