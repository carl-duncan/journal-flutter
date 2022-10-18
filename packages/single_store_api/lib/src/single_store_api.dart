// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:journal_api/journal_api.dart';

/// {@template single_store_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class SingleStoreApi extends JournalApi {
  /// {@macro single_store_api}
  const SingleStoreApi({
    required this.dio,
    required this.baseUrl,
    required this.database,
    required this.username,
    required this.password,
  });

  /// The [Dio] instance used to make requests.
  final Dio dio;

  /// The base URL used to make requests.
  final String baseUrl;

  /// The database used to make requests.
  final String database;

  /// username for Basic Auth
  final String username;

  /// password for Basic Auth
  final String password;

  @override
  Future<Entry> createEntry(Entry entry) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteEntry(Entry entry) {
    throw UnimplementedError();
  }

  @override
  Future<List<Entry>> getEntries() async {
    final result = await dio.post<Map<String, dynamic>>(
      '$baseUrl/query/rows',
      data: {
        'sql': 'select * from entries',
        'database': database,
      },
      options: Options(
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$username:$password'))}',
        },
      ),
    );

    final entries = <Entry>[];

    final data = result.data;

    final resultData = data!['results'] as List<Map<String, dynamic>>;

    final rows = resultData[0]['rows'] as List<Map<String, Object>>;

    for (final row in rows) {
      entries.add(Entry.fromJson(row));
    }

    return entries;
  }

  @override
  Stream<List<Entry>> searchEntries(String query) {
    throw UnimplementedError();
  }

  @override
  Future<Entry> updateEntry(Entry entry) {
    throw UnimplementedError();
  }
}
