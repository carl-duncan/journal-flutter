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

  /// The options used for the [Dio] instance.
  Options get options => Options(
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$username:$password'))}',
        },
      );

  @override
  Future<void> createEntry(Entry entry, {required String key}) async {
    final data = {
      'sql': 'insert into entries (title,body,user_id) '
          'values (encrypt(?,?),encrypt(?,?),?)',
      'args': [entry.title, key, entry.body, key, entry.userId],
      'database': database,
    };

    await dio.post<Map<String, dynamic>>(
      '${baseUrl}exec',
      data: data,
      options: options,
    );

    return;
  }

  @override
  Future<void> deleteEntry(Entry entry) async {
    final data = {
      'sql': 'delete from entries where id = ?',
      'args': [entry.id],
      'database': database,
    };

    await dio.post<Map<String, dynamic>>(
      '${baseUrl}exec',
      data: data,
      options: options,
    );

    return;
  }

  @override
  Future<List<Entry>> getEntries(String userId, {String? key}) async {
    const query = 'select id, '
        'decrypt(title, ?) as title, decrypt(body, ?) as body,'
        ' created_at, updated_at,user_id '
        'from entries where user_id = ?';

    final result = await dio.post<Map<String, dynamic>>(
      '${baseUrl}query/rows',
      data: key != null
          ? {
              'sql': query,
              'args': [key, key, userId],
              'database': database,
            }
          : {
              'sql': 'select * from entries where user_id = ?',
              'database': database,
              'args': [userId],
            },
      options: options,
    );

    final entries = <Entry>[];

    for (final row in result.data!['results'][0]['rows']) {
      entries.add(Entry.fromJson(row));
    }

    return entries;
  }

  @override
  Future<List<Entry>> searchEntries(
    String query,
    String userId, {
    String? key,
  }) async {
    final result = await dio.post<Map<String, dynamic>>(
      '${baseUrl}query/rows',
      data: {
        'sql': key != null
            ? 'select id, '
                'decrypt(title, ?) as title, decrypt(body, ?) as body,'
                ' created_at, updated_at,user_id '
                ' from entries where '
                'decrypt(title,?) like ? '
                'or decrypt(body,?) like ? and user_id = ?'
            : 'select * from entries where '
                'user_id = ? and (title like ? '
                'or body like ?)',
        'args': key != null
            ? [key, key, key, '%$query%', key, '%$query%', userId]
            : [
                userId,
                '%$query%',
                '%$query%',
              ],
        'database': database,
      },
      options: options,
    );

    final entries = <Entry>[];

    for (final row in result.data!['results'][0]['rows']) {
      entries.add(Entry.fromJson(row));
    }

    return entries;
  }

  @override
  Future<void> updateEntry(Entry entry, {required String key}) async {
    final data = {
      'sql': 'update entries set title = encrypt(?,?), '
          'body = encrypt(?,?), updated_at = ? where id = ?',
      'args': [entry.title, key, entry.body, key, entry.updatedAt, entry.id],
      'database': database,
    };

    await dio.post<Map<String, dynamic>>(
      '${baseUrl}exec',
      data: data,
      options: options,
    );

    return;
  }
}
