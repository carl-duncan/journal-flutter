// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/cubit/cubit.dart';
import 'package:journal_api/journal_api.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
  final cubit = MockHomeCubit();
  group('HomeCubit', () {
    group('constructor', () {
      when(() => cubit.state).thenReturn(HomeState());
      test('can be instantiated', () {
        expect(
          cubit,
          isNotNull,
        );
      });
    });

    test('initial state has default value for isLoading', () {
      when(() => cubit.state).thenReturn(HomeState());
      expect(cubit.state.isLoading, true);
    });

    test('initial state has default value for entries', () {
      when(() => cubit.state).thenReturn(HomeState());
      expect(cubit.state.entries, <Entry>[]);
    });
  });
}
