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
      final entry = Entry.fromJson(const {
        'id': 1,
        'title': 'title',
        'body': 'body',
        'created_at': '2021-01-01 00:00:00',
        'updated_at': '2021-01-01 00:00:00',
        'user_id': '1234567890',
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
