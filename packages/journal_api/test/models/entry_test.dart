// ignore_for_file: avoid_redundant_argument_values

import 'package:journal_api/journal_api.dart';
import 'package:test/test.dart';

void main() {
  group('Entry', () {
    test('can be instantiated', () {
      final entry = Entry(
        id: 1,
        title: 'title',
        body: 'body',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: '1',
      );
      expect(entry, isNotNull);
    });

    test('can be instantiated with a factory constructor', () {
      final entry = Entry.fromJson({
        'id': 1,
        'title': 'title',
        'body': 'body',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
        'userId': 1,
      });
      expect(entry, isNotNull);
    });

    test('can be converted to json', () {
      final entry = Entry(
        id: 1,
        title: 'title',
        body: 'body',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: '1',
      );
      final json = entry.toJson();
      expect(json, isNotNull);
    });
  });
}
