import 'package:flutter_test/flutter_test.dart';
import 'package:solid_app/blocs/home_bloc.dart';

void main() {
  group('HomeBloc', (){
    final HomeBloc homeBloc = HomeBloc();
    test('getColorsList should set currentState colorList', (){
      homeBloc.getColorsList(9);
      expect(homeBloc.currentState.colorList.length, 9);
    });

    test('changeWord(String word) should change currentState word', (){
      const word = 'Kchauu';
      homeBloc.changeWord(word);
      expect(homeBloc.currentState.word, word);
    });

    test('clearColors() should clear currentState colorList', (){
      homeBloc.getColorsList(10);
      homeBloc.clearColors();
      expect(homeBloc.currentState.colorList.length, 0);
    });
  });
}
