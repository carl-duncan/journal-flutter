// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/cubit/cubit.dart';

void main() {
  group('HomeState', () {
    test('supports value equality', () {
      expect(
        HomeState(),
        equals(
          const HomeState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const HomeState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const homeState = HomeState(
            isLoading: false,
          );
          expect(
            homeState.copyWith(),
            equals(homeState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const homeState = HomeState(
            isLoading: false,
          );
          final otherHomeState = HomeState();
          expect(homeState, isNot(equals(otherHomeState)));

          expect(
            homeState.copyWith(
              isLoading: otherHomeState.isLoading,
            ),
            equals(otherHomeState),
          );
        },
      );
    });
  });
}
