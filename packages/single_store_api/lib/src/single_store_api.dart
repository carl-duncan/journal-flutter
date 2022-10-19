// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
// ignore_for_file: avoid_dynamic_calls,for_in_of_invalid_type
// ignore_for_file: argument_type_not_assignable
import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:journal_api/journal_api.dart';

/// {@template single_store_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class SingleStoreApi extends JournalApi {
  /// {@macro single_store_api}
  const SingleStoreApi({
    required this.dio,
  });

  /// The [Dio] instance used to make requests.
  final Dio dio;

  /// The password used to authenticate with the API.
  String get password => const String.fromEnvironment('PASSWORD');

  /// The username used to authenticate with the API.
  String get username => const String.fromEnvironment('USERNAME');

  /// The database used to authenticate with the API.
  String get database => const String.fromEnvironment('DATABASE');

  /// The base URL used to authenticate with the API.
  String get baseUrl => const String.fromEnvironment('BASE_URL');

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
      '${baseUrl}query/rows',
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

    for (final row in result.data!['results'][0]['rows']) {
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
